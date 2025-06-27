#!/usr/bin/python3

'''
     author : Caian R. Ertl <hi@caian.org>
       code : github.com/caian-org/ansible-stow
    project : ansible-stow
description : An Ansible module that interacts with GNU Stow packages
    license : CC0 (Public Domain)

The person who associated a work with this deed has dedicated the work to the
public domain by waiving all of his or her rights to the work worldwide under
copyright law, including all related and neighboring rights, to the extent
allowed by law.

You can copy, modify, distribute and perform the work, even for commercial
purposes, all without asking permission.

AFFIRMER OFFERS THE WORK AS-IS AND MAKES NO REPRESENTATIONS OR WARRANTIES OF
ANY KIND CONCERNING THE WORK, EXPRESS, IMPLIED, STATUTORY OR OTHERWISE,
INCLUDING WITHOUT LIMITATION WARRANTIES OF TITLE, MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE, NON INFRINGEMENT, OR THE ABSENCE OF LATENT OR OTHER
DEFECTS, ACCURACY, OR THE PRESENT OR ABSENCE OF ERRORS, WHETHER OR NOT
DISCOVERABLE, ALL TO THE GREATEST EXTENT PERMISSIBLE UNDER APPLICABLE LAW.

For more information, please see
<http://creativecommons.org/publicdomain/zero/1.0/>
'''

import os
import re

from ansible.module_utils.basic import AnsibleModule


STOW_CONFLICTS_MESSAGE_REGEX_BY_VERSION = {
    '2.3.1': r'^\* existing target is neither a link nor a directory: (?P<link_path>.+)$',
    # pylint: disable-next=line-too-long
    '2.4.0': r'^\* cannot stow (?P<package_path>.+) over existing target (?P<link_path>.+) since neither a link nor a directory and --adopt not specified$',
    '2.4.1': r'^\* cannot stow (?P<package_path>.+) over existing target (?P<link_path>.+) since neither a link nor a directory and --adopt not specified$',
}

SUPPORTED_STOW_VERSIONS = list(STOW_CONFLICTS_MESSAGE_REGEX_BY_VERSION.keys())


def purge_conflicts(conflicted_files):
    """Delete a file or unlink a symlink conflicting with a package.

    Args:
        conflicted_files (list): Path of files or symlinks on the
            filesystem that conflicts with package files.

    Returns:
        dict or null: If the file is purged successfully, a None object is
            returned. If something goes wrong, a dictionary is returned
            containing the error message.
    """

    try:
        for file in conflicted_files:
            if os.path.islink(file):
                os.unlink(file)
            else:
                os.remove(file)

    except Exception as err:  # pylint: disable=broad-except
        return {'message': f'unable to purge file "{file}"; error: {str(err)}'}

    return None


def is_stow_in_path(module):
    """Verify if stow is installed and accessible (on the $PATH).

    Args:
        module (AnsibleModule): The Ansible module object.

    Returns:
        bool: True if stow is installed and accessible. False otherwise.
    """

    rc_, _, _ = module.run_command('which stow', check_rc=False)
    return rc_ == 0


def get_stow_version(module):
    """Get the installed stow version.

    Args:
        module (AnsibleModule): The Ansible module object.

    Returns:
        str or null: The installed stow version in the format "X.Y.Z". If stow
            is not installed or the version can't be determined, a None object
            is returned.
    """

    rc_, stdout, _ = module.run_command('stow --version')
    if rc_ != 0:
        return None

    stow_version = re.compile(r'^stow \(GNU Stow\) version (?P<version>\d+\.\d+\.\d+)$').match(stdout.strip())
    if not stow_version:
        return None

    return stow_version.group('version')


def stow_has_conflicts(stow_version, module, package, cmd):
    """Verify if a package has any conflicting files.

    Args:
        stow_version (str): The installed stow version.
        module (AnsibleModule): The Ansible module object.
        package (str): The name of the package to be un/re/stowed.
        cmd (str): The complete stow command, with all flags and arguments, to
            be executed in dry-run mode (no change is made on the filesystem).

    Returns:
        dict or null: If no conflict is found, a None object is returned.
            If a conflict is found, a dictionary is returned.

            Recoverable (i.e., conflicts on pre-existing files and symlinks on
            the filesystem) conflicts returns a different dict from a
            non-recoverable one:

                {
                    'recoverable': True,
                    'message': '...',
                    'files': ['/home/user/.bashrc', '/home/user/.config/foo']
                }

                ---

                {
                    'recoverable': False,
                    'message': '...'
                }
    """

    params = module.params

    # Dry-run to check if there's any conflict.
    cmd = f'{cmd} --no'
    rc_, _, stderr = module.run_command(cmd)

    if rc_ == 0:
        return None

    # Return code 2 means that the package points to a path that has a
    # directory on it. E.g.:
    #
    # Package "foo" is meant to be stowed at the home directory at
    # ".config/foo/bar" (absolute path being "/home/user/.config/foo/bar").
    #
    # If "bar" already exists as a directory at "/home/user/.config/foo",
    # stow can't continue.
    #
    # One way of dealing with this situation would be removing the directory.
    # Another way would be by backuping it. Either way, it's risky to
    # recursively delete an entire directory or even move it.
    #
    # This kind of scenario should be handled manually by the user, hence
    # the function returns with a non-recoverable flag error.
    if rc_ == 2:
        return {'recoverable': False, 'message': ''}

    conflict_re = re.compile(STOW_CONFLICTS_MESSAGE_REGEX_BY_VERSION[stow_version])

    conflicts = []
    for sel in stderr.split('\n'):
        conflict_match = conflict_re.match(sel.strip())

        if conflict_match:
            conflicts.append(os.path.join(params['target'], conflict_match.group('link_path')))

    conff = ', '.join(f'"{f}"' for f in conflicts)
    msg = f'unable to stow package "{package}" to "{params["target"]}"; conflicted files: {conff}'

    return {'recoverable': True, 'message': msg, 'files': conflicts}


def has_stow_changed_links(stow_output):
    if stow_output.strip() == '':
        return 0

    n_linked = set()
    link_re = re.compile(r'^LINK: (?P<link_path>.+) => (?P<package_path>.+)(?P<reverts> \(reverts previous action\))?$')

    n_unlinked = set()
    unlink_re = re.compile(r'^UNLINK: (?P<link_path>.+)$')

    for sel in stow_output.split('\n'):
        sel = sel.strip()

        link_match = link_re.match(sel)
        if link_match:
            n_linked.add(link_match.group('link_path'))
            continue

        unlink_match = unlink_re.match(sel)
        if unlink_match:
            n_unlinked.add(unlink_match.group('link_path'))

    return n_linked != n_unlinked


def stow(stow_version, module, package, state):
    """Perform stow on a package against the filesystem.

    Args:
        stow_version (str): The installed stow version.
        module (AnsibleModule): The Ansible module object.
        package (str): The name of the package to be un/re/stowed.
        state (str): The desirable package state within the system.

    Returns:
        dict: A dictionary that contains an error flag, the returned message
            and wether something changed or not.
    """

    params = module.params

    flag = ''
    if state in ('present', 'supress'):
        flag = '--stow'

    elif state == 'absent':
        flag = '--delete'

    elif state == 'latest':
        flag = '--restow'

    cmd = f'stow {flag} {package} --target={params["target"]} --dir={params["dir"]} --verbose'

    conflict = stow_has_conflicts(stow_version, module, package, cmd)
    if conflict:
        if state != 'supress' or not conflict['recoverable']:
            return {'error': True, 'message': conflict['message']}

        err = purge_conflicts(conflict['files'])
        if err:
            return {'error': True, 'message': err['message']}

    # When increasing verbosity level with the "--verbose" flag, all output
    # will be sent to the standard error (stderr).
    #
    # Stow is, by itself, an idempotent tool.
    # If a given package is already stowed, the tool will not perform again.
    # If a package is succesfully stowed, stow will output what have been done.
    #
    # That's why "information on stderr" equals "something has changed"
    # (supposing execution passed all errors checking).
    rc_, _, se_ = module.run_command(cmd)
    if rc_ != 0:
        msg = f'execution of command "{cmd}" failed with error code {rc_}; output: "{se_}"'
        return {'error': True, 'message': msg}

    return {'error': False, 'changed': has_stow_changed_links(se_)}


def main():
    '''The module main routine.'''

    module = AnsibleModule(
        argument_spec={
            'dir': {
                'required': True,
                'type': 'str',
            },
            'package': {
                'required': True,
                'type': 'list',
            },
            'target': {
                'required': False,
                'type': 'str',
                'default': os.environ.get('HOME'),
            },
            'state': {
                'required': True,
                'type': 'str',
                'choices': ['absent', 'present', 'latest', 'supress'],
            },
        }
    )

    params = module.params

    if not is_stow_in_path(module):
        module.fail_json(msg='unable to find stow')

    stow_version = get_stow_version(module)
    if not stow_version:
        module.fail_json(msg='unable to determine stow version')

    if stow_version not in SUPPORTED_STOW_VERSIONS:
        module.fail_json(msg=f'stow version {stow_version} is not supported')

    has_changed = False

    for package in list(params['package']):
        ret = stow(stow_version, module, package, params['state'])
        if ret['error']:
            module.fail_json(msg=ret['message'])

        has_changed = has_changed or ret['changed']

    module.exit_json(changed=has_changed)


if __name__ == '__main__':
    main()

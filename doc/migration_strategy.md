# Migration to Macbook Strategy

## Data Backup Tools

  [ ] Time Machine
  [ ] Backblaze
  [ ] Duplicati

---

## Key Data to Verify

  [ ] /Users/*
  [ ] Virtual Machines
  [ ] Desktop (Aaron)
  [ ] Stickies (Aaron)
  [ ] Keychain

---

## Work Applications

_Note: Data recovery should not be an issue for these
applications.  The data can be downloaded from servers
as needed._


  [ ] Pulse / VPN
  [ ] Chrome (Accounts)
  [ ] VIP Access (Register Token)
  [ ] Outlook (Account)
  [ ] Teams (Account)
  [ ] iTerm2 (License)
  [ ] Youtube Music (Account)
  [ ] Slack (Accounts)
  [ ] Docker Desktop (Account, Configs)
  [ ] Sublime Text (License, Configs, Plugins)
  [ ] Microsoft Remote Desktop (Configs)
  [ ] OneNote (Account)

---

## Personal Applications

_Note: These applications require data migration to
be useful, especially mail and virtual machine related._

  [ ] Omnifocus (Account, Config)
  [ ] Mail (Accounts, Config)
  [ ] Calendar (Account)
  [ ] MsgFiler (License)
  [ ] SendToKindle (Account)
  [ ] Microsoft Excel
  [ ] VMWare Fusion (License, Config)
  [ ] SpamSieve (License)
  [ ] MiniCalendar

---

## Additional Bits

  [ ] Printer (Manual)


---

# Procedures and Notes

## Base Install

See the base_install.md

---
Manual steps below here.

## Printers

  * Add printers manually as needed.

## Pulse Connections

  * Add connections
    * us-access
      * type: Policy Secure (UAC)
      * server: us-access.tradingscreen.com
      * settings prompted at login:
        * Realm: Two-Factor
        * User Name: {{ short username }}
    * eu-access
      * type: Policy Secure (UAC)
      * server: eu-access.tradingscreen.com
      * settings prompted at login:
        * Realm: Two-Factor
        * User Name: {{ short username }}
    * ap-access
      * type: Policy Secure (UAC)
      * server: ap-access.tradingscreen.com
      * settings prompted at login:
        * Realm: Two-Factor
        * User Name: {{ short username }}

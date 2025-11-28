# Python Package Management Migration

## Summary of Changes

The playbook has been updated to use **pipx** for Python CLI tools instead of pip for global package installation. This resolves PEP 668 externally-managed environment issues and follows Python best practices.

## What Changed

### 1. Removed Global pip Packages
All 51 pip packages have been removed from global installation. These should be installed in project-specific virtual environments:

**Removed packages (install per-project):**
- AI/ML: vllm, langchain, langchain-*, langgraph, langsmith
- LLM Providers: openai, anthropic, cohere, groq, mistralai, ollama
- Vector DBs: chromadb, pinecone-client, qdrant-client, weaviate-client
- Cloud: boto3, google-cloud-aiplatform, ibm-watsonx-ai
- Web Frameworks: fastapi, pydantic
- Data Science: pandas, numpy, scipy, datasets
- Document Processing: docling, pypdf, python-docx, python-pptx
- Web Scraping: beautifulsoup4, selenium
- Observability: opentelemetry-api, opentelemetry-sdk, langfuse

### 2. Added pipx for CLI Tools
Only Python CLI tools are now installed globally via pipx:
- `pytest` - Testing framework
- `ruff` - Python linter/formatter
- `ansible-lint` - Ansible playbook linter

### 3. Added pipx to Homebrew
The `pipx` package manager is now installed via Homebrew.

## Why This Approach?

### Problems with Global pip Installation
1. **PEP 668 Restrictions**: Modern Python (via Homebrew) blocks global pip installations
2. **Dependency Conflicts**: Global packages can conflict with each other
3. **System Instability**: Can break system Python or Homebrew
4. **Not Best Practice**: Libraries should be in project venvs, not global

### Benefits of pipx
1. **Isolated Environments**: Each tool gets its own virtual environment
2. **No Conflicts**: Tools can have different dependency versions
3. **Global Access**: Executables are available in PATH
4. **Easy Management**: Simple install/upgrade/uninstall commands
5. **PEP 668 Compliant**: Works with externally-managed Python

## How to Use

### Installing CLI Tools (via playbook)
The playbook automatically installs these via pipx:
```bash
ansible-playbook main.yml --ask-become-pass
```

### Installing Project Libraries (manual)
For each project, create a virtual environment:
```bash
# Create project directory
mkdir my-ai-project && cd my-ai-project

# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# Install project dependencies
pip install langchain openai anthropic pandas numpy
```

### Managing pipx Packages (manual)
```bash
# Install a new CLI tool
pipx install black

# Upgrade a tool
pipx upgrade pytest

# List installed tools
pipx list

# Uninstall a tool
pipx uninstall ruff
```

## Project Workflow Example

```bash
# 1. Create project
mkdir langchain-app && cd langchain-app

# 2. Create venv
python3 -m venv venv
source venv/bin/activate

# 3. Install dependencies
pip install langchain langchain-openai openai python-dotenv

# 4. Create requirements.txt
pip freeze > requirements.txt

# 5. Work on project
# (venv) $ python app.py

# 6. Deactivate when done
deactivate
```

## Configuration Files Modified

1. **default.config.yml**
   - Removed `pip_packages` (51 packages → 0)
   - Added `pipx_packages` (3 CLI tools)
   - Added `pipx` to `homebrew_installed_packages`

2. **tasks/extra-packages.yml**
   - Added task to install pipx packages
   - Kept pip task (now empty, for future use)

## Testing the Changes

Run the playbook in your VM:
```bash
cd /Users/pnuw/git/pnuw-mac-dev-playbook
ansible-playbook main.yml --ask-become-pass
```

The playbook should now complete successfully without pip installation errors.

## Next Steps

1. **Test the playbook** - Verify it runs without errors
2. **Create project venvs** - Set up virtual environments for your AI/ML projects
3. **Install project dependencies** - Use pip within each venv
4. **Add more CLI tools** - If you need other global CLI tools, add them to `pipx_packages`

## Additional Resources

- [pipx documentation](https://pipx.pypa.io/)
- [Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)
- [PEP 668](https://peps.python.org/pep-0668/)
# Portable Python Bundle for Windows
## Overview
This is a portable bundle for Windows, designed to be easily distributed and used without installation and hardcoded absolute path dependencies.

## Structure
```bash
<bundle>
└───python3
    ├───python3.exe
    ├───Scripts/
    ├───Lib/
    ├───...
└───pip_wrapper
    ├───scripts/
        ├───pip.py
    ├───bin/
        ├───pip.exe
```
## Usage

To use the portable Python bundle on Windows, download from latest [release](https://github.com/lc700x/portable-python-bundle/releases/latest) and extract to whatever location you prefer: i.e. `<bundle>`:

1. Activate in a `cmd.exe` shell:
    ```bash
    call <bundle>\activate.cmd
    ```

2. OR Activate in a `PowerShell` instance:
    ```bash
    . <bundle>\activate.ps1
    ```

3. Use Python just as normal after the environment is activated
    For example: to install ``Jupyter Notebook:

    ```bash
    pip install notebook
    ```

    This creates a `<bundle>\python3\Scripts\jupyter.exe` that is already in the PATH of our activated environment.

    So, to start Jupyter Notebook, run this command directly from our `cmd` Shell or `PowerShell` instance:

    ```bash
    jupyter notebook
    ```

## Build

To build the portable Python bundle, you can use the provided `build_bundle.ps1` PowerShell script. This script automates the process of downloading and setting up the portable Python environment.

### Steps to Build

1. Open PowerShell and navigate to the directory containing the `build_bundle.ps1` script.
2. Run the script:
   ```bash
   .\build_bundle.ps1
   ```
3. Follow the prompts to specify the desired Python version and other options.
4. Optional: install tkinter
   ```bash
   pip install --target <bundle>\python3 tkinter-embed
   ```

## Reference
[Portable Python Bundles on Windows](https://dev.to/treehouse/portable-python-bundles-on-windows-41ac)

# Portable Python `3.11.9` Bundle for Windows
## Overview
This is a portable Python 3.11.9 bundle for Windows, designed to be easily distributed and used without installation and hardcoded absolute path dependencies.

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

## Reference
[Portable Python Bundles on Windows](https://dev.to/treehouse/portable-python-bundles-on-windows-41ac)

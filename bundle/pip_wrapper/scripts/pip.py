#!/usr/bin/python
import sys
import os

if __name__ == "__main__":
    from pip._vendor.distlib.scripts import ScriptMaker
    ScriptMaker.executable = r"python.exe"

    from pip._internal.cli.main import main
    sys.exit(main())
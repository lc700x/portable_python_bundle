$ScriptDir = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
$Env:PATH = "$ScriptDir\pip_wrapper\bin;$ScriptDir\python3\Scripts;$ScriptDir\python3;$Env:PATH"
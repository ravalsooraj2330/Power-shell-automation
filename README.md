# Power-shell-automation
Cross-platform scripts to automate Windows server patching. Includes batch, PowerShell, and Bash versions with logging, remote execution, and reboot options. Designed for IT infrastructure teams to improve efficiency and compliance
## How to Run
For Windows remote patching, ensure WinRM is enabled and firewall rules allow it.
### Windows (Batch)
```cmd
REM Run as Administrator
windows\patch_windows.bat
windows\patch_windows.bat --reboot

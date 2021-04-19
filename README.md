# Prerequirements

* [OpenSSH on Windows](https://docs.microsoft.com/windows-server/administration/openssh/openssh_overview)
* [PowerShell configuration for script execution](https://go.microsoft.com/fwlink/?LinkID=135170)

# How to use

Run `ssh-ps-wrapper.ps1`

# How to use on [Windows Terminal](https://github.com/microsoft/terminal)

You can use [fragments.json](fragments.json) to add SSH PS Wrapper to your Windows Terminal.  
For example, run following commands to add SSH PS Wrapper for all users.

```
PS > mkdir "C:\ProgramData\Microsoft\Windows Terminal\Fragments\ssh-ps-wrapper"
PS > cp C:\Path\To\ssh-ps-wrapper.ps1 "C:\ProgramData\Microsoft\Windows Terminal\Fragments\ssh-ps-wrapper"
```

Please see [Applications installed from the web](https://docs.microsoft.com/ja-jp/windows/terminal/json-fragment-extensions#applications-installed-from-the-web) in Microsoft Docs.

# License

GNU General Public License v2.0

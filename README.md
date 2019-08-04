# Prerequirements

* [OpenSSH on Windows](https://docs.microsoft.com/windows-server/administration/openssh/openssh_overview)
* [PowerShell configuration for script execution](https://go.microsoft.com/fwlink/?LinkID=135170)

# How to use

Run `ssh-ps-wrapper.ps1`

# How to use on [Windows Terminal](https://github.com/microsoft/terminal)

You need to add a profile for SSH PS Wrapper as below:

```
    {
      "acrylicOpacity": 0.75,
      "closeOnExit": true,
      "colorScheme": "Campbell",
      "commandline": "powershell.exe -Command C:\\Path\\To\\ssh-ps-wrapper.ps1",
      "cursorColor": "#FFFFFF",
      "cursorShape": "filledBox",
      "fontFace": "Consolas",
      "fontSize": 10,
      "guid": "{4bd6e30c-4f35-4024-b74d-c377e1ff1b4f}",
      "historySize": 9001,
      "name": "SSH PS Wrapper",
      "padding": "0, 0, 0, 0",
      "snapOnInput": true,
      "startingDirectory": "%USERPROFILE%",
      "useAcrylic": true
    }
```

# License

GNU General Public License v2.0

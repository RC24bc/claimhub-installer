' ClaimHub Launcher — starts the server hidden and opens the browser
' This script runs AR.Web.exe without showing a CMD window,
' waits for the server to start, then opens the browser.

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Get the directory where this script lives (the install folder)
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
exePath = scriptDir & "\AR.Web.exe"

' Check if already running
On Error Resume Next
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colProcesses = objWMI.ExecQuery("Select * from Win32_Process Where Name = 'AR.Web.exe'")
On Error GoTo 0

If colProcesses.Count = 0 Then
    ' Start AR.Web.exe hidden (0 = hidden window)
    WshShell.Run """" & exePath & """", 0, False

    ' Wait for server to be ready (up to 15 seconds)
    WScript.Sleep 3000
End If

' Open the browser
WshShell.Run "http://localhost:5249", 1, False

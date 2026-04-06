#define MyAppName      "ClaimHub"
#define MyAppVersion   "1.0.0"
#define MyAppPublisher "ClaimHub Services"
#define MyAppURL       "https://claimhub.cc"
#define MyAppExeName   "AR.Web.exe"

; ── BUILD INSTRUCTIONS ─────────────────────────────────────────────────────
; 1. Publish:    dotnet publish AR.Web -c Release -o Installer/publish
; 2. Obfuscate:  ConfuserEx.CLI.exe -n Installer/ClaimHub.crproj
;                (Output lands in Installer/obfuscated/)
; 3. Update Source in [Files] to: Source: "obfuscated\*"
; 4. Compile:    ISCC.exe Installer/ClaimHub.iss
; Paths in this file are relative to this .iss file location (Installer/)
; ──────────────────────────────────────────────────────────────────────────

[Setup]
AppId={{C1A1M2H3-U4B5-6789-ABCD-EF0123456789}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
DefaultDirName={autopf64}\ClaimHub
DefaultGroupName={#MyAppName}
OutputDir=output
OutputBaseFilename=ClaimHub-Setup-v{#MyAppVersion}
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
; Admin install to Program Files — requires elevation prompt
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64
UninstallDisplayIcon={app}\{#MyAppExeName}
; Welcome + finish page
WizardSmallImageFile=assets\logo-55x55.bmp
SetupIconFile=assets\claimhub.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Shortcuts:"

[Files]
Source: "publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "ClaimHub-Launcher.vbs"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
; Register claimhub:// URI scheme for deep link activation
Root: HKLM; Subkey: "SOFTWARE\Classes\claimhub"; ValueType: string; ValueData: "URL:ClaimHub Protocol"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\claimhub"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKLM; Subkey: "SOFTWARE\Classes\claimhub\DefaultIcon"; ValueType: string; ValueData: "{app}\{#MyAppExeName},0"
Root: HKLM; Subkey: "SOFTWARE\Classes\claimhub\shell\open\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""

; Set deployment mode environment variable
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: string; ValueName: "CLAIMHUB_DEPLOYMENT_MODE"; ValueData: "Local"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "wscript.exe"; Parameters: """{app}\ClaimHub-Launcher.vbs"""; IconFilename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "wscript.exe"; Parameters: """{app}\ClaimHub-Launcher.vbs"""; IconFilename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; Launch app after install (hidden, then open browser)
Filename: "wscript.exe"; Parameters: """{app}\ClaimHub-Launcher.vbs"""; Flags: nowait postinstall skipifsilent; Description: "Launch ClaimHub now"

[UninstallRun]
Filename: "taskkill"; Parameters: "/F /IM {#MyAppExeName}"; Flags: runhidden

[Messages]
; Friendly installer messages
WelcomeLabel1=Welcome to ClaimHub Setup
WelcomeLabel2=ClaimHub helps your clinic recover unpaid TPA claims automatically.%n%nYour patient data never leaves your computer.%n%nThis will install ClaimHub {#MyAppVersion} on your PC.
FinishedHeadingLabel=ClaimHub is ready
FinishedLabel=ClaimHub has been installed. Click Finish to launch the app.%n%nYou will need your license key (sent to your email) to activate the app.

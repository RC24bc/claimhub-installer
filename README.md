# ClaimHub Installer

Open-source installer packaging for [ClaimHub](https://claimhub.cc) — a desktop tool that helps Malaysian GP clinics reconcile TPA panel payments against their account receivables.

## What This Repo Contains

This repository contains **only the installer packaging scripts** — not the application source code.

- `ClaimHub.iss` — [Inno Setup](https://jrsoftware.org/isinfo.php) script that packages the pre-built application into a Windows installer
- `ClaimHub-Launcher.vbs` — VBScript wrapper that launches the app without showing a CMD window and opens the browser
- `ClaimHub.crproj` — ConfuserEx configuration for binary obfuscation (applied to pre-built binaries before packaging)

## How It Works

ClaimHub is a .NET 8 Blazor Server application that runs locally on the user's PC. The installer:

1. Copies the pre-built application to `Program Files\ClaimHub`
2. Creates desktop and Start Menu shortcuts
3. Registers the `claimhub://` URI scheme for deep-link activation
4. Sets the `CLAIMHUB_DEPLOYMENT_MODE=Local` environment variable
5. Launches the app via VBS wrapper (hidden process + browser)

## Building

### Prerequisites
- [Inno Setup 6+](https://jrsoftware.org/isdl.php)
- Pre-built application binaries in `publish/` directory
- (Optional) [ConfuserEx](https://mkaring.github.io/ConfuserEx/) for binary obfuscation

### Steps

```bash
# 1. Place published .NET app in publish/
# 2. (Optional) Obfuscate binaries
ConfuserEx.CLI.exe -n ClaimHub.crproj
# 3. Compile installer
ISCC.exe ClaimHub.iss
```

Output: `output/ClaimHub-Setup-v1.0.0.exe`

## About ClaimHub

ClaimHub automates the reconciliation of TPA (Third Party Administrator) panel payments for Malaysian GP clinics. It matches payment reports from AIA, Micare, PMCare, RedAlertOnline, and HealthConnect against the clinic's account receivables.

**All patient data stays on the clinic's own PC** — the app only contacts the server to verify the license key.

Built by [ClaimHub Services](https://claimhub.cc).

## License

MIT License — see [LICENSE](LICENSE) for details.

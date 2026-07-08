# OTPApp (iOS) — Cloud build via Codemagic

A minimal Swift iOS app that shows a random 12-digit OTP on screen.

You do NOT need a Mac. The app is compiled on Codemagic's macOS cloud,
and you install the resulting `.ipa` with **Sideloadly** on Windows.

## 1. Make a GitHub repo
- Create a new **private or public** repo on https://github.com (e.g. `OTPApp-ios`).
- Do NOT add a README/.gitignore when creating (we already have files).

## 2. Push this folder to GitHub
From this folder (`OTPApp-ios`), run:
```
git init
git add .
git commit -m "OTPApp initial"
git branch -M main
git remote add origin https://github.com/<your-user>/OTPApp-ios.git
git push -u origin main
```

## 3. Build on Codemagic (free)
- Go to https://codemagic.io → **Sign in with GitHub**.
- Click **Add application** → pick your `OTPApp-ios` repo → **Finish**.
- The `codemagic.yaml` is detected automatically. Click **Start new build**.
- Wait for the build. When done, download **build/ios/ipa/OTPApp.ipa** from artifacts.

## 4. Install on iPhone with Sideloadly (Windows)
- Open Sideloadly, drag the downloaded `OTPApp.ipa` in.
- Enter your free Apple ID, click **Start**.
- On iPhone: Settings → General → VPN & Device Management → trust the profile.
- Open OTPApp, read the 12-digit code, type it into the PC verifier.

## Free limits
- Codemagic free tier = limited build minutes/month (enough for occasional rebuilds).
- Sideloadly free Apple ID = max 3 apps, re-sign every 7 days.

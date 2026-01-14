# Install Circom 2.0 - Quick Guide

## Download circom-macos-amd64

Since `circom-macos-amd64` is what's available, use that (it works on both Intel and Apple Silicon Macs via Rosetta 2).

## Method 1: Use the Download Script

```bash
cd /Users/mac/HOUSE/privacy-pools
./download-circom.sh
```

## Method 2: Manual Download

1. **Visit GitHub Releases:**
   https://github.com/iden3/circom/releases

2. **Download:**
   - File: `circom-macos-amd64`
   - Latest version (currently v2.2.3)

3. **Save and setup:**
   ```bash
   cd /Users/mac/HOUSE/privacy-pools
   # Move the downloaded file here and rename to 'circom'
   chmod +x ./circom
   ./circom --version  # Should show: circom 2.x.x
   ```

## After Installation

Once Circom is installed, run:

```bash
./complete-setup.sh
```

This will:
- ✅ Verify Circom 2.0 is installed
- ✅ Compile circuits (10-30 minutes)
- ✅ Compile contracts
- ✅ Verify everything works

## Note on Architecture

- **circom-macos-amd64** works on:
  - Intel Macs (native)
  - Apple Silicon Macs (via Rosetta 2 translation)
  
If you're on Apple Silicon, Rosetta 2 will automatically handle the translation, so the amd64 version works fine.

## Verify Installation

```bash
./circom --version
# Should show: circom 2.x.x (not 0.5.x)
```

If you see version 0.5.x, that's the old npm package - you need to use the manually downloaded binary instead.

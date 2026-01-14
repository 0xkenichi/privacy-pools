# Copy Circom Binary

You have the Circom source code in `/Users/mac/Downloads/circom-2.2.3/`, but we need the compiled binary.

## Option 1: Download Pre-compiled Binary (Easiest)

1. **Visit GitHub Releases:**
   https://github.com/iden3/circom/releases

2. **Download:**
   - File: `circom-macos-amd64`
   - Version: v2.2.3 (or latest)

3. **Copy to privacy-pools:**
   ```bash
   cd /Users/mac/HOUSE/privacy-pools
   # Move the downloaded file here and rename to 'circom'
   cp ~/Downloads/circom-macos-amd64 ./circom
   chmod +x ./circom
   ./circom --version  # Should show: circom 2.2.3
   ```

## Option 2: Build from Source

If you want to build from the source code you have:

1. **Install Rust (if not installed):**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source ~/.cargo/env
   ```

2. **Build Circom:**
   ```bash
   cd /Users/mac/Downloads/circom-2.2.3
   cargo build --release
   ```

3. **Copy the binary:**
   ```bash
   cd /Users/mac/HOUSE/privacy-pools
   cp /Users/mac/Downloads/circom-2.2.3/target/release/circom ./circom
   chmod +x ./circom
   ./circom --version
   ```

## After Binary is Ready

Once you have the `circom` binary in `/Users/mac/HOUSE/privacy-pools/`:

```bash
cd /Users/mac/HOUSE/privacy-pools
./complete-setup.sh
```

This will complete the circuit compilation and contract setup.

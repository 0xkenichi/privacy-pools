# Manual Circom 2.0 Installation Guide

Since automated installation is having network issues, here are reliable manual installation methods:

## Method 1: Download from GitHub Releases (Easiest)

1. **Visit the releases page:**
   https://github.com/iden3/circom/releases

2. **Download the appropriate binary:**
   - For Apple Silicon (M1/M2/M3): `circom-macos-arm64`
   - For Intel Mac: `circom-macos-amd64`

3. **Install it:**
   ```bash
   cd /Users/mac/HOUSE/privacy-pools
   # Move the downloaded file to this directory and rename to 'circom'
   chmod +x ./circom
   
   # Test it
   ./circom --version
   ```

4. **Add to PATH (optional, for system-wide use):**
   ```bash
   sudo mv ./circom /usr/local/bin/circom
   ```

## Method 2: Install via Rust/Cargo

If you have Rust installed or can install it:

```bash
# Install Rust (if not installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install Circom
cargo install --git https://github.com/iden3/circom.git --tag v2.1.7 circom

# Verify
circom --version
```

## Method 3: Use Docker (Alternative)

If you have Docker installed:

```bash
# Create a wrapper script
cat > ./circom << 'EOF'
#!/bin/bash
docker run --rm -v "$(pwd):/workspace" -w /workspace iden3/circom:latest circom "$@"
EOF
chmod +x ./circom
```

## After Installation

Once Circom 2.0 is installed, run:

```bash
cd /Users/mac/HOUSE/privacy-pools
./complete-setup.sh
```

This will complete the circuit compilation and contract setup.

## Verify Installation

```bash
circom --version
# Should show: circom 2.x.x (not 0.5.x)
```

## Troubleshooting

### "Command not found"
- Make sure the binary is executable: `chmod +x ./circom`
- If using local binary, use: `./circom` instead of `circom`
- Or add to PATH: `export PATH=$PATH:$(pwd)`

### "Wrong version"
- Make sure you have Circom 2.0+, not 0.5.x
- The npm package installs 0.5.x which won't work
- You need to install manually

### Network Issues
- Try downloading from GitHub releases page directly in browser
- Or use Method 2 (Rust/Cargo) if you have better network to Rust servers

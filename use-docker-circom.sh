#!/bin/bash

# Use Docker to run Circom
# This creates a wrapper script that uses Docker

set -e

echo "Creating Circom wrapper using Docker..."
echo ""

cd "$(dirname "$0")"

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found!"
    echo "Please install Docker or use build-circom-from-source.sh instead"
    exit 1
fi

echo "✅ Docker found: $(docker --version | head -1)"
echo ""

# Create wrapper script
cat > ./circom << 'EOF'
#!/bin/bash
# Circom wrapper using Docker
docker run --rm \
  -v "$(pwd):/workspace" \
  -w /workspace \
  iden3/circom:latest \
  circom "$@"
EOF

chmod +x ./circom

echo "✅ Created ./circom wrapper script"
echo ""

# Test it (this will pull the Docker image on first run)
echo "Testing Circom (this will download Docker image on first run)..."
echo ""

./circom --version

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Circom is ready via Docker!"
    echo "=========================================="
    echo ""
    echo "Next step: Run ./complete-setup.sh"
    echo ""
else
    echo ""
    echo "❌ Docker test failed!"
    echo "Trying to pull image manually..."
    docker pull iden3/circom:latest
    ./circom --version
fi

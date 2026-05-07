#!/bin/bash
# ============================================================
# mumu Codespace Setup Script
# Runs automatically after the Codespace container is created
# ============================================================

set -e  # Exit on any error

echo ""
echo "=========================================="
echo "  Setting up mumu deployment environment"
echo "=========================================="
echo ""

# --- 1. Verify Java ---
echo "✅ Checking Java..."
java -version
echo "JAVA_HOME: $JAVA_HOME"

# --- 2. Make Gradle wrapper executable ---
echo ""
echo "✅ Making Gradle wrapper executable..."
if [ -f "./gradlew" ]; then
  chmod +x ./gradlew
  echo "gradlew is ready"
else
  echo "⚠️  gradlew not found — make sure you opened the mumu repo in this Codespace"
fi

# --- 3. Install Docker ---
# The base Java image does not include Docker, so we install it here
echo ""
echo "✅ Installing Docker..."
if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker vscode
  sudo service docker start
  echo "Docker installed"
else
  echo "Docker already present"
  sudo service docker start || true
fi
docker --version
docker compose version

# --- 4. Verify Gradle wrapper ---
echo ""
echo "✅ Checking Gradle wrapper (./gradlew)..."
if [ -f "./gradlew" ]; then
  ./gradlew --version
else
  echo "⚠️  gradlew not found yet — clone the mumu repo first"
fi

# --- 5. Pre-pull PostgreSQL Docker image ---
echo ""
echo "✅ Pre-pulling PostgreSQL Docker image..."
docker pull postgres:latest

# --- 6. Print next steps ---
echo ""
echo "=========================================="
echo "  Environment ready! Next steps:"
echo "=========================================="
echo ""
echo "  1. Build the app:"
echo "     ./gradlew clean build -x test"
echo ""
echo "  2. Start all services:"
echo "     docker compose up -d"
echo ""
echo "  3. Check running containers:"
echo "     docker compose ps"
echo ""
echo "  4. Watch logs:"
echo "     docker compose logs -f"
echo ""
echo "  5. Access the app at:"
echo "     http://localhost:8080"
echo ""
echo "  Useful commands:"
echo "     docker compose down        # stop everything"
echo "     docker compose down -v     # stop + wipe DB data"
echo "     ./gradlew test             # run tests"
echo ""

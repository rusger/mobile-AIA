#!/bin/bash

# Flutter iOS Development Fix Script
# Save as: fix_ios_flutter.sh
# Make executable: chmod +x fix_ios_flutter.sh
# Run: ./fix_ios_flutter.sh

echo "🔧 Flutter iOS Fix Script Starting..."

# Function to check if command succeeded
check_status() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 completed successfully"
    else
        echo "❌ $1 failed, continuing..."
    fi
}

# 1. Kill stuck processes
echo "📱 Step 1: Killing stuck processes..."
killall -9 Xcode 2>/dev/null
killall -9 IBAgent 2>/dev/null
killall -9 SimController 2>/dev/null
killall -9 com.apple.CoreSimulator.CoreSimulatorService 2>/dev/null
killall -9 dart 2>/dev/null
sudo killall -9 usbmuxd 2>/dev/null
check_status "Process cleanup"

# 2. Restart USB services
echo "🔌 Step 2: Restarting USB services..."
sudo launchctl stop com.apple.usbmuxd
sudo launchctl start com.apple.usbmuxd
check_status "USB services restart"

# 3. Clean Flutter project
echo "🧹 Step 3: Cleaning Flutter project..."
flutter clean
rm -rf .dart_tool
rm -rf build
rm -rf ~/Library/Developer/Xcode/DerivedData/*
check_status "Flutter clean"

# 4. Clean iOS specific files
echo "📱 Step 4: Cleaning iOS files..."
cd ios 2>/dev/null
if [ $? -eq 0 ]; then
    rm -rf Pods
    rm -rf Podfile.lock
    rm -rf .symlinks
    rm -rf Flutter/Flutter.podspec
    rm -rf Flutter/Generated.xcconfig
    pod cache clean --all
    cd ..
    check_status "iOS clean"
else
    echo "⚠️  Not in a Flutter project directory"
fi

# 5. Get packages
echo "📦 Step 5: Getting packages..."
flutter pub get
check_status "Package fetch"

# 6. Install pods
echo "🎯 Step 6: Installing iOS pods..."
cd ios 2>/dev/null
if [ $? -eq 0 ]; then
    pod install --repo-update
    cd ..
    check_status "Pod installation"
fi

# 7. Check devices
echo "📱 Step 7: Checking connected devices..."
flutter devices

# 8. Build for iOS
echo "🏗️ Step 8: Building iOS app..."
flutter build ios --debug
check_status "iOS build"

# 9. List available devices and let user choose
echo "📱 Step 9: Available devices:"
flutter devices

# 10. Attempt install if device ID provided
if [ ! -z "$1" ]; then
    echo "📲 Step 10: Installing to device $1..."
    flutter install -d $1
    check_status "App installation"
    
    echo "🚀 Step 11: Launching app..."
    flutter run -d $1
else
    echo "💡 Tip: Run with device ID as parameter:"
    echo "   ./fix_ios_flutter.sh 00008020-000805DE2242002E"
    echo ""
    echo "Or run manually:"
    echo "   flutter run -d [device-id]"
fi

echo ""
echo "✅ Script complete!"
echo ""
echo "🔧 If still having issues:"
echo "1. On iPhone: Settings → General → VPN & Device Management → Trust Developer"
echo "2. On iPhone: Settings → Developer → Clear Trusted Computers (then reconnect USB)"
echo "3. Open Xcode: open ios/Runner.xcworkspace"
echo "4. In Xcode: Select device → Press Play button"

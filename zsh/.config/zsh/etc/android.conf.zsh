# vim: filetype=sh
# Configurações do Android SDK e ferramentas de linha de comando

export ANDROID_SDK_ROOT="$HOME/.local/share/Android"

if [ -d "$ANDROID_SDK_ROOT" ]; then
    export ANDROID_SDK_HOME="$ANDROID_SDK_ROOT"
    export ANDROID_AVD_HOME="$HOME/.android/avd"
    export ANDROID_HOME="$ANDROID_SDK_ROOT"

    [ -d "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin" ] &&
        export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
    [ -d "$ANDROID_SDK_ROOT/platform-tools" ] &&
        export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    [ -d "$ANDROID_SDK_ROOT/emulator" ] &&
        export PATH="$PATH:$ANDROID_SDK_ROOT/emulator"
fi

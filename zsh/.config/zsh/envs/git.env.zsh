# Read: https://developer.1password.com/docs/ssh/get-started/
#       https://git-scm.com/docs/git-config#_environment
case "$(uname -s)" in
  Darwin)
    export GIT_CONFIG_GPG_SSH_PROGRAM="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    ;;
  Linux)
    export GIT_CONFIG_GPG_SSH_PROGRAM="/opt/1Password/op-ssh-sign"
    ;;
  *)
    echo "Unsupported OS $(uname -s)" >&2
    exit 1
    ;;
esac
export GIT_CONFIG_COUNT=1
export GIT_CONFIG_KEY_0=gpg.program
export GIT_CONFIG_VALUE_0=$GIT_CONFIG_GPG_SSH_PROGRAM

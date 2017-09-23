after_install autoalias

autoalias() {
  if [ "$STATUS" = 0 ]; then
    case "$VERSION_NAME" in
    *[0-9]-*)
      phpenv alias "${VERSION_NAME%-*}" --auto 2>/dev/null || true
      phpenv alias "${VERSION_NAME%%-*}" --auto 2>/dev/null || true
      ;;
    *.*.*)
      phpenv alias "${VERSION_NAME%.*}" --auto 2>/dev/null || true
      ;;
    esac
  fi
}

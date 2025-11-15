{ lib, pkgs, writeShellScriptBin, nodejs_20, ... }:

writeShellScriptBin "qwen" ''
  exec ${nodejs_20}/bin/npx @qwen-code/qwen-code@0.0.15-nightly.8 "$@"
''
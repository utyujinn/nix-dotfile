{ lib, pkgs, writeShellScriptBin, nodejs_20, ... }:

writeShellScriptBin "qwen" ''
  exec ${nodejs_20}/bin/npx @qwen-code/qwen-code@0.10.5-nightly.20260224.a13d88ac "$@"
''

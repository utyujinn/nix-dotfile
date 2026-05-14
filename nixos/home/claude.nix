{ config, pkgs, lib, ... }:
let
  toolBinDir = "${config.home.homeDirectory}/.local/bin";

  mcpConfig = pkgs.writeText "claude-mcp-config.json" (builtins.toJSON {
    mcpServers = {
      serena = {
        type = "stdio";
        command = "${toolBinDir}/serena";
        args = [ "start-mcp-server" "--context" "claude-code" "--project-from-cwd" ];
        env = { };
      };
      "mcp-nixos" = {
        type = "stdio";
        command = "${toolBinDir}/mcp-nixos";
        args = [ ];
        env = { };
      };
      "token-savior" = {
        type = "stdio";
        command = "${toolBinDir}/token-savior";
        args = [ ];
        env = {
          WORKSPACE_ROOTS = config.home.homeDirectory;
          TOKEN_SAVIOR_CLIENT = "claude-code";
        };
      };
    };
  });
in
{
  # nixos-rebuild switch 時にインストール → Claude起動時はネットワーク不要
  home.activation.installMcpServers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.uv}/bin/uv tool install serena-agent              || true
    ${pkgs.uv}/bin/uv tool install mcp-nixos                || true
    ${pkgs.uv}/bin/uv tool install "token-savior-recall[mcp]" || true
  '';

  home.activation.claudeMcpConfig = lib.hm.dag.entryAfter [ "writeBoundary" "installMcpServers" ] ''
    # Claude Code の設定は ~/.claude.json（~/.claude/settings.json ではない）
    cfg="$HOME/.claude.json"
    [ -f "$cfg" ] || echo '{}' > "$cfg"
    tmp=$(mktemp)
    ${pkgs.jq}/bin/jq --slurpfile mcp ${mcpConfig} '. * $mcp[0]' "$cfg" > "$tmp" && mv "$tmp" "$cfg"

    # ~/.claude/settings.json の不要な mcpServers エントリを削除
    settings="$HOME/.claude/settings.json"
    if [ -f "$settings" ]; then
      tmp2=$(mktemp)
      ${pkgs.jq}/bin/jq 'del(.mcpServers)' "$settings" > "$tmp2" && mv "$tmp2" "$settings"
    fi
  '';
}

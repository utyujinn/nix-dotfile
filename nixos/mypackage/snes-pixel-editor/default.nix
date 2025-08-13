# ~/nix-packages/snes-pixel-editor/default.nix

# { ... }: は、このファイルが引数を取る関数であることを示します。
# これらはNixpkgsから提供される基本的なツールやライブラリです。
{ lib, stdenv, fetchurl, patchelf, makeWrapper, xorg, alsa-lib, gtk3 }:

# stdenv.mkDerivationはNixでパッケージを定義するための中心的な関数です。
stdenv.mkDerivation rec {
  # パッケージ名とバージョン
  pname = "snes-pixel-editor";
  version = "snes"; # リリースタグなどから適切なバージョンを付けます

  # 1. ソースの取得
  src = fetchurl {
    url = "https://github.com/utyujinn/snes-pixel-editor/releases/download/${version}/${pname}";
    # ここにステップ1で取得したハッシュ値を貼り付けます
    sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # 例: "sha256-yourHashGoesHere..."
  };

  # 2. 依存関係
  # ビルド時にのみ必要なツール
  nativeBuildInputs = [
    patchelf      # バイナリのライブラリパスを修正するツール
    makeWrapper   # 実行時に環境変数を設定するラッパーを生成するツール
  ];

  # 実行時に必要なライブラリ
  buildInputs = [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXrender
    alsa-lib
    gtk3 # GTK製アプリケーションの可能性を考慮
  ];

  # 3. インストール手順
  # pre-compiledバイナリなので、ビルドフェーズは不要です。
  # installPhaseで、ダウンロードしたファイルをNixストアに配置します。
  installPhase = ''
    # Nixストア内のインストール先ディレクトリを作成
    runHook preInstall
    mkdir -p $out/bin

    # ダウンロードしたバイナリをコピーし、実行権限を付与
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    runHook postInstall
  '';

  # 4. パッチ適用 (Fixup)
  # バイナリがNixストア内のライブラリを見つけられるように修正します。
  postFixup = ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${lib.makeLibraryPath buildInputs}" \
      $out/bin/${pname}
  '';

  # メタデータ (任意ですが推奨)
  meta = with lib; {
    description = "A pixel art editor for SNES";
    homepage = "https://github.com/utyujinn/snes-pixel-editor";
    license = licenses.unfree; # ライセンスが不明な場合はunfreeとします
    platforms = platforms.linux;
  };
}

{
  stdenv,
  fetchFromGitHub,
  cmake,
  qt6
}:


stdenv.mkDerivation rec {
  pname = "snes-pixel-editor";
  version = "1.0"; 

  src = fetchFromGitHub {
    owner = "utyujinn";
    repo = "snes-pixel-editor";
    rev = "0.1";
    sha256 = "CiHkXLELxb8xcO3uEixrTBmWu4gk7zvN+zOJ3TZJnbQ=";
  };

  nativeBuildInputs = [ 
    cmake
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp build/src/ColorPaletteApp $out/bin/snes-pixel-editor
    runHook postInstall
  '';
}



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
    rev = "0.2";
    sha256 = "aO2P0HFWGQdPtoHzmefmfoPpe8Lpy45PQu5PGrr9qFQ=";
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
    cp src/snes-pixel-editor $out/bin/snes-pixel-editor
    runHook postInstall
  '';
}



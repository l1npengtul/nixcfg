{
  stdenv,
  fetchzip,
  lib,
  autoPatchelfHook,
}:
stdenv.mkDerivation rec {
  pname = "airwindows";
  version = "0.2";

  src = fetchzip {
    url = "https://www.airwindows.com/wp-content/uploads/LinuxVSTs.zip";
    sha256 = "sha256-UYYmfvLzT26hpHFzHxktlGitkvdRhBTo+ILDTmPW3Fk=/M=";
    stripRoot = false;
  };

  buildInputs = [stdenv.cc.cc.lib];

  nativeBuildInputs = [autoPatchelfHook];

  installPhase = ''

    runHook preInstall

    mkdir -p $out/lib/vst/airwindows
    find . -name \*.so -exec cp {} $out/lib/vst/airwindows \;

    runHook postInstall

  '';

  meta = with lib; {
    description = "airwindows plugins";
    homepage = "https://airwindows.com/";
    platforms = platforms.x86_64;
  };
}

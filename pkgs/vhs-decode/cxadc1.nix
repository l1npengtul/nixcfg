{
  stdenv,
  lib,
  kernel,
  fetchFromGitHub,
  kmod,
}:
stdenv.mkDerivation rec {
  pname = "cxadc-linux3";
  passthru.moduleName = "cxadc";
  version = "240";

  src = fetchFromGitHub {
    owner = "happycube";
    repo = "cxadc-linux3";
    rev = "27721c563a041d8b40432723435ad2e47e223990";
    hash = "sha256-DFtnrlXYwtWBp1NZQ10Blt6Z4UBDitoitu/Kh7YjT2Q=";
  };

  nativeBuildInputs = [kernel.moduleBuildDependencies];

  hardeningDisable = ["pic"];

  makeFlags =
    kernel.makeFlags
    ++ [
      "KVERSION=${kernel.modDirVersion}"
      "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
      "INSTALL_MOD_PATH=$(out)"
    ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m 755 leveladj $out/bin/leveladj
    cd $src/utils
    find . -name 'cx*' -exec install -m777 -Dt $out/bin/ {} \;

    mkdir -p $out/etc/udev/rules.d
    mkdir -p $out/etc/modprobe.d

    cd $src
    cp cxadc.rules $out/etc/udev/rules.d
    cp cxadc.conf $out/etc/modprobe.d

    runHook postInstall
  '';

  meta = with lib; {
    description = "CXADC Driver";
    homepage = "https://github.com/happycube/cxadc-linux3";
    platforms = platforms.linux;
  };
}

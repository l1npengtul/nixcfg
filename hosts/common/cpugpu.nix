{...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libvdpau-va-gl
      vulkan-loader
      vulkan-validation-layers
      mesa.opencl # Enables Rusticl (OpenCL) support
      rocmPackages.clr.icd
    ];
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    clinfo
  ];
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };

  musnix.enable = true;
  musnix.rtcqs.enable = true;
}

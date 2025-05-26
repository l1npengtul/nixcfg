{pkgs, ...}: {
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          pkgs.OVMF
        ];
      };
      vhostUserPackages = [pkgs.virtiofsd];
    };
  };

  environment.systemPackages = with pkgs; [libguestfs-with-appliance];
}

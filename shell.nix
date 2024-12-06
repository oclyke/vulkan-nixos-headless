let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    cmake
    clang-tools
    gcc
    python310
    pkg-config
    libxc
    lz4
    ninja
    #qt5.full # the nuclear option
    qt5.qmake # a more surgical approach
    wayland
    xorg.libX11
    xorg.libxcb
    xorg.libXau
    xorg.libXdmcp
    xorg.libXrandr
    xorg.libXinerama # added for Vulkan-Samples
    xorg.libXcursor # added for Vulkan-Samples
    glm # added for SaschaWillems/Vulkan
    #vulkan-utils # added for ICD loader (to support the GPU)
    vulkan-loader
    vulkan-tools
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    libxc
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXdmcp
    xorg.libXrandr
    xorg.libXinerama # added for Vulkan-Samples
    xorg.libXcursor # added for Vulkan-Samples
  ]);
}


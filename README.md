
`vulkaninfo` - Display Vulkan information
`lshw -c display` - Display information (https://discourse.nixos.org/t/vulkan-not-working-with-nvidia-drivers/46972/15)
`nvidia-smi` - Check GPU status


# process


## Vulkan SDK
```sh
# enter the development shell
nix-shell

export VULKAN_SDK_VERSION=1.3.283.0
export VULKAN_SDK_FILENAME=vulkansdk-linux-x86_64-${VULKAN_SDK_VERSION}.tar.xz
export VULKAN_SDK_URL=https://sdk.lunarg.com/sdk/download/${VULKAN_SDK_VERSION}/linux/${VULKAN_SDK_FILENAME}

# download the SDK and extract it into its final location
mkdir VulkanSDK
wget -O ${VULKAN_SDK_FILENAME} ${VULKAN_SDK_URL}
tar -xf ${VULKAN_SDK_FILENAME} -C VulkanSDK

# build the SDK (with a shitload of parallel jobs b/c you have enough RAM)
VulkanSDK/${VULKAN_SDK_VERSION}/vulkansdk -j 32

# add the SDK to the path
source ~/VulkanSDK/${VULKAN_SDK_VERSION}/setup-env.sh
```

## Sascha Willems Vulkan examples
```sh
git clone https://github.com/SaschaWillems/Vulkan.git
cd Vulkan
mkdir build
cd build
cmake ..
make -j$(nproc)

# show the built examples
ls bin

# run an example
./bin/computecloth
```

## Vulkan C++ examples
```sh
# recursively clone the repository
git clone --recurse-submodules https://github.com/KhronosGroup/Vulkan-Samples.git
cd Vulkan-Samples

# configure the cmake project
cmake -G "Unix Makefiles" -Bbuild/linux -DCMAKE_BUILD_TYPE=Release

# build the project
cmake --build build/linux --config Release --target vulkan_samples -j$(nproc)

./build/linux/app/bin/Release/x86_64/vulkan_samples --help # show the help
./build/linux/app/bin/Release/x86_64/vulkan_samples samples # list available samples
./build/linux/app/bin/Release/x86_64/vulkan_samples sample hello_triangle # run the hello_triangle sample
```


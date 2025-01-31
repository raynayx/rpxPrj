cmake_minimum_required(VERSION 3.5)

# initialize the SDK based on PICO_SDK_PATH
# note: this must happen before project()

set(PICO_SDK_PATH ~/opt/pico-sdk)
# set(PICO_BOARD seeed_xiao_rp2040)
set(picotool_DIR ~/opt/picotool_bin/picotool)


#turn off compiler optimization
set(CMAKE_BUILD_TYPE Debug)
# set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")
# set (PICO_DEOPTIMIZED_DEBUG 1)


#set(LINKER_SCRIPT memmap_mod.ld)
set(MY_TARGET firmware)

# add_compile_options(-Wall
#         -Wno-format          # int != int32_t as far as the compiler is concerned because gcc has int32_t as long int
#         -Wno-unused-function # we have some for the docs that aren't called
#         -O0
#         )


include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(my_project)

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# rest of your project
add_executable(${MY_TARGET}
   src/main.c

)

#Enable printing over USB and disable printing over UART
pico_enable_stdio_usb(${MY_TARGET} 1)
pico_enable_stdio_uart(${MY_TARGET} 0)


# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(${MY_TARGET} pico_stdlib hardware_gpio hardware_i2c 
hardware_uart)


target_include_directories(${MY_TARGET} PUBLIC lib)


# Use custom linker script
#pico_set_linker_script(${MY_TARGET} ${LINKER_SCRIPT})

# create map/bin/hex/uf2 file in addition to ELF.
pico_add_extra_outputs(${MY_TARGET})

#!/usr/bin/env lua

local common = require "build_tools.lua.common"

-- Build the ROM.
common.build_rom_and_handle_failure("main", "s2built", "", "-p=0 -z=0," .. "kosinskiplus" .. ",Size_of_DAC_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

-- A successful build; we can quit now.
common.exit()

#!/usr/bin/env lua

--------------
-- Settings --
--------------

-- Set this to true to use a better compression algorithm for the DAC driver.
-- Having this set to false will use an inferior compression algorithm that
-- results in an accurate ROM being produced.
local improved_dac_driver_compression = false

---------------------
-- End of settings --
---------------------

-------------------------------------
-- Actual build script begins here --
-------------------------------------

local common = require "tools.lua.common"

-- Build the ROM.
local compression = improved_dac_driver_compression and "kosinski-optimised" or "kosinski"
common.build_rom_and_handle_failure("main", "s2built", "", "-p=0 -z=0," .. compression .. ",Size_of_DAC_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

-- A successful build; we can quit now.
common.exit()

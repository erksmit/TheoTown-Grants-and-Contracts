-- this file contains manual additions to theodocs.lua for functions that are not documented or not feasable to document (GUI)
---@meta

---@alias frame number
---@alias font number
---@alias bool boolean
---@alias int integer
---@alias float number
---@alias animationdraft draft

---@class Settings
---@field hideUI bool Whether to hide UI or not.
TheoTown.SETTINGS = {}

---@class Font
---@field BIG font
---@field DEFAULT font
---@field SMALL font
Font = {}

Icon = {}
NinePatch = {}

---@class GUI
---@field content gui (undocumented) only exists on dialogs
GUI = {}

-- (undocumented)
---@param x number
---@param y number
function GUI:setAlignment(x, y) end

-- (undocumented)
---@param r number
---@param g number
---@param b number
function GUI:setColor(r, g, b) end

-- (undocumented) Only exists on layouts.
---@return gui layout
---@nodiscard
function GUI:getFirstPart() end

-- Sets a building icon for the specified building. Note that game building icons have higher precedence than custom ones.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param icon? string | draft An animation draft to use as icon. Use nil to reset.
function Tile.setBuildingIcon(x, y, icon) end

---@class Vector
---@operator add: Vector
---@operator sub: Vector
---@operator pow: Vector
---@operator mul: Vector
---@operator div: Vector
---@operator unm: Vector
---@operator mod: Vector
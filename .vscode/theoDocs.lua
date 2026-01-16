-- tt lua docs
---@meta

---@class Array A set of tools to extend Lua's quite simple arrays with more intuitive, traditional methods.
Array = {}
---@alias array Array

-- Adds an object to the array. An index can be provided to specify a position for insertion.
---@param element any Object to add. May not be nil.
---@param index? number Index of where the object should be inserted. If no index was provided the object will be appended to the array. (optional)
---@return int r Index of the inserted object.
function Array:add(element, index) end

-- Adds an object to the array. An index can be provided to specify a position for insertion.
---@param arr any Array whose elements should be added.
---@param index? int Index of where the elements should be inserted. If no index was provided the elements will be appended to the array. (optional)
---@return int r Starting index of the inserted elements.
function Array:addAll(arr, index) end

-- Clears the array by removing all elements. The resulting size of the array will be 0.
function Array:clear() end

-- Returns true iff the given object is part of the array.
---@param element any The object to search for.
---@return bool r True iff the object is in the array.
function Array:contains(element) end

-- Returns a copy of the array.
---@return array r The copy of the array.
function Array:copy() end

-- Counts how many elements fulfill a given predicate.
---@param predicate function A function that returns true or false for an element of the array.
---@return int r 
function Array:count(predicate) end

-- Returns true iff at least one element matches the given predicate.
---@param predicate function A function that returns true or false for an element of the array.
---@return bool r 
function Array:exists(predicate) end

-- Creates a copy that only contains filtered elements.
---@param filterFunction function 
---@return array r The filtered array.
function Array:filter(filterFunction) end

-- Returns the index of an object in the array. If the array doesn't contain it the function returns -1.
---@param element any The object to search for.
---@return int r The index of element or -1 if it's not in the array.
function Array:find(element) end

-- Returns the first object that meets the given condition function or just the first element if no predicate function was given.
---@param predicate? function A predicate function that returns true for the element that should be returned. (default nil)
---@return any r The first element that met the condition / the first element / nil.
function Array:first(predicate) end

-- Iterates over all elements of the array and applieds a function on them. This is especially useful to avoid explicit use of a for loop. However, this functional style comes at an allocation and performance cost because of the function. Use it when it suits your needs.
---@param callbackFunction function 
function Array:forEach(callbackFunction) end

-- Returns true iff the array is empty. This is equivalent to checking the size size of the array being 0 manually.
---@return bool r True iff the array is empty.
function Array:isEmpty() end

-- Joins the contents of the array into a string using the specified separator.
---@param separator? string (optional)
---@return string r 
function Array:join(separator) end

-- Returns the last object that meets the given condition function or just the last element if no predicate function was given.
---@param predicate? function A predicate function that returns true for the element that should be returned. (default nil)
---@return any r The last element that met the condition / the first element / nil.
function Array:last(predicate) end

-- Maps all elements to a new array using a given function.
---@param mapFunction function 
---@return array r The mapped array.
function Array:map(mapFunction) end

-- Returns a random element of the array. Returns if the array is empty.
---@return any r Randomly selected element.
function Array:pick() end

-- Removes the first appearance of an object from the array.
---@param element any Object that should be found and removed.
---@return bool r True iff the object was found and removed.
function Array:remove(element) end

-- Removes the object at a specific index.
---@param i number Index of the object that should be removed.
---@return any r The removed object, or nil if no object has been removed.
function Array:removeAt(i) end

-- Removes the first object that meets the given condition function.
---@param predicate any A predicate function that returns true for the element that should be removed.
---@return bool r True iff an element met the condition and was removed.
function Array:removeIf(predicate) end

-- Removes all objects that met the given condition function.
---@param predicate any A predicate function that returns true for elements that should be removed.
---@return int r The number of occurences that were found and removed.
function Array:removeWhere(predicate) end

-- Shuffles the elements of the array into a random order. The function uses math.random internally so that the result is dependent on the current random seed value. To get different results for different runs you might call
function Array:shuffle() end

-- Uses natural order of the elements in the array to sort them. You can optionally provide your own function for comparing two elements.
---@param compFunc? function The comparison function must return a boolean value specifying whether the first argument should be before the second argument in the array. The default behaviour is ascending order. (optional)
function Array:sort(compFunc) end

-- Creates a sub-array for the specified range.
---@param startIndex number The index from where to copy.
---@param length? int The length of the new array. By default the array will be copied to the end. (optional)
---@return array r The created sub-array.
function Array:sub(startIndex, length) end

-- Sums up the result of the given function called on all elements.
---@param eval function A function that associates each element with a number.
---@return number r 
function Array:sum(eval) end


---@class Builder Functions to create and destroy buildings, roads, trees and more.
Builder = {}
---@alias builder Builder

-- Tries to build the given building draft at the specified position and sets it's frame if a frame was specified. Returns true iff the build was was successful.
---@param draft draft 
---@param x int 
---@param y int 
---@param frame? int The frame to use for the building. If no frame was specified a random frame will be used (in case the building has multiple frames). (optional)
---@return bool r Whether the building has been built successfully.
function Builder.buildBuilding(draft, x, y, frame) end

-- Applies a building upgrade to a building. An upgrade can only be applied iff the building exists, the upgrade was not applied to it already and the building upgrade was actually defined for that building. The upgrade will be applied as pending and may therefor not be visible immediately. On top of that, it may be subject to a build time. Applying an upgrade may remove other upgrades in the future dependent on their respective settings.
---@param draft draft Draft of the upgrade to apply.
---@param x int X component of the building position.
---@param y int Y component of the building position.
---@return bool r True iff the upgrade was applied.
function Builder.buildBuildingUpgrade(draft, x, y) end

-- Tries to build the given bus stop draft on the road on the specified location. Returns true iff this was successful.
---@param draft draft A bus stop draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level? int Road level of the target position with 0 being ground level. (default 0)
---@return bool r Whether the bus stop has been built.
function Builder.buildBusStop(draft, x, y, level) end

-- Builds fence on the specified edge of a tile.
---@param fence draft A fence draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param edge int Fences can be located at all four edges of a tile. The edges are indexed as follows (for non rotated city): 0 is south-east, 1 is north-east, 2 is north-west, 3 is south-west
---@return bool r Whether the fence has been built.
function Builder.buildFence(fence, x, y, edge) end

-- Builds fence around the specified rectangle area.
---@param fence draft A fence draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param width int Width of the target area in tiles.
---@param height int Height of the target area in tiles.
---@return bool r Whether at least one fence has been built.
function Builder.buildFenceAround(fence, x, y, width, height) end

-- Builds the specified ground draft and returns true iff building was successful.
---@param draft draft A ground draft. You can alternatively provide true for water or false for land. A generic ground draft will be used then. If this is a ground decal it will be placed on the ground below it.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return bool r Whether the ground has been built.
function Builder.buildGround(draft, x, y) end

-- Tries to build the given pipe draft along the given line. Returns true if building was successful.
---@param draft draft Draft of the pipe to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (default x0)
---@param y1? int Y component of the end position. (default y0)
---@return bool r Whether the pipe has been built successfully.
function Builder.buildPipe(draft, x0, y0, x1, y1) end

-- Tries to build the given road draft along the given line. Returns true if building was successful.
---@param draft draft Draft of the road to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1 int X component of the end position.
---@param y1 int Y component of the end position.
---@param level0? int Level at the start position. Default value is 0. (default 0)
---@param level1? int Level at the end position. Default value is 0. (default 0)
---@param bridge? bool Specifies whether a bridge should be built. For this option to work level0 and level1 must be equal. Default is false. (default false)
---@return bool r Whether the road has been built successfully.
function Builder.buildRoad(draft, x0, y0, x1, y1, level0, level1, bridge) end

-- Tries to build the given road decoration draft on the road on the specified location. Returns true iff this was successful.
---@param draft draft A road decoration draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level int Road level of the target position with 0 being ground level.
---@param index? int If specified the decoration will be place at the given index if possible (starting with 1). (default nil)
---@return bool r Whether the road decoration has been built.
function Builder.buildRoadDeco(draft, x, y, level, index) end

-- Tries to build the given tree draft at the specified position x, y and return true iff this was successful. If frame is specified it also tries to set the frame of the tree accordingly.
---@param draft draft The tree draft that should be used.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param frame? int The frame to use for the tree. A random frame will be picked if it isn't specified. (optional)
---@return bool r Whether the tree can be built.
function Builder.buildTree(draft, x, y, frame) end

-- Tries to build the given wire draft along the given line. Returns true if building was successful.
---@param draft draft Draft of the wire to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (optional)
---@param y1? int Y component of the end position. (optional)
---@return bool r Whether the wire has been built successfully.
function Builder.buildWire(draft, x0, y0, x1, y1) end

-- Builds the specified zone draft or removes it if draft is nil.
---@param draft draft A zone draft or nil.
---@param x int X component of the target position.
---@param y int Y component of the target position.
function Builder.buildZone(draft, x, y) end

-- Returns the price of the building. May change with time.
---@param draft draft 
---@param x int 
---@param y int 
---@return int r The price in Theons.
function Builder.getBuildingPrice(draft, x, y) end

-- Returns the price of applying an upgrade to a building.
---@param draft draft Draft of the upgrade to apply.
---@param x int X component of the building position.
---@param y int Y component of the building position.
---@return int | nil r The price in Theons or nil if there is no such building or the upgrade was applied to it already.
function Builder.getBuildingUpgradePrice(draft, x, y) end

-- Returns the price of the bus stop.
---@param draft draft A bus stop draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level? int Road level of the target position with 0 being ground level. (default 0)
---@return int r The price in Theons.
function Builder.getBusStopPrice(draft, x, y, level) end

-- Returns the price of the ground. May change with time.
---@param draft draft A ground draft. You can alternatively provide true for water or false for land. A generic ground draft will be used then.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return int r The price in Theons.
function Builder.getGroundPrice(draft, x, y) end

-- Returns the price to build a pipe. May change with time.
---@param draft draft Draft of the pipe to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (default x0)
---@param y1? int Y component of the end position. (default y0)
---@return int r The price in Theons.
function Builder.getPipePrice(draft, x0, y0, x1, y1) end

-- Returns the price of the road deco. May change with time.
---@param draft draft A road decoration draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level int Road level of the target position with 0 being ground level.
---@return int r The price in Theons.
function Builder.getRoadDecoPrice(draft, x, y, level) end

-- Returns the price of the road. May change with time.
---@param draft draft Draft of the road to probe.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1 int X component of the end position.
---@param y1 int Y component of the end position.
---@param level0? int Level at the start position. Default value is 0. (default 0)
---@param level1? int Level at the end position. Default value is 0. (default 0)
---@param bridge? bool Specifies whether a bridge should be built. For this option to work level0 and level1 must be equal. Default is false. (default false)
---@return int r The price in Theons.
function Builder.getRoadPrice(draft, x0, y0, x1, y1, level0, level1, bridge) end

-- Queries the expected price to build the terrain height as specified.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param height int The height that should be tried to set.
---@return int r The expected price.
function Builder.getTerrainHeightPrice(x, y, height) end

-- Returns the price of the tree. May change with time.
---@param draft draft The tree draft that should be used.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return int r The price in Theons.
function Builder.getTreePrice(draft, x, y) end

-- Returns the price to build a wire. May change with time.
---@param draft draft Draft of the wire to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (default x0)
---@param y1? int Y component of the end position. (default y0)
---@return int r The price in Theons.
function Builder.getWirePrice(draft, x0, y0, x1, y1) end

-- Returns the price to build the given zone. May change with time.
---@param draft draft A zone draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return int r The price in Theons.
function Builder.getZonePrice(draft, x, y) end

-- Checks whether the specified building draft can be built at the given position x, y. Returns true iff the building can be built.
---@param draft draft A building draft.
---@param x int 
---@param y int 
---@param checkZone? bool If true and the building needs a specific zone then the function will only return true if that zone is already present or can be built without replacing another zone type. (default true)
---@param checkRoad? bool If true and the building needs a road connection then the function will only return true if there is road nearby. (default true)
---@return bool r Whether the building can be built.
function Builder.isBuildingBuildable(draft, x, y, checkZone, checkRoad) end

-- Checks whether the specified bus stop draft can be built on the road at the specified location and level.
---@param draft draft A bus stop draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level? int Road level of the target position with 0 being ground level. (default 0)
---@return bool r Whether the bus stop can be built.
function Builder.isBusStopBuildable(draft, x, y, level) end

-- Checks whether the fence can be built on the specified edge of a tile.
---@param fence draft A fence draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param edge int Fences can be located at all four edges of a tile. The edges are indexed as follows (for non rotated city): 0 is south-east, 1 is north-east, 2 is north-west, 3 is south-west
---@return bool r Whether the fence can be built.
function Builder.isFenceBuildable(fence, x, y, edge) end

-- Returns true iff the ground draft can be built at the given location.
---@param draft draft A ground draft. You can alternatively provide true for water or false for land. A generic ground draft will be used then.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return bool r Whether the ground can be built.
function Builder.isGroundBuildable(draft, x, y) end

-- Checks whether the specified pipe draft can be build along the given line x0,y0 - x1,y1. A valid line has to fulfill the property x0 == x1 or y0 == y1.
---@param draft draft Draft of the pipe to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (default x0)
---@param y1? int Y component of the end position. (default y0)
---@return bool r Whether the pipe can be built.
function Builder.isPipeBuildable(draft, x0, y0, x1, y1) end

-- Checks whether the specified road draft can be build along the given line x0,y0 - x1,y1. To build a bridge manually you have to set level0 = level1 and bridge = true Only a single lane will be built so a valid line has to fulfill the property x0 == x1 or y0 == y1
---@param draft draft Draft of the road to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1 int X component of the end position.
---@param y1 int Y component of the end position.
---@param level0? int Level at the start position. Default value is 0. (default 0)
---@param level1? int Level at the end position. Default value is 0. (default 0)
---@param bridge? bool Specifies whether a bridge should be built. For this option to work level0 and level1 must be equal. Default is false. (default false)
---@return bool r Whether the road can be built.
function Builder.isRoadBuildable(draft, x0, y0, x1, y1, level0, level1, bridge) end

-- Returns true iff the given road decoration can be applied to the road at the specified location.
---@param draft draft A road decoration draft.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level int Road level of the target position with 0 being ground level.
---@return bool r Whether the road decoration can be built.
function Builder.isRoadDecoBuildable(draft, x, y, level) end

-- Queries whether the terrain height can be built as specified. This does not consider the price of the action.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param height int The height that should be tried to set.
---@return bool r True iff the terrain height is buildable as specified.
function Builder.isTerrainHeightBuildable(x, y, height) end

-- Checks whether the specified tree draft can be built at the specified position.
---@param draft draft The tree draft that should be used.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return bool r Whether the tree can be built.
function Builder.isTreeBuildable(draft, x, y) end

-- Checks whether the specified wire draft can be build along the given line x0,y0 - x1,y1. A valid line has to fulfill the property x0 == x1 or y0 == y1.
---@param draft draft Draft of the wire to build.
---@param x0 int X component of the starting position.
---@param y0 int Y component of the starting position.
---@param x1? int X component of the end position. (default x0)
---@param y1? int Y component of the end position. (default y0)
---@return bool r Whether the wire can be built.
function Builder.isWireBuildable(draft, x0, y0, x1, y1) end

-- Removes anything from the specified location.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return bool r Whether something was removed.
function Builder.remove(x, y) end

-- Removes a building upgrade from a building. Pending upgrades cannot be removed or probed.
---@param draft draft Draft of the upgrade to remove.
---@param x int X component of the building position.
---@param y int Y component of the building position.
---@return bool r True iff the upgrade was removed.
function Builder.removeBuildingUpgrade(draft, x, y) end

-- Removes the bus stop from a specified road.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level? int Road level of the target position with 0 being ground level. (default 0)
---@return bool r True iff the bus stop was removed.
function Builder.removeBusStop(x, y, level) end

-- Removes the fence on the specified edge of a tile.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param edge? int Fences can be located at all four edges of a tile. The edges are indexed as follows (for non rotated city): 0 is south-east, 1 is north-east, 2 is north-west, 3 is south-west. If not specified all fences on the tile will be removed. (optional)
---@return bool r Whether a fence was removed.
function Builder.removeFence(x, y, edge) end

-- Removes any fence within the specified rectangle area.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param width int Width of the target area in tiles.
---@param height int Height of the target area in tiles.
---@return bool r Whether at least one fence has been removed.
function Builder.removeFenceWithin(x, y, width, height) end

-- Removes the ground decal at the given position if there is any.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@return bool r Whether a ground decal was removed.
function Builder.removeGround(x, y) end

-- Dedicated remove function to remove pipes only.
---@param x int X component of a tile.
---@param y int Y component of a tile.
---@return bool r Whether the pipe was removed.
function Builder.removePipe(x, y) end

-- Removes all or a specific road decoration from a specified road.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param level? int Road level of the target position with 0 being ground level. (default 0)
---@param index? int Index of the road decoration to remove starting with 1, or nil to remove all road decorations on the road (default nil)
---@return bool r True iff at least one road decoration was removed.
function Builder.removeRoadDeco(x, y, level, index) end

-- Dedicated remove function to remove wires only.
---@param x int X component of a tile.
---@param y int Y component of a tile.
---@param level int Level of the wire to remove. The level of normal wires is 0 (-1 for underground and 1 for long distance wires).
---@return bool r Whether the wire was removed.
function Builder.removeWire(x, y, level) end

-- Tries to set the terrain height of the given location to the given height.
---@param x int X component of the target position.
---@param y int Y component of the target position.
---@param height int The height that should be tried to set.
function Builder.setTerrainHeight(x, y, height) end


---@class Building Building library for TheoTown A building is a representation object for single buildings in a city.
Building = {}
---@alias building Building

-- Abandons this (RCI) building. It will be empty afterwards.
function Building:abandon() end

-- Extinguishes the fire of this building in case it's burning.
function Building:extinguish() end

-- Gets the color of an animation of the building. The default color is white which is expressed as 255,255,255,255.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int,int,int,int | nil r If the operation was successful the color is returned as four integer numbers.
function Building:getAnimationColor(slot) end

-- Returns the current frame of an animation that is attached to this building.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Building:getAnimationFrame(slot) end

-- Returns the height of the building. Multiply by 8 to get an estimation for actual pixel height.
---@return int r The building's height.
function Building:getBuildHeight() end

-- Returns the number of days since this building was constructed. Negative values indicate non finished buildings.
---@return int r Days since the building was built/completed.
function Building:getDaysBuilt() end

-- Returns the draft of the building.
---@return draft r The draft object.
function Building:getDraft() end

-- Returns the draw pivot position of this building. You can use the result for use in Drawing.setTile() to get rotation independent drawing based on the building's left most point.
---@return int,int r X and Y component of the drawing tile position of the building.
function Building:getDrawXY() end

-- Returns the current frame of the building.
---@return int r The index of the current frame.
function Building:getFrame() end

-- Returns the height of the base area of the building.
---@return int r Height of the base area.
function Building:getHeight() end

-- Gets a set custom building icon.
---@param x any 
---@param y any 
---@return draft r The currently used animation draft or nil.
function Building:getIcon(x, y) end

-- Shortcut for the id of the building's draft.
---@return string r Draft ID of the building's building draft.
function Building:getId() end

-- Gets the name of this building.
---@return string | nil r Name of the building or nil if no name is set.
function Building:getName() end

-- Returns the current performance of this building. 1.0 represents 100%.
---@return float r Performance of this building.
function Building:getPerformance() end

-- Returns the storage table of the building. Storage tables can be used to save information into cities/buildings/roads permanently.
---@return table r The storage table.
function Building:getStorage() end

-- Returns the text set to the building.
---@return string | nil r The text of the building or nil if none was set.
function Building:getText() end

-- Returns the width of the base area of the building.
---@return int r Width of the base area.
function Building:getWidth() end

-- Returns the x position of this building.
---@return int r X component of the pivot position of this building.
function Building:getX() end

-- Returns the pivot position of this building. The returned point can differ from the location used to retrieve this building object for buildings that have a size bigger than 1.
---@return int r X component and
---@return int r the Y component of the pivot position of this building.
function Building:getXY() end

-- Returns the y position of this building.
---@return int r Y component of the pivot position of this building.
function Building:getY() end

-- Returns true iff this building needs a road connection and also has a road connection.
---@return bool r Whether the building has road or doesn't need it.
function Building:hasNeededRoad() end

-- Returns true iff this building has a road connection (even if it doesn't require one according to its json).
---@return bool r Whether the building has road.
function Building:hasRoad() end

-- Returns true iff this building has a specific upgrade applied to it.
---@param upgradeId string ID of an upgrade.
---@return bool r Whether the building has the specified upgrade.
function Building:hasUpgrade(upgradeId) end

-- Resumes an animation that is attached to this building.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Whether the specified animation is paused right now, nil if an error occurred.
function Building:isAnimationPaused(slot) end

-- Returns true iff this building is burning right now.
---@return bool r Whether this building is burning right now.
function Building:isBurning() end

-- Returns true iff this building is empty right now. This means that people left it. Only happens for RCI buildings.
---@return bool r Whether the building is empty.
function Building:isEmpty() end

-- Returns true iff this building has transport issues with dead bodies right now.
---@return bool r Whether the building has dead people in it.
function Building:isFullOfDeadPeople() end

-- Returns true iff this building is full of garbage right now.
---@return bool r Whether the building is full of garbage.
function Building:isFullOfWaste() end

-- Returns true iff this building contains ill people right now.
---@return bool r Whether there are ill people.
function Building:isIll() end

-- Returns true iff this building is in construction right now.
---@return bool r Whether the building is in construction.
function Building:isInConstruction() end

-- Determines whether this (RCI) building is untouchable. An untouchable building is protected in terms of it won't be replaced by automatically spawned buildings.
---@return bool r Whether the building is untouchable.
function Building:isUntouchable() end

-- Returns true iff this building has a pending upgrade right now.
---@return bool r Whether the building has an upgrade in progress.
function Building:isUpgradeInConstruction() end

-- Returns true iff this building is working right now. A working building has road connection if needed, is not in construction and is not empty. It also has power and water if needed.
---@return bool r Whether the building is working.
function Building:isWorking() end

-- Pauses an animation that is attached to this building.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Building:pauseAnimation(slot) end

-- Resumes an animation that is attached to this building.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@param speed? float A speed multiplier for the animation. (default 1.0)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Building:resumeAnimation(slot, speed) end

-- Sets the color of an animation of the building. The default color is white which is expressed as 255,255,255 or 255,255,255,255.
---@param red int The red color component.
---@param green int The green color component.
---@param blue int The blue color component.
---@param alpha? int The alpha color component that is considered as transparency. (default 255)
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Only true if the operation was successful.
function Building:setAnimationColor(red, green, blue, alpha, slot) end

-- Sets the current frame of an animation regardless of whether the animation is playing right now.
---@param frame int The frame to set.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Whether the operation was successful.
function Building:setAnimationFrame(frame, slot) end

-- Sets the current frame of the building.
---@param frame int The frame index to set. Starts at 0.
function Building:setFrame(frame) end

-- Sets a building icon. Note that game icons have higher precedence than custom ones.
---@param icon string | draft An animation draft to use as icon. Use nil to reset.
function Building:setIcon(icon) end

-- Sets the name of this building.
---@param name string | nil The name that should be used for the building. Use nil to reset it.
function Building:setName(name) end

-- Sets the performance of this building. The performance value will be clipped by the min and max value defined in the building's json.
---@param performance float The performance to set. 1.0 represents 100%.
function Building:setPerformance(performance) end

-- Sets a building text or resets it.
---@param text string The text to apply to the buiding. Use nil to remove it.
function Building:setText(text) end

-- Marks this (RCI) building as untouchable or touchable. An untouchable building is protected in terms of it won't be replaced by automatically spawned buildings.
---@param state? bool The untouchable state to set for the building. (default true)
function Building:setUntouchable(state) end


---@class Car Car library for TheoTown.
Car = {}
---@alias car Car

-- Returns an array of smart cars that are owned by the calling draft. Since this is a potentially heavy operatin you should only call it at rare points in time e.g. when a city gets entered.
---@return array r An array of cars that belong to the calling draft.
function Car.getCars() end

-- Spawns a car at a given position/position of a building that drives to the given target/building at the target. The car will actually not be spawned immediately but after a path has been calculated. This happens asynchronously since path calculation can take some time. You can provide a frame to determine the which variant of the car to use in case multiple variants are available. It will be choosen randomly by default.
---@param carDraft draft 
---@param startX int 
---@param startY int 
---@param targetX int 
---@param targetY int 
---@param frame? int (default nil)
---@param storage? table If you provide a table (may be empty) here the car will support smart car functionality like extended car event callbacks. (default nil)
---@param startLevel? int (default nil)
---@param targetLevel? int (default nil)
function Car.spawn(carDraft, startX, startY, targetX, targetY, frame, storage, startLevel, targetLevel) end

-- Adds a segment to the tail of a car.
---@param draft draft A car draft that will be used for the tail segment. In case of nil a placeholder car ($car_null00) will be used.
---@param position? int A one based tail index that indicates where the new tail segment should be inserted. If nil (default) the segment will appended at the end of the tail. (default nil)
---@param frame? int A zero based variant index that will be used for the car. In case of -1 a random variant will be used. (default -1)
function Car:addTail(draft, position, frame) end

-- Signals that the car should be deleted. It may not be deleted immediately due to the asynchronous behavior of car updates.
function Car:despawn() end

-- Will issue a new location for the car to drive to. Listening to smart car events will let you know whether the target can be reached.
---@param x int The x tile position to target.
---@param y int The y tile position to target.
---@param level? int The level to target. By default the game will try to match anything the car can drive to (e.g. buildings or roads). (default nil)
function Car:driveTo(x, y, level) end

-- Returns the overall capacity of a car. The capacity of a car is a generic integer value defined in the car draft(s). The default capacity of a car draft is 0. This function returns the accumulated capacity of the car itself and its tail segments.
---@return int r The overall capacity of the car.
function Car:getCapacity() end

-- Returns the current direction of the car.
---@return int r The current direction of the car (1=SE, 2=NE, 4=NW, 8=SW)
function Car:getDir() end

-- Returns the car draft of the car.
---@return draft r The car draft of the car.
function Car:getDraft() end

-- Returns the current effective speed of the car. The effective speed depends on road factors, car factors, target speed factors and so on.
---@return float r The current effective speed of the car.
function Car:getEffectiveSpeed() end

-- Returns the current frame of the car. The frame is actually the index of the variant determined by the total frames of the car / frames per variant. The first variant has index 0.
---@return int r The index of the current frame.
function Car:getFrame() end

-- Returns the current height level of the car.
---@return int r The height level of the car with 0 being ground.
function Car:getLevel() end

-- Returns the current target speed factor of the car.
---@return float r The current target speed factor of the car.
function Car:getSpeed() end

-- Returns the storage table of the car. The table was provided in the Car.spawn(...) car spawn request. Note that as usual you cannot store functions in the storage table as these cannot be serialized. (that means they won't be there after saving and loading the city)
---@return table r The storage table of the car.
function Car:getStorage() end

-- Returns the car draft of a tail segment.
---@param position int A one based tail index that indicates which tail segment should be queried.
---@return draft r The car draft of the tail segment.
function Car:getTailDraft(position) end

-- Returns the car frame of a tail segment.
---@param position int A one based tail index that indicates which tail segment should be queried.
---@return draft r The car frame of the tail segment.
function Car:getTailFrame(position) end

-- Returns the current x tile position of the car.
---@return int r The x tile position of the car.
function Car:getX() end

-- Returns the current postion and level of the car all at once.
---@return int,int,int r The x, y tile position and level (0=ground) of the car.
function Car:getXY() end

-- Returns the current y tile position of the car.
---@return int r The y tile position of the car.
function Car:getY() end

-- Returns true iff this car is valid. You should dispose the handle in case the car is not valid anymore. You cannot respawn it.
---@return bool r True iff the car is valid, false otherwise.
function Car:isValid() end

-- Removes a tail segment.
---@param position? int A one based tail index that indicates which tail segment should be removed. (default nil)
---@return bool r True iff a tail segment was removed.
function Car:removeTail(position) end

-- Removes the whole tail.
---@return bool r True iff at least one tail segment was removed.
function Car:removeWholeTail() end

-- Sets the current frame of the car. The frame is actually the index of the variant determined by the total frames of the car / frames per variant. The first variant has index 0.
---@param frame int The frame to set.
function Car:setFrame(frame) end

-- Returns the current target speed factor of the car.
---@param speed float The target speed factor of the car. Normal is 1.0.
function Car:setSpeed(speed) end

-- Sets the car frame of a tail segment.
---@param position int A one based tail index that indicates which tail segment should be modified.
---@param frame int The frame to set.
function Car:setTailFrame(position, frame) end

-- Returns the size of the tail of a car.
---@return int r Size of the tail. If the result is 0 then there is no tail.
function Car:tailSize() end


---@class City This library contains functions to access and modfiy city information, general buildings and roads.
---@field ACTIONPLACE_FIRE any Action place for fire alerts. Used for action place markers.
---@field ACTIONPLACE_GARBAGE any Action place for garbage alerts.
---@field ACTIONPLACE_MEDIC any Action place for medic alerts.
---@field ACTIONPLACE_POLICE any Action place for police alerts.
---@field ACTIONPLACE_SWAT any Action place for swat alerts.
---@field DISASTER_BLIZZARD any Identifier for blizzard disaster.
---@field DISASTER_CRIME any Identifier for crime disaster.
---@field DISASTER_EARTHQUAKE any Identifier for earthquake disaster.
---@field DISASTER_FIRE any Identifier for fire disaster. Used by City.getDisaster and City.issueDisaster.
---@field DISASTER_FLOODING any Identifier for flooding disaster.
---@field DISASTER_GREEN_SLIME any Identifier for green slime disaster.
---@field DISASTER_ILLNESS any Identifier for illness disaster.
---@field DISASTER_METEOR any Identifier for meteorite disaster.
---@field DISASTER_NUKE any Identifier for nuke disaster.
---@field DISASTER_PINK_SLIME any Identifier for pink slime disaster.
---@field DISASTER_RIOT any Identifier for riot disaster.
---@field DISASTER_TORNADO any Identifier for tornado disaster.
---@field DISASTER_UFO any Identifier for ufo disaster.
---@field HAPPINESS_EDUCATION any Name of education happiness
---@field HAPPINESS_ENVIRONMENT any Name of environment happiness
---@field HAPPINESS_FIREDEPARTMENT any Name of fire deparment happiness
---@field HAPPINESS_FREETIME any Name of free time happiness
---@field HAPPINESS_GENERAL any Name of general happiness
---@field HAPPINESS_HEALTH any Name of health happiness
---@field HAPPINESS_LEVEL any Name of level happiness. This is a hidden happiness which means that it is used for internal calculcations, only.
---@field HAPPINESS_PARK any Name of park happiness
---@field HAPPINESS_POLICE any Name of police happiness
---@field HAPPINESS_RELIGION any Name of religion happiness
---@field HAPPINESS_SPORT any Name of sport happiness
---@field HAPPINESS_SUPPLY any Name of supply happiness
---@field HAPPINESS_TAXES any Name of taxes happiness
---@field HAPPINESS_TRANSPORT any Name of transport happiness
---@field HAPPINESS_WASTE any Name of waste happiness
---@field HAPPINESS_ZONE any Name of zone happiness. This is a hidden happiness which means that it is used for internal calculcations, only.
---@field INFO_AIRPORT any Identifier for airport city information screen
---@field INFO_BUDGET any Identifier for budget city information screen
---@field INFO_EDUCATION any Identifier for education city information screen
---@field INFO_ENERGY any Identifier for energy city information screen
---@field INFO_GENERAL any Identifier for general city information screen
---@field INFO_HEALTH any Identifier for health city information screen
---@field INFO_LOAN any Identifier for loan city information screen
---@field INFO_NEIGHBOR any Identifier for neighbor city information screen
---@field INFO_RANK any Identifier for rank city information screen
---@field INFO_RATING any Identifier for rating city information screen
---@field INFO_RCI any Identifier for rci/demand city information screen
---@field INFO_STATISTICS any Identifier for statistics city information screen
---@field INFO_WATER any Identifier for water city information screen
---@field TAX_COMMERCIAL any Identifier for denoting commercial tax.
---@field TAX_INDUSTRIAL any Identifier for denoting industrial tax.
---@field TAX_RESIDENTIAL any Identifier for denoting residential tax.
City = {}
---@alias city City

-- Adds one or multiple event listeners for (specific) buildings in the city. Listeners will not be persisted so you may want to always register them in script:enterCity(). Listeners will not be called in any specific order.
---@param tbl table A table that holds named parameters.
function City.addBuildingListener(tbl) end

-- Adds one or multiple event listeners for (specific) roads in the city. Listeners will not be persisted so you may want to always register them in script:enterCity(). Listeners will not be called in any specific order.
---@param tbl table A table that holds named parameters.
function City.addRoadListener(tbl) end

-- Sets an action marker (or removes the one previously set there).
---@param actionPlaceType int 
---@param x int 
---@param y int 
function City.alert(actionPlaceType, x, y) end

-- Returns true if the specified amount of money can be spend by the city.
---@param amount int The amount to query whether it can be spent.
function City.canSpend(amount) end

-- Returns the overall amount of buildings. Optionally of a specific draft. This can for example be used to iterate over all buildings of a draft by using City.getBuilding(index, draft).
---@param draft? draft A building draft. (optional)
---@return int r Amount of buildings.
function City.countBuildings(draft) end

-- Returns the number of buildings of a specific building type.
---@param type string The building type to count. Can be one of "residential", "commercial", "industrial", "farm", "harbor ind", "harbor pier", "park", "sport", "public", "religion", "award", "energy", "water", "medic", "police", "swat", "fire brigade", "education", "bus depot", "destroyed", "decoration", "buoy", "railway station", "waste disposal", "body disposal", "military", "airport", "terrain", "landmark" or "building" (this one being a placeholder).
---@param level? int The level the buildings should have. If not specified the level of the buildings is ignored. Level 0 would be first level. (optional)
---@return int r The number of buildings of the specified type (and level).
function City.countBuildingsOfType(type, level) end

-- Returns number of cars that are active right now. This includes operatonal cars and trains.
---@return int r Cars in the city.
function City.countCars() end

-- Returns the overall amount of pipes in the city.
---@return int r The number of pipes.
function City.countPipes() end

-- Returns the overall amount of roads. Optionally of a specific draft. This can for example be used to iterate over all roads (of a draft) by using City.getRoad(index, draft).
---@param draft? draft A road draft. (optional)
---@return int r Amount of roads.
function City.countRoads(draft) end

-- Returns the overall amount of wires in the city.
---@return integer r The number of wires.
function City.countWires() end

-- Earns amount of the currency named name.
---@param name any string
---@param amount any number
function City.earnCurrency(name, amount) end

-- Earns some money. If x, y is provided (and >= 0) then the money will be drawn as if it was earned at the provided place (green text). If showOverlay is true and overlay for the money will be shown (default is false).
---@param amount int 
---@param x? int (optional)
---@param y? int (optional)
---@param showOverlay? bool (default false)
---@param budgetItem? draft (optional)
function City.earnMoney(amount, x, y, showOverlay, budgetItem) end

-- Enables or disables the automatic disaster of the given name.
---@param name string 
---@param state? bool true by default. (optional)
function City.enableDisaster(name, state) end

-- Executes a command as if it was entered into the console.
---@param cmd string The command to execute.
---@param receiver function A function with one parameter that will be called for any feedback.
function City.execute(cmd, receiver) end

-- Closes the current city and will go back to region view.
---@param save? bool Whether to save the city before exiting it. (default false)
function City.exit(save) end

-- Returns the current absolute day of the city.
---@return int r 
function City.getAbsoluteDay() end

-- Returns the name of the author that the player entered
---@return any r string
function City.getAuthor() end

-- Returns the current background draft of the city.
---@return draft r 
function City.getBackground() end

-- Gets the position of a specific building of a specific draft by it's index. The index starts with 1 and ranges up to City.countBuildings(draft).
---@param index int Index of the building, starting with 1.
---@param draft? draft (optional)
---@return int r X position of the building.
---@return int r Y position of the building.
function City.getBuilding(index, draft) end

-- Returns the total commercial jobs per level.
---@param level? int The level, 0, 1 or 2. If no level is provided the sum of all levels will be used. (optional)
---@param progress? bool If true, buildings that are in building process will be included. (default false)
---@return int r Amount of total commercial jobs.
function City.getCommercialJobs(level, progress) end

-- Returns the available amount of the currency of the given name. E.g. City.getCurreny('bus currency')
---@param name any string
---@return int r 
---@return string r 
function City.getCurrency(name) end

-- Returns the current day of the month of the city. The value ranges from 1 to 30.
---@return int r 
function City.getDay() end

-- Returns the current part of the day with 0 being the start and 1 being the end. You can use City.getDay() + City.getDayPart() as a game speed dependent time source that does not wrap around like City.getTime() does.
---@return int r 
function City.getDayPart() end

-- Returns the name of the curretly active disaster or nil if no disaster is is active right now.
---@return string r 
function City.getDisaster() end

-- Returns the name of the file of the city.
---@return any r string
function City.getFileName() end

-- Returns the value of the classic fun variable of the given name or fallbackValue if no such variable has been defined, yet. fallbackValue is 0 by default. Note that fun variables can only contain numbers. Use City.getStorage() or TheoTown.getStorage() to store more fancy stuff. Global fun variables are indicated by a leading ! in it's name.
---@param name string 
---@param fallbackValue? int (optional)
---@return int r 
function City.getFunVar(name, fallbackValue) end

-- Returns the average happiness.
---@param happinessType? string Type of a happiness, e.g. City.HAPPINESS_PARK. If not provided the general happiness will be returned. Be cautious, the calculcation for a specific type can be time consuming and should not be done every frame. (optional)
---@return float r 0..1 with 1 being happy
function City.getHappiness(happinessType) end

-- Height of the city in tiles
---@return any r int
function City.getHeight() end

-- Returns the ID of the city.
---@return string r ID of the city.
function City.getId() end

-- Returns the monthly income of the city.
---@return int r Income of the city in Theons.
function City.getIncome() end

-- Returns the total industrial jobs per level.
---@param level? int The level, 0, 1 or 2. If no level is provided the sum of all levels will be used. (optional)
---@param progress? bool If true, buildings that are in building process will be included. (default false)
---@return int r Amount of total residential jobs.
function City.getIndustrialJobs(level, progress) end

-- Returns the estate of the city.
---@return any r int The money of the city in Theon.
function City.getMoney() end

-- Returns the current month of the city. The value ranges from 1 to 12.
---@return int r 
function City.getMonth() end

-- Name of the current city
---@return any r string
function City.getName() end

-- Returns the id of the owner of the city if the city is online.
---@return any r string
function City.getOwnerId() end

-- Returns the name of the owner of the city if the city is online.
---@return any r string
function City.getOwnerName() end

-- Returns the number of the specified level (0, 1 or 2). Returns the number of all people if no level was specified.
---@param level any int optional
---@return int r 
function City.getPeople(level) end

-- Returns the index'th pipe's x,y location of the city. Can be used to iterate over all pipes of the city by using City.countPipes() to determine the overall amount of pipes.
---@param index int Index of the pipe, starting with 1.
---@return int r The x location and
---@return int r the Y location of the pipe at the given index.
function City.getPipe(index) end

-- Returns the play time in this city in seconds.
---@return int r Time in seconds.
function City.getPlayTime() end

-- Returns the current rank draft and the rank index.
---@return draft r The rank draft of the city.
---@return int r Index of the rank, starts with 0 for the first one.
function City.getRank() end

-- Returns the id of the region or nil if the city is not in a region. The id of a reqion is (in theory) unique. For online regions it is just a number.
---@return string r The id of the region or nil.
function City.getRegionId() end

-- Returns the name of the region this city is located in. Returns nil for for individual cities.
---@return string r Name of the region or nil.
function City.getRegionName() end

-- Returns the residential space (in buildings) per level.
---@param level? int The level, 0, 1 or 2. If no level is provided the sum of all levels will be used. (optional)
---@param progress? bool If true, buildings that are in building process will be included. (default false)
---@return int r Amount of residential space (unit is people).
function City.getResidentialSpace(level, progress) end

-- Gets the position and level of a specific road (of a specific draft) by it's index.
---@param index int 
---@param draft? draft (optional)
---@return int r X location
---@return int r Y location
---@return int r Level
function City.getRoad(index, draft) end

-- Returns the current rotation of the city. City rotation is expressed with an integer number 0 (unrotated), ..., 3
---@return any r int {0, 1, 2, 3}
function City.getRotation() end

-- Gets the current scaling of the city with 1.0 being no scaling.
---@return float r The scale of the city.
function City.getScale() end

-- Returns the seed that was used to generate the city
---@return any r string
function City.getSeed() end

-- Returns the current simulation speed of the city.
---@return int r The speed value.
function City.getSpeed() end

-- Use this storage table to save things city wide
---@return table r 
function City.getStorage() end

-- Returns the current taxes applied to a certain building type and level
---@param rci int Must be one of City.TAX_RESIDENTIAL, City.TAX_COMMERCIAL or City.TAX_INDUSTRIAL
---@param level int Must be an integer number in 1..3.
---@return number r The tax in percent. Will be in 0..100.
function City.getTax(rci, level) end

-- Returns the animation time of the game in milliseconds.
---@return int r 
function City.getTime() end

-- Returns the name of the currently opened tool. The default tool (that is selected when no other tool is open) has a name of "Default".
---@return string r The name of the opened tool.
function City.getToolName() end

-- Returns the tile position the camera is currently looking at as well as the current scale. Format: x, y, scale Note that this function does no terrain elevation adjustment unlike City.setView.
---@return int r 
---@return int r 
---@return float r 
function City.getView() end

-- Width of the city in tiles
---@return any r int
function City.getWidth() end

-- Returns the index'th wire's x,y,level location of the city. Can be used to iterate over all wires of the city by using City.countWires() to determine the overall amount of wires.
---@param index int Index of the wire, starting with 1.
---@return int r The X location and
---@return int r the Y location and
---@return int r the level location of the wire at the given index.
function City.getWire(index) end

-- Returns the amount of experience of the city.
---@return int r 
function City.getXp() end

-- Returns the current year of the city. The value starts at 1.
---@return int r 
function City.getYear() end

-- Returns a pseudo random positive 32bit integer number. The returned number is only dependent on the city and - if specified - on the provided x,y location. The returned value can be used to generate peusdo random values that are fixed per city/city and location. This can be useful to produce seemingly random but yet deterministic behavior.
---@param x? int (optional)
---@param y? int (optional)
---@return int r Positive pseudo random number.
function City.hash(x, y) end

-- Indicates whether this city is an online city.
---@return bool r True iff the city is online
function City.isOnline() end

-- Indicates whether this city is readonly. Cities that are readonly can not be saved. For example foreign cities in online regions are read only.
---@return bool r True iff the city is readonly
function City.isReadonly() end

-- Determines whether the city is in free or sandbox mode
---@return bool r 
function City.isSandbox() end

-- Returns true if uber is activated for that city.
---@return bool r Iff city is uber
function City.isUber() end

-- Issues the disaster of the given name at the given position x, y. Returns true iff disaster was issued successfully.
---@param name string The name of a disaster, e.g. City.DISASTER_FIRE
---@param x? int X position. Random by default. (default -1)
---@param y? int Y position. Random by default. (default -1)
---@param radius? int Radius for nuke disaster. (default 20)
---@param radioactive? bool Radioactivity for nuke disaster. (default true)
---@return bool r 
function City.issueDisaster(name, x, y, radius, radioactive) end

-- Loads a city file provided by the plugin. path is the file of the city file (thus it includes the .city file ending). Prior to loading the city will be copied to maps or private maps folder first (depending on private value). If a city of similar file name already exists at that directory it will be overridden if overwrite flag is set. The target file name can be changed by specifieing a target name.
---@param path string 
---@param overwrite? bool (optional)
---@param private? bool (optional)
---@param target? string (optional)
function City.load(path, overwrite, private, target) end

-- Moves the city according to the given screen space coordinates. Can be used to implement smooth scrolling similar to mouse / key / touch based one.
---@param x float 
---@param y float 
function City.move(x, y) end

-- Returns a noise value for the specified coordinates.
---@param x int 
---@param y int 
---@param z? int (optional)
---@param w? int (optional)
---@return float r Ranges from -1 to 1
function City.noise(x, y, z, w) end

-- Opens the city information screen of the given type.
---@param infoType string Use one of the constants mentioned above, e.g. City.INFO_GENERAL
function City.openInfo(infoType) end

-- Plays a sound.
---@param sound draft A sound draft or id of a sound draft.
---@param x int X coordinate of the sound's origin tile.
---@param y int Y coordinate of the sound's origin tile.
---@param volume? float A value between 0 and 1. (default 1)
---@param loop? bool Whether or not to loop the sound. (default false)
---@return table r A table that contains functions to control the sound.
function City.playSound(sound, x, y, volume, loop) end

-- Rebuilds the UI of the city view including the toolbar.
function City.rebuildUI() end

-- Saves the city if the user has autosave enabled. If enforce is set the city will even be saved if the user has autosave disabled. Don't call this function e.g. in event functions since they may be called from outside of the main thread. You can call it from a function passed to Runtime.postpone to fix that.
---@param enforce? bool Whether to enforce saving. (default false)
function City.save(enforce) end

-- Sets a new author name for the city.
---@param name string Name of the author
function City.setAuthor(name) end

-- Sets a background.
---@param draft draft An animation draft or it's id as a string. Use nil to set default background.
function City.setBackground(draft) end

-- Sets the value of a classic fun variable called name. Note that fun variables can only contain numbers. Use City.getStorage() or TheoTown.getStorage() to store more fancy stuff. Global fun variables are indicated by a leading ! in it's name.
---@param name string 
---@param value int 
function City.setFunVar(name, value) end

-- Sets a new city name
---@param newName any string
function City.setName(newName) end

-- Sets the rotation of the city
---@param r any 
---@return any r int {0, 1, 2, 3}
function City.setRotation(r) end

-- Sets the scale of the city with 1.0 being no scaling.
---@param scale float The scale to apply.
function City.setScale(scale) end

-- Sets the simulation speed of the city. The following values are allowed:
---@param speed int One of the values above.
function City.setSpeed(speed) end

-- Sets the view to a specified tile x, y using the provided scale. If no scale is provided the current scale will be used. Scale 1 means no scaling, 2 times scaling etc.
---@param x int 
---@param y int 
---@param scale? float (optional)
---@param adjustY? bool Adjust for terrain elevation (1.11.24) (default true)
function City.setView(x, y, scale, adjustY) end

-- Sets the experience amount of the city.
---@param xp int 
function City.setXp(xp) end

-- Shows a notification. See for an example.
---@param tableOfArguments table A table that contains all of the arguments that should be used for the notification.
function City.showNotification(tableOfArguments) end

-- Spends amount of the currency named name.
---@param name any string
---@param amount any int
function City.spendCurrency(name, amount) end

-- Spends some money. If x, y is specified it will show a red price at that location.
---@param amount int 
---@param x? int (optional)
---@param y? int (optional)
---@param budgetItem? draft (optional)
function City.spendMoney(amount, x, y, budgetItem) end


---@class DSA This library contains functions associated with the DSA integration.
DSA = {}
---@alias dSA DSA

-- Returns the supplies of DSA rocket station.
---@return int | nil r The supply count or nil if something went wrong.
function DSA.getSupplies() end

-- Returns true iff user is currently in moon.
---@return bool r Whether the user is in the moon or not.
function DSA.isInMoon() end


---@class Debug Functions for debugging.
Debug = {}
---@alias debug Debug

-- Logs a message into the debug overlay of the game. This function is meant to be used within the script:update() method since the log is cleared every frame. Calling this function opens the debug overlay automatically, so ensure to remove it in your production code.
---@param message1 any 
---@param message2? any (optional)
---@param message3? any (optional)
---@param ...? any (optional)
function Debug.info(message1, message2, message3, ...) end

-- Logs a message into the script internal log.
---@param message1 any 
---@param message2? any (optional)
---@param message3? any (optional)
---@param ...? any (optional)
function Debug.log(message1, message2, message3, ...) end

-- Shows the specified message as toast overlay. It's discouraged to call this function too often since new messages are postponsed if a previous message is still displayed.
---@param message1 any 
---@param message2? any (optional)
---@param message3? any (optional)
---@param ...? any (optional)
function Debug.toast(message1, message2, message3, ...) end


---@class Draft Draft library for TheoTown A draft can be considered a single "plugin object" like the template for a building.
Draft = {}
---@alias draft Draft

-- Adds a JSON code to the list of JSON codes that will be loaded by the game. Can only be called during the main call of the Lua script. That is, when the script's main body is called. Can be useful to generate JSON code dynamically.
---@param json string A string containing the JSON code to load.
function Draft.append(json) end

-- Calls the event function called name on all scripts if defined.
---@param name string 
---@param arg1? any (optional)
---@param arg2? any (optional)
---@param ...? any (optional)
function Draft.callAll(name, arg1, arg2, ...) end

-- Returns the draft of the given id. is returned if no draft of the given id was found.
---@param id string 
---@return draft r 
function Draft.getDraft(id) end

-- Returns an array of drafts that have the given tag defined. If no tag is provided this function returns a list of all available drafts.
---@param tag? string (optional)
---@return array r 
function Draft.getDrafts(tag) end

-- Merges the provided JSON object into the json object that is being loaded by the game right now. Can only be called during the main call of the Lua script. That is, when the script's main body is called. Can be useful to define JSON code dynamically for the current draft. Will only have an effect for attributes that were not read by the game, yet.
---@param json string A string containing the JSON code to merge. Must be a JSON object.
function Draft.merge(json) end

-- Calls the event function called name on all scripts of the draft if defined.
---@param name string 
---@param arg1? any (optional)
---@param arg2? any (optional)
---@param ...? any (optional)
function Draft:call(name, arg1, arg2, ...) end

-- Returns the author of the draft as defined in it's json definition.
---@return string r The author.
function Draft:getAuthor() end

-- Returns the bridge price defined for this road draft. The actual price for the bridge will depend on the actual height of it. For levels of 2 and more the bridge price will usually be used twice.
---@return int r The price of bridges.
function Draft:getBridgePrice() end

-- Returns the build height of the building. Only available for building drafts. The build height is the visiual height of the building divided by 8. Not to be confused with regular height which refers to the height of the basement of the building from top view.
---@return int r 
function Draft:getBuildHeight() end

-- For data drafts only: returns the raw json definition of the draft.
---@return table r The json object of the data draft as a Lua table.
function Draft:getContent() end

-- Returns the diamond price defined for this draft. Not all draft types support to have a price. In the desktop version of the game this function will always return 0.
---@return int r Diamond price or 0 if there was no diamond price set. nil if the draft does not support to have a dimaond price.
function Draft:getDiamondPrice() end

-- Returns a frame specified by its index (starting with 1).
---@param frameIndex? int (default 1)
---@return int r A frame, represented by a single number.
function Draft:getFrame(frameIndex) end

-- Returns the number of frames defined in that draft. Only available for draft types that use frames (e.g. buildings, roads and cars).
---@return int r 
function Draft:getFrameCount() end

-- Returns the frame type of a frame based on its index (starting with 1). The frame type is a 0-255 integer number that can be accessed from within the shader. The values 0-64 can be considered as reserved by the game.
---@param frameIndex? int (default 1)
---@return int r The frame type of the queried frame.
function Draft:getFrameType(frameIndex) end

-- Returns the height of the building. Only available for building drafts.
---@return int r 
function Draft:getHeight() end

-- Returns the ID of the draft.
---@return string r The draft ID.
function Draft:getId() end

-- Returns the wealth level of building drafts.
---@return int r The level of the building ranging from 0 to 2 with 0 being poor.
function Draft:getLevel() end

-- Returns the meta table of the draft if available. nil otherwise.
---@return table r 
function Draft:getMeta() end

-- Returns the monthly price defined for this draft. Not all draft types support to have a monthly price.
---@return int r 
function Draft:getMonthlyPrice() end

-- Returns the ordinality of the draft. In case of ranks this matches the rank index.
---@return int r 
function Draft:getOrdinal() end

-- Returns the plugin ID of the plugin the draft belongs to. Only plugins downloaded from Plugin Store have such an id.
---@return int r Plugin ID of the plugin the draft belongs to; 0 if the plugin was not downloaded from the Plugin Store or if the draft is not part of a plugin
function Draft:getPluginId() end

-- Returns the amount of power the building produces. Negative numbers indicate consumption. For buildings only.
---@return int r 
function Draft:getPower() end

-- Returns a preview frame specified by its index (starting with 1).
---@param frameIndex? int (default 1)
---@return int r A preview frame, represented by a single number.
function Draft:getPreviewFrame(frameIndex) end

-- Returns the number of preview frames defined in that draft. Preview frames are frames used to preview the draft in the toolbar.
---@return int r 
function Draft:getPreviewFrameCount() end

-- Returns the price defined for this draft. Not all draft types support to have a price.
---@return int r 
function Draft:getPrice() end

-- Returns an array of all attached scripts to this draft. modify the returned array.
---@return array r 
function Draft:getScripts() end

-- Returns the localized description of the draft.
---@return string r The description.
function Draft:getText() end

-- Returns the localized title of the draft.
---@return string r The title.
function Draft:getTitle() end

-- Returns the diamond price defined for this road draft. If a diamond price is set it will take precedence to a regular price.
---@return int r The diamond price of tunnels.
function Draft:getTunnelDiamondPrice() end

-- Returns the tunnel price defined for this road draft.
---@return int r The price of tunnels.
function Draft:getTunnelPrice() end

-- Returns a string that represents the concrete type of the draft.
---@return string r 
function Draft:getType() end

-- Returns the unified ID of the draft. The unified id is the id of the draft but adjusted to be used e.g. for file names. Duplicate unified ids are allowed.
---@return string r The unified draft ID.
function Draft:getUnifiedId() end

-- Returns the amount of water the building produces. Negative numbers indicate consumption. For buildings only.
---@return int r 
function Draft:getWater() end

-- Returns the width of the building. Only available for building drafts.
---@return int r 
function Draft:getWidth() end

-- Returns true iff the draft is a road draft and has automatic road decorations.
---@return bool r True if the road draft has road decorations
function Draft:hasDecorations() end

-- Returns iff the draft defines an animation.
---@return bool r 
function Draft:isAnimation() end

-- Returns iff the draft defines a building.
---@return bool r 
function Draft:isBuilding() end

-- Returns iff the draft defines a car.
---@return bool r 
function Draft:isCar() end

-- Returns iff the draft defines a category.
---@return bool r 
function Draft:isCategory() end

-- Returns iff the draft defines a commercial building.
---@return bool r 
function Draft:isCommercial() end

-- Returns true iff the building is a composition. Only available for building drafts.
---@return bool r True iff the building is a composition.
function Draft:isComposition() end

-- Returns iff the draft is declared as final (isFinal in json definition). Cannot be altered during runtime.
---@return bool r True iff this draft is final.
function Draft:isFinal() end

-- Returns iff the draft defines a ground type.
---@return bool r 
function Draft:isGround() end

-- Returns iff the draft defines a industrial building.
---@return bool r 
function Draft:isIndustrial() end

-- True unless the plugin is unloaded right now. This happens for example when the user enters a city in online mode that doesn't allow plugins.
---@return bool r True if the plugin is loaded, otherwise false.
function Draft:isLoaded() end

-- Returns true iff the draft is part of a plugin (also local ones).
---@return bool r True iff the draft is part of a plugin
function Draft:isPlugin() end

-- Returns true iff the draft is privileged.
---@return bool r True iff the draft is privileged
function Draft:isPrivileged() end

-- Returns iff the draft defines a building that is either residential, commercial or industrial.
---@return bool r 
function Draft:isRCI() end

-- Returns iff the draft defines a residential building.
---@return bool r 
function Draft:isResidential() end

-- Returns iff the draft defines a road.
---@return bool r 
function Draft:isRoad() end

-- Returns iff the draft defines a road decoration.
---@return bool r 
function Draft:isRoadDecoration() end

-- Returns iff the draft defines a draft template.
---@return bool r 
function Draft:isTemplate() end

-- Returns iff the draft defines a tree.
---@return bool r 
function Draft:isTree() end

-- Returns whether this draft is unlocked. A draft can be locked if e.g. it depends on a feature to be available.
---@return bool r True iff this draft is unlocked.
function Draft:isUnlocked() end

-- Returns iff the draft is visible (corresponds to negated hidden attribute in json).
---@return bool r 
function Draft:isVisible() end

-- Overrides a frame by index. Starting index is 1.
---@param frameIndex int The frame position to overwrite.
---@param frame int New frame.
function Draft:setFrame(frameIndex, frame) end

-- Sets the frame type of a frame based on its index (starting with 1). The frame type is a 0-255 integer number that can be accessed from within the shader. The values 0-64 can be considered as reserved by the game. You should only use frame types that are either defined by the game or were previously allocated using Drawing.allocateFrameType(). Use the frameType value 0 to indicate that the frame has no specific type (in this case Drawing.setFrameType will take precedence).
---@param frameIndex int 
---@param frameType int The frame type to set.
---@return int r The previously set frame type of the frame.
function Draft:setFrameType(frameIndex, frameType) end

-- Overrides a frame by index. Starting index is 1.
---@param frameIndex int The frame position to overwrite.
---@param frame int New preview frame.
function Draft:setPreviewFrame(frameIndex, frame) end

-- Sets the visibility state of the draft (corresponds to negated hidden attribute in json). For buildings the visibility state defined whether they are present in the toolbar. You may have to call City.rebuildUI() for the change to become visible in the toolarbar.
---@param state bool The new visibility state.
function Draft:setVisible(state) end


---@class Drawing Functions for drawing images and text.
Drawing = {}
---@alias drawing Drawing

-- Allocates a free frame type integer for use with Drawing.setFrameType. You should only call this function once during the lifecycle of the game to prevent clutter.
---@return int r A fresh frame type identifier.
function Drawing.allocateFrameType() end

-- Draws a frame.
---@param frame integer | draft A frame or draft (that contains at least one frame).
---@param x number The x coordinate for drawing.
---@param y number The y coordinate for drawing.
function Drawing.drawImage(frame, x, y) end

-- Draws a frame into a specified rectangle.
---@param frame integer | draft A frame or draft (that contains at least one frame).
---@param x number The x coordinate for drawing.
---@param y number The y coordinate for drawing.
---@param w number The width for drawing.
---@param h number The height for drawing.
function Drawing.drawImageRect(frame, x, y, w, h) end

-- Draws a line.
---@param x0 number X component of the start point.
---@param y0 number Y component of the start point.
---@param x1 number X component of the end point.
---@param y1 number Y component of the end point.
---@param width? number The width of the line. (default 1)
function Drawing.drawLine(x0, y0, x1, y1, width) end

-- Draws a nine patch into a specified rectangle. A nine patch is a set of 9 frames that are used to draw a rectangle with borders. All parts expect the corners are streched to match accordingly.
---@param frame integer | draft The base frame of the nine patch.
---@param x number The x coordinate for drawing.
---@param y number The y coordinate for drawing.
---@param w number The width for drawing.
---@param h number The height for drawing.
---@param sparse? boolean If true the center frame will not be drawn. (default false)
function Drawing.drawNinePatch(frame, x, y, w, h, sparse) end

-- Draws a quad using four corner points. If no frame is provided a white quad will be drawn.
---@param x0 number X component of the first point.
---@param y0 number Y component of the first point.
---@param x1 number X component of the second point.
---@param y1 number Y component of the second point.
---@param x2 number X component of the third point.
---@param y2 number Y component of the third point.
---@param x3 number X component of the fourth point.
---@param y3 number Y component of the foruth point.
---@param frame? integer | draft A frame or draft (that contains at least one frame). (default nil)
function Drawing.drawQuad(x0, y0, x1, y1, x2, y2, x3, y3, frame) end

-- Draws a filled rectangle.
---@param x number The x coordinate for drawing.
---@param y number The y coordinate for drawing.
---@param w number The width for drawing.
---@param h number The height for drawing.
function Drawing.drawRect(x, y, w, h) end

-- Draws a text.
---@param text string The text to draw.
---@param x number The x coordinate for drawing.
---@param y number The y coordinate for drawing.
---@param font? font The font to use. (default nil)
---@param centerX? number The relative x center for the pivot point (usually ranges from 0 to 1; 0.5 would be the center of the text). (default 0)
---@param centerY? number The relative y center for the pivot point (usually ranges from 0 to 1; 0.5 would be the center of the text). (default 0)
function Drawing.drawText(text, x, y, font, centerX, centerY) end

-- Draws a tile frame on the currently set tile. A tile frame is supposed to lay flat on the ground. The magic of this function is to draw the frame correctly on slopes. Use this function e.g. for drawing tool markers on the ground.
---@param frame integer | draft A frame or draft (that contains at least one frame).
function Drawing.drawTileFrame(frame) end

-- Draws a triangle. If no frame is provided a white triangle will be drawn. As the game is optimized to draw quads it is more efficient to draw a quad using Drawing.drawQuad rather than drawing two triangles.
---@param x0 number X component of the first point.
---@param y0 number Y component of the first point.
---@param x1 number X component of the second point.
---@param y1 number Y component of the second point.
---@param x2 number X component of the third point.
---@param y2 number Y component of the third point.
---@param frame? integer | draft A frame or draft (that contains at least one frame). (default nil)
function Drawing.drawTriangle(x0, y0, x1, y1, x2, y2, frame) end

-- Flushes the drawing pipeline. Can be used to synchronize when things are drawn. Normally frames are drawn in large batches for better performance.
function Drawing.flush() end

-- Returns the current additive factor for drawing.
---@return number r Additive factor ranging from 0 (not additive) to 1 (fully additive).
function Drawing.getAdditive() end

-- Returns the current transparency for drawing.
---@return number r Transparency value ranging from 0 (transparent) to 1 (opaque).
function Drawing.getAlpha() end

-- Returns the current drawing color.
---@return integer r Red comoponent of the drawing color.
---@return integer r Green comoponent of the drawing color.
---@return integer r Blue comoponent of the drawing color.
function Drawing.getColor() end

-- Returns the current part of the "visual day" with 0.5 being noon.
---@return number r A number 0..1 representing the visual day.
function Drawing.getDaytime() end

-- Returns the shading color that is used for the current day time.
---@return int,int,int r Three integers that represent the shading color.
function Drawing.getDaytimeColor() end

-- Gets the currently set frame type. The frame type is a 0-255 integer number that can be accessed from within the shader. The values 0-64 can be considered as reserved by the game.
---@return int r The currently set frame type.
function Drawing.getFrameType() end

-- Returns the handle of an image/frame.
---@param frame integer | draft A frame or draft (that contains at least one frame) for which the handle location will be queried.
---@return number r X handle of the frame (in pixels).
---@return number r y handle of the frame (in pixels).
function Drawing.getImageHandle(frame) end

-- Returns the size of an image/frame.
---@param frame integer | draft A frame or draft (that contains at least one frame) for which the size will be queried.
---@return number r Width of the frame (in pixels).
---@return number r Height of the frame (in pixels).
function Drawing.getImageSize(frame) end

-- Returns the current scale factors set by setScale.
---@return number r Scaling factor for x axis.
---@return number r Scaling factor for y axis.
function Drawing.getScale() end

-- Returns the current screen size width, height in pixels. Note that the result may change over time due to resolution changes.
---@return number r Screen width.
---@return number r Screen height.
function Drawing.getSize() end

-- Queries the drawing size for a given text.
---@param text string The text to calculate the size of (in pixels).
---@param font? font The font to calculate the size for. (default nil)
---@return number r Width required to draw the text.
---@return number r Height required to draw the text.
function Drawing.getTextSize(text, font) end

-- Resets all drawing properties. It's good practice to call this function before using other Drawing functions.
function Drawing.reset() end

-- Resets clipping so that draw functions affect all pixels again.
function Drawing.resetClipping() end

-- Sets the additive factor used for additive drawing. Additive drawing simply adds the colors to the background instead of mixing them.
---@param additive number The additivity factor to use. 0 being non additive, 1 being fully additive.
function Drawing.setAdditive(additive) end

-- Sets the transparency for drawing.
---@param alpha number The transparency to use. 0 being fully transparent, 1 being fully opaque.
function Drawing.setAlpha(alpha) end

-- Sets the clipping rect to a specified rectangle. Consecutive calls to drawing functions will only afftect pixels within that rectangle.
---@param x number The x coordinate for clipping.
---@param y number The y coordinate for clipping.
---@param w number The width for clipping.
---@param h number The height for clipping.
function Drawing.setClipping(x, y, w, h) end

-- Sets the drawing color. Component values range from 0 to 255 with 0,0,0 being black and 255,255,255 being white. When drawing things the drawing color is applied in a multiplicative way. So using white as drawing color won't alter the color of images when drawing.
---@param r integer Red component of the color.
---@param g integer Green component of the color.
---@param b integer Blue component of the color.
function Drawing.setColor(r, g, b) end

-- Sets a frame type that will be applied to the next drawn frames. The frame type is a 0-255 integer number that can be accessed from within the shader. The values 0-64 can be considered as reserved by the game. It is good practice to set the frame type to the previous value after you are done with it. You should only use frame types that are either defined by the game or were previously allocated using Drawing.allocateFrameType(). If you try to draw frames whose Draft:getFrameType is non zero that frame type will be used instead.
---@param frameType int The frame type to set.
---@return int r The previously set frame type.
function Drawing.setFrameType(frameType) end

-- Sets the scale for drawing (absolute). 1 for both of them would mean no scaling at all while values greater than 1 will scale things up. values smaller than 1 will draw things smaller.
---@param scaleX number Scaling factor for x axis.
---@param scaleY number Scaling factor for y axis.
function Drawing.setScale(scaleX, scaleY) end

-- Sets the current drawing offset and scale to a certain tile on the map.
---@param tileX integer X coordinate of the tile.
---@param tileY integer Y coordinate of the tile.
---@param offsetX? number X offset for drawing (in pixels). (default 0)
---@param offsetY? number Y offset for drawing (in pixels). (default 0)
---@param localScaleX? number Additional scaling factor for x axis. (default 1)
---@param localScaleY? number Additional scaling factor for y axis. (default 1)
function Drawing.setTile(tileX, tileY, offsetX, offsetY, localScaleX, localScaleY) end

-- Sets a uniform float vector that can be used in shaders. A uniform vector can hold up to 4 entries. If no entries are provided the uniform will be deleted.
---@param name string The name of the uniform variable in the shader
---@param v0 float The first vector entry
---@param v1? float The second vector entry (optional)
---@param v2? float The third vector entry (optional)
---@param v3? float The fourth vector entry (optional)
function Drawing.setUniform(name, v0, v1, v2, v3) end


---@class GUI Allows to access UI elements of the game.
GUI = {}
---@alias gui GUI

-- Shows a dialog on the screen. See the for the parameters that can be provided in the args table.
---@param args table A table that contains various parameters.
---@return table r A table that represents the dialog.
function GUI.createDialog(args) end

-- Shows a menu with various actions in it. An easy way to allow the user to pick from a set of things. See the for the parameters that can be provided in the args table.
---@param args table A table that contains the actions.
function GUI.createMenu(args) end

-- Shows a dialog that allows the user to enter some text. The game uses this dialog for rename operations, search query input and so on. You can use a textfield object instead if it suits your needs. Having a separate dialog prevents you from dealing with the quirks that some of the textfield implementations can have.
---@param args table A table that contains all of the parameters for the dialog creation. Usually all of the values are optional. See the example for available parameters.
---@return table r Returns a dialog table object similar to GUI.createDialog
function GUI.createRenameDialog(args) end

-- Shows a dialog that allows the user to select a single or multiple drafts from a list of drafts. This is for example used in the to allow the player to select species to plant.
---@param args table A table that contains all of the parameters for the dialog creation. Usually all of the values are optional. See the example for available parameters.
---@return table r Returns a dialog table object similar to GUI.createDialog
function GUI.createSelectDraftDialog(args) end

-- Finds a GUI object by its id. An id can be assigned to any GUI object to find it using this function. Some game made GUI objects also have an id that you can find using this function.
---@param id string 
---@return gui r object
function GUI.get(id) end

-- Returns the root GUI object. The root GUI object is a panel that streches along the whole screen. All other GUI objects are directly or indirectly children of this object. The padding of this object leaves space for e.g. notches. This means that the inner area of this object represents the safe area where you can place stuff.
---@return gui r object that has no parent
function GUI.getRoot() end

-- Adds a button object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created button object.
function GUI:addButton(args) end

-- Adds a canvas object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created canvas object.
function GUI:addCanvas(args) end

-- Adds a hotkey to a GUI object. If the button gets pressed the GUI objects onClick callback function will be called. Usually used for buttons.
---@param key number A keycode as defined in the Keys table.
function GUI:addHotkey(key) end

-- Adds an icon object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created icon object.
function GUI:addIcon(args) end

-- Adds a label object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created label object.
function GUI:addLabel(args) end

-- Adds a layout object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created layout object.
function GUI:addLayout(args) end

-- Adds a listbox object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created listbox object.
function GUI:addListBox(args) end

-- Adds a panel object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created panel object.
function GUI:addPanel(args) end

-- Adds a slider object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created slider object.
function GUI:addSlider(args) end

-- Adds a textfield object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created textfield object.
function GUI:addTextField(args) end

-- Adds a textframe object. See the for more information.
---@param args table A table that contains the GUI object creation parameters.
---@return gui r The created textframe object.
function GUI:addTextFrame(args) end

-- Returns the number of children GUI objects this object has.
---@return number r The number of children.
function GUI:countChildren() end

-- Removes this GUI object from the active GUI hierarchy which will effectively delete it.
function GUI:delete() end

-- Returns the top-most parent of this GUI object. This object is not valid anymore if its aboslute parent isn't the root GUI object. If the object has no parent the object itself will be returned.
---@return gui r The absolute parent GUI object.
function GUI:getAbsoluteParent() end

-- Returns the absolute x location of the GUI object. This matches the x coordinate you would use for drawing or would find in touchpoints.
---@return number r The absolute x location of the GUI object.
function GUI:getAbsoluteX() end

-- Returns the absolute y location of the GUI object. This matches the y coordinate you would use for drawing or would find in touchpoints.
---@return number r The absolute y location of the GUI object.
function GUI:getAbsoluteY() end

-- Gets a child by its index. The index ranges from 1 to :countChildren() of the parent object.
---@param index number The index of a child.
---@return gui r The GUI object of the given index.
function GUI:getChild(index) end

-- Gets the child index of this GUI object.
---@return number r The child index of this object.
function GUI:getChildIndex() end

-- Returns the height of the inner area of the GUI object. The inner height is the height that is available for child objects. That is the height minus the top and bottom padding.
---@return number r The height of the inner area.
function GUI:getClientHeight() end

-- Returns the width of the inner area of the GUI object. The inner width is the width that is available for child objects. That is the width minus the left and right padding.
---@return number r The width of the inner area.
function GUI:getClientWidth() end

-- Gets the font of a GUI object. Only text related objects support this function, e.g. labels, buttons, ... Text fields do not support this function.
---@return font r The font that is currently in use by that object.
function GUI:getFont() end

-- Returns the height of the GUI object.
---@return number r The height of the GUI object.
function GUI:getHeight() end

-- Gets the set icon of a GUI object.
---@return int r The frame of the currently used icon.
function GUI:getIcon() end

-- Gets id of the GUI object. An id can be assigned to any GUI object to identify it.
---@return string r Returns the id of the GUI object.
function GUI:getId() end

-- Returns the padding of this GUI object. Padding defines the distances between the inner area to the border of this object.
---@return number r Padding on the left side.
---@return number r Padding on the top side.
---@return number r Padding on the right side.
---@return number r Padding on the bottom side.
function GUI:getPadding() end

-- Returns the parent GUI object of this object. Can be if this is the root object or if this object is not valid anymore (that means not part of the active GUI hierarchy).
---@return gui r The parent GUI object.
function GUI:getParent() end

-- Returns the text of a GUI object. Only text related object support this function, e.g. labels, buttons, text fields, ...
---@return string r The current text of that object.
function GUI:getText() end

-- Returns the active touch point that is active in this GUI object if there is any and if this object is touch sensitive (like buttons, canvases, ...). The values returned are all nil otherwise.
---@return number r x Current absolute x location of the touch point.
---@return number r y Current absolute y location of the touch point.
---@return number r firstX Absolute x location of the touch point when it was initiated.
---@return number r firstY Absolute y location of the touch point when it was initiated.
---@return number r speedX X movement of this touch point since the last update.
---@return number r speedY Y movement of this touch point since the last update.
---@return number r time The unix time in ms when the touch point was initiated. Can be used for identifying the touch point.
function GUI:getTouchPoint() end

-- Returns the width of the GUI object.
---@return number r The width of the GUI object.
function GUI:getWidth() end

-- Returns the local x location of the GUI object relative to its parent.
---@return number r The x location of the GUI object.
function GUI:getX() end

-- Returns the local y location of the GUI object relative to its parent.
---@return number r The y location of the GUI object.
function GUI:getY() end

-- For text fields: returns whether the text field is currently selected for input.
---@return bool r True iff this text field is currently active.
function GUI:isActive() end

-- Returns whether this GUI object is enabled right now. A disabled object will not be clickable. Disabled buttons will be drawn differently.
---@return boolean r True if this object is enabled.
function GUI:isEnabled() end

-- Determines whether the mouse pointer is currently over the GUI object. Returns always false if there is no mouse pointer.
---@return bool r True if the mouse pointer is hovering the object.
function GUI:isMouseOver() end

-- Determines whether this GUI object is valid. A GUI object is valid if it's part of the current GUI hierarchy.
---@return boolean r True is this object is part of the active GUI hierarchy.
function GUI:isValid() end

-- Returns whether this GUI object is set to be visible right now.
---@return boolean r Returns true iff this GUI object is set to be visible.
function GUI:isVisible() end

-- Issues a recalculation of this GUI object's layout and its children. Calling this function should not be necessary since it will usually be called automatically when an object changes.
function GUI:layout() end

-- Removes a hotkey from the GUI object.
---@param key number The keycode of a key to remove.
---@return bool r Returns true iff such a hotkey was actually assigned.
function GUI:removeHotkey(key) end

-- Marks a text field as active, meaning that it will be focused for user input.
function GUI:setActive() end

-- Sets the child index of this GUI object. By changing the child index of an object you can alter the drawing order and/or listing order between this object and its siblings. The index should be in range 1 to :countChildren() of the parent object.
---@param index number The child index to apply to this object.
function GUI:setChildIndex(index) end

-- Enables or disables this GUI object. A disabled object will not be clickable. Disabled buttons will be drawn differently.
---@param state boolean Whether to enable this object.
function GUI:setEnabled(state) end

-- Sets the font of a GUI object. Only text related objects support this function, e.g. labels, buttons, ... Text fields do not support this function.
---@param font font The text to apply to this object.
function GUI:setFont(font) end

-- Sets the icon of a GUI object. Supported GUI objects are dialogs, buttons and icons.
---@param icon int The frame to use as an icon
function GUI:setIcon(icon) end

-- Sets the id of the GUI object. An id can be assigned to any GUI object to identify it.
---@param id string The id to apply to the GUI object.
function GUI:setId(id) end

-- Sets the padding of this GUI object.
---@param left number Padding on the left side.
---@param top number Padding on the top side.
---@param right number Padding on the right side.
---@param bottom number Padding on the bottom side.
function GUI:setPadding(left, top, right, bottom) end

-- Sets the position of that GUI object to the given location. The location is relative to the inner area of the parent object.
---@param x number X coordinate.
---@param y number Y coordinate.
function GUI:setPosition(x, y) end

-- Sets the visibility of the border and background of a textframe or listbox.
---@param state boolean The visibility state to apply to the border/background.
function GUI:setShowBorder(state) end

-- Sets the size of the GUI object.
---@param width number The width to set.
---@param height number The height to set.
function GUI:setSize(width, height) end

-- Sets the text of a GUI object. Only text related object support this function, e.g. labels, buttons, text fields, ...
---@param text string The text to apply to this object.
function GUI:setText(text) end

-- Sets the though through state of the GUI object. If this is set to true touch events will not be consumed by the object and therefore affect other GUI objects that are behind it.
---@param state bool True to enable the touch through option.
function GUI:setTouchThrough(state) end

-- Sets this GUI object to be visible or invisible.
---@param state boolean The visibility state to set.
function GUI:setVisible(state) end


---@class NeighborCity Neighbor City library for TheoTown.
NeighborCity = {}
---@alias neighborCity NeighborCity

-- Creates a new virtual neighboring city using the given id and name.
---@param id string A draft unique id that can be used to identify the neighbor. If a neighbor with the same id was already created it will be replaced by the new one.
---@param name? string A name that will be shown for the created city. If no name was provided the game will generate a random one. (default nil)
---@return neighborCity r A neighbor city object.
function NeighborCity.create(id, name) end

-- Returns the neighbor city object of this draft that has the given id.
---@param id string The id that should be found.
---@return neighborCity r The neighbor city object with the given id or nil if no such neighbor object exists.
function NeighborCity.get(id) end

-- Returns an array of all neighbor city objects that belong to this draft.
---@return array r An array of all virtual neighbor cities.
function NeighborCity.getNeighbors() end

-- Deletes this neighbor city so it can no longer be used for trading.
function NeighborCity:delete() end

-- Returns the amount of body disposal services this neighbor city can export.
---@return int r The amount of body disposal services that can be exported from the neighbor city.
function NeighborCity:getBodyDisposal() end

-- Returns the unique id of this neighbor city. The id is unique between the neighbor cities that belong to the calling draft.
---@return string r The id associated during the creation process.
function NeighborCity:getId() end

-- Returns the displayed name for this city.
---@return string r The name of the neighbor city.
function NeighborCity:getName() end

-- Returns the amount of power this neighbor city can export.
---@return int r The amount of power that can be exported from the neighbor city.
function NeighborCity:getPower() end

-- Returns the amount of power that gets exported (+) to / imported (-) from this neighbor city.
function NeighborCity:getPowerExport() end

-- Returns the amount of waste disposal services this neighbor city can export.
---@return int r The amount of waste disposal services that can be exported from the neighbor city.
function NeighborCity:getWasteDisposal() end

-- Returns the amount of water this neighbor city can export.
---@return int r The amount of water that can be exported from the neighbor city.
function NeighborCity:getWater() end

-- Determines whether this neighbor city object is valid.
---@return bool r True if this neighbor city object is still valid.
function NeighborCity:isValid() end

-- Sets the amount of body disposal services this neighbor city can export.
---@param amount int The amount of body disposal services that can be exported from the neighbor city.
function NeighborCity:setBodyDisposal(amount) end

-- Sets a visible name for this city.
---@param name string The new name of the neighbor city.
function NeighborCity:setName(name) end

-- Sets the amount of power this neighbor city can export.
---@param amount int The amount of power that can be exported from the neighbor city.
function NeighborCity:setPower(amount) end

-- Sets the amount of waste disposal services this neighbor city can export.
---@param amount int The amount of waste disposal services that can be exported from the neighbor city.
function NeighborCity:setWasteDisposal(amount) end

-- Sets the amount of water this neighbor city can export.
---@param amount int The amount of water that can be exported from the neighbor city.
function NeighborCity:setWater(amount) end


---@class Runtime Functions to access general runtime information.
Runtime = {}
---@alias runtime Runtime

-- Converts a json string into a lua table.
---@param json string 
---@return table r 
function Runtime.fromJson(json) end

-- Package id of the app, should be 'info.flowersoft.theotown.theotown'
---@return string r 
function Runtime.getId() end

-- Returns model name and manufacturer of the device.
---@return string r 
---@return string r 
function Runtime.getModel() end

-- Name of the application, should be 'TheoTown'
---@return string r 
function Runtime.getName() end

-- Returns the version code of the os (e.g. Android API level).
---@return number r 
---@return string r 
function Runtime.getOSVersion() end

-- Returns a string that represents that platform TheoTown is running on right now. E.g. 'android', 'ios' or 'desktop'.
---@return string r 
function Runtime.getPlatform() end

-- Unix timestamp in milliseconds
---@return int r 
function Runtime.getTime() end

-- Returns a random uuid string.
---@return string r 
function Runtime.getUuid() end

-- Current version of TheoTown, e.g. 1.5.15
---@return string r 
function Runtime.getVersion() end

-- Current version of TheoTown as number, e.g. 1515
---@return int r 
function Runtime.getVersionCode() end

-- Returns true iff game is currently running on a debug build. Should always return false.
---@return bool r 
function Runtime.isDebug() end

-- Returns true iff this copy of TheoTown is a premium version.
---@return bool r 
function Runtime.isPremium() end

-- Postpones the execution of a function. Postponed functions will be executed synchronously once per frame. You can optionally set a minimum time to wait until execution.
---@param func function The function that should be executed.
---@param delayMS? int Minimum amount of milliseconds to wait until execution. (optional)
function Runtime.postpone(func, delayMS) end

-- Converts a table into a json string.
---@param table table 
---@return string r 
function Runtime.toJson(table) end


---@class Script The unit scripts are organized in.
---@field EVENT_ALIGNED any Will be called for alignable buildings when their alignment was updated. New feature: This is a new feature that was added in version 1.11.09 See also: script:event
---@field EVENT_CAR_DESPAWNED any Will be called for building with car spawner whenever a car was despawned.
---@field EVENT_CAR_REACHED any Will be called for building with car spawner whenever a car reached it's target.
---@field EVENT_CAR_SPAWNED any Will be called for building with car spawner whenever a car was spawned.
---@field EVENT_FINISHED any Will be called for building and road drafts right after construction. That is immediately after placements for roads and for buildings witht zero buildtime. Note that this function will also be called after a building was built after it was moved. If there is no build time, e.g. in sandbox mode, this call happens immediately after EVENT_PLACED and does not reflect the final properties of the building like upgrades. For that you could use Runtime.postpone to do the check for properties a bit later.
---@field EVENT_PLACED any Will be called for building and road drafts right after placement. Note that this function will also be called after a building was moved. See also: script:event
---@field EVENT_REMOVE any Will be called for scripts attached to a building or road the moment before it gets removed.
---@field EVENT_REPLACED any Will be called for building and road drafts after they have been built again either by user issued undo or redo action. New feature: This is a new feature that was added in version 1.10.79 See also: script:event
---@field EVENT_TOOL_ENTER any Will be called for scripts attached to a generic tool when users selects the tool.
---@field EVENT_TOOL_LEAVE any Will be called for scripts attached to a generic tool when users closes the tool. Be aware of that the tool will not be closes automatically when the user leaves the city.
---@field EVENT_UPGRADE any Will be called for scripts attached to a building after an upgarde of it was finished.
Script = {}
---@alias script Script

-- Returns the current script or if no script is running right now. Since scripts are executed synchronously to avoid race conditions there can only be one script running.
---@return script r 
function Script.getScript() end

-- Returns an array of all scripts, or, if tag is specified, an array of all scripts that defined the given tag. Don't manipulate the returned array directly.
---@param tag? any (optional)
---@return array r 
function Script.getScripts(tag) end

-- Adds a script to a draft. Only call this method in the init or lateInit methods to ensure that it will be executed correctly. However, init and/or lateInit might not be called on the new script automatically. Format of initializer: initializer(script) If no initializer is provided the own initializer will be used. Returns the newly created script.
---@param name string 
---@param draft draft 
---@param initializer? function (optional)
---@return script r 
function Script:addScript(name, draft, initializer) end

-- Adds a tag to this script. Tags can be used to find scripts by using .
---@param tag any 
function Script:addTag(tag) end

-- Returns the draft the script is attached to. Every script instance is attached to exactly one draft. However, multiple instances of the same script may be attached to different drafts.
---@return draft r 
function Script:getDraft() end

-- Every script is uniquely identified by a single number. Note that this identifier is only constant during runtime. It may be different in the next session, therefore you shouldn't rely on it.
---@return int r 
function Script:getId() end

-- Returns a readable location identifier that contains the draft id.
---@return string r 
function Script:getLocation() end

-- Returns the name of the script. E.g. the name of a script
---@return string r 
function Script:getName() end

-- Returns the parent script if there is any, otherwise. A parent script is the script that instantiated this script using Scripts are usually not instantiated by other scripts.
---@return script r 
function Script:getParent() end

-- Returns an array of all parent scripts.
---@return array r 
function Script:getParents() end

-- Returns the relative path of the script.
---@return string r 
function Script:getPath() end

-- Returns an array that contains the tags that have been defined for that script.
---@return array r 
function Script:getTags() end

-- Determines whether the script is active right now.
---@return bool r 
function Script:isActive() end

-- Activates or disables the script. No event methods will be called on disabled scripts. A disabled script cannot re-enable itself since it won't be updated anymore.
---@param state bool 
function Script:setActive(state) end

-- Will be called after the city GUI was built. When entering the city stage this method will not always be called due to GUI caching.
function Script:buildCityGUI() end

-- Will be called when users taps on a building/road of this draft while being in default tool. Return false to prevent opening the default tile dialog. You should favor this method over earlyTap() and tap() as they operate indepently of tile dialog and selected tool and don't take the own draft into consideration. This method will also be called for custom tools if user taps on a tile and script:isBuildable() returned true for it.
---@param x number 
---@param y number 
---@param level number 
function Script:click(x, y, level) end

-- Will be called on a daily basis for every building or road that are instances of the owning draft. Level is 0 for buildings.
---@param x any int
---@param y any int
---@param level any int
function Script:daily(x, y, level) end

-- Will be called when this script is about to be disabled.
function Script:disable() end

-- Will be called after a building/road instance has been drawn. Will also be called on all visible tiles for custom tools. For tools, instead of level there are two integer parameters tx, ty which are either -1,-1 if no mouse pointer is present, or the tile coords the mouse pointer is currently over.
---@param x int 
---@param y int 
---@param level int 
function Script:draw(x, y, level) end

-- This event function will be called right after the city was drawn. If you want to draw something directly on top of the city it's a good idead to do it in here.
function Script:drawCity() end

-- Will be called on all scripts before script:init(). Use this method to set up early things.
function Script:earlyInit() end

-- Will be called when the user taps on the map. Will be called just before the tap is handled by the current tool. Let it return false in case you do not want the current tool to handle this tap.
---@param tileX number 
---@param tileY number 
---@param x number 
---@param y number 
function Script:earlyTap(tileX, tileY, x, y) end

-- Will be called when this script is about to be enabled. Scripts are enabled by definiton right after their creation so this method won't be called then.
function Script:enable() end

-- Will be called when the user enters a city.
function Script:enterCity() end

-- Will be called right before a new city is generated.
---@param phase number Will be 0 for first pass and 1 for decoration creation
function Script:enterCityGeneration(phase) end

-- Will be called whenever the user enters a stage. A stage is for example a city, the settings screen or the gallery.
---@param name string A readable name of the stage.
function Script:enterStage(name) end

-- Will be called for building/road/tool events of instances of the owning draft. Level is 0 for buildings. Be careful not to do any meaningful work when receiving removal event since that could cause cassade enless calling of event functions. Use Runtime.postpone() to prevent that.
---@param x int The x location of the event. The targeted building's pivot x location for car related events.
---@param y int Same as x but for y coordinate.
---@param level int The level of the event. The selected car frame for car related events.
---@param event int Event number (see listing above)
---@param source draft The car draft in case of car events, nil otherwise.
function Script:event(x, y, level, event, source) end

-- Will be called when the game gets closed. There is no guarantee that This function will actually be called.
function Script:exit() end

-- Gets called after the information dialog for buildings and/or roads was built. Only gets called for buildings/roads this script is attached to.
---@param x number X coordinate of the building or road.
---@param y number Y coordinate of the building or road.
---@param lvl number For roads only: the level of the road.
---@param dialog table A dialog table as it is returned by GUI.createTable(...).
function Script:finishInformationDialog(x, y, lvl, dialog) end

-- Will be called once after all drafts and scripts have been loaded.
function Script:init() end

-- For buildings and roads only: Will be queried to determine if a building/road can be built at a specific location. To prevent buildability just let it return false. Is also queried for custom tools to determine buildability.
---@param x any int
---@param y any int
---@param level any int
function Script:isBuildable(x, y, level) end

-- Will be called once after script:init() has been called on all scripts. Use this method for things that relay on other scripts' setup.
function Script:lateInit() end

-- Will be called when the user leaves the city. Don't rely on this method to permanently save state since there's no guarantee that this method will be called.
function Script:leaveCity() end

-- Will be called after city generation process was completed.
---@param phase any 
function Script:leaveCityGeneration(phase) end

-- Will be called whenever the user leaves a stage. A stage is for example a city, the settings screen or the gallery.
function Script:leaveStage() end

-- Will be called after lateInit and when the draft is reloaded after it was unloaded e.g. for an online mode region that does not allow plugins.
function Script:load() end

-- Will be called on a daily basis for each script.
function Script:nextDay() end

-- Will be called on a monthly basis for each script.
function Script:nextMonth() end

-- Will be called on a yearly basis for each script.
function Script:nextYear() end

-- Gets called for smart cars when the car was despawned.
---@param car car A car object that can be used to control the car.
function Script:onCarDespawned(car) end

-- Gets called for smart cars when a car did not find a way.
---@param car car A car object that can be used to control the car.
function Script:onCarFoundNoWay(car) end

-- Gets called for smart cars when the car found a way to a destination.
---@param car car A car object that can be used to control the car.
function Script:onCarFoundWay(car) end

-- Gets called for smart cars when the car could not be spawned. The provided storage table of the not spawned car can be used to identify which City.spawnCar request failed.
---@param storage table The storage table that was used in City.spawnCar(...)
function Script:onCarNotSpawned(storage) end

-- Gets called for smart cars when the car reached it's destination.
---@param car car A car object that can be used to control the car.
function Script:onCarReached(car) end

-- Gets called for smart cars when the car was spawned.
---@param car car A car object that can be used to control the car.
function Script:onCarSpawned(car) end

-- Will be called once per frame after UI has been drawn. Will also be called outside of cities.
function Script:overlay() end

-- Will be called every day for scripts whose owning draft is a building or road. x and y is a random (valid) postion on the map.
---@param x number 
---@param y number 
function Script:random(x, y) end

-- Will be called just before the city is saved.
function Script:save() end

-- Will be called when rebuilding the settings page of the game. Can return a table contains settings items that will then be displayed. See on how to use it.
function Script:settings() end

-- Will be called when the user taps on the map. Will be called just after the tap is handled by the current tool.
---@param tileX number 
---@param tileY number 
---@param x number 
---@param y number 
function Script:tap(tileX, tileY, x, y) end

-- Will be called before the plugin get's unloaded. This happens for example when the user enters a city in online mode that doesn't allow plugins.
function Script:unload() end

-- Will be called per frame for each script while a city is open. Can be used to draw stuff on the screen (under the UI). Use overlay() do draw on top of UI and/or outside of cities.
function Script:update() end


---@class TheoTown TheoTown specific functions that don't fit into other libraries.
TheoTown = {}
---@alias theoTown TheoTown

-- Executes a command as if it was entered into the console.
---@param cmd string The command to execute.
---@param receiver function A function with one parameter that will be called for any feedback.
function TheoTown.execute(cmd, receiver) end

-- Formats a number a an amount of money and appends the Theon symbol. Optionally prefixes a + sign for positive numbers if signed is set to true.
---@param amount number The amount of money to format.
---@param signed? boolean If set to true the plus sign may be prefixed. (default false)
---@return string r The formatted money.
function TheoTown.formatMoney(amount, signed) end

-- Formats a (big) number. Optionally prefixes a + sign for positive numbers if signed is set to true.
---@param amount number The number to format.
---@param signed? boolean If set to true the plus sign may be prefixed. (default false)
---@param abbreviate? boolean Set this to false to not abbreviate. (default true)
---@return string r The formatted number.
function TheoTown.formatNumber(amount, signed, abbreviate) end

-- Returns the number of diamonds that the user currently has.
---@return number r Amount of diamonds that the user currently has.
function TheoTown.getDiamonds() end

-- Returns a game wide storage table that's backed by an actual file. The file will even persist if the user deleted the game. Only a deletion of the TheoTown folder will reset this storage.
---@return table r Persistent game wide storage table.
function TheoTown.getFileStorage() end

-- Returns the value of the global fun variable of the given name or fallbackValue if no such variable has been defined, yet. fallbackValue is 0 by default. Note that fun variables can only contain numbers. Use City.getStorage() or TheoTown.getStorage() to store more fancy stuff. Global fun variables are indicated by a leading ! in their name.
---@param name string 
---@param fallbackValue? number (optional)
---@return number r Value of the variable or the fallback value
function TheoTown.getGlobalFunVar(name, fallbackValue) end

-- Returns the play time in the game in seconds.
---@return number r Play time in seconds.
function TheoTown.getPlayTime() end

-- Returns a game wide storage table. Use it to save data permanently across all cities.
---@return table r Game wide storage table.
function TheoTown.getStorage() end

-- Returns the name of the current logged in user or nil if the player is not logged in.
---@return string r Name of the current user or nil if the player is not logged in.
function TheoTown.getUserName() end

-- Returns true iff this version of the game is capable of running multiplayer mode.
---@return bool r Whether the game is capable of running multiplayer mode or not.
function TheoTown.isMultiplayer() end

-- Loads a city file provided by the plugin. path is the file of the city file (thus it includes the .city file ending). Prior to loading the city will be copied to maps or private maps folder first (depending on private value). If a city of similar file name already exists at that directory it will be overridden if overwrite flag is set. The target file name can be changed by specifieing a target name.
---@param path string 
---@param overwrite? bool (optional)
---@param private? bool (optional)
---@param target? string (optional)
function TheoTown.loadCity(path, overwrite, private, target) end

-- Plays a sound.
---@param sound draft A sound draft or id of a sound draft.
---@param volume? number A value between 0 and 1. (default 1)
---@param loop? boolean Whether or not to loop the sound. (default false)
---@return table r A table that contains functions to control the sound.
function TheoTown.playSound(sound, volume, loop) end

-- Registers a function that can then by called from console. Instead of a name you can provide a function that returns true for commands the second function should handle.
---@param name string | function 
---@param action function A function that will be called when the command got entered.
function TheoTown.registerCommand(name, action) end

-- Sets the value of a global fun variable called name. Note that fun variables can only contain numbers. Use City.getStorage() or TheoTown.getStorage() to store more fancy stuff. Global fun variables are indicated by a leading ! in their name.
---@param name string 
---@param value number 
function TheoTown.setGlobalFunVar(name, value) end

-- Spends amount diamonds if possible.
---@param amount number 
---@return bool r Whether spending was successful.
function TheoTown.spendDiamonds(amount) end

-- Translates an id into the corressponding string. Instead of TheoTown.translate('key') you can write Translation.key for convenience.
---@param id string The ID of a translation to translate.
---@return string r The translation.
function TheoTown.translate(id) end

-- Resolves the translation of an inline translation string. Such a string may look like "default[de]German[fr]French...". The result will be the appropriate part based on language settings.
---@param str string A packed string to prick a translation from.
---@return string r The picked translation.
function TheoTown.translateInline(str) end


---@class Tile Contains functions to query single tiles for information about objects on them.
---@field INFLUENCE_BODY_DISPOSAL any Body disposal influence type.
---@field INFLUENCE_COMMERCIAL any Commercial influence type.
---@field INFLUENCE_CULTURE any Culture influence type.
---@field INFLUENCE_DENSITY any Density influence type.
---@field INFLUENCE_EDUCATION_HIGH any High education influence type.
---@field INFLUENCE_EDUCATION_LOW any Low education influence type.
---@field INFLUENCE_FIREDEPARTMENT any Fire department influence type.
---@field INFLUENCE_HEALTH any Health influence type.
---@field INFLUENCE_INDUSTRIAL any Industrial influence type.
---@field INFLUENCE_LEVEL_HIGH any High level influence type.
---@field INFLUENCE_LEVEL_LOW any Low level influence type.
---@field INFLUENCE_LEVEL_MIDDLE any Medium level influence type.
---@field INFLUENCE_MANAGEMENT any Management influence type.
---@field INFLUENCE_NATURE any Nature influence type.
---@field INFLUENCE_NOISE any Noise influence type.
---@field INFLUENCE_PARK any Park influence type.
---@field INFLUENCE_PASSENGER_BUS any Bus passenger influence type.
---@field INFLUENCE_PASSENGER_TRAIN any Train passenger influence type.
---@field INFLUENCE_POLICE any Police influence type.
---@field INFLUENCE_POLLUTION any Pollution influence type.
---@field INFLUENCE_RADIOACTIVITY any Radioactivity influence type.
---@field INFLUENCE_RELIGION any Religion influence type.
---@field INFLUENCE_RESIDENTIAL any Residential influence type.
---@field INFLUENCE_SPORT any Sport influence type.
---@field INFLUENCE_TRAFFIC any Traffic influence type.
---@field INFLUENCE_WASTE_DISPOSAL any Waste disposal influence type.
Tile = {}
---@alias tile Tile

-- Abandons the building at the given location.
---@param x int X component of a position.
---@param y int Y component of a position.
function Tile.abandonBuilding(x, y) end

-- Returns the bridges number of the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r The bridges number of the road or zero if there's no road and or bridge frames.
function Tile.countRoadBridgeType(x, y, level) end

-- Returns the number of decorations on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r The number of decorations on the road or zero if there's no road and or decorations.
function Tile.countRoadDecos(x, y, level) end

-- Extinguishes the fire of a building at a given position.
---@param x int X component of a building position.
---@param y int Y component of a building position.
function Tile.extinguishBurningBuilding(x, y) end

-- Returns a building object that can be use to call building related functions more conveniently.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return building r A building object with convenient functions.
function Tile.getBuilding(x, y) end

-- Gets the color of an animation of a building. The default color is white which is expressed as 255,255,255,255.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int,int,int,int | nil r If the operation was successful the color is returned as four integer numbers.
function Tile.getBuildingAnimationColor(x, y, slot) end

-- Returns the current frame of an animation that is attached to a building.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Tile.getBuildingAnimationFrame(x, y, slot) end

-- Returns the number of days since this building was constructed. Negative values indicate non finished buildings.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return int r 
function Tile.getBuildingDaysBuilt(x, y) end

-- Returns the draft of a building at a given position.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return draft r 
function Tile.getBuildingDraft(x, y) end

-- Returns the draw pivot position of the building at a given position. You can use the result for use in Drawing.setTile() to get rotation independent drawing based on the building's left most point.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return int,int r X and Y component of the drawing tile position of the building.
function Tile.getBuildingDrawXY(x, y) end

-- Returns the current frame of a building at a given position.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return int r The zero based building frame if there is a building.
function Tile.getBuildingFrame(x, y) end

-- Gets the currently set custom building icon for the specified building.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return draft r The currently used animation draft or nil.
function Tile.getBuildingIcon(x, y) end

-- Gets the name of a building
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return string | nil r Name of the building or nil if no name is set.
function Tile.getBuildingName(x, y) end

-- Returns the current performance of a building at a given position. 1.0 represents 100%.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return float r 
function Tile.getBuildingPerformance(x, y) end

-- Returns the storage table of the building at a given position. Storage tables can be used to save information into cities/buildings/roads permanently.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return table r 
function Tile.getBuildingStorage(x, y) end

-- Returns the pivot position of a building at a given position. That point can differ from the queried position for buildings that have a size bigger than 1.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return int,int r X and Y component of the pivot position of the building.
function Tile.getBuildingXY(x, y) end

-- Returns the draft of the bus stop on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return draft r 
function Tile.getBusStop(x, y, level) end

-- Returns the terrain height of the tile corner at a given position. Valid locations range from 0,0 to widht,height (inclusive) so the corners at the right edges of the city can be addressed. In contrast to "ground height" terrain height refers to the hill functionality that was added with the TheoTown66 release. A height step is 12 pixels in size visually. Ocean level has height 0. Smaller values are not possible.
---@param x int X component of a corner position.
---@param y int Y component of a corner position.
---@return int r An int value that indicates the height of the terrain at the corner.
function Tile.getCornerTerrainHeight(x, y) end

-- Returns the fence draft of the fence at the given location at the given edge. As fences are technically placed in-between tiles two neighboring tiles always share an edge in between them.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param edge int Fences can be located at all four edges of a tile. The edges are indexed as follows (for non rotated city): 0 is south-east, 1 is north-east, 2 is north-west, 3 is south-west
---@return draft | nil r The fence draft or nil if there is no fence.
function Tile.getFenceDraft(x, y, edge) end

-- Returns the ground draft at a given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level? int Level to query, must be -1 (water), 0 (main) or 1 (deco). Level -1 queries the water draft that is used to draw water for this tile. The water draft is determined by the level 0 draft of this and neighboring tiles. The default water draft will be returned if there are no water tiles nearby. (default 0)
---@return draft r 
function Tile.getGroundDraft(x, y, level) end

-- Returns the legacy ground height at a given position. Ground height is a legacy system used for terrain shading and water depth coloring. It was added to the game before there were actual hills.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return int r An integer that represents height. 0 means ocean level. Negative values are possible.
function Tile.getGroundHeight(x, y) end

-- Returns the influence value of a influence type at a given position.
---@param influenceType int A influence type constant like Tile.INFLUENCE_PARK.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return float r A number in 0..1. 1 Means the influence is maxed out.
function Tile.getInfluence(influenceType, x, y) end

-- Returns the draft of the pipe at a given location.
---@param x int X component of a location.
---@param y int Y component of a location.
---@return draft | nil r The draft of the pipe if there is any.
function Tile.getPipeDraft(x, y) end

-- Returns the active frame of the pipe at a given location. This frame is independent of city rotation.
---@param x int X component of a location.
---@param y int Y component of a location.
---@return int | nil r The zero based frame index of the pipe if there is a pipe.
function Tile.getPipeFrame(x, y) end

-- Returns the absolute level of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int | nil r The absolute level of the road. The absolute level is the road level reduced by the terrain height.
function Tile.getRoadAbsoluteLevel(x, y, level) end

-- Returns the alignment of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int | nil r The absolute alignment of the road with a range from 0 to 15.
function Tile.getRoadAlign(x, y, level) end

-- Returns the bridge type of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int | nil r The bridge type of the road depends of the road bridge frames.
function Tile.getRoadBridgeType(x, y, level) end

-- Returns the absolute car counter of the road at a given position and level. The car counter is incremented for each car that has entered that road. You can use it to track the number of passed by cars in a certain time frame.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r Amount of cars.
function Tile.getRoadCarCount(x, y, level) end

-- Returns the absolute chargeable car counter of the road at a given position and level. The car counter is incremented for each chargeable car that has entered that road. You can use it to track the number of passed by chargeable cars in a certain time frame.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r 
function Tile.getRoadChargeableCarCount(x, y, level) end

-- Returns the draft of the road decoration on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@param index? int Index of the decoration. Starts with 1. (default 1)
---@return draft r 
function Tile.getRoadDeco(x, y, level, index) end

-- Returns the direction of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int | nil r The direction of the road. The directions are indexed as follows (for non rotated city): 1 is east direction, 2 is north direction, 4 is west direction, 8 is south direction.
function Tile.getRoadDirection(x, y, level) end

-- Returns the draft of the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return draft r Road draft object of the road.
function Tile.getRoadDraft(x, y, level) end

-- Returns the frame of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r The frame of the road. Typically ranges from 0 to 15 dependent on the alignment (regardless city rotation).
function Tile.getRoadFrame(x, y, level) end

-- Returns the draft of the road occupcation on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level? int A road level with 0 being ground. (default 0)
---@return animationdraft r The draft used for the occupation or nil if no occupation is set.
function Tile.getRoadOccupation(x, y, level) end

-- Returns the bridge entrance or exit direction of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return int r The bridge entrance or exit direction of the road. The directions are indexed as follows (for non rotated city): 0 flat road direction. 1 east entrance direction | west exit direction. 2 north entrance direction | south exit direction. 4 west entrance direction | east exit direction. 8 sout exit direction | north exit direction.
function Tile.getRoadSlopeDirection(x, y, level) end

-- Returns the storage table of the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return table r The table can be used to save information permanently in a road.
function Tile.getRoadStorage(x, y, level) end

-- Returns the amount of traffic on a road tile.
---@param x int X component of a road position.
---@param y int Y component of a road position.
---@param level int A road level with 0 being ground.
---@return float r 0..1 with 1 being high traffic
function Tile.getRoadTraffic(x, y, level) end

-- Returns the average terrain height at a given position. Interpolates between the height of all four edges in case of a slope. In contrast to "ground height" terrain height refers to the hill functionality that was added with the TheoTown66 release. A height step is 12 pixels in size visually. Ocean level has height 0. Smaller values are not possible.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return float r A float value that indicates the height of the terrain.
function Tile.getTerrainHeight(x, y) end

-- Returns the draft of the tree at the given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return draft r 
function Tile.getTreeDraft(x, y) end

-- Returns the frame of the tree at the given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return int r The zero based frame index of the tree
function Tile.getTreeFrame(x, y) end

-- Returns the draft of the wire at a given location.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param level? int Level of the wire to look for. The level of normal wires is 0 (-1 for underground and 1 for long distance wires). (default 0)
---@return draft | nil r The draft of the wire if there is any.
function Tile.getWireDraft(x, y, level) end

-- Returns the frame of the wire at a given location. Frame indices are zero based and city rotation independent.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param level? int Level of the wire to look for. The level of normal wires is 0 (-1 for underground and 1 for long distance wires). (default 0)
---@return int | nil r The zero based frame of the wire if there is any.
function Tile.getWireFrame(x, y, level) end

-- Returns the draft of the zone at a given location.
---@param x int X component of a location.
---@param y int Y component of a location.
---@return draft | nil r The draft of the zone or nil if there is no zone.
function Tile.getZoneDraft(x, y) end

-- Returns true iff there's a building at a given position that needs a road connection but also has a road connection.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.hasBuildingNeededRoad(x, y) end

-- Returns true iff the building at a given position has a specific pending upgrade on it. Pending upgrades are being built right now and will be applied in the future.
---@param upgradeId string | draft Id or draft of a building upgrade.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return bool | nil r True iff the building has the pending building upgrade.
function Tile.hasBuildingPendingUpgrade(upgradeId, x, y) end

-- Returns true iff there's a building at a given position that has a road connection.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.hasBuildingRoad(x, y) end

-- Returns true iff the building at a given position has a specific upgrade applied to it.
---@param upgradeId string | draft Id or draft of a building upgrade.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@return bool | nil r True iff the building has the building upgrade.
function Tile.hasBuildingUpgrade(upgradeId, x, y) end

-- Returns true iff there is any fence at the given location.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param edge? int The edge to check for. If not specified the whole tile will be checked for any fences. (optional)
---@return bool r True iff there is at least once fence.
function Tile.hasFence(x, y, edge) end

-- Returns true iff there is any fence within a specifiedc rectangle.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param width int Width of the target area.
---@param height int Height of the target area.
---@return bool r True iff there is at least once fence within the rectangle.
function Tile.hasFenceWithin(x, y, width, height) end

-- Returns true if there's any raod at the given position regardless of the level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r True if there is road.
function Tile.hasRoad(x, y) end

-- Returns true iff there's a road occupation on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool r 
function Tile.hasRoadOccupation(x, y, level) end

-- Determines whether there is any wire at the given location regardless of the level.
---@param x int X component of a location.
---@param y int Y component of a location.
---@return bool r True iff there is any wire.
function Tile.hasWire(x, y) end

-- Returns true iff there's a building at a given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuilding(x, y) end

-- Resumes an animation that is attached to a building.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Is true iff the specified animation is paused right now, nil if an error occurred.
function Tile.isBuildingAnimationPaused(x, y, slot) end

-- Returns true iff there is a building at the given position that is burning right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingBurning(x, y) end

-- Returns true iff there's a building at a given position that is empty right now. That means that people left it. Only happens for RCI buildings.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingEmpty(x, y) end

-- Returns true iff there's a building at a given position that has transport issues with dead bodies right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingFullOfDeadPeople(x, y) end

-- Returns true iff there's a building at a given position that is full of garbage right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingFullOfWaste(x, y) end

-- Returns true iff there's a building at a given position that contains ill people right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingIll(x, y) end

-- Returns true iff there's a building at a given position that is in construction right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingInConstruction(x, y) end

-- Determines whether a RCI building is untouchable. An untouchable building is protected in terms of it won't be replaced by automatically spawned buildings.
---@param x int X component of a building position.
---@param y int Y component of a building position.
function Tile.isBuildingUntouchable(x, y) end

-- Returns true iff there's a building at a given position that has a pending upgrade right now.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingUpgradeInConstruction(x, y) end

-- Returns true iff there's a building at a given position that is working right now. A working building has road connection if needed, is not in construction and is not empty. It also has power and water if needed.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isBuildingWorking(x, y) end

-- Returns true iff there's a bus stop on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool r 
function Tile.isBusStop(x, y, level) end

-- Returns true iff there's land at a given position and water on at least one of the four neighboring tiles.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r Whether this is a land tile that is near water.
function Tile.isCoast(x, y) end

-- Determines whether the ground is flat at a given position. Ground is flat if there is not slope in it.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r True iff the ground is flat.
function Tile.isFlat(x, y) end

-- Returns true iff there's land (the opposite of water) at a given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isLand(x, y) end

-- Determines whether there is pipe at the given location.
---@param x int X component of a location.
---@param y int Y component of a location.
---@return bool r True iff there is a pipe.
function Tile.isPipe(x, y) end

-- Returns true if there's a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool r True iff there is road.
function Tile.isRoad(x, y, level) end

-- Returns true iff there's a road decoration on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool r 
function Tile.isRoadDeco(x, y, level) end

-- Returns the bridge pile of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool r True iff there is a brige pile.
function Tile.isRoadPile(x, y, level) end

-- Returns true iff there's a bridge entrance or exit on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@return bool | nil r 
function Tile.isRoadSlope(x, y, level) end

-- Determines whether there is a slope in the terrain at a given position. The height step of a slope is 12 pixels in size visually.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r True iff there is a slope at the given position, false otherwise.
function Tile.isSlope(x, y) end

-- Returns true iff there's a tree at a given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isTree(x, y) end

-- Returns true iff a position is on the map.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isValid(x, y) end

-- Returns true iff there's water at a given position.
---@param x int X component of a position.
---@param y int Y component of a position.
---@return bool r 
function Tile.isWater(x, y) end

-- Determines whether there is a wire at the given location and level.
---@param x int X component of a location.
---@param y int Y component of a location.
---@param level? int Level of the wire to look for. The level of normal wires is 0 (-1 for underground and 1 for long distance wires). (default 0)
---@return bool r True iff there is a wire.
function Tile.isWire(x, y, level) end

-- Returns true iff there's a pole on the wire at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level? int Level of the wire to look for. The level must be equal or greater than 0 (underground wires don't have poles). (default 0)
---@return bool r True iff there is a wire pole.
function Tile.isWirePole(x, y, level) end

-- Pauses an animation that is attached to a building.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Tile.pauseBuildingAnimation(x, y, slot) end

-- Resumes an animation that is attached to a building.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@param speed? number A speed multiplier for the animation. (default 1.0)
---@return int | nil r The current frame of the animation or nil if something went wrong.
function Tile.resumeBuildingAnimation(x, y, slot, speed) end

-- Sets the color of an animation of a building. The default color is white which is expressed as 255,255,255 or 255,255,255,255.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param red int The red color component.
---@param green int The green color component.
---@param blue int The blue color component.
---@param alpha? int The alpha color component that is considered as transparency. (default 255)
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Only true if the operation was successful.
function Tile.setBuildingAnimationColor(x, y, red, green, blue, alpha, slot) end

-- Sets the current frame of an animation regardless of whether the animation is playing right now.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param frame int The frame to set.
---@param slot? int The index of the animation to pause. 1 is the first attached animation. (default 1)
---@return bool | nil r Only true if the operation was successful.
function Tile.setBuildingAnimationFrame(x, y, frame, slot) end

-- Sets the frame of a building at a given position.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param frame int The zero based frame index to set.
function Tile.setBuildingFrame(x, y, frame) end

-- Sets a building icon for the specified building. Note that game building icons have higher precedence than custom ones.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param icon string | draft An animation draft to use as icon. Use nil to reset.
function Tile.setBuildingIcon(x, y, icon) end

-- Sets the name of a building
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param name string | nil The name that should be used for the building. Use nil to reset it.
function Tile.setBuildingName(x, y, name) end

-- Sets the performance of a building. The performance value will be clipped by the min and max value defined in the building's draft.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param performance float The performance to set. 1 represents 100%.
function Tile.setBuildingPerformance(x, y, performance) end

-- Marks a RCI building as untouchable/touchable. An untouchable building is protected in terms of it won't be replaced by automatically spawned buildings.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param state? bool The untouchable state to set for the building. (default true)
function Tile.setBuildingUntouchable(x, y, state) end

-- Sets the legacy ground height of a tile. Ground height is a legacy system used for terrain shading and water depth coloring. It was added to the game before there were actual hills.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param height int An integer that represents height. 0 means ocean level. Negative values are possible.
function Tile.setGroundHeight(x, y, height) end

-- Sets the alignment of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@param alignment int The zero based alignment index to set with a range from 0 to 15.
function Tile.setRoadAlignment(x, y, level, alignment) end

-- Sets the bridge type on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@param index? int The bridge type index of the road depends of the road bridge frames. (default 0)
function Tile.setRoadBridgeType(x, y, level, index) end

-- Sets the road occupation on the road at a given position and level.
---@param draft draft The animation draft to set on the road.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level? int A road level with 0 being ground. (default 0)
function Tile.setRoadOccupation(draft, x, y, level) end

-- Sets the direction and alignment of a road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@param alignment int The zero based alignment index to set with a range from 0 to 63.
function Tile.setRoadOneWayAlignment(x, y, level, alignment) end

-- Sets the bridge pile on the road at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level int A road level with 0 being ground.
---@param state bool The brige pile state to set for the road.
function Tile.setRoadPile(x, y, level, state) end

-- Sets the wire pole on the wire at a given position and level.
---@param x int X component of a position.
---@param y int Y component of a position.
---@param level? int Level of the wire to look for. The level must be equal or greater than 0 (underground wires don't have poles). (default 0)
---@param state bool The pole state to set for the wire.
function Tile.setWirePole(x, y, level, state) end

-- Will register one or multiple pedestrians for spawning from this building. The pedestrians will be spawned over time on neighboring roads. The pedestrian type to be spawned will be picked based on the spawning building if it has the "pedestrian" attribute defined. Otherwise the normal picking mechanism will be used that considers present influence values.
---@param x int X component of a building position.
---@param y int Y component of a building position.
---@param amount? int Amount of pedestrians to spawn. (default 1)
function Tile.spawnBuildingPedestrian(x, y, amount) end


---@class Util Some general utility functions.
Util = {}
---@alias util Util

-- Collects all tile positions in a rectangle.
---@param x int X component of a tile position.
---@param y int Y component of a tile position.
---@param w int Width of the rect.
---@param h int Height of the rect.
---@return array r An array of {x=..., y=...} positions.
function Util.collectFullRectTiles(x, y, w, h) end

-- Collects all tile positions along a rectangle. The listing is in clock-wise order and starts at the top left corner of the rectangle.
---@param x int X component of a tile position.
---@param y int Y component of a tile position.
---@param w int Width of the rect.
---@param h int Height of the rect.
---@param noCorners? bool If true the corners won't be included. (default false)
---@return array r An array of {x=..., y=...} positions.
function Util.collectRectTiles(x, y, w, h, noCorners) end

-- Returns the named content of a storage table. If no such entry exists it will be created by a given constructor, saved into the table and returned.
---@param src table Source table.
---@param name string Name of the entry to load.
---@param constructor? function | table A function that returns a new object or the object itself. (optional)
---@return any r The object that's effectively in src[name] after the call.
function Util.optStorage(src, name, constructor) end

-- Unites acces on multiple tables. For read access the value of the first table that contains the queried key will be returned. For write access the value is written into all tables using the provided key.
---@param table1 table 
---@param table2? table (optional)
---@param ...? any (optional)
function Util.unite(table1, table2, ...) end


---@class Vector A 3-dimensional vector implementation that can be used for convenience.
---@field x any X component of the vector.
---@field y any Y component of the vector.
---@field z any Z component of the vector.
Vector = {}
---@alias vector Vector

-- Returns a 1:1 copy of the vector.
---@return vector r 
function Vector:copy() end

-- Returns the cross product of two vectors a and b.
---@param o vector 
---@return vector r 
function Vector:cross(o) end

-- 
---@param o vector 
---@return number r 
function Vector:dot(o) end

-- Returns the length of the vector.
---@return number r 
function Vector:length() end

-- Creates a new vector out of the components x, y, z. You may use the alias Vector(x, y, z) instead.
---@param x? number X component of the vector. (default 0)
---@param y? number Y component of the vector. (default 0)
---@param z? number Z component of the vector. (default 0)
---@return Vector r 
function Vector.new(x, y, z) end

-- Returns a normalized vector that points in the same direction as self.
---@return vector r 
function Vector:normalized() end


---@class string This module extends the functionality contained in the string table for convenience.
string = {}

-- Returns true iff the string contains the given substring.
---@param needle string The string to search for.
---@return bool r True if the needle is within the string.
function string.contains(needle) end

-- Checks whether the string ends with the given string.
---@param part string The string to check if it ends with it.
---@return bool r True iff self ends with the string part.
function string.endsWith(part) end

-- Splits the string into a table of strings by a given separator. Uses implementation from .
---@param sep string The literal separator pattern, e.g. ','
---@return table r A table that contains the remaining strings.
function string.split(sep) end

-- Checks whether the string starts with the given string.
---@param part string The string to check if it starts with it.
---@return bool r True iff self starts with the string part.
function string.startsWith(part) end

-- Removes white spaces at the start and ending of the string.
---@return string r The string without starting and ending spaces.
function string.trim() end


local var = {} 

local Mt = { } 
Mt.__add = function(t1, t2) 
   for key, data in pairs(t2) do
      t1[key] = data
   end 
   return t1 
end 

local splitTable = {  
setmetatable(require('data.ItemContent.parts.part101_80997'), Mt),
setmetatable(require('data.ItemContent.parts.part80998_3001203'), Mt),
setmetatable(require('data.ItemContent.parts.part3001204_3064605'), Mt),
setmetatable(require('data.ItemContent.parts.part3064606_30803013'), Mt),
setmetatable(require('data.ItemContent.parts.part30803014_30829489'), Mt),
setmetatable(require('data.ItemContent.parts.part30829490_30831489'), Mt),
setmetatable(require('data.ItemContent.parts.part30831490_30833489'), Mt),
setmetatable(require('data.ItemContent.parts.part30833490_30835489'), Mt),
setmetatable(require('data.ItemContent.parts.part30835490_30837489'), Mt),
setmetatable(require('data.ItemContent.parts.part30837490_30838272'), Mt),
} 

for i, v in ipairs(splitTable) do 
   var = var + v 
end 

return var
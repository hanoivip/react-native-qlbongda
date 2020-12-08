local var = {} 

local Mt = { } 
Mt.__add = function(t1, t2) 
   for key, data in pairs(t2) do
      t1[key] = data
   end 
   return t1 
end 

local splitTable = {  
setmetatable(require('data.Paster.parts.part1WarPasterCopper_1_1508'), Mt),
setmetatable(require('data.Paster.parts.part1509_3508'), Mt),
setmetatable(require('data.Paster.parts.part3509_5508'), Mt),
setmetatable(require('data.Paster.parts.part5509_5953'), Mt),
} 

for i, v in ipairs(splitTable) do 
   var = var + v 
end 

return var
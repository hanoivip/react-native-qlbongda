local var = {} 

local Mt = { } 
Mt.__add = function(t1, t2) 
   for key, data in pairs(t2) do
      t1[key] = data
   end 
   return t1 
end 

local splitTable = {  
setmetatable(require('data.Item.parts.part1_33878'), Mt),
} 

for i, v in ipairs(splitTable) do 
   var = var + v 
end 

return var
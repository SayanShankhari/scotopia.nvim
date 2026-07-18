local M = {};

function M.clamp (target, minimum, maximum)
  return math.max (minimum, math.min (maximum, target));
end

-- instance metatable setup
local NumMetatable = {};
NumMetatable.__index = NumMetatable;

function NumMetatable:clamp (minimum, maximum)
  return setmetatable ({ _value = M.clamp (self._value, minimum, maximum) }, NumMetatable);
end

-- turn M into functable
setmetatable (M, {
  __call = function (_, value)
    return setmetatable ({ _value = value }, NumMetatable);
  end
});


-- static
print (M.clamp(-5, 0, 10));

-- constructor
local num = M(-5);
print (num._value);
print (M(-5):clamp(0, 10));

return M;

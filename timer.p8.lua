ctimer = {}

function ctimer:new(endTick, callback)
  local this = {
    endTick = endTick,
    running = true,
    callback = callback,
  }

  setmetatable(this, self)
  self.__index = self
  return this
end

function ctimer:update(tick)
  if self.running then
    if tick >= self.endTick then
      self.running = false
      self.callback()
      return false
    end
  end

  return true
end

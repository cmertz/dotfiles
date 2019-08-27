local os   = require("os")
local math = require("math")

math.randomseed(os.time())

local function split(s,re)
  local find,sub,append = string.find, string.sub, table.insert
  local i1,ls = 1,{}
  if not re then re = '%s+' end
  if re == '' then return {s} end
  while true do
    local i2,i3 = find(s,re,i1,plain)
    if not i2 then
      local last = sub(s,i1)
      if last ~= '' then append(ls,last) end
      if #ls == 1 and ls[1] == '' then
        return {}
      else
        return ls
      end
    end
    append(ls,sub(s,i1,i2-1))
    i1 = i3+1
  end
end

local function get_files(dir)
  local find = assert(io.popen('/usr/bin/find '.. dir .. ' -type f', 'r'))
  local files = find:read('*all')

  find:close()

  return split(files, "\n")
end

local function random_wallpaper(dir)
  local files = get_files(dir)

  local count = 0
  for _ in pairs(files) do
    count = count + 1
  end

  if count == 0 then
    return
  end

  return files[math.random(count)]
end

return {
  random = random_wallpaper
}

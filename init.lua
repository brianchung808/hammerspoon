local mash = {"shift", "alt"}

-- disable window animation
hs.window.animationDuration = 0

function fullscreen()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h

  win:setFrame(f)
end

function leftscreen()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  win:setFrame(f)
end

function rightscreen()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  win:setFrame(f)
end

-- open an application that is named -app_name-
function openapplication(app_name)
  local success = hs.application.launchOrFocus(app_name)
  if not success then hs.alert(app_name .. " not found") else hs.alert(app_name .. "!") end
end

-- window manipulators
hs.hotkey.bind(mash, "W", fullscreen) 
hs.hotkey.bind(mash, "A", leftscreen) 
hs.hotkey.bind(mash, "S", rightscreen) 

-- application openers
hs.hotkey.bind(mash, "C", function() 
  openapplication("Google Chrome")
end)

hs.hotkey.bind(mash, "V", function() 
  openapplication("MacVim")
end)

hs.hotkey.bind(mash, "T", function() 
  openapplication("iTerm")
end)

hs.hotkey.bind(mash, "F", function() 
  openapplication("Finder")
end)

hs.hotkey.bind(mash, "M", function() 
  openapplication("Messages")
end)


-- update app on init.lua change
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.hotkey.bind({"option"}, "space", function()
  local hyper = hs.application.find('hyper')
  hs.application.launchOrFocus("/Applications/Hyper.app")
end)

hs.hotkey.bind({"option"}, "v", function()
  local hyper = hs.application.find('hyper')
  hs.application.launchOrFocus("/Applications/Visual Studio Code.app")
end)

hs.hotkey.bind({"option"}, "c", function()
  local hyper = hs.application.find('hyper')
  hs.application.launchOrFocus("/Applications/Google Chrome.app")
end)

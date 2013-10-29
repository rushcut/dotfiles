EDITOR = "iTerm"
S.eachApp (app) ->
  EDITOR = "Emacs" if app.name() == "Emacs"

apps = ["iTerm", "Emacs", "OmniFocus", "Google Chrome", "Things", "iTunes", "Preview", "QuickTime Player", "Safari", "Firefox", "Parallels Desktop", "Image Capture", "VietOCR", "Markdown Pro"]

MONITER27 = "2560x1440"
LAPTOP = "1920x1200"

slate.bind("0:ctrl", slate.operation("relaunch"))

op = (name, apps) ->  S.operation(name, { "app": apps } )
move = (rx, ry, rw, rh, screen = MONITER27) ->
  x = "screenOriginX + screenSizeX * " + rx
  y = "screenOriginY + screenSizeY * " + ry
  w = "screenSizeX * " + rw
  h = "screenSizeY * " + rh
  S.operation "move", {
    "x": x,
    "y": y,
    "width": w,
    "height": h,
    "screen": screen
  }

binding = (key, apps_string) ->
  targets = apps_string.split("-")
  config = {}
  config["_before_"] = { "operations": op("hide", _.difference(apps, targets)) }
  config["_after_"]  = { "operations": [op("show", targets), op("focus", targets[0])] }
  if targets.length == 1
    config[targets[0]] = { "operations": [move(0, 0, 1, 1)] }
  else if targets.length == 2
    config[targets[0]] = { "operations": [move(0, 0, 0.649, 1)] }
    config[targets[1]] = { "operations": [move(0.65, 0, 0.35, 1)] }
  else if targets.length == 3
    config[targets[0]] = { "operations": [move(0,   0, 0.399, 1)] }
    config[targets[1]] = { "operations": [move(0.4, 0, 0.299, 1)] }
    config[targets[2]] = { "operations": [move(0.7, 0, 0.3,   1)] }
  S.layout(apps_string, config)
  S.bind(key, S.operation("layout", { "name": apps_string }))

if EDITOR == "Emacs"
  binding("1:ctrl", "Emacs-iTerm")
  binding("2:ctrl", "Emacs-Safari")
  binding("3:ctrl", "Emacs-Firefox-iTerm")
else
  binding("1:ctrl", "iTerm")
  binding("2:ctrl", "iTerm-Safari")
  binding("3:ctrl", "iTerm-Firefox")
  binding("4:ctrl", "iTerm-Safari-Firefox")

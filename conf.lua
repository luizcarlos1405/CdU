function love.conf(t)
	t.version = "0.10.1"
	t.window.title = "CdU"
	t.window.width = 1040 -- 16 x 65
	t.window.height = 585 -- 9 x 65
	t.console = true
	t.window.fullscreen = false
	t.identity = t.window.title
	t.modules.physics = false
end

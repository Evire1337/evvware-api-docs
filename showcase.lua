local function on_create_move(cmd)
	local local_player = entities.get_local_player()

	if not local_player then return end


	local start_position = local_player:origin()
    	local end_position = vector3.new(100, 0, 0) 
    

	local new_ray = game_ray.new()
    	new_ray:init(start_position, end_position)

	local new_trace = game_trace.new()

	local trace_filter = trace_filter_default.new(local_player)


	client.print("before fraction -> ".. tostring(new_trace.fraction))
	engine.trace_ray(new_ray, 1174421515, trace_filter, new_trace)
	client.print("after fraction -> ".. tostring(new_trace.fraction))


	local weapon = local_player:get_active_weapon()

	if not weapon then return end

	local config_current_path = config.get_current_aimbot_config_path(weapon)

	local anim = local_player:get_prop("DT_BaseAnimating", "m_flPoseParameter"):get_float_index(4)

	--client.print("anim -> ".. anim)

	--client.print("current weapon config is enabled -> ".. tostring(config.get_bool(config_current_path.."active")))
end

local function on_fsn(stage)
	if stage == client_frame_stage.FRAME_NET_UPDATE_END then
		--client.print("frame_net_update_end")
	end
end

local variable = false
local slider = 90
local fakelag = 0
local dropdown = 0
local hfgjtytjtj_no_alpha = color.new(148, 255, 255, 255)
local hfgjtytjtj_alpha = color.new(148, 255, 255, 255)
local multi_dropdown = { 1 } -- { 1 } means 2nd element, { 0 } means 1st element


local key_bind = c_key_bind.new(74, key_bind_mode.always) -- key indexes: https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes

-- 74 means in dec, 0x4A hex

local key_bind_example = c_key_bind.new("J", key_bind_mode.always) -- key indexes: https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes


local menu_setting = menu_settings.new()


local clicked_times = 0


--config.add_config_data("bool_data_lua", "bool", false)

local data, other_data = false, false
local color_data = color.new(128, 255, 255, 255)


local function on_menu_render()
	menu.add_text("lua support")

	menu.jump()

	variable = menu.add_checkbox("new checkbox", variable)

	menu.jump()

	slider = menu.add_slider_float("slider float", slider, 0, 180)
	fakelag = menu.add_slider_int("slider int", fakelag, 0, 180)
	dropdown = menu.add_dropdown("dropdown int", dropdown, "item1\0item2\0item3\0")

	menu.jump()

	if menu.add_button("click me", vector2.new(200, 18)) == true then
		clicked_times = clicked_times + 1
	end

	menu.jump()

	menu.add_text(string.format("Clicked: %s times", clicked_times))

	menu.jump()

	multi_dropdown = menu.add_multi_dropdown("test dropdown", multi_dropdown, "item 15\0item 25\0")

	key_bind = menu.add_keybind("keybind test", key_bind, "In Keybinds List")



	hfgjtytjtj_no_alpha = menu.add_color_picker("color picker##Tags Invisible##", hfgjtytjtj_no_alpha, false)
	hfgjtytjtj_alpha = menu.add_color_picker("color picker##Other Tag##", hfgjtytjtj_alpha, true)


	menu_setting:add_checkbox_settings("first name", data)
	other_data = menu_setting:add_data("hello", other_data)
	color_data = menu_setting:add_data("color", color_data)
	menu_setting:create()
end

local tahoma_structure = render.create_font("Tahoma Bold", 11, 300, 0, 0, 16) -- 16 flag is antialias, read on https://gitlab.com/FriskTheFallenHuman/SourceEngine2007/-/blob/master/src_main/public/vgui/ISurface.h#L230

local function on_paint_traverse()
	local keybind_data = key_bind:get_data()

	if tahoma_structure ~= nil and keybind_data.toggle then
		--client.print("font created! ".. tahoma_structure.font, color.new(0, 255, 0, 255))

		tahoma_structure:set_size(fakelag) -- set font size



		render.filled_rect(100, 100, 200, 100, color.new(255, 255, 255, 255))

		render.text(tahoma_structure.font, 3, false, false, 180, 120, color.new(0, 0, 0, 255), "text type 1")

		local text_size = render.get_text_size(tahoma_structure.font, "text type 1")

		render.text(tahoma_structure.font, 2, false, false, 180, 120 + text_size.y * 3, color.new(0, 0, 0, 255), "text type 2")
		render.text(tahoma_structure.font, 1, false, false, 180, 120 + text_size.y * 4, color.new(0, 0, 0, 255), "text type 3")
		render.text(tahoma_structure.font, 3, false, true, 180, 120 + text_size.y * 5, color.new(255, 255, 255, 255), "text type 4")
	end


	client.add_esp_flag(esp_flag.new(true, esp_flag_position.bottom, "lua", color.new(255, 0, 0, 255)))
end

local function on_game_events(event)
	if event:get_name() ~= "bullet_impact" then return end

	client.print("bullet impact event", color.new(255, 200, 255, 255))
end


client.register_callback("create_move", on_create_move)
client.register_callback("menu_render", on_menu_render)
client.register_callback("paint_traverse", on_paint_traverse)
client.register_callback("frame_stage_notify", on_fsn)
client.register_callback("game_event_listener", on_game_events)

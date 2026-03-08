client.print("" .. _VERSION)
client.print("jit loaded: " .. tostring(jit ~= nil))

local ffi = require("ffi")
client.print("ffi loaded: ".. tostring(jit ~= nil))

ffi.cdef[[
            int MessageBoxA(void* hWnd,
                            const char* lpText,
                            const char* lpCaption,
                            unsigned int uType);
        ]]

        local user32 = ffi.load("user32")

        user32.MessageBoxA(nil, "Hello from LuaJIT FFI!", "FFI Works", 0)


local function on_create_move(cmd)
	local local_player = entities.get_local_player()

	if not local_player then return end


	local start_position = local_player:origin()
    	local end_position = vector3.new(100, 0, 0) 
    

	local new_ray = game_ray.new()
    	new_ray:init(start_position, end_position)

	local new_trace = game_trace.new()

	local box_min, box_max = client.get_hitbox_box(local_player, 12)

	local hitbox_position = client.get_hitbox_position(local_player, 12)

	--client.print("hitbox position -> x".. hitbox_position.x .." y".. hitbox_position.y .." z".. hitbox_position.z)

	--client.print("box min -> x".. box_min.x .." y".. box_min.y .." z".. box_min.z)

	--client.print("box max -> x".. box_max.x .." y".. box_max.y .." z".. box_max.z)

	for i, player in ipairs(engine.get_active_players_data()) do
		client.print("index: " .. tostring(player.index) .. " dormant: ".. tostring(player.dormant))
	end


	local trace_filter = trace_filter_custom.new(function(ent, mask)
		return true
	end)


	--client.print("before fraction -> ".. tostring(new_trace.fraction))
	engine.trace_ray(new_ray, 1174421515, trace_filter, new_trace)
	--client.print("after fraction -> ".. tostring(new_trace.fraction))


	local weapon = local_player:get_active_weapon()

	if not weapon then return end

	local config_current_path = config.get_current_aimbot_config_path(weapon)

	local anim = local_player:get_prop("DT_BaseAnimating", "m_flPoseParameter"):get_float_index(4)


	--local movetype = local_player:move_type()

	--client.print("movetype -> ".. movetype)
	--client.print("anim -> ".. anim)

	--client.print("current weapon config is enabled -> ".. tostring(config.get_bool(config_current_path.."active")))
end


local ui_manager = create_ui_manager()

local new_frame = ui_manager:add_frame()
local frame = ui_manager:add_frame()
local frame_test = ui_manager:add_frame()

frame_test:text("frame test")

local checkbox1 = new_frame:add_checkbox("Hide Other Frame", false, function(v)
	if v then
		frame:hide()
	else
		frame:show()
	end
end)

frame:show()

local new_checkbox = frame:add_checkbox("Enable Slider Widget", false, function(v)
	client.print(tostring(v))
	if _G.test_callback then
		_G.test_callback(v)
	end
end)

frame:jump()

frame:text("hello world!")
frame:same_line()
frame:button("test", vector2.new(50, 15))

frame:space()

frame:jump()


local new_slider = frame:add_slider_int("Test slider", 45, 0, 100, function(v)
	client.print("[slider int] changed to ".. tostring(v))
end)

client.print("slider int value is ".. tostring(new_slider:get_int()))

local new_slider_float = frame:add_slider_float("Test slider 11", 0, 0, 100, function(v)
	client.print("[slider float] changed to ".. tostring(v))
end)

new_slider_float:visible(false)

_G.test_callback = function(v)
	new_slider_float:visible(v)
end

frame:button("Created Button", vector2.new(200, 18), function()
	client.print("clicked")
end)

local item_dropdown = frame:add_dropdown("Dropdown", 1 --[[1 means 2nd element]], "item 1\0item 2\0item 3\0", function(v)
	client.print("[dropdown] changed to ".. tostring(v))
end)

local item_multi_dropdown = frame:add_multi_dropdown("Dropdown 123", {0, 2} --[[{ 0 } means 1st element, { 2 } means 3rd element]], "item 1\0item 2\0item 3\0", false, false, function(v)
	client.print("[multi_dropdown] changed! (v is a table)")
end)

local item_color_picker = frame:add_color_picker("Color (No Alpha)", color.new(255, 255, 255, 255), false)

local item_color_picker_alpha = frame:add_color_picker("Color (With Alpha)", color.new(255, 0, 0, 255), true)


local keybind_1 = frame:add_keybind("Keybind 1", c_key_bind.new(74, key_bind_mode.always), "In Keybinds List")

local keybind_2 = frame:add_keybind("Keybind 2", c_key_bind.new("J", key_bind_mode.always), "In Keybinds List 2", function(v)
	client.print("[keybind] changed! (v is a c_key_bind)")
end)

local new_checkbox_settings = frame:add_checkbox_settings("Checkbox & Settings", false, function(v)
	client.print(tostring(v))
end)

local checkbox_in_settings = new_checkbox_settings:add_checkbox("Checkbox Settings", false)

local sliderint_in_settings = new_checkbox_settings:add_slider_int("Slider Int", 6, 0, 100)

client.print("slider int in settings value is ".. tostring(sliderint_in_settings:get_int()))

local sliderfloat_in_settings = new_checkbox_settings:add_slider_float("Slider Float", 10, 0, 100)

local item_color_picker_in_settings = new_checkbox_settings:add_color_picker("Settings Color (No Alpha)", color.new(148, 255, 255, 255), false)

local item_color_picker_alpha_in_settings = new_checkbox_settings:add_color_picker("Settings Color (Alpha)", color.new(148, 255, 255, 255), true)


local keybind_1_in_settings = new_checkbox_settings:add_keybind("Settings Keybind 1", c_key_bind.new(74, key_bind_mode.always), "In Keybinds List")

local keybind_2_in_settings = new_checkbox_settings:add_keybind("Settings Keybind 2", c_key_bind.new("J", key_bind_mode.always), "In Keybinds List 2")

local item_dropdown_in_settings = new_checkbox_settings:add_dropdown("Settings Dropdown##TES1##", 2 --[[1 means 2nd element]], "item 1\0item 2\0item 3\0")

local item_multi_dropdown_in_settings = new_checkbox_settings:add_multi_dropdown("Settings Dropdown##TEST##", {1, 2} --[[{ 1 } means 2nd element, { 2 } means 3rd element]], "item 1\0item 2\0item 3\0", false, false)


local function on_fsn(stage)
	if stage == client_frame_stage.FRAME_NET_UPDATE_END then
		client.print("".. tostring(variable:get_bool()))
	end
end

--[[local function on_menu_render()
	menu_setting:add_checkbox_settings("first name", data)
	other_data = menu_setting:add_data("hello", other_data)
	color_data = menu_setting:add_data("color", color_data)
	menu_setting:create()
end--]]

local tahoma_structure = render.create_font("Tahoma Bold", 11, 300, 0, 0, 16) -- 16 flag is antialias, read on https://gitlab.com/FriskTheFallenHuman/SourceEngine2007/-/blob/master/src_main/public/vgui/ISurface.h#L230


local lua_esp_flag = esp_flag.new(esp_flag_position.bottom, "lua", color.new(255, 0, 0, 255))

local function on_paint_traverse()
	local local_player = entities.get_local_player()

	if not local_player then return end
	if tahoma_structure ~= nil then
		--client.print("font created! ".. tahoma_structure.font, color.new(0, 255, 0, 255))

		tahoma_structure:set_size(fakelag) -- set font size



		render.filled_rect(100, 100, 200, 100, color.new(255, 255, 255, 255))

		render.text(tahoma_structure.font, 3, false, false, 180, 120, color.new(0, 0, 0, 255), "text type 1")

		local text_size = render.get_text_size(tahoma_structure.font, "text type 1")

		render.text(tahoma_structure.font, 2, false, false, 180, 120 + text_size.y * 3, color.new(0, 0, 0, 255), "text type 2")
		render.text(tahoma_structure.font, 1, false, false, 180, 120 + text_size.y * 4, color.new(0, 0, 0, 255), "text type 3")
		render.text(tahoma_structure.font, 3, false, true, 180, 120 + text_size.y * 5, color.new(255, 255, 255, 255), "text type 4")
	end


	client.add_esp_flag(2, lua_esp_flag)

	lua_esp_flag:modify_color(color.new(255, 255, 255, 255))
	lua_esp_flag:modify_text("test")

	client.add_esp_flag(3, lua_esp_flag)

	--client.remove_esp_flag(2, lua_esp_flag:get_key())
end

local function on_game_events(event)
	if event:get_name() ~= "bullet_impact" then return end

	client.print("bullet impact event", color.new(255, 200, 255, 255))
end


client.register_callback("create_move", on_create_move)
client.register_callback("paint_traverse", on_paint_traverse)
client.register_callback("frame_stage_notify", on_fsn)
client.register_callback("game_event_listener", on_game_events)
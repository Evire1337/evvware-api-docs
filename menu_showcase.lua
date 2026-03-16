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
new_slider:set_int(100)
client.print("NEW slider int value is ".. tostring(new_slider:get_int()))

local new_slider_float = frame:add_slider_float("Test slider 11", 4.7, 0, 100, function(v)
	client.print("[slider float] changed to ".. tostring(v))
end)

client.print("slider float value is ".. tostring(new_slider_float:get_float()))

new_slider_float:visible(new_checkbox:get_bool())

_G.test_callback = function(v)
	new_slider_float:visible(v)
end

frame:button("Created Button", vector2.new(200, 18), function()
	client.print("clicked")
end)

frame:jump()

local item_dropdown = frame:add_dropdown("Dropdown", 1 --[[1 means 2nd element]], "item 1\0item 2\0item 3\0", function(v)
	client.print("[dropdown] changed to ".. tostring(v))
end)

local item_multi_dropdown = frame:add_multi_dropdown("Dropdown 123", {0, 2} --[[{ 0 } means 1st element, { 2 } means 3rd element]], "item 1\0item 2\0item 3\0", false, false, function(v)
	client.print("[multi_dropdown] changed! (v is a table)")
end)

local t = item_multi_dropdown:get_table()

for i, v in pairs(t) do
	client.print("[item_multi_dropdown] index ".. i ..", value ".. v)
end


frame:jump()

local item_color_picker = frame:add_color_picker("Color (No Alpha)", color.new(255, 255, 255, 255), false)

client.print(tostring(item_color_picker:get_color()))

local item_color_picker_alpha = frame:add_color_picker("Color (With Alpha)", color.new(255, 0, 0, 255), true)

frame:jump()

local keybind_1 = frame:add_keybind("Keybind 1", c_key_bind.new(74, key_bind_mode.always), "In Keybinds List")

local keybind_2 = frame:add_keybind("Keybind 2", c_key_bind.new("J", key_bind_mode.always), "In Keybinds List 2", function(v)
	client.print("[keybind] changed! (v is a c_key_bind)")
end)

frame:jump()
frame:jump()

local new_checkbox_settings = frame:add_checkbox_settings("Checkbox & Settings", false, function(v)
	client.print(tostring(v))
end)

local checkbox_in_settings = new_checkbox_settings:add_checkbox("Checkbox Settings", false)

new_checkbox_settings:jump()

local sliderint_in_settings = new_checkbox_settings:add_slider_int("Slider Int", 6, 0, 100)

client.print("slider int in settings value is ".. tostring(sliderint_in_settings:get_int()))

local sliderfloat_in_settings = new_checkbox_settings:add_slider_float("Slider Float", 10, 0, 100)

new_checkbox_settings:jump()
new_checkbox_settings:text("hello world again!")
new_checkbox_settings:jump()

local item_color_picker_in_settings = new_checkbox_settings:add_color_picker("Settings Color (No Alpha)", color.new(148, 255, 255, 255), false)

local item_color_picker_alpha_in_settings = new_checkbox_settings:add_color_picker("Settings Color (Alpha)", color.new(148, 255, 255, 255), true)

new_checkbox_settings:jump()

local keybind_1_in_settings = new_checkbox_settings:add_keybind("Settings Keybind 1", c_key_bind.new(74, key_bind_mode.always), "In Keybinds List")

local keybind_2_in_settings = new_checkbox_settings:add_keybind("Settings Keybind 2", c_key_bind.new("J", key_bind_mode.always), "In Keybinds List 2")

new_checkbox_settings:jump()

local item_dropdown_in_settings = new_checkbox_settings:add_dropdown("Settings Dropdown##TES1##", 2 --[[2 means 3rd element]], "item 1\0item 2\0item 3\0")

local item_multi_dropdown_in_settings = new_checkbox_settings:add_multi_dropdown("Settings Dropdown##TEST##", {1, 2} --[[{ 1 } means 2nd element, { 2 } means 3rd element]], "item 1\0item 2\0item 3\0", false, false)
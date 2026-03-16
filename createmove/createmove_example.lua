local function on_create_move(cmd)

end

local function on_pre_create_move(cmd)

end


--[[
"create_move" -> это каллбек который будет вызывать функцию после выполнения энджин предикта чита (то есть после выполнения всего функционала)
"pre_create_move" -> это каллбек который будет вызывать функцию до выполнения энджин предикта чита (то есть до выполнения всего функционала)

оба каллбека имеют в себе аргумент cmd, больше информации на сайте с документацией
]]
client.register_callback("create_move", on_create_move)
client.register_callback("pre_create_move", on_pre_create_move)
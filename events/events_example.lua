local function on_game_events(event)
    if event:get_name() ~= "bullet_impact" then return end

    client.print("bullet impact event", color.new(255, 200, 255, 255))
end


--[[
"game_event_listener" -> это каллбек который будет вызываться при каждом срабатывании гейм эвента поддерживающим читом
На данный момент чит поддерживает такие эвенты как:
player_say
player_spawn
round_start
player_death
player_hurt
bullet_impact

каллбек имеет в себе аргумент event, больше информации на сайте с документацией
]]
client.register_callback("game_event_listener", on_game_events)
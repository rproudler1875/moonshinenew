Schema.name = "Moonshine"
Schema.author = "pie"
Schema.description = "A CityRP schema with advanced roleplay mechanics."

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")

ix.config.Add("weather", "clear", "The current weather (clear, cold, hot).", nil, {data = {type = ix.type.string}})
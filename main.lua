local GodMode = _G.SRB2GodMode or {}
_G.SRB2GodMode = GodMode

-- Carrega os módulos do addon.
local config = require("SRB2GodMode.config")
local menu = require("SRB2GodMode.menu")
local powers = require("SRB2GodMode.powers")
local teleport = require("SRB2GodMode.teleport")
local hud = require("SRB2GodMode.hud")
local debug = require("SRB2GodMode.debug")

--[[
    Inicializa o addon quando ele é carregado.
    Aqui montamos o estado inicial e deixamos o mod pronto.
]]
function GodMode.init()
    GodMode.state.map.name = "Mapa carregado"
    GodMode.state.map.levelnum = 0
    GodMode.state.fly_state = GodMode.state.fly_state or {
        active = false,
        vertical_speed = 0,
    }

    print("God Mode inicializado. Pressione F1 para abrir o menu.")
end

--[[
    Atualiza o addon a cada frame.
    Em uma implementação real, isso seria ligado ao loop do jogo.
]]
function GodMode.tick(player)
    if not player then
        return
    end

    GodMode.powers.applyToPlayer(player)
    GodMode.hud.draw(player)
end

--[[
    Recebe input do jogador e repassa ao menu.
]]
function GodMode.handleInput(player, key)
    if key == "space" then
        GodMode.state.fly_button_down = true
        return true
    end

    if key == "spaceup" then
        GodMode.state.fly_button_down = false
        return true
    end

    return GodMode.menu.handleKeyDown(player, key)
end

--[[
    Atualiza o estado quando o mapa muda.
    Isso mantém o addon compatível com qualquer fase ou addon.
]]
function GodMode.onMapChange(mapName, levelnum)
    GodMode.state.map.name = mapName or GodMode.state.map.name
    GodMode.state.map.levelnum = levelnum or GodMode.state.map.levelnum
end

--[[
    Salva a posição atual para teleporte.
]]
function GodMode.saveCheckpoint(player)
    return GodMode.teleport.saveCheckpoint(player)
end

--[[
    Mostra informações de depuração do mapa.
]]
function GodMode.debugInfo()
    return GodMode.debug.showMapInfo()
end

--[[
    Retorna identificação do addon.
]]
function GodMode.getInfo()
    return GodMode.name, GodMode.version
end

GodMode.init()
return GodMode

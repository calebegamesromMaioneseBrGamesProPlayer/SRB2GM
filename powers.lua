local GodMode = _G.SRB2GodMode or {}
_G.SRB2GodMode = GodMode

GodMode.powers = GodMode.powers or {}

--[[
    Aplica os poderes ativos ao jogador atual.
    Esta função é o ponto central do addon.
]]
function GodMode.powers.applyToPlayer(player)
    if not GodMode.state.enabled then
        return
    end

    if not player or not player.mo then
        return
    end

    if GodMode.state.powers.fly then
        GodMode.powers.applyFly(player)
    end

    if GodMode.state.powers.invincible then
        GodMode.powers.applyInvincibility(player)
    end

    if GodMode.state.powers.infinite_rings then
        GodMode.powers.applyInfiniteRings(player)
    end

    if GodMode.state.powers.infinite_lives then
        GodMode.powers.applyInfiniteLives(player)
    end

    if GodMode.state.powers.infinite_jump then
        GodMode.powers.applyInfiniteJump(player)
    end

    if GodMode.state.powers.super_speed then
        GodMode.powers.applySuperSpeed(player)
    end

    if GodMode.state.powers.noclip then
        GodMode.powers.applyNoClip(player)
    end

    if GodMode.state.powers.freeze_enemies then
        GodMode.powers.applyFreezeEnemies(player)
    end

    if GodMode.state.powers.clear_enemies then
        GodMode.powers.clearEnemies()
        GodMode.state.powers.clear_enemies = false
    end

    if GodMode.state.powers.teleport then
        GodMode.powers.applyTeleport(player)
        GodMode.state.powers.teleport = false
    end

    if GodMode.state.powers.restart_stage then
        GodMode.powers.restartStage(player)
        GodMode.state.powers.restart_stage = false
    end
end

--[[
    Poder de voo livre.
    Agora o voo só é aplicado enquanto a barra de espaço estiver pressionada.
    Isso faz o movimento parecer mais controlado, como um voo ativo.
]]
function GodMode.powers.applyFly(player)
    if not player or not player.mo then
        return
    end

    local mo = player.mo
    local state = GodMode.state.fly_state or {
        active = false,
        vertical_speed = 0,
    }

    if not GodMode.state.fly_button_down then
        state.active = false
        state.vertical_speed = 0
        GodMode.state.fly_state = state
        return
    end

    state.active = true
    state.vertical_speed = math.max(state.vertical_speed - 0.45, -9)
    mo.momz = state.vertical_speed

    if mo.momx then
        mo.momx = mo.momx * 1.02
    end
    if mo.momy then
        mo.momy = mo.momy * 1.02
    end

    GodMode.state.fly_state = state
end

--[[
    Torna o jogador invulnerável.
]]
function GodMode.powers.applyInvincibility(player)
    if player then
        player.powers = player.powers or {}
        player.powers.invincible = true
    end
end

--[[
    Mantém anéis em quantidade alta.
]]
function GodMode.powers.applyInfiniteRings(player)
    if player then
        player.rings = 999
    end
end

--[[
    Mantém a quantidade de vidas alta.
]]
function GodMode.powers.applyInfiniteLives(player)
    if player then
        player.lives = 999
    end
end

--[[
    Mantém o pulo com impulso vertical constante.
]]
function GodMode.powers.applyInfiniteJump(player)
    if player and player.mo then
        player.mo.momz = math.min(player.mo.momz, -2)
    end
end

--[[
    Aumenta o movimento horizontal para dar sensação de super velocidade.
]]
function GodMode.powers.applySuperSpeed(player)
    if player and player.mo then
        player.mo.momx = (player.mo.momx or 0) * 2
        player.mo.momy = (player.mo.momy or 0) * 2
    end
end

--[[
    Marca o objeto para ignorar colisões.
    Em uma implementação mais completa, isso seria trocado por uma flag
    específica do motor.
]]
function GodMode.powers.applyNoClip(player)
    if player and player.mo then
        player.mo.flags = (player.mo.flags or 0) + 1
    end
end

--[[
    Placeholder para congelar inimigos.
]]
function GodMode.powers.applyFreezeEnemies(player)
    if not player then
        return
    end

    print("God Mode: inimigos congelados")
end

--[[
    Placeholder para remover todos os inimigos.
]]
function GodMode.powers.clearEnemies()
    print("God Mode: todos os inimigos removidos")
end

--[[
    Teleporta o jogador para o último checkpoint salvo.
]]
function GodMode.powers.applyTeleport(player)
    if not player or not player.mo then
        return
    end

    local checkpoint = GodMode.state.last_checkpoint
    if checkpoint then
        player.mo.x = checkpoint.x
        player.mo.y = checkpoint.y
        player.mo.z = checkpoint.z
    else
        print("God Mode: nenhum checkpoint salvo")
    end
end

--[[
    Placeholder para reiniciar a fase.
]]
function GodMode.powers.restartStage(player)
    print("God Mode: reiniciando fase")
end

return GodMode

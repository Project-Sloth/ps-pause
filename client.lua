local Replacer = {
    ["TITLE"] = "FE_THDR_GTAO",
    ["MAP"] = "PM_SCR_MAP",
    ["GAME"] = "PM_SCR_GAM",
    ["LEAVE"] = "PM_PANE_LEAVE",
    ["QUIT"] = "PM_PANE_QUIT",
    ["INFO"] = "PM_SCR_INF",
    ["STATS"] = "PM_SCR_STA",
    ["SETTINGS"] = "PM_SCR_SET",
    ["GALLERY"] = "PM_SCR_GAL",
    ["KEYBIND"] = "PM_PANE_CFX",
    ["EDITOR"] = "PM_SCR_RPL",
}

function AddTextEntry(key, value)
    Citizen.InvokeNative(0x32CA01C3, key, value)
end

CreateThread(function()
    for key, value in pairs(Config.Header) do
        if Replacer[key] then
            AddTextEntry(Replacer[key], value)
        end
    end
        
    RequestStreamedTextureDict('ps_pause', true)

    ReplaceHudColourWithRgba( 116 , Config.RGBA.LINE["RED"] , Config.RGBA.LINE["GREEN"] , Config.RGBA.LINE["BLUE"] , Config.RGBA.LINE["ALPHA"]) --LINE ABOVE EACH OPTION
    ReplaceHudColourWithRgba( 117 , Config.RGBA.STYLE["RED"] , Config.RGBA.STYLE["GREEN"] , Config.RGBA.STYLE["BLUE"] , Config.RGBA.STYLE["ALPHA"]) -- BACKGROUND OF EACH OPTION + BLIPS IN THE LIST
    ReplaceHudColourWithRgba( 142 , Config.RGBA.WAYPOINT["RED"] , Config.RGBA.WAYPOINT["GREEN"] , Config.RGBA.WAYPOINT["BLUE"] , Config.RGBA.WAYPOINT["ALPHA"]) -- WAYPOINT COLOURS

    while not HasStreamedTextureDictLoaded("ps_pause") do
        Wait(100)
    end
    while true do
        if IsPauseMenuActive() then
            SetScriptGfxDrawBehindPausemenu(true)
            DrawSprite("ps_pause", Config.Background, 0.5, 0.5, 1.0, 1.0, 0, 255, 255, 255, Config.Opacity)
            PushScaleformMovieFunctionParameterBool(true)
            BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
            PushScaleformMovieFunctionParameterString(Config.Header['SERVER_NAME'])
            PushScaleformMovieFunctionParameterString(Config.Header['SERVER_TEXT'])
            PushScaleformMovieFunctionParameterString(Config.Header['SERVER_DISCORD'])
            ScaleformMovieMethodAddParamBool(false)
            EndScaleformMovieMethod() 
            Wait(3)
        else
            SetStreamedTextureDictAsNoLongerNeeded('ps_pause')
            Wait(150)
        end
    end
end)

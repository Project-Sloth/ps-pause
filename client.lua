local QBCore = exports['qb-core']:GetCoreObject()
local title = Config.Header["TITLE"]
local subtitle = Config.Header["SUBTITLE"]

function AddTextEntry(k, v)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), k, v)
 end

CreateThread(function()
    RequestStreamedTextureDict("ps_pause", true)
    while not HasStreamedTextureDictLoaded("ps_pause") do
        Wait(100)
    end
    while true do
        if IsPauseMenuActive() then
            SetScriptGfxDrawBehindPausemenu(true)
            DrawSprite("ps_pause", Config.Background, 0.5, 0.5, 10.0, 10.0, 0, 255, 255, 255, Config.Opacity)
        else
            SetStreamedTextureDictAsNoLongerNeeded("ps_pause")
        end
      	Wait(0)
    end
end)

local isLoopActive = false

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if IsPauseMenuActive() and not isLoopActive then
            isLoopActive = true
            print("Loop started")

            Citizen.CreateThread(function()
                while true do
                    Wait(1)
                    -- Left Menu
                    N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunction()
                    N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
                    PushScaleformMovieFunctionParameterString(Config.Header["TITLE"])
                    PushScaleformMovieFunctionParameterBool(true)
                    PushScaleformMovieFunctionParameterString(Config.Header["SUBTITLE"])
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()

                    -- Right Menu
                    BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
                    PushScaleformMovieFunctionParameterString(Config.Header["SERVER_NAME"])
                    PushScaleformMovieFunctionParameterString(Config.Header["SERVER_TEXT"]:format(cashAmount))
                    PushScaleformMovieFunctionParameterString(Config.Header["SERVER_DISCORD"]:format(bankAmount))
                    ScaleformMovieMethodAddParamBool(false)
                    ScaleformMovieMethodAddParamBool(isScripted)
                    EndScaleformMovieMethod()
                end
            end) 
        elseif not IsPauseMenuActive() and isLoopActive then
            isLoopActive = false 
            print("Loop stopped")
        end
    end
end)

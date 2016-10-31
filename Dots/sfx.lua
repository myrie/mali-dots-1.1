local sfx = {}

sfx.ping = audio.loadSound( "audio/pingsound.wav" )
sfx.click = audio.loadSound( "audio/tapsound.wav" )
sfx.fanFare = audio.loadSound( "audio/gameover.wav" )
sfx.bgm = audio.loadStream("audio/Calm World.mp3")

sfx.startBgm = function()
    --set loops = -1 to loop infinitely
    local backgroundMusicChannel = audio.play( sfx.bgm, { channel=1, loops=-1}  )
    audio.setVolume(0.25, { channel = 1 })
end

return sfx
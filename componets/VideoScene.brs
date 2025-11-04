function init()
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoTitle = m.top.findNode("videoTitle")
    m.top.visible = false ' La escena empieza invisible

    ' Observador para saber cuando el video termina o hay un error
    m.videoPlayer.observeField("state", "onVideoStateChange")
    m.videoPlayer.observeField("position", "onVideoPositionChange")
end function

function showVideo(videoContent as Object)
    m.videoTitle.text = videoContent.title
    m.videoPlayer.content = videoContent
    m.videoPlayer.control = "play"
    m.videoPlayer.setFocus(true)
end function

function onVideoStateChange(event as Object)
    state = event.getData()
    if state = "finished"
        closeVideo()
    end if
end function

function onVideoPositionChange(event as Object)
    ' Ocultar el título después de unos segundos de reproducción
    position = event.getData()
    if position > 3 and position < 3.5
        m.videoTitle.visible = false
    end if
end function

function closeVideo()
    m.videoPlayer.control = "stop"
    m.top.visible = false
    ' Devolvemos el foco a la escena principal
    m.top.getScene().findNode("posterGrid").setFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    if key = "back"
        closeVideo()
        return true ' Indicamos que hemos manejado el evento
    end if

    return false
end function

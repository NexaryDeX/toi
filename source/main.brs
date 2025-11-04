sub Main()
    ' Creamos un nodo de escena para nuestra pantalla principal
    scene = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    scene.setMessagePort(m.port)

    ' Creamos una instancia de nuestro componente HomeScene
    homeScene = scene.CreateScene("HomeScene")
    
    ' Mostramos la escena
    scene.Show()
    
    ' Iniciamos el bucle de eventos
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed()
                return ' Salimos de la aplicación si se cierra la pantalla
            end if
        end if
    end while
end sub

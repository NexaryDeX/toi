function init()
    m.posterGrid = m.top.findNode("posterGrid")
    m.titleLabel = m.top.findNode("titleLabel")

    ' Cargamos el contenido de prueba
    loadContent()

    ' Observadores de eventos
    m.posterGrid.observeField("itemFocused", "onItemFocused")
    m.posterGrid.observeField("itemSelected", "onItemSelected")
end function

function loadContent()
    content = CreateObject("roSGNodeContentNode")
    
    ' Usamos videos de dominio público para la prueba
    videos = [
        {
            title: "Big Buck Bunny",
            description: "Una divertida aventura de un conejo gigante.",
            posterUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        },
        {
            title: "Elephant Dream",
            description: "El primer cortometraje de Blender, todo en código abierto.",
            posterUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        },
        {
            title: "Sintel",
            description: "Una joven guerrera busca a su dragón, Sintel.",
            posterUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg",
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"
        }
    ]

    for each item in videos
        child = content.createChild("ContentNode")
        child.hdPosterUrl = item.posterUrl
        child.title = item.title
        child.description = item.description
        child.url = item.videoUrl
    end for

    m.posterGrid.content = content
end function

function onItemFocused(event as Object)
    itemFocused = event.getData()
    content = m.posterGrid.content.getChild(itemFocused)
    m.titleLabel.text = content.title
end function

function onItemSelected(event as Object)
    itemSelected = event.getData()
    content = m.posterGrid.content.getChild(itemSelected)
    
    ' Navegamos a la escena de video
    m.top.videoScene = m.top.createChild("VideoScene")
    m.top.videoScene.callFunc("showVideo", {
        url: content.url,
        title: content.title
    })
    m.top.videoScene.visible = true
    m.posterGrid.setFocus(false) ' Quitamos el foco del grid
end function

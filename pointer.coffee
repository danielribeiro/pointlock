requestPointerLock = (container) ->
    # Lock the pointer
    container.requestPointerLock = container.requestPointerLock or container.mozRequestPointerLock or container.webkitRequestPointerLock
    if container.mozRequestFullScreen
        container.mozRequestFullScreen()
        document.addEventListener "mozfullscreenchange", (fullscreenChange = ->
            container.requestPointerLock() if document.mozFullScreenElement is container
        ), false
    else
        container.requestPointerLock()


changeCallback = (args...) -> 
    console.log "pointer lock changed"
    console.log args

# Hook pointer lock state change events
document.addEventListener('pointerlockchange', changeCallback, false)
document.addEventListener('mozpointerlockchange', changeCallback, false)
document.addEventListener('webkitpointerlockchange', changeCallback, false)


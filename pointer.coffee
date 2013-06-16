PointerLock =
    init: ->
        @enabled = false
        # Hook pointer lock state change events
        ["", "moz", "webkit"].forEach (prefix) ->
            changeCallback = (e) ->
                console.log "pointer lock changed for #{prefix}"
                console.log e.type

            document.addEventListener(prefix + 'pointerlockchange', changeCallback, false)

    requestPointerLock: (container) ->
        # Lock the pointer
        container.requestPointerLock = container.requestPointerLock or container.mozRequestPointerLock or container.webkitRequestPointerLock
        if container.mozRequestFullScreen
            container.mozRequestFullScreen()
            if document.mozFullScreenElement is container
                onScreenChange = container.requestPointerLock()
                document.addEventListener "mozfullscreenchange", onScreenChange, false
        else
            container.requestPointerLock()






window.onload = ->
    button = document.querySelector("#click")
    PointerLock.init()
    button.addEventListener("click", -> PointerLock.requestPointerLock(button))
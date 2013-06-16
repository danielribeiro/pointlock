PointerLock =
    init: ->
        @enabled = false
        self = @
        # Hook pointer lock state change events
        ["", "moz", "webkit"].forEach (prefix) ->
            changeCallback = (e) ->
                console.log "pointer lock changed for #{prefix}"
                console.log e.type
                self.enabled = !self.enabled
                document.querySelector("#status").textContent = if self.enabled then "locked!" else "not locked"
            document.addEventListener(prefix + 'pointerlockchange', changeCallback, false)

    fullScreenLock: (container) ->
        console.log "enabling full lock...." , @enabled
        return if @enabled
        console.log "not returned"
        # Lock the pointer
        container.fullScreenLock = container.fullScreenLock or container.mozRequestPointerLock or container.webkitRequestPointerLock
        onFirefox = container.mozRequestFullScreen?
        if onFirefox
            onScreenChange = ->
                container.fullScreenLock() if document.mozFullScreenElement is container
            document.addEventListener "mozfullscreenchange", onScreenChange, false
            container.mozRequestFullScreen()
        else
            container.fullScreenLock()






window.onload = ->
    button = document.querySelector("#click")
    PointerLock.init()
    button.addEventListener("click", -> PointerLock.fullScreenLock(document.querySelector("body")))
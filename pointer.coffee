PointerLock =
    init: (callbackObj = {}) ->
        @enabled = false
        @container = null
        self = @
        {onEnable, onDisable} = callbackObj
        # Hook pointer lock state change events
        ["", "moz", "webkit"].forEach (prefix) ->
            changeCallback = (e) ->
                self.enabled = !self.enabled
                if self.enabled
                    onEnable?()
                else
                    onDisable?()
            document.addEventListener(prefix + 'pointerlockchange', changeCallback, false)

    fullScreenLock: (container) ->
        return if @enabled
        # Lock the pointer
        container.fullScreenLock = container.fullScreenLock or container.mozRequestPointerLock or container.webkitRequestPointerLock
        onFirefox = container.mozRequestFullScreen?
        if onFirefox
            unless @container == container
                onScreenChange = -> container.fullScreenLock() if document.mozFullScreenElement is container
                document.addEventListener "mozfullscreenchange", onScreenChange, false
            container.mozRequestFullScreen()
        else
            container.fullScreenLock()
            container.webkitRequestFullScreen()
        @container = container



window.onload = ->
    showStatus = (str) ->
        document.querySelector("#status").textContent = str
    button = document.querySelector("#click")
    PointerLock.init
        onEnable: ->
            console.log "enabled!"
            showStatus "locked!"
        onDisable: ->
            console.log "disabled!"
            showStatus "not locked"
    button.addEventListener("click", -> PointerLock.fullScreenLock(document.querySelector("body")))
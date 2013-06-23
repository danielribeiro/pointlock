@PointerLock =
    lockAndFullscreen: (el, callbackObj = {}) ->
        @init callbackObj
        @fullScreenLock el

    init: (callbackObj = {}) ->
        @enabled = false
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
            onScreenChange = ->
                container.fullScreenLock() if document.mozFullScreenElement is container
            document.addEventListener "mozfullscreenchange", onScreenChange, false
            container.mozRequestFullScreen()
        else
            container.fullScreenLock()
            container.webkitRequestFullScreen()

window.onload = ->
    showStatus = (str) -> document.querySelector("#status").textContent = str
    button = document.querySelector("#click")
    button.addEventListener "click", ->
        PointerLock.lockAndFullscreen document.querySelector("body"),
            onEnable: ->
                showStatus "locked!"
                console.log "enabled!"
            onDisable: ->
                showStatus "not locked"
                console.log "disabled!"

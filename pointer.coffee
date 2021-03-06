@PointerLock =
    _initialized: false

    init: (callbackObj = {}) ->
        return if @_initialized
        @_initialized = true
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
            container.webkitRequestFullscreen()
        @container = container

    lock: (container, callbackObj) ->
        @init(callbackObj)
        @fullScreenLock(container)

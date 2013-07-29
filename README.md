Pointlock
=========

Simple way of doing cross browser pointer lock. It also makes it fullscreen, as on older versions of Firefox, it is required to be fullscreen in order to get the pointer lock.

Based on the following:

http://advent2012.digitpaint.nl/23/

https://github.com/toji/game-shim/blob/master/game-shim.js

Example of usage (on [gh-page](https://github.com/danielribeiro/pointlock/tree/gh-pages))

```coffeescript
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
```


Meta
----

Created by [Daniel Ribeiro](http://metaphysicaldeveloper.wordpress.com/about-me). 

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

https://github.com/danielribeiro/pointlock

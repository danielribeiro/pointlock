// Generated by CoffeeScript 1.6.2
(function() {
  var PointerLock;

  PointerLock = {
    init: function(callbackObj) {
      var onDisable, onEnable, self;
      if (callbackObj == null) {
        callbackObj = {};
      }
      this.enabled = false;
      this.container = null;
      self = this;
      onEnable = callbackObj.onEnable, onDisable = callbackObj.onDisable;
      return ["", "moz", "webkit"].forEach(function(prefix) {
        var changeCallback;
        changeCallback = function(e) {
          self.enabled = !self.enabled;
          if (self.enabled) {
            return typeof onEnable === "function" ? onEnable() : void 0;
          } else {
            return typeof onDisable === "function" ? onDisable() : void 0;
          }
        };
        return document.addEventListener(prefix + 'pointerlockchange', changeCallback, false);
      });
    },
    fullScreenLock: function(container) {
      var onFirefox, onScreenChange;
      if (this.enabled) {
        return;
      }
      container.fullScreenLock = container.fullScreenLock || container.mozRequestPointerLock || container.webkitRequestPointerLock;
      onFirefox = container.mozRequestFullScreen != null;
      if (onFirefox) {
        if (this.container !== container) {
          onScreenChange = function() {
            if (document.mozFullScreenElement === container) {
              return container.fullScreenLock();
            }
          };
          document.addEventListener("mozfullscreenchange", onScreenChange, false);
        }
        container.mozRequestFullScreen();
      } else {
        container.fullScreenLock();
        container.webkitRequestFullScreen();
      }
      return this.container = container;
    }
  };

}).call(this);

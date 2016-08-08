// Generated by CoffeeScript 1.8.0
(function() {
  var FlickAPI;

  FlickAPI = require('flick-electric-api');

  module.exports = function(RED) {
    var FlickElectricPrice;
    FlickElectricPrice = function(config) {
      var flick;
      RED.nodes.createNode(this, config);
      if (!(this.credentials.username && this.credentials.password)) {
        this.error("Missing username/password");
        return;
      }
      flick = new FlickAPI(this.credentials.username, this.credentials.password);
      this.on('input', (function(_this) {
        return function(msg) {
          flick.get_price();
          return flick.once('price', function(price) {
            msg.payload = price;
            return _this.send(msg);
          });
        };
      })(this));
      flick.on('error', (function(_this) {
        return function(err, details) {
          _this.error("" + err + ": " + details);
          return _this.status({
            fill: "red",
            shape: "dot",
            text: "error"
          });
        };
      })(this));
      flick.on('authenticated', (function(_this) {
        return function() {
          return _this.status({
            fill: "green",
            shape: "dot",
            text: "authenticated"
          });
        };
      })(this));
      return null;
    };
    return RED.nodes.registerType("flick-electric-price", FlickElectricPrice, {
      credentials: {
        username: {
          type: "text"
        },
        password: {
          type: "password"
        }
      }
    });
  };

}).call(this);

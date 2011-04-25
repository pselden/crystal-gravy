(function ($, console) {
	var	owners = {},
		commands = {},
		persistent = {};
	function callem(cmd, handlers, data) {
		if (!handlers) return;
		for (var i = 0; i < handlers.length; i++) {
			try {
				if (handlers[i](data, cmd) === true)
					$.comm.stopListening(cmd, handlers[i--]);
			}
			catch (ex) {
				$.error("$.comm handler error", ex);
			}
		}
	}
	$.comm = {
		own: function (name, switchboard) {
			if (owners[name])
				throw new Error(name + " already registered");
			if (!switchboard)
				throw new Error("invalid switchboard");

			owners[name] = switchboard;
			var broadcast = function (cmd, data) {
				callem(cmd, commands[cmd], data);
			};
			return {
				broadcast: function (cmd, data) {
					if (!broadcast) throw new Error("This controller has been abandoned");
					cmd = name + '.' + cmd;
					broadcast(cmd, data);
				},
				abandon: function () {
					if (!broadcast) throw new Error("This controller has already been abandoned");
					delete owners[name];
					broadcast = null
				}
			};
		},
		listen: function (cmd, callback, persist) {
			if (!$.isFunction(callback)) return;
			var cmds = cmd.split(',');
			for (var i = 0; i < cmds.length; i++) {
				cmd = cmds[i];
				(commands[cmd] || (commands[cmd] = [])).push(callback);
				if (persist)
					(persistent[cmd] || (persistent[cmd] = [])).push(callback);
			}
		},
		stopListening: function (cmd, callback) {
			var audience = commands[cmd];
			if (!audience) return;
			var i = $.inArray(callback, audience);
			if (i == -1) return;
			audience.splice(i, 1);

			audience = persistent[cmd];
			if (audience) {
				i = $.inArray(callback, audience);
				if (i > -1)
					audience.splice(i, 1);
			}
		},
		send: function (cmd, data) {
			var parts = cmd.match(/([^.]+)(?:\.(.+))?/).slice(1);
			if (parts.length != 2)
				throw new Error("invalid command");
			var owner = owners[parts[0]];
			if (owner) (owner[parts[1]] || $.noop)(data);
			else callem(cmd, commands[cmd], data);
		},
		_clearListeners: function () {
			commands = $.extend({}, persistent, true);
		}
	};
})(jQuery, window.console);

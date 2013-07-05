(function() {
    var self = this;
    var paramNamesIn, resolveArguments, serviceNamedIn, create;
    exports.bind = function(Constructor, services) {
        var self = this;
        var names, args;
        names = paramNamesIn(Constructor);
        args = resolveArguments(names, services);
        return function() {
            return create(Constructor, args);
        };
    };
    paramNamesIn = function(func) {
        var s;
        s = func.toString();
        return s.slice(s.indexOf("(") + 1, s.indexOf(")")).match(/([^\s,]+)/g);
    };
    resolveArguments = function(names, services) {
        var args, gen1_items, gen2_i, name;
        args = [];
        gen1_items = names;
        for (gen2_i = 0; gen2_i < gen1_items.length; ++gen2_i) {
            name = gen1_items[gen2_i];
            args.push(serviceNamedIn(name, services));
        }
        return args;
    };
    serviceNamedIn = function(name, services) {
        if (name in services) {
            return services[name];
        } else {
            throw new Error("No service named '" + name + "'");
        }
    };
    create = function(Constructor, args) {
        var BoundConstructor, instance;
        BoundConstructor = function() {
            return void 0;
        };
        BoundConstructor.prototype = Constructor.prototype;
        instance = new BoundConstructor();
        Constructor.apply(instance, args);
        return instance;
    };
}).call(this);
exports.bind (Constructor, services) =
    names = param names in (Constructor)
    args = resolve arguments (names, services)
    @{ create (Constructor, args) }

param names in (func) =
    s = func.to string()
    s.slice(s.indexOf '(' + 1, s.indexOf ')').match r/([^\s,]+)/g

resolve arguments (names, services) =
    args = []
    for each @(name) in (names)
        args.push (service named (name) in (services))

    args

service named (name) in (services) =
    if ((name) in (services))
        services.(name)
    else
        throw (@new Error "No service named '#(name)'")

create (Constructor, args) =
    Bound Constructor () = nil
    Bound Constructor.prototype = Constructor.prototype
    instance = @new Bound Constructor
    Constructor.apply(instance, args)
    instance

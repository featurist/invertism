invertism = require '../src/invertism'

describe 'invertism'
    
    Clock (time, display) =
        this.time = time
        this.display = display

    Clock.prototype.read () =
        this.display(this.time())
    
    it 'injects dependencies by name'
        services = {
            time () = '12:34'
            display (text) = "[#(text)]"
        }
        factory = invertism.bind(Clock, services)
        clock = factory()
        clock.read().should.equal '[12:34]'

    it 'complains about unresolvable dependencies'
        services = { time () = 'xxx' }
        binding () = invertism.bind(Clock, services)
        binding.should.throw "No service named 'display'"

    it 'injects objects as services'
        services = {
            time = 123
            display = false
        }
        factory = invertism.bind(Clock, services)
        clock = factory()
        clock.time.should.equal 123
        clock.display.should.be.false
        
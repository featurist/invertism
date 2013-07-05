# Invertism

A dependency inversion utility for JavaScript.

Use invertism for [partial appliction](http://en.wikipedia.org/wiki/Partial_application) of constructors and other functions, where arguments are injected from on a set of named services.

## Install

    npm install invertism

## Usage

    invertism = require 'invertism'
    
    services = {
        time () = '12:34'
        display (text) = "[#(text)]"
    }
    
    Clock (time, display) =
        this.time = time
        this.display = display
    
    Clock.prototype.read () =
        this.display(this.time())
      
    Bound Clock = invertism.bind(Clock, services)
    
    clock = @new Bound Clock () // no arguments!
    clock.read()                // '[12:34]'

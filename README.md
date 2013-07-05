# Invertism

A dependency inversion utility for JavaScript.

Use invertism to inject arguments into constructors and other functions, from a set of named services.

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

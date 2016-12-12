package;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import haxe.Timer;

class World extends B2World {
    var rocket : Rocket;
    var physicsTimer : Timer;
    var timeStepSeconds = 1.0 / 60.0;
    var timeStepMillis : Int;

    public function new() {
        var gravity = new B2Vec2(0.0, 0.0);
        var doSleep = true;
        super(gravity, doSleep);

        this.timeStepMillis = Std.int(timeStepSeconds * 1000);
        this.physicsTimer = new Timer(timeStepMillis);

        physicsTimer.run = this.stepWorld;

        this.rocket = new Rocket(this);
    }

    public function getDisplayObjects() : Array<DisplayObject> {
        return [rocket];
    }

    function stepWorld() {
        // # of iterations for Box2D's simulation
        // higher is more accurate (but slower)
        var velocityIters = 8;
        var positionIters = 3;
        trace('stepping');
        this.step(this.timeStepSeconds, velocityIters, positionIters);
    }
}

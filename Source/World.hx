package;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.DisplayObject;

import haxe.Timer;

class World extends B2World {
    var rocket : Rocket;
    var physicsTimer : Timer;
    var timeStepSeconds = 1.0 / 30.0;
    var timeStepMillis : Int;
    var track : Track;

    public static inline var widthM = 10.0;
    public static inline var heightM = 10.0;

    var debugSprite : Sprite;
    var debugDraw = true;

    public function new() {
        var gravity = new B2Vec2(0.0, 0.0);
        var doSleep = true;
        super(gravity, doSleep);

        // create objects in the world
        this.track = new Track(this);
        this.rocket = new Rocket(this);

        this.timeStepMillis = Std.int(timeStepSeconds * 1000);
        this.physicsTimer = new Timer(timeStepMillis);
        physicsTimer.run = this.stepWorld;

        if (debugDraw) {
            setupDebugDraw();
        }
    }

    function setupDebugDraw() {
        var dbDraw = new B2DebugDraw();
        dbDraw.appendFlags(B2DebugDraw.e_shapeBit);
        debugSprite = new Sprite();
        dbDraw.setSprite(debugSprite);
        dbDraw.setDrawScale(50.0);
        this.setDebugDraw(dbDraw);
    }

    public function getDisplayObjects() : Array<DisplayObject> {
        if (debugDraw) {
            return [debugSprite];
        } else {
            return [cast(rocket, DisplayObject)].concat(track.getDisplayObjects());
        }
    }

    function stepWorld() {
        // # of iterations for Box2D's simulation
        // higher is more accurate (but slower)
        var velocityIters = 8;
        var positionIters = 3;
        this.step(this.timeStepSeconds, velocityIters, positionIters);
        this.drawDebugData();
    }

    public static function metersToPixels(
            horiz : Float,
            vert : Float) : Util.IntPoint {
        var minDim = getSquareDimensionPx();

        var xPx = Std.int(horiz / World.widthM * minDim);
        var yPx = Std.int(vert / World.heightM * minDim);
        return {x : xPx, y : yPx}
    }

    static function getSquareDimensionPx() {
        var stageWidthPx = Lib.current.stage.stageWidth;
        var stageHeightPx = Lib.current.stage.stageHeight;
        return Math.min(stageWidthPx, stageHeightPx);
    }

    public static function pixelsToMeters(px : Int) : Float {
        var minDimPx = getSquareDimensionPx();
        var minDimM = Math.min(World.widthM, World.heightM);

        return px / minDimPx * minDimM;
    }
}

package;

import openfl.display.DisplayObject;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

// a course to race on
class Track {
    var world : B2World;
    var boundaries : Array<TrackEdge>;

	public function new(_world : B2World, trackType : TrackType) {
        this.world = _world;

        boundaries = new Array<TrackEdge>();
        var topLeft  = new B2Vec2(0.0,          0.0);
        var topRight = new B2Vec2(World.widthM, 0.0);

        var thicknessM = World.pixelsToMeters(Std.int(TrackEdge.thicknessPx));
        var botLeft  = new B2Vec2(0.0,          World.heightM - thicknessM);
        var botRight = new B2Vec2(World.widthM, World.heightM - thicknessM);

        boundaries.push(new TrackEdge(world, topRight, topLeft));
        boundaries.push(new TrackEdge(world, topLeft, botLeft));
        boundaries.push(new TrackEdge(world, botLeft, botRight));
        boundaries.push(new TrackEdge(world, botRight, topRight));

        if (trackType == LOOP) {
            addInnerBox();
        }
    }
    function addInnerBox() {
        var raceWayWidth = .3 * World.widthM;
        var raceWayHeight = .3 * World.heightM;
        var topLeft  = new B2Vec2(raceWayWidth, raceWayHeight);
        var topRight = new B2Vec2(World.widthM - raceWayWidth, raceWayHeight);
        var botLeft  = new B2Vec2(raceWayWidth, World.heightM - raceWayHeight);
        var botRight = new B2Vec2(World.widthM - raceWayWidth,
                World.heightM - raceWayHeight);

        boundaries.push(new TrackEdge(world, topRight, topLeft));
        boundaries.push(new TrackEdge(world, topLeft, botLeft));
        boundaries.push(new TrackEdge(world, botLeft, botRight));
        boundaries.push(new TrackEdge(world, botRight, topRight));
	}

    public function getDisplayObjects() {
        return boundaries.map(
            function(edge : TrackEdge) : DisplayObject {
                return cast(edge, DisplayObject);
            }
        );
    }
}

enum TrackType {
    BOX;
    LOOP;
}

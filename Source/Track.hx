package;

import openfl.display.DisplayObject;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

// a course to race on
class Track {
    var world : B2World;
    var parentBody : B2Body;
    var boundaries : Array<TrackEdge>;

	public function new(_world : B2World) {
        this.world = _world;

        var bodyDef = new B2BodyDef();
        parentBody = world.createBody(bodyDef);

        boundaries = new Array<TrackEdge>();
        var topLeft  = new B2Vec2(0.0,          0.0);
        var topRight = new B2Vec2(World.widthM, 0.0);

        var thicknessM = World.pixelsToMeters(Std.int(TrackEdge.thicknessPx));
        var botLeft  = new B2Vec2(0.0,          World.heightM - thicknessM);
        var botRight = new B2Vec2(World.widthM, World.heightM - thicknessM);

        boundaries.push(new TrackEdge(parentBody, topLeft, topRight));
        boundaries.push(new TrackEdge(parentBody, topLeft, botLeft));
        boundaries.push(new TrackEdge(parentBody, botLeft, botRight));
        boundaries.push(new TrackEdge(parentBody, botRight, topRight));
	}

    public function getDisplayObjects() {
        return boundaries.map(
            function(edge : TrackEdge) : DisplayObject {
                return cast(edge, DisplayObject);
            }
        );
    }
}

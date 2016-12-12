package;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

// a course to race on
class Track {
    var world : B2World;
    var parentBody : B2Body;
    var boundaries : Array<B2PolygonShape>;

	public function new(_world : B2World) {
        this.world = _world;

        var bodyDef = new B2BodyDef();
        bodyDef.position = new B2Vec2(0.0, 0.0);
        parentBody = world.createBody(bodyDef);

        boundaries = new Array<B2PolygonShape>();
        var topLeft  = new B2Vec2(0.0,          0.0);
        var topRight = new B2Vec2(World.widthM, 0.0);
        var botLeft  = new B2Vec2(0.0,          World.heightM);
        var botRight = new B2Vec2(World.widthM, World.heightM);
        boundaries.push(createEdge(topLeft, topRight));
        boundaries.push(createEdge(topLeft, botLeft));
        boundaries.push(createEdge(botLeft, botRight));
        boundaries.push(createEdge(botRight, topRight));
	}

    function createEdge(
            startPoint : B2Vec2,
            endPoint : B2Vec2) : B2PolygonShape {
        var shape = new B2PolygonShape();
        shape.setAsEdge(startPoint, endPoint);
        parentBody.createFixture2(shape);
        return shape;
    }

    function getDisplayObjects() {
    }
}

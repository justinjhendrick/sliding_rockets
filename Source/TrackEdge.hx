package;

import openfl.display.Sprite;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class TrackEdge extends Sprite {
    var world : B2World;

    var body : B2Body;
    var physicalShape : B2PolygonShape;

    var startPoint : B2Vec2;
    var endPoint : B2Vec2;

    var startPointPx : Util.IntPoint;
    var endPointPx : Util.IntPoint;

    var color = 0x000000;
    public static inline var thicknessPx = 10.0;

	public function new(
            _world : B2World,
            _startPoint : B2Vec2,
            _endPoint : B2Vec2) {
        super();
        this.world = _world;
        this.startPoint = _startPoint;
        this.endPoint = _endPoint;

        this.startPointPx = World.metersToPixels(startPoint.x, startPoint.y);
        this.endPointPx = World.metersToPixels(endPoint.x, endPoint.y);

        draw();

        var bodyDef = new B2BodyDef();
        this.body = world.createBody(bodyDef);
        this.physicalShape = new B2PolygonShape();
        this.physicalShape.setAsEdge(this.startPoint, this.endPoint);
        this.body.createFixture2(this.physicalShape);
    }

    function draw() {
        Util.drawLine(
                this.graphics,
                this.color,
                TrackEdge.thicknessPx,
                this.startPointPx.x,
                this.startPointPx.y,
                this.endPointPx.x,
                this.endPointPx.y);
    }
}

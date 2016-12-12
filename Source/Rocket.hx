package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class Rocket extends Sprite {

    public var body : B2Body;

    var needRedraw = false;
    var color = 0xff0000;

    var widthM = 1.0;
    var heightM = 2.0;

    var widthPx : Int;
    var heightPx : Int;
	
	public function new(world : B2World) {
		super();
        createBody(world);

        onResize(null);
        draw();

        this.addEventListener(Event.ENTER_FRAME, everyFrame);
        this.addEventListener(Event.RESIZE, onResize);
    }

    function createBody(world : B2World) {
        var bodyDef = new B2BodyDef();
        bodyDef.type = B2BodyType.DYNAMIC_BODY;
        bodyDef.position = new B2Vec2(0.0, 0.0);
        bodyDef.angle = 0.0;
        bodyDef.linearVelocity = new B2Vec2(1.0, 1.0); // m/s
        bodyDef.linearDamping = 0.0;
        this.body = world.createBody(bodyDef);

        var shape = new B2PolygonShape();
        var triangleVertices = new Array();
        triangleVertices.push(new B2Vec2(widthM / 2, 0.0));
        triangleVertices.push(new B2Vec2(0.0, heightM));
        triangleVertices.push(new B2Vec2(widthM, heightM));
        shape.setAsVector(triangleVertices);

        this.body.createFixture2(shape);
	}

    function everyFrame(e : Event) {
        var p = World.metersToPixels(
                this.body.getPosition().x,
                this.body.getPosition().y);
        this.x = p.x;
        this.y = p.y;

        if (needRedraw) {
            this.graphics.clear();
            this.draw();
        }
    }

    function onResize(e : Event) {
        var p = World.metersToPixels(this.widthM, this.heightM);
        this.widthPx = p.x;
        this.heightPx = p.y;
    }

    function draw() {
        this.graphics.beginFill(color);
        Util.drawTriangle(
            this.graphics,
            new Point(this.widthPx / 2, 0),
            new Point(this.widthPx, this.heightPx),
            new Point(0, heightPx)
        );
        this.graphics.endFill();
    }
}

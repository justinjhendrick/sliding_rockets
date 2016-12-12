package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class Rocket extends Sprite {

    public var body : B2Body;
    public var fixture : B2Fixture;

    var needRedraw = false;
    var color = 0xff0000;
    var widthPx = 50;
    var heightPx = 100;

    var widthM = 1.0;
    var heightM = 2.0;
	
	public function new(world : B2World) {
		super();
        createBody(world);
        draw();
        this.addEventListener(Event.ENTER_FRAME, everyFrame);
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

        fixture = this.body.createFixture2(shape);
	}

    function everyFrame(e : Event) {
        if (needRedraw) {
            this.graphics.clear();
            this.draw();
        }
        computePixelCoords();
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

    function computePixelCoords() {
        // TODO scale to screen
        trace('x = $x, y = $y');
        this.x = this.body.getPosition().x;
        this.y = this.body.getPosition().y;
    }
}

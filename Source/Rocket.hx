package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.ui.Keyboard;

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
    
    var inputHandler : InputHandler;
	
	public function new(world : B2World) {
		super();
        createBody(world);

        onResize(null);
        draw();

        Main.globalTopLevelSprite.stage
            .addEventListener(Event.ENTER_FRAME, everyFrame);
        Main.globalTopLevelSprite.stage
            .addEventListener(Event.RESIZE, onResize);
        inputHandler = new InputHandler();
    }

    function createBody(world : B2World) {
        var bodyDef = new B2BodyDef();
        bodyDef.type = B2BodyType.DYNAMIC_BODY;
        bodyDef.position = new B2Vec2(0.0, 0.0);
        bodyDef.angle = 0.0;
        bodyDef.linearVelocity = new B2Vec2(1.0, 1.0); // m/s
        bodyDef.linearDamping = 0.0;
        bodyDef.bullet = true;
        bodyDef.fixedRotation = false;
        this.body = world.createBody(bodyDef);

        var shape = new B2PolygonShape();
        var triangleVertices = new Array();
        triangleVertices.push(new B2Vec2(widthM / 2, 0.0));
        triangleVertices.push(new B2Vec2(widthM, heightM));
        triangleVertices.push(new B2Vec2(0.0, heightM));
        shape.setAsVector(triangleVertices);

        this.body.createFixture2(shape, 1.0);
	}

    function everyFrame(e : Event) {
        getInputAndApplyForces();

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

    function getInputAndApplyForces() {
        var forceMagnitude = 0.1; // in N
        var torqueMagnitude = 1.0; // in Nm
        var force : B2Vec2 = new B2Vec2(0.0, 0.0);
        var torque = 0.0; // +z is into the screen
        if (inputHandler.isHeldOrWasDown(Keyboard.SPACE)) {
            var angle = this.body.getAngle() - Math.PI / 2;
            var rocketPrograde = new B2Vec2(Math.cos(angle), Math.sin(angle));
            rocketPrograde.multiply(forceMagnitude);
            force.add(rocketPrograde);
        }
        if (inputHandler.isHeldOrWasDown(Keyboard.LEFT)) {
            torque -= torqueMagnitude;
        }
        if (inputHandler.isHeldOrWasDown(Keyboard.RIGHT)) {
            torque += torqueMagnitude;
        }
        var centerOfMassInWorldCoords = body.getWorldCenter();
        this.body.m_torque = 0.0; // only apply torque for one frame
        this.body.applyTorque(torque);
        this.body.applyImpulse(force, centerOfMassInWorldCoords);

        var m_torque = body.m_torque;
        var angVel = body.m_angularVelocity;
        trace('torque = $m_torque, angVel = $angVel');
    }

    function onResize(e : Event) {
        var p = World.metersToPixels(this.widthM, this.heightM);
        this.widthPx = p.x;
        this.heightPx = p.y;
    }

    function draw() {
        var verticesLocalPx = getVerticesLocalPx();
        this.graphics.beginFill(color);
        Util.drawTriangleInt(
            this.graphics,
            verticesLocalPx[0],
            verticesLocalPx[1],
            verticesLocalPx[2]);
        this.graphics.endFill();
    }

    function getVerticesLocalPx() : Array<Util.IntPoint> {
        var shape = cast(this.body.getFixtureList().getShape(), B2PolygonShape);
        var verticesLocalM = shape.getVertices();

        // get WorldPoint rotates and translates
        var verticesGlobalM = verticesLocalM.map(body.getWorldPoint);

        // but we only want the rotation, so translate back to local positions
        var verticesLocalRotatedM = verticesGlobalM.map(
            function(v : B2Vec2) : B2Vec2 {
                var pos = body.getPosition();
                var newX = v.x - pos.x;
                var newY = v.y - pos.y;
                return new B2Vec2(newX, newY);
            });

        var verticesLocalPx = verticesLocalRotatedM.map(
            function(v : B2Vec2) : Util.IntPoint {
                return World.metersToPixels(v.x, v.y);
            });
        return verticesLocalPx;
    }
}

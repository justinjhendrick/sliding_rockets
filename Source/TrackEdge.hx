package;

import openfl.display.Sprite;

import box2D.dynamics.*;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class TrackEdge extends Sprite {
    var physicalShape : B2PolygonShape;

    var widthPx : Int;
    var heightPx : Int;

    var color = 0x000000;

	public function new(
            parentBody : B2Body,
            startPoint : B2Vec2,
            endPoint : B2Vec2) {
        super();

        var p = World.metersToPixels(startPoint.x, startPoint.y);
        this.x = p.x; this.y = p.y;

        p = World.metersToPixels(
                endPoint.x - startPoint.x,
                endPoint.y - startPoint.y);
        this.widthPx = p.x;
        this.heightPx = p.y;

        if (this.widthPx < 5) {
            this.widthPx = 5;
        }
        if (this.heightPx < 5) {
            this.heightPx = 5;
        }

        draw();

        this.physicalShape = new B2PolygonShape();
        this.physicalShape.setAsEdge(startPoint, endPoint);
        parentBody.createFixture2(this.physicalShape);
    }

    function draw() {
        Util.drawRectangle(
                this.graphics,
                this.color,
                this.widthPx,
                this.heightPx);
    }

}

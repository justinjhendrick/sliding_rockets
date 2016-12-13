package;

import openfl.Vector;
import openfl.display.Graphics;
import openfl.geom.Point;

typedef IntPoint = {x: Int, y :Int};

class Util {
    public static function drawTriangle(
            g : Graphics,
            p1 : Point,
            p2 : Point,
            p3 : Point) {
        var v = new Vector<Float>(6);
        v[0] = p1.x;
        v[1] = p1.y;
        v[2] = p2.x;
        v[3] = p2.y;
        v[4] = p3.x;
        v[5] = p3.y;
        g.drawTriangles(v);
    }

    public static function drawRectangle(
            g : Graphics,
            color : Int,
            w : Int,
            h : Int) {
        drawRectangleWithOffset(g, color, 0, 0, w, h);
    }

    public static function drawRectangleWithOffset(
            g : Graphics,
            color : Int,
            deltaX : Int, // this is not the absolute position
            deltaY : Int, // rather, relative to g's parent x and y
            w : Int,
            h : Int) {
        g.beginFill(color);
        g.drawRect(deltaX, deltaY, w, h);
        g.endFill();
    }
}

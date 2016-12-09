package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;

class Rocket extends Sprite {

    var needRedraw = false;
    var color = 0xff0000;
    var width_px = 50;
    var height_px = 100;
	
	public function new() {
		super();
        this.x = 0;
        this.y = 0;
        draw();
        this.addEventListener(Event.ENTER_FRAME, redraw);
	}

    function draw() {
        this.graphics.beginFill(color);
        Util.drawTriangle(
            this.graphics,
            new Point(this.width_px / 2, 0),
            new Point(this.width_px, this.height_px),
            new Point(0, height_px)
        );
        this.graphics.endFill();
    }

    function redraw(e : Event) {
        if (needRedraw) {
            this.graphics.clear();
            this.draw();
        }
    }
}

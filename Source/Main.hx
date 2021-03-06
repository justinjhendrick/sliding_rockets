package;

import openfl.display.Sprite;
import openfl.display.DisplayObject;

class Main extends Sprite {
    var world : World;
    public static var globalTopLevelSprite;
	
	public function new() {
		super();
        globalTopLevelSprite = this;
        world = new World();
        this.addChildren(world.getDisplayObjects());
	}

    public function addChildren(displayObjects : Array<DisplayObject>) {
        for (dispObj in displayObjects) {
            this.addChild(dispObj);
        }
    }
}

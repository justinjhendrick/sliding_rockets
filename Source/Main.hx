package;

import openfl.display.Sprite;

class Main extends Sprite {
	
	public function new() {
		super();
        var rocket = new Rocket();
        this.addChild(rocket);
	}
}

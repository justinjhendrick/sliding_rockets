package;

import haxe.unit.*;

import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.ui.Keyboard;
import openfl.display.InteractiveObject;

class TestInputHandler extends TestCase {
    var kDown : KeyboardEvent;
    var kUp : KeyboardEvent;
    var mDown : KeyboardEvent;
    var mUp : KeyboardEvent;

    override public function setup() {
       kDown = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
       kDown.keyCode = Keyboard.K;
       kUp = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
       kUp.keyCode = Keyboard.K;

       mDown = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
       mDown.keyCode = Keyboard.M;
       mUp = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
       mUp.keyCode = Keyboard.M;
    }
        
    public function testBasic() {
        var inputHandler = new InputHandler();

        inputHandler.onKeyDown(kDown);
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.K));
        inputHandler.onKeyUp(kUp);
        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.K));

        inputHandler.onKeyDown(kDown);
        inputHandler.onKeyUp(kUp);
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.K));
    }

    public function testRepeatChar() {
        var inputHandler = new InputHandler();
        
        inputHandler.onKeyDown(mDown);
        inputHandler.onKeyUp(mUp);
        inputHandler.onKeyDown(mDown);
        inputHandler.onKeyUp(mUp);
        inputHandler.onKeyDown(mDown);
        inputHandler.onKeyUp(mUp);

        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.M));
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.M));
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.M));
        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.M));
    }

    public function testMultipleChars() {
        var inputHandler = new InputHandler();
        
        inputHandler.onKeyDown(mDown);
        inputHandler.onKeyDown(kDown);
        inputHandler.onKeyUp(mUp);
        inputHandler.onKeyUp(kUp);

        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.M));
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.K));
        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.M));
        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.K));
    }

    public function testMultipleCharsHold() {
        var inputHandler = new InputHandler();
        
        inputHandler.onKeyDown(mDown);
        inputHandler.onKeyDown(kDown);
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.K));
        inputHandler.onKeyUp(kUp);
        assertTrue(inputHandler.isHeldOrWasDown(Keyboard.M));
        inputHandler.onKeyUp(mUp);

        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.K));
        assertFalse(inputHandler.isHeldOrWasDown(Keyboard.M));
    }
}

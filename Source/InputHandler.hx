/*   I don't want to repeatedly creat an isDown array in every class that
     wants to listen to events

   This class must:
   1) provide an interface for all objects that want to listen to keyboard and
   other events. NOTE: the current solution is for each object to have their own
   InputHandler instance.
       1a) user objects can't interfere with each other. For example:
       user presses key k, object A queries and gets k. if object B queries as
       well, it must also retrieve k.  Each object can act like it is the only
       input reader.
   2) no inputs are impossible to read
       2a) if the key press occurs between queries (and isn't actually down when
       either query occurs), the reader should still recieve the input (but
       only once).
       2b) a user input of k, k should return wasDown(k) -> true TWICE
*/

package;

import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.ui.Keyboard;
import openfl.display.InteractiveObject;

typedef KeyCode = Int;

// TODO mouse events
@:allow(TestInputHandler)
class InputHandler extends InteractiveObject {

    var isDown : Set<KeyCode>;
    var numberOfUnreadDowns : CounterMap<KeyCode>;

    public function new() {
        super();
        isDown = new Set<KeyCode>();
        var noNegatives = true;
        numberOfUnreadDowns = new CounterMap<KeyCode>(noNegatives);

        Main.globalTopLevelSprite.stage
            .addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.globalTopLevelSprite.stage
            .addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    public function isHeldOrWasDown(k : KeyCode) : Bool {
        var result = false;
        if (isDown.contains(k) || numberOfUnreadDowns.getCount(k) > 0) {
            result = true;
        }
        numberOfUnreadDowns.decrement(k); // won't go past 0
        return result;
    }

    function onKeyDown(e : KeyboardEvent) {
        //debug
        var k = e.keyCode;
        trace('$k down');

        isDown.put(e.keyCode);
        numberOfUnreadDowns.increment(e.keyCode);
    }

    function onKeyUp(e : KeyboardEvent) {
        //debug
        var k = e.keyCode;
        trace('$k up');

        isDown.remove(e.keyCode);
    }
}

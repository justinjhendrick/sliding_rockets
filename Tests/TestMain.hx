package;

import haxe.unit.*;

class TestMain extends TestRunner {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestInputHandler());
        r.run();
    }
}

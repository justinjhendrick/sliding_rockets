package;

// Haxe doesn't have a Set class
@:generic
@:remove
class Set<K> {
    var map : Map<K, Bool>;

    public function new() {
        map = new Map<K, Bool>();
    }

    public function put(k : K) {
        map.set(k, true);
    }

    public function contains(k : K) : Bool {
        return map.exists(k);
    }

    public function remove(k : K) {
        map.remove(k);
    }
}

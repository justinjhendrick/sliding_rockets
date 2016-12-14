package;

// a map from K to a count
@:generic
@:remove
class CounterMap<K> {
    var noNegatives : Bool;
    var map : Map<K, Int>;

    public function new(_noNegatives : Bool) {
        noNegatives = _noNegatives;
        map = new Map<K, Int>();
    }

    public function increment(k : K) {
        addOrSubtract(k, 1);
    }

    public function decrement(k : K) {
        addOrSubtract(k, -1);
    }

    function addOrSubtract(k : K, delta : Int) {
        if (map.exists(k)) {
            map.set(k, map.get(k) + delta);
        } else {
            map.set(k, delta);
        }

        if (noNegatives) {
            keepNatural(k);
        }
    }

    // as in the Natural Numbers 0, 1, 2, 3, ...
    function keepNatural(k : K) {
        if (map.get(k) < 0) {
            map.set(k, 0);
        }
    }

    public function getCount(k : K) : Int {
        var count = map.get(k);
        if (count == null) {
            return 0;
        }
        return count;
    }
}

using Lambda;

typedef CacheObject = {
  response :String,
  accessTime :Float
};

class LruCache {
    public var capacity(default,null) :Int;
    private var cacheData :Map<String, CacheObject>;
    private var length = 0;
      
    public function new(capacity) {
        this.capacity = capacity;
        this.cacheData = new Map<String,CacheObject>();
    }

    public function add(key :String, value :String) {
        if( !cacheData.exists(key) )
            length++;

        var cacheObj = {
            response: value,
            accessTime: Sys.time()
        };
        cacheData.set(key, cacheObj);

        if( length > capacity ){
            evictLru();
        }
    }

    public function has(key) {
        return cacheData.exists(key);
    }

    public function get(key) {
        var value = cacheData.get(key);
        value.accessTime = Sys.time();
        return value.response;
    }

    public function remove(key) {
        cacheData.remove(key);
    }

    private function evictLru() {
        var oldestKey = null;
        var oldestValue = null;
        for( key => value in cacheData ){
            if( oldestValue == null || oldestValue.accessTime > value.accessTime ){
                oldestKey = key;
                oldestValue = value;
            }
        }
        cacheData.remove(oldestKey);
    }
}


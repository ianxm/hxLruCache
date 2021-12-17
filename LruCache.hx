using Lambda;

typedef CacheObject<T> = {
    response :T,
    accessTime :Float
};

class LruCache<T> {

    public var capacity(default,null) :Int;
    private var cacheData :Map<String, CacheObject<T>>;
    public var length(default,null) = 0;
      
    public function new(capacity) {
        this.capacity = capacity;
        this.cacheData = new Map<String,CacheObject<T>>();
    }

    public function add(key :String, value :T) {
        if( !cacheData.exists(key) )
            length++;

        var cacheObj = {
            response: value,
            accessTime: getTime()
        };
        cacheData.set(key, cacheObj);

        if( length > capacity ){
            evictLru();
        }
    }

    inline public function has(key) {
        return cacheData.exists(key);
    }

    public function get(key) {
        var value = cacheData.get(key);
        value.accessTime = getTime();
        return value.response;
    }

    inline public function remove(key) {
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

    private function getTime() {
#if sys
        return Sys.time();
#else
        return Date.now().getTime();
#end
    }
}

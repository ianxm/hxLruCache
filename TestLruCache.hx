class TestLruCache extends haxe.unit.TestCase
{
    public function testAddHasGet()
    {
        var cache = new LruCache(3);
        cache.add("key1", "value1");
        cache.add("key2", "value2");

        assertTrue(cache.has("key1"));
        assertTrue(cache.has("key2"));
        assertFalse(cache.has("key3"));

        assertEquals("value1", cache.get("key1"));
        assertEquals("value2", cache.get("key2"));
    }

    public function testAddAddEvict()
    {
        var cache = new LruCache(2);
        cache.add("key1", "value1");
        cache.add("key2", "value2");
        cache.add("key3", "value3");

        assertFalse(cache.has("key1"));
        assertTrue(cache.has("key2"));
        assertTrue(cache.has("key3"));
    }

    public function testAddTouchEvict()
    {
        var cache = new LruCache(2);
        cache.add("key1", "value1");
        cache.add("key2", "value2");
        cache.get("key1");
        cache.add("key3", "value3");

        assertTrue(cache.has("key1"));
        assertFalse(cache.has("key2"));
        assertTrue(cache.has("key3"));
    }
}

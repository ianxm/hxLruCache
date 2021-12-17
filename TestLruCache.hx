class TestLruCache extends haxe.unit.TestCase
{
    public function testAddHasGet()
    {
        var cache = new LruCache<String>(3);
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
        var cache = new LruCache<String>(2);
        cache.add("key1", "value1");
        cache.add("key2", "value2");
        cache.add("key3", "value3");

        assertFalse(cache.has("key1"));
        assertTrue(cache.has("key2"));
        assertTrue(cache.has("key3"));
    }

    public function testAddTouchEvict()
    {
        var cache = new LruCache<String>(2);
        cache.add("key1", "value1");
        cache.add("key2", "value2");
        cache.get("key1");
        cache.add("key3", "value3");

        assertTrue(cache.has("key1"));
        assertFalse(cache.has("key2"));
        assertTrue(cache.has("key3"));
    }

    public function testAddHasGetInt()
    {
        var cache = new LruCache<Int>(3);
        cache.add("key1", 1);
        cache.add("key2", 2);

        assertTrue(cache.has("key1"));
        assertTrue(cache.has("key2"));
        assertFalse(cache.has("key3"));

        assertEquals(1, cache.get("key1"));
        assertEquals(2, cache.get("key2"));
    }
}

#!/bin/bash

if [ -e hxLruCache.zip ]; then
    rm hxLruCache.zip
fi

zip hxLruCache.zip haxelib.json LICENSE README *.hx test.hxml

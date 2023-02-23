#!/usr/bin/env python3

'''
implement a function.  It uses the requests module to obtain the
HTML content of a particular URL and returns it
'''
import requests
import time
from functools import wraps
from typing import Dict

cache: Dict[str, str] = {}

def get_page(url: str) -> str:
    if url in cache:
        print(f"Retrieving from cache: {url}")
        return cache[url]
    else:
        print(f"Retrieving from web: {url}")
        out = requests.get(url)
        result = out.text
        cache[url] = result
        return result

def cache_with_expiration(expiration: int):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            url = args[0]
            key = f"count:{url}"
            if key in cache:
                count, timestamp = cache[key]
                if time.time() - timestamp > expiration:
                    result = func(*args, **kwargs)
                    cache[key] = (count+1, time.time())
                    return result
                else:
                    cache[key] = (count+1, timestamp)
                    return

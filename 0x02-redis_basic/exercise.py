#!/usr/bin/env python3

'''
create cache class
'''
import redis
import uuid
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    ''' count calls '''
    @wraps(method)
    def wrap(self, *args, **kwds):
        ''' wrap '''
        key = method.__qualname__
        self._redis.incr(key, 0) + 1
        return method(self, *args, **kwds)
    return wrap


def call_history(method: Callable) -> Callable:
    ''' call history '''
    @wraps(method)
    def wrap(self, *args, **kwds):
        ''' wrap '''
        key_m = method.__qualname__
        ins = key_m + ':ins'
        outs = key_m + ":outputs"
        data = str(args)
        self._redis.rpush(ins, data)
        end = method(self, *args, **kwds)
        self._redis.rpush(outs, str(end))
        return end
    return wrap


def replay(func: Callable):
    ''' replay '''
    r = redis.Redis()
    key_m = func.__qualname__
    ins = r.lrange("{}:ins".format(key_m), 0, -1)
    outs = r.lrange("{}:outputs".format(key_m), 0, -1)
    calls_number = len(ins)
    times_str = 'times'
    if calls_number == 1:
        times_str = 'time'
    end = '{} was called {} {}:'.format(key_m, calls_number, times_str)
    print(end)
    for k, v in zip(ins, outs):
        end = '{}(*{}) -> {}'.format(
            key_m,
            k.decode('utf-8'),
            v.decode('utf-8')
        )
        print(end)


class Cache():
    ''' class cache '''
    def __init__(self):
        ''' init '''
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        ''' store '''
        generate = str(uuid.uuid4())
        self._redis.set(generate, data)
        return generate

    def get(self, key: str,
            fn: Optional[Callable] = None) -> Union[str, bytes, int, float]:
        ''' get '''
        value = self._redis.get(key)
        return value if not fn else fn(value)

    def get_int(self, key):
        return self.get(key, int)

    def get_str(self, key):
        value = self._redis.get(key)
        return value.decode("utf-8")

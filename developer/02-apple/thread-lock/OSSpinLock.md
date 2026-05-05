
# OSSpinLock

OSSpinLock 自旋锁，这种锁在没有得到锁时不会去休息，而是一直不停的尝试获取锁，因此效率较高，适用于对时间要求较高的情况。比如音视频播放中。缺点是浪费CPU资源。形象的例子就是有人占着卫生间，外面有个很急的人在卫生间门口原地跑步等里面的人出来。

#include <libkern/OSAtomic.h>

OSSpinLock _lock;

_lock = OS_SPINLOCK_INIT;

// 加锁
OSSpinLockLock(&_lock);

// 去锁
OSSpinLockUnlock(&_lock);

http://blog.ibireme.com/2016/01/16/spinlock_is_unsafe_in_ios/

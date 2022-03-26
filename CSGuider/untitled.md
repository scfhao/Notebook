# 数据结构不难：能不能写一个更通用的数据结构？

我在读《数据结构（C语言版）》中的顺序表的时候，一直在想一个问题，能不能写一个更通用的顺序表？

之所以会有这个问题，是因为教科书上的这个顺序表并不通用。有如下几点：

* 使用`typedef XX ElemType`定义的元素类型，这就决定了我们代码中元素类型只能是`XX`这一种类型，虽然`XX`可以替换为任意你想替换的类型。
* C 语言没有“泛型”的概念，在支持泛型的语言中，创建顺序表的时候可以指定顺序表元素的类型，这样的顺序表就是“通用”的。
* C 语言也不支持函数重载，所以也没办法为不同的类型编写同名的函数来处理这个问题。

> 没有接触过“泛型”和“函数重载”这两个概念的同学在这里不必理会这两点说明，只需要知道教科书上这种写法的顺序表不能同时兼容多种元素类型即可。
> 本文讨论的不仅是顺序表的事，书上的其他（用到 ElemType）数据结构也有这个缺陷，这也是标题里写的是数据结构而不是顺序表的原因，本文只以最简单的顺序表举例。

如果我们写的顺序表不通用，那么当我们的程序中如果有多个地方要用到顺序表，而且这几个地方顺序表中的元素类型不一致的情况下，就只能另外再写一个线性表了，而且多个线性表中的函数名不能重名。这样会很麻烦，所以我就会想，能不能写一个类型通用的顺序表？

那怎么写一个更通用的顺序表呢？答案很简单，只需要顺序表的代码只关注顺序表本身处理的问题，并与元素类型进行解耦即可，那我们在回过头来看一下教科书上的顺序表哪里用到了元素类型：

```C
Status InitList_Sq(SqList *L) {
    L->elem = (ElemType *)malloc(LIST_INIT_SIZE * sizeof(ElemType));
    // 原书这里内存分配失败时，直接调用了 exit(OVERFLOW);
    // 中止了程序，个人认为是否需要退出程序应由调用方决定
    if (!L->elem) return OVERFLOW;
    L->length = 0;
    L->listsize = LIST_INIT_SIZE;
    return OK;
}

Status ListInsert_Sq(SqList *L, int i, ElemType e) {
    if (i < 1 || i > L->length + 1) return ERROR;
    if (L->length >= L->listsize) {
        ElemType *newbase = (ElemType *)realloc(L->elem, (L->listsize + LISTINCREMENT) * sizeof(ElemType));
        if (!newbase) return OVERFLOW;
        L->elem = newbase;
        L->listsize += LISTINCREMENT;
    }
    ElemType *q = &L->elem[i-1];
    for (ElemType *p = &L->elem[L->length - 1]; p >= q; --p) *(p+1) = *p;
    *q = e;
    ++L->length;
    return OK;
}
```

可以看到在`InitList_Sq()`和`ListInsert_Sq()`两个函数中都用到了`sizeof(ElemType)`，因为 ElemType 是通过`typedef`定义的，所以在分配元素存储空间时是按照当前定义的`ElemType`类型的大小分配内存的，所以只需要把`malloc()`和`realloc()`的参数改成动态传入，而不是根据类型计算，那样的顺序表就能做到类型通用了。

下面是我改良后的顺序表的定义：

```C
typedef struct {
    int capacity;   // 容量，即够存多少个元素
    int increament; // 增量，容量不够时容量的增量
    int typeSize;   // 一个元素的内存大小
    int length;     // 有几个元素
    void *elements; // 元素数组
} _USqList;
```

这里用`typeSize`这个变量来保存当前的顺序表中一个元素占的内存大小，这样，创建顺序表时，只需要根据顺序表要存的元素类型设置好`typeSize`变量即可，顺序表在`InitList_Sq()`和`ListInsert_Sq()`函数中就可以根据`typeSize`的值来申请新的内存空间了。





4号 8小时
11号 6小时
18号 4小时
30号 4小时
31号 8小时



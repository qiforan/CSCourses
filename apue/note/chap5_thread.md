# 线程 Thread

## 基本概念 

典型的 UNIX 进程可以看成只有一个控制线程。多线程的好处：
* 简化异步事件的代码。
* 相比多进程，能访问相同的存储地址空间和描述符。
* 分解问题，以提高整个程序的吞吐量。
* 改善交互程序的响应时间。

每个线程都有线程 ID、一组寄存器值、栈、调度优先级和策略、信号屏蔽字、errno 变量以及线程私有数据。

线程 ID 是用 pthread_t 表示，是一个结构而非整数。
```c
#include <pthread.h>
int pthread_equal(pthread_t p1, pthread_t p2); // 比较两个线程 ID
int pthread_self(void); // 获取当前线程 ID
```

## 线程创建

```c
#include <pthread.h>
int pthread_create(pthread_t *thread, //传一个线程 ID，让函数回填
                   const pthread_attr_t *attr,  //指定属性
                   void *(*start_routine)(void *),  // 函数地址
                   void *restrict arg);  // 函数参数
```

线程的调度策略取决于调度器策略

## 线程的终止

任一进程调用了 exit、_Exit 和 _exit，那么整个进程终止。

在不终止整个进程的情况下，线程的结束方式：
1. 从启动例程返回，返回值是退出码
2. 被同一进程的其他线程取消
3. 线程调用 pthread_exit

```c
#include <pthread.h>
pthread_exit(void *rval_ptr);
pthread_join(pthread_t thread, void **rval_ptr);
```

### 栈的清理

类似于 atexit，线程清理处理函数可以在线程结束时做一些清理工作，其实现为宏。

```c
#include <pthread.h>
pthread_cleanup_push(void (*routine)(void *), void *arg);
pthread_cleanup_pop(int execute);
```

### 线程取消

```c
#include <pthread.h>
int pthread_cancel(pthread_t tid);
```
仅仅是提出请求，线程可以选择忽略取消或者选择何时取消。
允许取消（默认）不是即时取消，而是推迟到取消点再取消。POSIX 定义的取消点，都是可能引发阻塞的系统调用。

取消选项分为 可取消状态 和 可取消类型，前者表示是否可以被取消，默认为是。尽管设置为不可取消，取消请求也不是消失而是挂起，等待设置为可取消再响应。
当然也可以自定义取消点，或者选择即时取消而不是延迟取消。
```c
#include <pthread.h>
// 设置可取消状态为 state，并把原来的状态存储与 oldstate
// 该操作为原子操作
int pthread+setcancelstate(int state, int *oldstate);
// 当有取消请求时，主动取消
void pthread_testcancel(void);
// 设置取消类型，可用选项为延迟取消和异步取消，后者即时取消，不用等待到取消点
int pthread_setcanceltype(int type,int *oldstate);
```

### 线程分离

```c
#include <pthread.h>
int pthread_detach(pthread_t thread);
```

## 线程同步

### 互斥量

互斥量是用 pthread_mutex_t 表示的，使用前必须初始化。动态分配的互斥量，在释放内存前，还得调用 pthread_mutex_destroy.

```c
#include <pthread.h>
int pthread_mutex_destroy(pthread_mutex_t *mutex);
int pthread_mutex_init(pthread_mutex_t *restrict mutex,const pthread_mutexattr_t *restrict attr);
```

可用在临界区前后使用互斥锁
```c
#include <pthread.h>
// 阻塞
int pthread_mutex_lock(pthread_mutex_t *mutex);
// 不阻塞
int pthread_mutex_trylock(pthread_mutex_t *mutex);
int pthread_mutex_unlock(pthread_mutex_t *mutex);
```

### 

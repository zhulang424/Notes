# Promise

> 将异步任务以同步任务的形式表现出来，**避免层层嵌套的回调函数**

## 简介

Promise 是一个对象，封装了一个异步任务。Promise 对象创建后，里面的任务立刻开始执行。根据任务执行的结果，在 Promise 对象内部更改 Promise 对象的状态，并触发相应的回调函数。

Promise 对象包含两种三种状态：pending（进行中），resolved（成功）,rejected（失败），后两种状态分别对应各自的回调函数。状态只能在 Promise 对象内部更改，外部只能设置回调函数。并且状态会一直保存着，无论何时设置回调函数，都会根据状态触发相应的回调函数。

Promise 的优点：将异步任务以同步任务的形式表现出来，避免了层层嵌套回调函数

Promise 的缺点：

- 一旦创建 Promise 对象，任务就开始执行，无法中途取消
- 任务执行过程中（pending 状态），无法得知任务进展
- 如果不设置回调函数，Promise 对象内部抛出的错误，不会冒泡到外部（只能通过 catch() 方法捕获到）

## 使用

```javascript
// 创建 Promise 对象
const promise = new Promise(function(resolve, reject) {
  // 异步任务...

  // 异步任务结束，对异步任务结果进行判断，然后改变 Promise 对象状态
  if (/* 异步操作成功 */){
    resolve(result);			// 将 Promise 对象改为 resolved 状态，并传入异步任务结果
    return
  } else {
    reject(error);		// 将 Promise 对象改为 rejected 状态，并传入错误信息
	return 
  }
});

// 创建 Promise 对象后，通过 then() 指定 resolve 状态的回调函数，通过 catch() 指定rejected 状态的回调函数，同时捕获 then() 回调函数中抛出的错误
promise
	.then(function(result){/* resolved 状态回调函数 */})
	.catch(function(error){/* rejected 状态回调函数 */})
// ***************************************************************************
// 注：
// resolve 函数、reject 函数，由 JS 引擎提供，用于改变 Promise 对象的状态
 		// resove 函数将 Promise 对象改为 resolved(成功) 状态
 		// reject 函数将 Promise 对象改为 rejected(失败) 状态
```

简洁版：

```javascript
const promise = new Promise(function(resolve,reject){
    // async task...
    
    if(/* async task success */){
       return resolve(result)
    } else {
	   return reject(error)
    } 
}).then(function(result){
    // resolved callback...
}).catch(function(error){
    // rejected or error in then() callback...
})
```

注意：

如果一个 Promise 对象（A）内部，调用 resolve(result)方法改变状态时，参数中传入另一个 Promise 对象（B）的话，A 的 resolve() 方法失效，A 的状态取决于 B 的状态，当 B 变为 resolved 状态或 rejected 状态时，A 才会跟着改变状态，触发响应的回调函数

Promise对象中，`resolve()`和`reject()`会在本轮事件循环末尾执行，也就是晚于所有Promise对象中的同步语句执行。

按照Promise的目的来说，`resolve()`和`reject()`应该终结Promise对象内的操作，所以应该`return resolve()`或`return reject()`保证不会出现意外

## 链式调用

### 简介

then()、catch() 都会返回一个新的 Promise 对象，所以可以链式调用

```javascript
const promise = new Promise(function(resolve,reject){
    
})
promise.then(function(result){
    
}).then(function(result){
    
}).catch(function(error){
    
})
```

### 如何确定新 Promise 对象的状态？

- then() 返回的 Promise 对象，默认是 resolved 状态（也就是说，默认触发下一个 then()），只有在 then() 中抛出异常，才会变成 rejected 状态
- 想要手动改变 then() 返回的 Promise 对象的状态，可以在 then() 中，手动创建一个 Promise 对象，并 return。这个 Promise 对象将替换掉，then() 默认返回的 Promise 对象，所以通过这个 Promise 对象，可以修改状态

```javascript
const promise = new Promise(function (resolve, reject) {
    console.log('promise')
    resolve()
  })
  promise.then(function (result) {
    // 该方法返回的 Promise 对象，默认是 resolved 状态(默认触发下一个 then())
    console.log('first then()')
  }).then(function (result) {
    console.log('second then()')
  }).catch(function (error) {
    console.log(error)
  })
// promise
// first then()
// second then()
```

```javascript
const promise = new Promise(function (resolve, reject) {
    console.log('promise')
    resolve()
  })
  promise.then(function (result) {
    // 只有抛出异常时，才会变成 rejected 状态，触发 catch()
    console.log('first then()')
    return x
  }).then(function (result) {
    console.log('second then()')
  }).catch(function (error) {
    console.log('catch():' + error.message)
  })
//  promise
// first then()
// catch():x is not defined
```

```javascript
const promise = new Promise(function (resolve, reject) {
    console.log('promise')
    resolve()
  })
  // 想要改变 then()返回的 Promise 对象的状态，需要在 then()中手动创建 Promise对象并返回
  promise.then(function (result) {
    return new Promise(function (resolve, reject) {
      console.log('first then() return a rejected Promise')
      reject('catch()')		// 改变状态
    })
  }).then(function (result) { // 因为上一个 then()返回的 Promise 对象不是 resolved 状态，被跳过
    console.log('second then()')	
  }).catch(function (error) { 
    console.log(error)
  })
// promise
// first then() return a rejected Promise
// catch()
```

## Promise 异常处理

> Promise 对象的错误不会冒泡到外部，只能在链式调用期间捕获

Promise 对象中抛出的异常，在链式调用间，沿着链一直向后传递，直到被 catch()捕获；如果没有 catch()，错误会被“吃掉”。

```javascript
promise.then(function(result){
    // some code...
}).then(function(result){
    // some code...
}).catch(function(error){
    // 捕获前三个 Promise 对象抛出的异常
})
```

## Promise.all

> 将多个 Promise 对象，合成一个 Promise 对象

### 使用

```javascript
const const p = Promise.all([p1, p2, p3]);
p.then(function([p1Result,p2Result,p3Result]){
    
}).catch(function(error){
    
})
```

p 的状态由 p1、p2、p3 共同决定：

- 当 p1，p2，p3 的状态都是 resolved 时，p 触发 resolved 状态。此时，p1，p2，p3 的 resolve(result) 中的参数，组成数组，传递给 p 的 then()
- 当 p1、p2、p3 中有一个状态是 rejected 时，p 触发 rejected 状态。第一个触发 rejected 状态的 promise 对象，其 rejcted(error) 函数中的参数，传递给 p 的 catch()








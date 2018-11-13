# 概述

JavaScript 中，`Object`是所有复合类型的父类，所有的对象都是`Object`类型的实例（`任意对象 instanceof Object` 返回`true`）

# Object()

强制类型转换：将任意类型值，转换为对象

## 转换原始类型

返回包装类的实例

```javascript
var obj = Object(true);
obj instanceof Boolean	// true

obj = Object(1);
obj instanceof Number	// true

obj = Object('sdf');
obj instanceof String	// true
```

## 转换复合类型

返回原对象

```javascript
var obj = {};
obj === Object(obj)		// true

var arr = [];
arr === Object(arr)		// true

var func = function () {};
func === Object(func)	// true
```

利用这一特点，可以用来判断一个变量是不是对象

```javascript
function isObject(value) {
    return value === Object(value)
}
```

## 参数为空/undefined/null

返回空对象

```javascript
var obj = Object();
obj		// {}

obj = Object(undefined);
obj		// {}

obj = Object(null);
obj		// {}
```

# Object 构造函数

`Object`是一个构造函数（JavaScript 中，用构造函数实现类），可以通过`new`操作符调用，生成实例

```javascript
var obj = new Object();
// 等同于
var obj = {};	// 语法糖
```

可以传入参数，规则与`Object()`相同

```javascript
// 传入复合类型，返回该对象
var obj = {};
var newObj = new Objcet(obj);
newObj === obj		// true

// 传入原始类型，返回包装类实例
var obj = new Object(1);
obj instanceof Number	// true
```

# Object 静态方法

部署在`Object`构造函数上的方法

## 属性相关

### Object.keys()

接收一个对象作为参数，返回一个数组，包含对象中，所有可枚举的**实例属性**名

```javascript
var obj = {
    a: 1,
    b: 2
};
Object.keys(obj)	// ["a", "b"]
```

### Object.getOwnPropertyNames()

与`Object.keys()`类似，区别在于返回所有**实例属性**，包括不可枚举的

```javascript
var obj = {
    a: 1,
    b: 2
};
Object.defineProperty(obj, 'c', {
    configurable: true,
    enumerable: false,
    writable: true,
    value: 'sdf'
});
Object.keys(obj)	// ["a", "b"]
Object.getOwnPropertyNames		// ["a", "b", "c"]
```

### Object.getOwnPropertyDescriptor()

获取对象某个属性的描述对象

```javascript
var obj = { p: 'a' };

Object.getOwnPropertyDescriptor(obj, 'p')
// Object { value: "a",
//   writable: true,
//   enumerable: true,
//   configurable: true
// }
```

### Object.defineProperty()

通过描述对象定义属性

#### 描述对象

- configurable：属性是否可配置（是否可以删除该属性，是否可以修改该属性的特性），默认为`true`
- enumerable：属性是否可枚举，默认为`true`
- writable：属性是否可写，默认`true`
- value：属性值，默认`undefined`
- get：属性的 getter，默认`undefined`
- set：属性的 setter，默认`undefined`

```javascript
{
  value: 123,
  writable: false,
  enumerable: true,
  configurable: false,
  get: undefined,
  set: undefined
}
```

数据属性特性

- configurable
- enumerable
- writable
- value

```javascript
var obj = Object.defineProperty({}, 'p', {
  value: 123,
  writable: false,
  enumerable: true,
  configurable: false
});
```

访问器属性特性

- configurable
- enumerable
- writable
- value

```javascript
var obj = Object.defineProperties({}, {
  p1: { value: 123, enumerable: true },
  p2: { value: 'abc', enumerable: true },
  p3: { get: function () { return this.p1 + this.p2 },
    enumerable:true,
    configurable:true
  }
});
```

注：访问器属性依赖于其他属性，类似于Vue中的计算属性

#### 使用规则

- 如果新增属性，`configurable`、`enumerable`、`writable`默认是`false`
- 如果修改原有属性特性，只修改部分就可以

### Object.defineProperties()

通过描述对象，定义多个属性

## 控制对象状态

### Object.preventExtensions()

禁止对象添加属性

### Object.seal()

禁止对象添加属性、删除属性、修改属性特性（原理是将对象所有属性的`configurable`改为`false`）

可以需改属性值（只要`configurable`、`writable`有一个是`true`，就可以修改属性值）

### Object.freeze()

禁止对象添加属性、删除属性、修改属性特性、修改属性值（将对象变为常量）

- `Object.isExtensible()`：判断对象是否可扩展。
- `Object.isSealed()`：判断一个对象是否可配置。
- `Object.isFrozen()`：判断一个对象是否被冻结。

## 原型相关

### Object.create()

该方法可以指定原型对象和属性，返回一个新的对象

### Object.getPrototypeOf()

返回对象的原型对象

# Object 原型方法

定义在`Object.prototype`上的方法，所有`Object`类型的实例都可以调用这些方法

## Object.prototype.valueOf()

返回对象的值，默认返回对象自身

常用于自动类型转换时，JavaScript 引擎自动调用

可以在实例上覆盖该方法，返回指定的值

## Object.prototype.toString()

### 概述

返回对象的字符串形式，返回类型字符串（默认`[object Object]`）

### 用法

#### 判断变量的数据类型

不同数据类型的`Object.prototype.toString`方法返回值如下。

- 数值：返回`[object Number]`。
- 字符串：返回`[object String]`。
- 布尔值：返回`[object Boolean]`。
- undefined：返回`[object Undefined]`。
- null：返回`[object Null]`。
- 数组：返回`[object Array]`。
- arguments 对象：返回`[object Arguments]`。
- 函数：返回`[object Function]`。
- Error 对象：返回`[object Error]`。
- Date 对象：返回`[object Date]`。
- RegExp 对象：返回`[object RegExp]`。
- 其他对象：返回`[object Object]`。

```javascript
Object.prototype.toString.call(2) // "[object Number]"
Object.prototype.toString.call('') // "[object String]"
Object.prototype.toString.call(true) // "[object Boolean]"
Object.prototype.toString.call(undefined) // "[object Undefined]"
Object.prototype.toString.call(null) // "[object Null]"
Object.prototype.toString.call(Math) // "[object Math]"
Object.prototype.toString.call({}) // "[object Object]"
Object.prototype.toString.call([]) // "[object Array]"
```

利用这个特性，可以写出一个比`typeof`更准确的类型判断函数

```javascript
function type(o) {
    var s = Object.prototype.toString.call(o);
    return s.match(/\[object (.*?)\]/)[1].toLowerCase();
}

type({}); // "object"
type([]); // "array"
type(5); // "number"
type(null); // "null"
type(); // "undefined"
type(/abcd/); // "regex"
type(new Date()); // "date"
```

在这个函数的基础上，可以添加专门判断某个类型的方法

```javascript
['Null',
 'Undefined',
 'Object',
 'Array',
 'String',
 'Number',
 'Boolean',
 'Function',
 'RegExp'
].forEach(function (t) {
  type['is' + t] = function (o) {
    return type(o) === t.toLowerCase();
  };
});

type.isObject({}) // true
type.isNumber(NaN) // true
type.isRegExp(/abc/) // true
```

#### 自动类型转换

跟`valueOf()`一样，用于自动类型转换时，JavaScript 引擎自动调用

可以在实例上覆盖该方法，返回指定字符串

`Array`、`String`、`Function`、`Date`都定义了自己的`toString()`，覆盖了`Object.prototype.toString`

```javascript
[1, 2, 3].toString()	// "1,2,3"
'sdf'.toString()		// "sdf"
(function () {}).toString()		// "function () {}"
(new Date()).toString()			// "Fri Oct 12 2018 16:47:33 GMT+0800 (中国标准时间)"
```

因为该方法返回类型字符串，可以用于检查变量的数据类型

## Object.prototype.hasOwnProperty()

用于判断某个属性是不是实例属性，如果是，返回`true`

```javascript
var obj = {
  p: 123
};

obj.hasOwnProperty('p') // true
obj.hasOwnProperty('toString') // false
```

## Object.prototype.isPrototypeOf()

判断某个对象是不是另一个对象的原型对象

## Object.prototype.propertyIsEnumerable()

判断某个属性是否可枚举，对于原型属性，一律返回`false`

```javascript
var obj = {};
obj.p = 123;

obj.propertyIsEnumerable('p') // true
obj.propertyIsEnumerable('toString') // false
```

# 用法

## 判断变量的数据类型

`Object.prototype.toString.call()`

## 遍历对象的实例属性

- `Object.keys()`：只遍历可枚举的实例属性
- `Object.getOwnPropertyNames()`：遍历所有实例属性，包括不可枚举

## 检查对象是否具有某个实例属性

步骤一：检查对象是否有这个属性

`in`操作符

步骤二：检查这个属性是不是实例属性

`Object.prototype.hasOwnProperty()`

## 定义属性的 getter/setter

`Object.defineProperty()`

`Object.defineProperties()`
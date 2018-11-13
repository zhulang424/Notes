Symbol是原始数据类型，表示独一无二的值

用来做对象的属性名，防止出现同名属性（每个Symbol值都是不相等的）

用Symbol()函数创建Symbol类型的值

Symbol()可以接收一个参数，作为该Symbol对象的描述

Symbol可以转换成Boolean,String，但是不能转化为Number

```javascript
const mySymbol1 = Symbol();
const mySymbol2 = Symbol();
const o = {
    [mySymbol1]: 'hello Symbol',
    [mySymbol2](arg) {
        // ...
    }
};
```

Symbol作属性名时，不能用点运算符，必须用方括号

```javascript
o[mySymbol]	// 'hello Symbol'
```

Symbol还可以用来定义常量

```javascript
const COLOR_RED    = Symbol();
const COLOR_GREEN  = Symbol();

function getComplement(color) {
  switch (color) {
    case COLOR_RED:
      return COLOR_GREEN;
    case COLOR_GREEN:
      return COLOR_RED;
    default:
      throw new Error('Undefined color');
    }
}
```

Symbol作为属性名时，不会出现在Object.keys()、Object.getOwnPropertyNames()

但是Symbol属性不是私有属性，通过特定方法，可以访问到：Object.getOwnPropertySymbols()

因为Symbol属性不会被常规方法遍历到，所以可以用来定义私有属性

Symbol.for()

Symbol.keyOf()
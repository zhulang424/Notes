# Set

没有重复成员的数组

```javascript
// 不传参数
const s1 = new Set();
// 传入数组
const s2 = new Set([1, 2, 3]);
// 传入类数组对象
const s3 = new Set(document.querySelectorAll('div'));
```

像数组一样，支持扩展运算符

```javascript
let arr = [1, 1, 2, 3];
arr = [...new Set(arr)];	// [1, 2, 3]
```

Set内部的比较方法：类似于===，但是NaN等于NaN

Set.prototype.size：返回成员数量（类似于数组length）

Set.prototype.add：添加成员

Set.prototype.delete：删除某个成员

Set.prototype.has：检查是否包含某个成员

Set.prototype.clear：清空



Array.from可以把Set变成数组



数组去重两种方法：

```javascript
// 方法一
function dedupe(array) {
    return [...new Set(array)];
}
// 方法二
function defupe(array) {
    return Array.from(new Set(array));
}
```



Set中，成员顺序就是插入顺序，也就是遍历顺序

Set与Array不同点是：Array成员的键是数字键，Set中键名和键值相同

遍历方法：

- keys()
- values()（因为Set中键名、键值相同，所以与keys()返回值相同）
- entires()
- forEach()

常用：

- for...of
- forEach()



扩展运算符（`...`）内部使用`for...of`循环



WeakSet

只能放对象

对成员弱引用

没有size属性，不可遍历（弱引用，成员随时可能消失）

用处：储存DOM节点，避免内存泄漏



Map

类似于Object，区别在于key可以是任意数据类型






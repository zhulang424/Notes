# 块级元素只显示固定字数文字

设置好`width`和`height`，然后设置`overflow:hidden`

# 选择器：奇数、偶数

`div:nth-child(odd)`

`div:nth-child(even)`

# 多行文本溢出显示'...'

```css
// 设定好宽高
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
```


什么是 BFC？

> 块级格式化上下文，一个区域

BFC 特点？

> - BFC 区域不与浮动元素 BOX 重叠
> - BFC 区域在计算高度时，会计算浮动元素的高度
> - BFC 区域内部元素与 BFC 区域外部元素互相没有影响
>   - BFC 区域内部元素的垂直外边距，不会伸出 BFC 区域与区域外元素进行外边距合并，而是被 BFC 区域包含在内
>   - BFC 区域内部元素之间还是会进行垂直外边距合并

如何触发 BFC？

> - float:left/right
> - position:absolute/fixed
> - display:inline-block/table-cell/table-caption/flex/inline-flex
> - overflow:hidden/auto/scroll

BFC 的应用？

> **解决浮动造成的父元素高度坍塌**
>
> 父元素设置成 BFC 区域

> **宽度自适应**
>
> 一列固定宽度并且浮动，另一列设置成 BFC 区域，自动避开浮动元素

> **避免元素之间进行垂直外边距合并**
>
> 使用一个 BFC 元素包裹一个不想进行垂直外边距合并的元素


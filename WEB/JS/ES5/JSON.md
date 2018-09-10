> JSON 中，字符串必须使用双引号（""）
>
> JSON 中，对象的属性名必须加双引号（""）



JSON是什么？

> 是一种数据格式

JSON 中可以表示什么？

> 数值，对象，数组

JSON对象是什么？

> 一个全局对象，用来处理 JSON数据【IE8+】

 如何进行解析和序列化？

JSON.stringify()

> 对象 ——》 JSON 字符串
>
> - 参数
>   - 对象
>   - 属性过滤器（可选）
>     - 过滤器是数组
>       - 只序列化数组中包含的属性名
>     - 过滤器是函数
>       - 函数接受两个参数：key/value，可以对属性值做一定处理，然后将处理后的结果返回
>       - 如果返回 undefined，那么属性会被忽略
>   - 缩进空格数/缩进字符（可选）
>     - 如果参数是数值，表示每个级别缩进空格数量
>     - 如果参数是字符串，该字符串将被用作缩进字符
> - 序列化规则
>   - 序列化过程中，会忽略：函数、原型属性
>   - 默认情况下，JSON 字符串不包含空格和缩进
>
> ```javascript
>     var person = {
>       name:'tom',
>       age:11,
>       sex:'male'
>     }
>     console.log(JSON.stringify(person)) 	// {"name":"tom","age":11,"sex":"male"}
> 
>     console.log(JSON.stringify(person,['name','age'])) 	  // {"name":"tom","age":11}
> 
>     console.log(JSON.stringify(person,function(key,value){
>       switch(key){
>         case 'name':
>           return 'jerry'
>         case 'sex':
>           return undefined
>         default:
>           return value
>       }
>     }))		// {"name":"jerry","age":11}
> 
>     console.log(JSON.stringify(person,null,4))
>     // {
>     // "name": "tom",
>     // "age": 11,
>     // "sex": "male"
>     // }
> ```

JSON.parse()

> JSON 字符串——》对象
>
> - 参数
> - JSON 字符串
> - 过滤器（可选）
>   - 函数，接受两个参数：key/value，将在每个键值对上调用，可以在生成对象之前对 value 进行处理，返回处理结果
>   - 如果返回 undefined，该属性将被忽略
>
> 如果字符串不是有效的 JSON，该方法抛出错误


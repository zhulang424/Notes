# 摘要

![](https://ws3.sinaimg.cn/large/006tNc79ly1fk551ff4wuj30fi0gowfz.jpg)

# 组成

- 表头（TableHeaderView）：表视图最上面的视图（例如联系人页面最上面的搜索框）
- 表脚（TableFooterView）：表示图最下面的视图（例如表示图分页时显示“加载中”）
- 单元格（Cell）：表示图中的每一行
- 分区（Section）：多个单元格组成的群组，有分区头（SectionHeader）、分区脚（SectionFooter）
  - 头（SectionHeader）：描述节的信息，文字左对齐
  - 脚（SectionFooter）：描述节的信息，文字左对齐

# 相关类

![](https://ws4.sinaimg.cn/large/006tKfTcly1fk56b641icj30hs079gm5.jpg)

# 扩展

- 索引

![](https://ws3.sinaimg.cn/large/006tNc79ly1fk5647ktudj308p0dct95.jpg)

- 多选

![](https://ws4.sinaimg.cn/large/006tNc79ly1fk56530dpgj308l0dc74v.jpg)

- 搜索：一般放在表头，翻到顶端才能看到

![](https://ws1.sinaimg.cn/large/006tNc79ly1fk565fqj5xj307h0dcaan.jpg)

- 分页：标图有“刷新”（下拉刷新），表脚有“更多”

![](https://ws1.sinaimg.cn/large/006tNc79ly1fk565rdbnmj30950dcgmi.jpg)

------

# 单元格

## 组成

![](https://ws4.sinaimg.cn/large/006tKfTcly1fk56c3r2wxj30hs081754.jpg)

## 样式

- ```UITableViewCellStyleDefault```

![](https://ws2.sinaimg.cn/large/006tKfTcly1fk56n4gcgrj308g0dcjrp.jpg)

- ```UITableViewCellStyleSubtitle```

  ![](https://ws2.sinaimg.cn/large/006tKfTcly1fk56oicgk0j307g0dcweo.jpg)

- ```UITableViewCellStyleValue1```

![](https://ws4.sinaimg.cn/large/006tKfTcly1fk56psrvjzj307c0dcdg1.jpg)

- ```UITableViewCellStyleValue2```

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk56q57iorj307n0dc0ss.jpg)

## 扩展视图样式

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk56v6sqv9j30hs05umy7.jpg)

------

# 使用

## 初始化

- 整个``` View```都是```UITableView```

  创建一个继承自 ```UITableViewController```的```ViewController```

- ```UITableView```作为子视图出现

  ```objective-c
  @interface ViewController ()<UITableViewDelegate,UITableViewDataSource> // 实现协议
  @property (nonatomic,strong) UITableView *tableView; // 声明一个 UITableView 类型属性
  @end

  @implementation ViewController
  - (void)viewDidLoad {
      [super viewDidLoad];
  	// 初始化 UITableView
      self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
      self.tableView.delegate = self;
      self.tableView.dataSource = self;
      // 将 UITableView 加入子视图
      [self.view addSubview:self.tableView];
  }
  @end
  ```

## 协议中必须实现的方法

**dataSource**

```objective-c
#pragma mark - UITableViewDataSource
// 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

// 初始化单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

```

## 设置单元格

### 初始化单元格

- dataSource

```objective-c
// 初始化单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
```

### 设置单元格外观

- delegate

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk8j749mhlj31ea0eu0w5.jpg)

### 设置单元格是否可以点击

- delegate

![](https://ws2.sinaimg.cn/large/006tKfTcly1fk8n6aunz2j315y05a75f.jpg)

### 生命周期：显示单元格

- delegate

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk8jb972h9j31kw09s0v3.jpg)



## 设置 Section

### 添加Section

- dataSource

![](https://ws4.sinaimg.cn/large/006tKfTcly1fk592bpzk0j31kw0d5gok.jpg)

### 设置 Section索引

> - 分区是添加索引的前提
> - 使用索引情况下不再使用扩展视图，否则点击时容易出现冲突

- dataSource

![](https://ws2.sinaimg.cn/large/006tKfTcly1fk592bftvdj31kw08imzj.jpg)

### 设置Section 外观

#### 设置 HeaderTitle

- dataSource

```objective-c
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
```

#### 设置 FooterTitle

- dataSource

```objective-c
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
```

#### 设置HeaderView

- delegate

![](https://ws2.sinaimg.cn/large/006tNc79ly1fk6b6ru8wpj315g03ojs1.jpg)

#### 设置 FooterView

- delegate

![](https://ws3.sinaimg.cn/large/006tNc79ly1fk6b9gm3ihj315403kdgg.jpg)

#### 设置 Header 和 Footer高度

- delegate

![](https://ws3.sinaimg.cn/large/006tNc79ly1fk6bkzo9jsj31a60fktbz.jpg)

### 生命周期：显示 HeaderView、FooterView

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk8jef39y6j31hy0kgtdo.jpg)

# 事件处理

## 点击行

- 当第一次点击某个```cell```时

  1.```- willSelectRowAtIndexPath:(NSIndexPath *)indexPath```，将选中的```indexPath```返回给```delegate```，其中包含```section```和```row```

  2.```- didSelectRowAtIndexPath:(NSIndexPath *)indexPath```![](https://ws3.sinaimg.cn/large/006tKfTcly1fk66vzqxhoj31kw086wgc.jpg)

- 再点击另一个```cell```时

  1.```- willSelectRowAtIndexPath:(NSIndexPath *)indexPath```方法，告诉```delegate```有一个新```cell```将要被选中，并将这个新```cell```的```indexPath```返回给```delegate```

  2.```- willDeselectRowAtIndexPath:(NSIndexPath *)indexPath```方法，告诉```delegate```即将取消选中上一个```cell```

  3.```didDeselectRowAtIndexPath:(NSIndexPath *)indexPath```，取消选中上一个cell

  4.```didSelectRowAtIndexPath:(NSIndexPath *)indexPath```，选中新cell![](https://ws2.sinaimg.cn/large/006tNc79ly1fk674jzeq0j31kw0heaea.jpg)

## 点击行高亮

- delegate

![](https://ws4.sinaimg.cn/large/006tKfTcly1fk8krr15d5j31920fcq61.jpg)

## 点击行辅助视图

- delegate

![](https://ws1.sinaimg.cn/large/006tNc79ly1fk6c84wl19j31dy03iq3k.jpg)

## 长按行显示编辑菜单

- delegate

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk8k7kwpbjj31kw0ebgpb.jpg)

## 行插入和删除

![](https://ws3.sinaimg.cn/large/006tKfTcly1fktby22pw9j308w02oaa2.jpg)

![](https://ws3.sinaimg.cn/large/006tKfTcly1fktbxamuvbj30hs06eq3f.jpg)

- 进入编辑状态（导航栏右按钮设置为```edit```按钮，点击该按钮，```UITableView```进入编辑状态）

  ```objective-c
  // UIViewController生命周期方法，用于响应视图编辑状态变化,点击编辑按钮调用
  - (void)setEditing:(BOOL)editing animated:(BOOL)animated {
      [super setEditing:editing animated:animated];
      [self.tableView setEditing:editing animated:TRUE];
  }
  ```


- delegate

  ```objective-c
  // 设置编辑按钮类型(None，Delete，Insert)
  - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
  ```


- dataSource

  ```objective-c
  // 处理插入和删除
  - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
      
    	// 获得 IndexPath 数组
      NSArray* indexPaths = [NSArray arrayWithObject:indexPath];
      
      // 处理删除
      if (editingStyle == UITableViewCellEditingStyleDelete) {
          // 删除数据源中的数据
          [self.listTeams removeObjectAtIndex: indexPath.row];
          // 删除改行对应的表格
          [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
      }
      // 处理插入
      else if (editingStyle == UITableViewCellEditingStyleInsert) {
          // 向数据源插入数据
          [self.listTeams insertObject:self.txtField.text atIndex:[self.listTeams count]];
          // 插入表格
          [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
      }
    
      // 刷新表格数据
      [self.tableView reloadData];
  }
  ```

## 行移动

![](https://ws1.sinaimg.cn/large/006tKfTcly1fktbzjxci6j308w02tmx4.jpg)

![](https://ws4.sinaimg.cn/large/006tKfTcly1fktc2hxbubj30hs07774y.jpg)

- dataSource

  ```objective-c
  // 设置是否可以移动某行
  - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 

  // 在数据源中处理行移动带来的变化
  - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
  ```

![](https://ws3.sinaimg.cn/large/006tKfTcly1fk8j47l2k9j31kw065411.jpg)



## 滑动操作

### IOS 8 ~ IOS 10（左滑）

- 设置删除按钮标题

![](https://ws3.sinaimg.cn/large/006tNc79ly1fk6d1nsixgj31ke03gdgl.jpg)

- 自定义按钮

![](https://ws2.sinaimg.cn/large/006tNc79ly1fk6c6r42fbj31kw03pjs8.jpg)

- 事件：左滑

![](https://ws2.sinaimg.cn/large/006tKfTcly1fk8k94chqzj31ag0aimz7.jpg)

### IOS11 （左滑，右滑）

- 自定义按钮

实现以下方法会取代```tableView: editActionsForRowAtIndexPath:```

![](https://ws1.sinaimg.cn/large/006tKfTcly1fk8ovuw66hj31kw07rq5p.jpg)

# 使用技巧

- 使用 ```UITableViewController```作为根视图控制时，不用声明```<UITableViewDataSource,UITableViewDelegate>```，也不用指定```dataSource 和 delegate```


# 设计模式

## 分页模式

### 用处

用于解决请求大量数据的问题

### 思路

先请求部分数据，显示完之后，再请求部分数据

### 用法

- 主动请求：满足条件时，自动发送数据请求，在分区脚显示活动指示器，请求结束指示器隐藏

  > 思路：所有已经得到的数据统一放置在一个```Section```中，在 ```SecionFooter```中放置活动指示器，在 ```SectionFooter```的声明周期显示方法中进行数据请求，请求结束后，将新得到的数据添加到数据源中数据的后面（得到新数据后，还是所有数据放在一个```Section```中，保证表格拉到最下方时能显示出放置在```SectionFooter```中的活动指示器），刷新表格数据

  ![](https://ws3.sinaimg.cn/large/006tKfTcly1fktetx039xj303o06o745.jpg)

- 被动请求：分区脚中放置一个按钮，点击按钮会向服务器发送数据请求，请求结束后按钮隐藏

  > 思路：同“主动请求”，在按钮的点击事件处理中进行数据请求，然后将按钮放在```SectionFooter```（所有数据放置在一个```Section```中）

  ![](https://ws2.sinaimg.cn/large/006tKfTcly1fktf0qm10gj303o06o0sl.jpg)



## 下拉刷新

### 思路

```UITableViewController``` 提供了 ```refreshControl``` 属性，该属性是 ```UIRefreshControl``` 类型，通过设置该属性，可以为表视图添加下拉刷新控件

>  ```UIRefreshControl```只能通过代码实现

### 用法

```objective-c
#import "ViewController.h"
@interface ViewController ()
@end
@implementation ViewController
// 在 viewDidLoad 中初始化 UIRefreshControl
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
}
// 刷新控件对应的方法
-(void) refreshTableView {
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        // 请求数据并处理
        ...
        // 刷新结束
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        // 刷新表格数据
        [self.tableView reloadData];
    }
}
@end

```


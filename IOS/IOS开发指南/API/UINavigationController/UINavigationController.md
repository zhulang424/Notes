# 概述

- 导航视图控制器，一般作为根视图控制器，用于树型导航模式
- 用“栈”来管理视图控制器，处于栈顶的视图控制器负责显示当前视图
  - 如果要进入下级视图，需要将下级视图控制器压入栈顶
  - 如果要回到上级视图，需要将当前视图控制器出栈
- 导航栏的标题由各个 ViewController 的“title”属性决定
  - self.title：同时改变导航栏标题和标签栏标题
  - self.navigationItem.title：只改变导航栏标题
- 进入次级页面后，导航栏左按钮是“返回”按钮（不可自定义成其他按钮），按钮标签文字为上级页面控制器的“title”

# 使用

## 初始化

- AppDelegate.m

```objective-c
#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    ViewController* viewController = [[ViewController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = navigationController;
    return YES;
}
```

## 入栈

```objective-c
// 初始化下级视图
CitiesViewController *citiesViewController = [[CitiesViewController alloc] initWithStyle:UITableViewStylePlain];
NSString *selectName = self.listData[selectedIndex];
citiesViewController.listData = self.dictData[selectName];
citiesViewController.title = selectName;
// 将下级视图压入栈顶
[self.navigationController pushViewController:citiesViewController animated:TRUE];
```

## 出栈

- 回到上级视图：popVIewControllerAnimated:
- 回到根视图：popToRootViewControllerAnimated:
- 回到指定视图：popToViewController:animated:
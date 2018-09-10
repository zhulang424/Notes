//
//  ViewController.m
//  CollectionViewSample
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "ViewController.h"
#import "EventCollectionViewCell.h"

//集合视图列数，即：每一行有几个单元格
#define COL_NUM 3

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray * events;
@property (strong, nonatomic) UICollectionView* collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取属性列表文件中的全部数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"events"
                                           ofType:@"plist"];
    self.events = [[NSArray alloc] initWithContentsOfFile:plistPath];

    // 配置 collectionView
    [self setupCollectionView];
    
}

// 配置 collectionView
- (void) setupCollectionView {
    
    // 1.创建流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake(80, 80);
    // 3.设置整个collectionView的内边距
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 30, 15);
    // 屏幕适配：重新设置iPhone 6/6s/7/7s/Plus
    CGSize screenSize  = [UIScreen mainScreen].bounds.size;
    if (screenSize.height > 568) {
        layout.itemSize = CGSizeMake(100, 100);
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 20, 15);
    }
    // 4.设置单元格之间的间距
    layout.minimumInteritemSpacing = 5;
    
    // 根据布局创建 collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:layout];
    // 设置可重用单元格标识与单元格类型
    [self.collectionView registerClass:[EventCollectionViewCell class]
            forCellWithReuseIdentifier:@"cellIdentifier" ];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
// 设置 Section 数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    int num = [self.events count] % COL_NUM;
    if (num == 0) {
        return [self.events count] / COL_NUM;
    } else {
        return [self.events count] / COL_NUM + 1;
    }
}
// 设置每个 Sction 中 Item 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {

    if (section == 2) {
        return 2;
    } else {
        return COL_NUM;
    }
}
// 设置每个 Cell 显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取复用 Cell
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier"
                                                                              forIndexPath:indexPath];
    // 计算events集合下标索引，防止下标越界
    NSInteger idx = indexPath.section * COL_NUM + indexPath.row;
    if (self.events.count <= idx) {
        return cell	;
    }
    
    // 设置 Cell 内容
    NSDictionary *event = self.events[idx];
    cell.label.text = event[@"name"];
    cell.imageView.image = [UIImage imageNamed:event[@"image"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 点击 Cell 的事件处理
- (void)  collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *event = self.events[indexPath.section * COL_NUM  + indexPath.row];
    NSLog(@"select event name : %@", event[@"name"]);
    
}

@end

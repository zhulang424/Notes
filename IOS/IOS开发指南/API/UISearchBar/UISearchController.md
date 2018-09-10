```objective-c
#import "ViewController.h"
// 声明协议
@interface ViewController ()  <UISearchBarDelegate, UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;
//内容过滤方法
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    // 设置self为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    // 在搜索是背景设置为灰色
    self.searchController.dimsBackgroundDuringPresentation = FALSE;
    
    // 设置搜索范围栏中的按钮
    self.searchController.searchBar.scopeButtonTitles = @[@"中文", @"英文"];
    self.searchController.searchBar.delegate = self;
    
    // 将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.searchController.searchBar sizeToFit];
}


#pragma mark --内容过滤方法
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope {
    
    if([searchText length]==0) {
        //查询所有
        self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0://中文 name字段是中文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        case 1: //英文 image字段保存英文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
}


#pragma mark --实现UISearchBarDelegate协议方法
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark --实现UISearchResultsUpdating协议方法
// 搜索内容改变时调用
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    //查询
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}
```


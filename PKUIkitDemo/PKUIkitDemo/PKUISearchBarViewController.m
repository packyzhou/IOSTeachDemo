//
//  PKUISearchBarViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-19.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUISearchBarViewController.h"

@interface PKUISearchBarViewController ()
{
    UISearchBar *searchBar;
}
@end

@implementation PKUISearchBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSearchBar];
    // Do any additional setup after loading the view from its nib.
}

-(void) initSearchBar
{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 100, 320, 80)];
    searchBar.delegate = self;//设置代理
//    searchBar.prompt = @"提示：";//输入框上文字
    searchBar.placeholder =  @"请输入";//输入框透明文字，输入时会消失
    searchBar.showsBookmarkButton = YES;//右边显示书样式的按钮
//    searchBar.showsCancelButton = YES;//输入框外右边增加cancel按钮
//    searchBar.showsSearchResultsButton = YES;//右边显示下拉样式按钮
    searchBar.showsScopeBar = YES;//显示搜索栏下部按钮
    searchBar.tintColor = [UIColor redColor];//输入跟踪光标颜色
    searchBar.translucent = YES;//控件半透明
   
    searchBar.scopeButtonTitles = @[@"按钮1",@"按钮2"];//所搜栏下部显示按钮
    searchBar.selectedScopeButtonIndex = 1;//默认选择按钮的索引
    
    [self.view addSubview:searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"搜索：%@",searchBar.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

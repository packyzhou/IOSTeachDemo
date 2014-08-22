//
//  PKTableViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-15.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKTableViewController.h"
#import "PKUILabelViewController.h"
#import "PKUIPickerViewController.h"
#import "PKUIDatePickerViewController.h"
#import "PKUIActivityIndicatorViewController.h"
#import "PKUIImageViewController.h"

#import "PKUITabBarViewController.h"
#import "PKUIToolBarViewController.h"
#import "PKUIAertViewViewController.h"
#import "PKUIActionSheetViewController.h"
#import "PKUIScrollViewController.h"
#import "PKUITextViewController.h"
#import "PKUISearchBarViewController.h"
#import "PKUIControlViewController.h"
#import "PKUIButtonViewController.h"
#import "PKUIProgressViewController.h"
#import "PKPageControlViewController.h"

#import "PKUISegmentedViewController.h"
#import "PKUITextFieldViewController.h"
#import "PKUISliderViewController.h"

#import "PKUICollectionViewController.h"
@interface PKTableViewController ()
{
    UITableView *table;
    NSArray *dataArray ;
    NSInteger dataCount;
}

@end

@implementation PKTableViewController

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
    //设置navigationBar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertTodo)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTodo)];
    //设置代理
    table = [[UITableView alloc] initWithFrame:CGRectMake(0 , 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
//    [table setEditing:YES animated:YES];//设置cell可以被编辑
    
    [self.view addSubview: table];
    [super viewDidLoad];
    //初始化数据
    dataArray = @[@"UILabel",@"UIPickerView",@"UIDatePicker",@"UIActivityIndicatorView",
                  @"UIImageView",@"UITabBar",@"UIToolBar",@"UINavigationBar",@"UIActionSheet",
                  @"UIAertView",@"UIScrollView",@"UITextView",@"UISearchBar",
                  @"UIControl",@"UIButton",@"UIProgressView",@"UIPageControl",@"UISegmentedControl",
                  @"UITextField",@"UISlider",@"UISwitch",@"UICollectionView"];

    // Do any additional setup after loading the view from its nib.
}

-(void) insertTodo
{
    NSLog(@"新增:%i",dataCount);
    [table beginUpdates];
    
    NSMutableArray *newData = [NSMutableArray arrayWithArray:dataArray];
    [newData insertObject:@"新增的数据" atIndex:0];
    dataArray = [newData copy];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [table insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [table endUpdates];
}

-(void) editTodo
{
    if (table.editing) {
        [table setEditing:NO animated:YES];
    }else{
        [table setEditing:YES animated:YES];
    }
    
}
//返回table有多少个cell，也就是多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.style == UITableViewStyleGrouped) {
        
    }
    return dataCount = [dataArray count];
}
//返回每个cell,进行设置，也就是设置行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];//寻找当前可重用的cell,节省内存
    //如果没有寻找到可重用的cell,则重新创建一个
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];//设置标题
    cell.imageView.image = [UIImage imageNamed:@"dir"];//设置cell的图片
    cell.detailTextLabel.text = @"子标题";//设置子标题
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//设置右箭头
//    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail"]];//设置右边按钮样式，与accessoryType 互拆
//    cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;//当cell进入编辑模式时的辅助按钮样式
//    cell.selectionStyle = UITableViewCellSelectionStyleBlue;//设置选中样式
//    UIView *selectView =[[UIView alloc] initWithFrame:cell.frame];
//    selectView.backgroundColor =[UIColor blueColor];
//    cell.selectedBackgroundView = selectView;//设置被选中时的cell背景View
    return cell;
}

//设置缩进,返回缩进行数
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
////根据条件，返回一个浮点值设置行高
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    if(indexPath.row%2 == 1)
//    {
//        return 80;
//    }
//    return 50;
//}
//根据条件，设置分组的头注行高
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section % 3 == 0)
//    {
//        return 50;
//    }
//    else if(section % 3 == 1)
//    {
//        return 20;
//    }
//    else
//    {
//        return 80;
//    }
//
//}
////根据条件设置分组标题文字，如果这个分组有返回View,则无效
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section % 3 == 0)
//    {
//        return @"测试标题";
//    }
//    else if(section % 3 == 1)
//    {
//        return @"测试标题1";
//    }
//    else if(section % 3 == 2)
//    {
//        return @"测试标题2";
//    }
//    return nil;
//}
//cell被选中时
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *message = [NSString stringWithFormat:@"%@,被选中了！", [dataArray objectAtIndex:indexPath.row] ];
//    UIAlertView *selectAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//    [selectAlert show];
//}
//当cell右边箭头被点击时调用，但只允许cell的accessoryType为UITableViewCellAccessoryDetailDisclosureButton有效
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UILabel"]) {
        PKUILabelViewController *labelController = [[PKUILabelViewController alloc] initWithNibName:@"PKUILabelViewController" bundle:nil];
        [self.navigationController pushViewController:labelController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIPickerView"]) {
        PKUIPickerViewController *pickerViewController = [[PKUIPickerViewController alloc] initWithNibName:@"PKUIPickerViewController" bundle:nil];
        [self.navigationController pushViewController:pickerViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIDatePicker"]) {
        PKUIDatePickerViewController *datePickerController = [[PKUIDatePickerViewController alloc] initWithNibName:@"PKUIDatePickerViewController" bundle:nil];
        [self.navigationController pushViewController:datePickerController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIActivityIndicatorView"]) {
        PKUIActivityIndicatorViewController *activityIndicatorViewController = [[PKUIActivityIndicatorViewController alloc] initWithNibName:@"PKUIActivityIndicatorViewController" bundle:nil];
        [self.navigationController pushViewController:activityIndicatorViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIImageView"]) {
        PKUIImageViewController *imageViewController = [[PKUIImageViewController alloc] initWithNibName:@"PKUIImageViewController" bundle:nil];
        [self.navigationController pushViewController:imageViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UITabBar"]) {
        
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIToolBar"]) {
        PKUIToolBarViewController *toolBarViewController = [[PKUIToolBarViewController alloc] initWithNibName:@"PKUIToolBarViewController" bundle:nil];
        [self.navigationController pushViewController:toolBarViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIActionSheet"]) {
        PKUIActionSheetViewController *actionSheetViewController = [[PKUIActionSheetViewController alloc] initWithNibName:@"PKUIActionSheetViewController" bundle:nil];
        [self.navigationController pushViewController:actionSheetViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIAertView"]) {
        PKUIAertViewViewController *aertViewViewController = [[PKUIAertViewViewController alloc] initWithNibName:@"PKUIAertViewViewController" bundle:nil];
        [self.navigationController pushViewController:aertViewViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIScrollView"]) {
        PKUIScrollViewController *scrollViewController = [[PKUIScrollViewController alloc] initWithNibName:@"PKUIScrollViewController" bundle:nil];
        [self.navigationController pushViewController:scrollViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UITextView"]) {
        PKUITextViewController *textViewController = [[PKUITextViewController alloc] initWithNibName:@"PKUITextViewController" bundle:nil];
        [self.navigationController pushViewController:textViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UISearchBar"]) {
        PKUISearchBarViewController *searchBarViewController = [[PKUISearchBarViewController alloc] initWithNibName:@"PKUISearchBarViewController" bundle:nil];
        [self.navigationController pushViewController:searchBarViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIControl"]) {
        PKUIControlViewController *controlViewController = [[PKUIControlViewController alloc] initWithNibName:@"PKUIControlViewController" bundle:nil];
        [self.navigationController pushViewController:controlViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIButton"]) {
        PKUIButtonViewController *buttonViewController = [[PKUIButtonViewController alloc] initWithNibName:@"PKUIButtonViewController" bundle:nil];
        [self.navigationController pushViewController:buttonViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIProgressView"]) {
        PKUIProgressViewController *progressViewController = [[PKUIProgressViewController alloc] initWithNibName:@"PKUIProgressViewController" bundle:nil];
        [self.navigationController pushViewController:progressViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UIPageControl"]) {
        PKPageControlViewController *pageControlViewController = [[PKPageControlViewController alloc] initWithNibName:@"PKPageControlViewController" bundle:nil];
        [self.navigationController pushViewController:pageControlViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UISegmentedControl"]) {
        PKUISegmentedViewController *segmentedViewController = [[PKUISegmentedViewController alloc] initWithNibName:@"PKPageControlViewController" bundle:nil];
        [self.navigationController pushViewController:segmentedViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UITextField"]) {
        PKUITextFieldViewController *textFieldViewController = [[PKUITextFieldViewController alloc] initWithNibName:@"PKUITextFieldViewController" bundle:nil];
        [self.navigationController pushViewController:textFieldViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UISlider"]) {
        PKUISliderViewController *sliderViewController = [[PKUISliderViewController alloc] initWithNibName:@"PKUISliderViewController" bundle:nil];
        [self.navigationController pushViewController:sliderViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UISwitch"]) {
        PKUISliderViewController *sliderViewController = [[PKUISliderViewController alloc] initWithNibName:@"PKUISliderViewController" bundle:nil];
        [self.navigationController pushViewController:sliderViewController animated:YES];
    }else if ([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"UICollectionView"]) {
        PKUICollectionViewController *collectionViewController = [[PKUICollectionViewController alloc] initWithNibName:@"PKUICollectionViewController" bundle:nil];
        [self.navigationController pushViewController:collectionViewController animated:YES];
    }
    
    
}
//设置编辑状态时的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//左滑动cell操作时调用
-(void) tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *newData = [NSMutableArray arrayWithArray:dataArray];
    [newData removeObjectAtIndex:indexPath.row];
    dataArray = [newData copy];
    [table reloadData];
}

//是否允许行移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//移动时调用
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"移动中");
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
}

//设置滑动
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

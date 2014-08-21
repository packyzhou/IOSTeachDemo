//
//  PKUIPickerViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-17.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUIPickerViewController.h"

@interface PKUIPickerViewController ()
{
    UIPickerView *pickerView;
    UIButton *button;
    UILabel *changeLabel;
    NSArray *dataArray;
}
@end

@implementation PKUIPickerViewController

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
    dataArray = @[@"香蕉",@"苹果",@"芒果",@"桃子",@"梨子",@"🍐",@"🐜",@"🐘"];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 64, 300, 300)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
   
    [self.view addSubview: pickerView];
    
    changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 320, 50)];
    changeLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:changeLabel];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(100, 350, 100, 50)];
    
    [button setTitle: @"按钮" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor brownColor];
    [button addTarget:self action:@selector(buttonTodo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view from its nib.
}

-(void) buttonTodo
{
   
}

//设置每行的view
//-(UIView *)pickerView: (UIPickerView *)pickerView viewForRow:(NSInteger) row forComponent:(NSInteger) component reusingView:(UIView *) view
//{
//    UIView *pickerSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    pickerSubView.backgroundColor = [UIColor redColor];
//    UILabel *viewTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    viewTextLabel.text = [dataArray objectAtIndex:row];
//    [pickerSubView addSubview:viewTextLabel];
//    return pickerSubView;
//}
// 返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArray count];
}

//设置每行的文字
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex:row];
}
//选择的元素
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    changeLabel.text =[dataArray objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

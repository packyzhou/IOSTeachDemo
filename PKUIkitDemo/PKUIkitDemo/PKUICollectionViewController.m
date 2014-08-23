//
//  PKUICollectionViewController.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-22.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKUICollectionViewController.h"
static NSString *cellStr = @"CollectionCell";
@interface PKUICollectionViewController ()
{
    UICollectionView *collectionView;
    NSArray *imageArray;
    PKMyCollectionViewCell *collectionViewCell;
    NSInteger cellCount;
    NSLock *lockEntity ;
}
@end

@implementation PKUICollectionViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"显示" style:UIBarButtonItemStylePlain target:self action:@selector(appearThread)];
//    lockEntity= [[NSLock alloc] init];
    [super viewDidLoad];
    [self initImageData];
    [self initCollectionView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) appearAllData:(NSNumber *) index
{
//    [lockEntity lock];
    NSLog(@"显示:%i",[index intValue]);
    cellCount = cellCount + 1;
    [collectionView performBatchUpdates:^{
        [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
    } completion:nil];
   
//   [lockEntity unlock];
}

-(void) appearThread
{
    for (int i = 0; i < imageArray.count;i++) {
       
        [self appearAllData:[NSNumber numberWithInt:i]];
        
    }
    
}

-(void) initImageData
{
    imageArray = @[[UIImage imageNamed:@"cell_0"],[UIImage imageNamed:@"cell_1"],
                   [UIImage imageNamed:@"cell_2"],[UIImage imageNamed:@"cell_3"],
                   [UIImage imageNamed:@"cell_4"],[UIImage imageNamed:@"cell_5"],
                   [UIImage imageNamed:@"cell_6"],[UIImage imageNamed:@"cell_7"],
                   [UIImage imageNamed:@"cell_8"],[UIImage imageNamed:@"cell_9"]];
    cellCount = 0;
}

-(void) initCollectionView
{
    myLayout = [[PKMyCollectionViewLayout alloc] init];
    myLayout.delegate = self;
    myLayout.cellCount = cellCount;
    
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:myLayout];
    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.collectionViewLayout = myLayout;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [collectionView addGestureRecognizer:tapRecognizer];//增加手势操作，跟代理方法冲突
    [collectionView registerClass:[PKMyCollectionViewCell class] forCellWithReuseIdentifier:cellStr];
    [self.view addSubview:collectionView];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:collectionView];//获得点击的坐标
        
        NSIndexPath* tappedCellPath = [collectionView indexPathForItemAtPoint:initialPinchPoint];//根据点击坐标获取索引
        if (tappedCellPath!=nil)
        {
            cellCount = cellCount - 1;
            [collectionView performBatchUpdates:^{
                [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
                
            } completion:nil];
        }
        else
        {
            cellCount = cellCount + 1;
            [collectionView performBatchUpdates:^{
                [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
            } completion:nil];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    
    return cellCount;
}

//配置头脚注
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath//每个cell的配置
{
    
    collectionViewCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    
    UIImage *image = [imageArray objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    collectionViewCell.backgroundView = imageView;
    
    return collectionViewCell;
}

-(void) collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择：%i",indexPath.row);
    if (indexPath!=nil)
    {
        cellCount = cellCount - 1;
        [aCollectionView performBatchUpdates:^{
            [aCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            
        } completion:nil];
    }
    else
    {
        cellCount = cellCount + 1;
        [aCollectionView performBatchUpdates:^{
            [aCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
        } completion:nil];
    }

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) dealloc
{
    NSLog(@"清理内存");
    imageArray = nil;
    collectionViewCell = nil;
    collectionView = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

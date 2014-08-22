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
    [super viewDidLoad];
    [self initImageData];
    [self initCollectionView];
    // Do any additional setup after loading the view from its nib.
}

-(void) initImageData
{
    imageArray = @[[UIImage imageNamed:@"cell_0"],[UIImage imageNamed:@"cell_1"],
                   [UIImage imageNamed:@"cell_2"],[UIImage imageNamed:@"cell_3"],
                   [UIImage imageNamed:@"cell_4"],[UIImage imageNamed:@"cell_5"],
                   [UIImage imageNamed:@"cell_6"],[UIImage imageNamed:@"cell_7"],
                   [UIImage imageNamed:@"cell_8"],[UIImage imageNamed:@"cell_9"]];
    cellCount = [imageArray count];
}

-(void) initCollectionView
{
    myLayout = [[PKMyCollectionViewLayout alloc] init];
    myLayout.delegate = self;
    myLayout.cellCount = [imageArray count];
    
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:myLayout];
    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.collectionViewLayout = myLayout;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [collectionView addGestureRecognizer:tapRecognizer];
    [collectionView registerClass:[PKMyCollectionViewCell class] forCellWithReuseIdentifier:cellStr];
    [self.view addSubview:collectionView];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint initialPinchPoint = [sender locationInView:collectionView];
        NSIndexPath* tappedCellPath = [collectionView indexPathForItemAtPoint:initialPinchPoint];
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath//每个cell的配置
{
    
    collectionViewCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    
    UIImage *image = [imageArray objectAtIndex:indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    collectionViewCell.backgroundView = imageView;
    
    return collectionViewCell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

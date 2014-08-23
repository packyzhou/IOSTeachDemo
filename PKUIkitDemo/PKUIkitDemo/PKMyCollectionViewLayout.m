//
//  PKMyCollectionViewLayout.m
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-22.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKMyCollectionViewLayout.h"
#define ITEM_SIZE 30
@implementation PKMyCollectionViewLayout
//布局前准备参数
-(void)prepareLayout
{
    [super prepareLayout];
    NSLog(@"布局1");
    CGSize size = self.collectionView.frame.size;//collection的size
    _cellCount = [[self collectionView] numberOfItemsInSection:0];//获取cell总数量
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);//获取中心点
    _radius = MIN(size.width, size.height) / 2.5;//计算圆半径
}
//获取collectionView内容的大小
-(CGSize)collectionViewContentSize
{
    NSLog(@"布局2");
    return [self collectionView].frame.size;
}

//通过索引确定每个项目的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    NSLog(@"布局4");
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);//设置cell大小
    //设置cell中心坐标
    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
                                    _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
    
    return attributes;
}

////获取所有cell的属性，并对目前的数据进行初始化
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"布局3");
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

//更新前调用并进行初始化

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    NSLog(@"更新1");
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}
//更新后清理数据
- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    NSLog(@"更新4");
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}


//增加时重新计算布局
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"更新2");
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.center = CGPointMake(_center.x, _center.y);
    }
    
    return attributes;
}

//减少时重新计算布局
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"更新3");
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.center = CGPointMake(_center.x, _center.y);
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}
@end

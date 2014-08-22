//
//  PKMyCollectionViewLayout.h
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-22.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKMyCollectionViewLayout : UICollectionViewFlowLayout
@property(assign,nonatomic) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@end

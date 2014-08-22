//
//  PKUICollectionViewController.h
//  PKUIkitDemo
//
//  Created by 周经伟 on 14-8-22.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKMyCollectionViewLayout.h"
#import "PKMyCollectionViewCell.h"
@interface PKUICollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    PKMyCollectionViewLayout *myLayout;
}

@end

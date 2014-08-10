//
//  PKContext.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-24.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKContext.h"

@implementation PKContext

+(BOOL) cutImageForSavePath:(NSString *)imageName cutSize:(CGSize) size path:(NSString *)homePath
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat column = [image size].width / size.width;
    CGFloat row = [image size].height / size.height;

    int fullColumns = floorf(column);
    int fullRows = floorf(row);
    
    CGFloat remainderW = [image size].width - (fullColumns*size.width);
    CGFloat remainderH = [image size].height - (fullColumns*size.height);
    
    if (column>fullColumns) {
        fullColumns++;
    }
    if (row >fullRows) {
        fullRows++;
    }
    
    CGImageRef fullImage = [image CGImage];
    
    for (int y = 0; y<fullRows; ++y) {
        for (int x = 0; x < fullColumns; ++x) {
            CGSize tileSize = size;
            if(x+1==fullColumns && remainderW > 0)
            {
                tileSize.width = remainderW;
            }
            if (y+1 == fullRows && remainderH > 0) {
                tileSize.height = remainderH;
            }
            CGRect tileRect = CGRectMake(x*size.width, y*size.height, tileSize.width, tileSize.height);
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage, tileRect);
            
            NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:tileImage]);
            
            CGImageRelease(tileImage);
            NSString *path = [NSString stringWithFormat:@"%@/%@_%d_%d.png",homePath,imageName,x,y ];
            [imageData writeToFile:path atomically:NO];
           
        }
    }
    NSLog(@"路径：%@",homePath);
    return YES;
}

@end

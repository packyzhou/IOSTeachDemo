//
//  PKTiledView.m
//  CoreGraphicsDemo
//
//  Created by 周经伟 on 14-7-24.
//  Copyright (c) 2014年 packy. All rights reserved.
//

#import "PKTiledView.h"

@implementation PKTiledView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CATiledLayer *layer = (CATiledLayer *)self.layer;
        layer.levelsOfDetail = 4;
        layer.levelsOfDetailBias = 4;
    }
    return self;
}

+ (Class)layerClass {
    return [CATiledLayer class];
}


-(void) drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
   
    CATiledLayer *layer = (CATiledLayer *)self.layer;
    CGSize tileSize = layer.tileSize;
    
    int firstCol = floorf(CGRectGetMinX(rect) / tileSize.width);
    int lastCol = floorf((CGRectGetMaxX(rect)-1) / tileSize.width);
    int firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    int lastRow = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);
    
    for (int row = firstRow; row <= lastRow; row++) {
        for (int col = firstCol; col <= lastCol; col++) {
            UIImage *tile = [self tileAtCol:row col:col type:@"png"];
            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row,
                                         tileSize.width, tileSize.height);
            
            // if the tile would stick outside of our bounds, we need to truncate it so as
            // to avoid stretching out the partial tiles at the right and bottom edges
            tileRect = CGRectIntersection(self.bounds, tileRect);
            
            [tile drawInRect:tileRect];
        }
    }
}

/*有缩放比*/
- (UIImage *)tileForScale:(CGFloat)scale row:(int)row col:(int)col type:(NSString *)type
{
    // we use "imageWithContentsOfFile:" instead of "imageNamed:" here because we don't
    // want UIImage to cache our tiles
    //图片名_缩放比_列_行
    NSString *tileName = [NSString stringWithFormat:@"%@/%@_%d_%d_%d", _path,_imageName, (int)(scale * 1000), col, row];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:tileName ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

/*有缩放无*/
- (UIImage *)tileAtCol:(int)row col:(int)col type:(NSString *)type
{
    // we use "imageWithContentsOfFile:" instead of "imageNamed:" here because we don't
    // want UIImage to cache our tiles
    //图片名_列_行
    NSString *tileName = [NSString stringWithFormat:@"%@/%@_%d_%d", _path, _imageName, col, row];
    NSString *imagePath = [NSString stringWithFormat:@"%@.%@",tileName,type ];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

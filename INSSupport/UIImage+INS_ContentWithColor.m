//
//  UIImage+INS_ContentWithColor.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "UIImage+INS_ContentWithColor.h"

@implementation UIImage (INS_ContentWithColor)

- (UIImage *)ins_contentWithColor:(UIColor *)color {
    if (!color) {
        return nil;
    }
    
    UIImage *contentWithColorImage = nil;
    
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    
    contentWithColorImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    
    UIGraphicsEndImageContext();
    return contentWithColorImage;
}

@end

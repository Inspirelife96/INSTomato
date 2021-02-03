//
//  INSLogoView.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class INSLogoConfiguration;

@interface INSLogoView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame andLogoConfiguration:(INSLogoConfiguration *)logoConfiguration;

@end

NS_ASSUME_NONNULL_END

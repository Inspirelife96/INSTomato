//
//  INSTomatoClockView.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoClockView : UIView

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTaskName:(NSString *)taskName;

- (void)updateProgress;
- (void)startHalo;
- (void)endHalo;

@end

NS_ASSUME_NONNULL_END

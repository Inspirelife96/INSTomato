//
//  INSTaskPageViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import <UIKit/UIKit.h>

@class INSTomatoClockView;

NS_ASSUME_NONNULL_BEGIN

@interface INSTaskPageViewController : UIViewController

@property(nonatomic, strong) INSTomatoClockView *tomatoClockView;

- (instancetype)initWithTaskId:(NSString *)taskId;

@end

NS_ASSUME_NONNULL_END

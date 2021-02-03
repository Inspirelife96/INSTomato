//
//  INSTaskConfigurationViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTaskConfigurationNavigationStyleBasedViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TaskConfigurationType) {
    TaskConfigurationTypeAdd,
    TaskConfigurationTypeModify
};

@interface INSTaskConfigurationViewController : INSTaskConfigurationNavigationStyleBasedViewController

@property(nonatomic, assign) TaskConfigurationType configurationType;

@end

NS_ASSUME_NONNULL_END

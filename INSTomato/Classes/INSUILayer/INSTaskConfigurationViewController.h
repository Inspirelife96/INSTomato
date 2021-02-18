//
//  INSTaskConfigurationViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTaskConfigurationNavigationStyleBasedViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, INSTaskConfigurationType) {
    INSTaskConfigurationTypeAdd,
    INSTaskConfigurationTypeModify,
    INSTaskConfigurationTypeModifyOnly,
};

@interface INSTaskConfigurationViewController : INSTaskConfigurationNavigationStyleBasedViewController

@property(nonatomic, assign) INSTaskConfigurationType configurationType;

@end

NS_ASSUME_NONNULL_END

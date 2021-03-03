//
//  INSTaskNameViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class INSTaskModel;

@interface INSTaskNameViewController : INSBaseViewController

@property (nonatomic, strong) INSTaskModel *taskModel;

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END

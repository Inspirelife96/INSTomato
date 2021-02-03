//
//  INSTaskConfigurationNavigationStyleBasedViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSBaseViewController.h"

@class INSTaskModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSTaskConfigurationNavigationStyleBasedViewController : INSBaseViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@property (nonatomic, strong) INSTaskModel *taskModel;

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel;

- (void)clickBackBarButtonItem:(id)sender;

@end

NS_ASSUME_NONNULL_END

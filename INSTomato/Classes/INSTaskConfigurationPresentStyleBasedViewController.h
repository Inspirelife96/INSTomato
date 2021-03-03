//
//  INSTaskConfigurationPresentStyleBasedViewController.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSBaseViewController.h"

@class INSTaskModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSTaskConfigurationPresentStyleBasedViewController : INSBaseViewController

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) INSTaskModel *taskModel;

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel;

- (void)clickCloseButton:(id)sender;

@end

NS_ASSUME_NONNULL_END

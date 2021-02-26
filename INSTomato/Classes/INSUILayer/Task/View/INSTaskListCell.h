//
//  INSTaskListCell.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class INSTaskListCellViewModel;

@interface INSTaskListCell : UITableViewCell

- (void)configWithTaskListCellViewModel:(INSTaskListCellViewModel *)taskListCellVM;

@end

NS_ASSUME_NONNULL_END

//
//  INSTaskListCellViewModel.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import <Foundation/Foundation.h>

@class INSTaskModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSTaskListCellViewModel : NSObject

@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *taskTomatoMinutes;
@property (nonatomic, strong) UIImage *taskColorImage;

@property (nonatomic, strong) INSTaskModel *taskModel;

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END

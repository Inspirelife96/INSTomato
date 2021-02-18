//
//  INSTaskTableConfiguration.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSTaskModel;

@interface INSTaskTableConfiguration : NSObject

//
@property (nonatomic, strong) NSArray<INSTaskModel *> *taskModelArray;

//
@property (nonatomic, assign) BOOL isAddTaskEnabled;

//
@property (nonatomic, copy) NSString *taskTableTitle;
@property (nonatomic, copy) NSString *taskTableDescription;
@property (nonatomic, strong) UIImage *taskTableIcon;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTaskModelArray:(NSArray<INSTaskModel *> *)taskModelArray NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

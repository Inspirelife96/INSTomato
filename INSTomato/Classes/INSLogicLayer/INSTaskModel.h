//
//  INSTaskModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTaskModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *music;
@property (nonatomic, strong) NSNumber *tomatoMinutes;
@property (nonatomic, strong) NSNumber *restMinutes;
@property (nonatomic, assign) BOOL isFocusModeEnabled;
@property (nonatomic, assign) BOOL isRestModeEnabled;
@property (nonatomic, assign) BOOL isMusicModeEnabled;
@property (nonatomic, assign) BOOL isAlertModeEnabled;
@property (nonatomic, strong) NSDate *alertDate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name color:(NSString *)color music:(NSString *)music NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTaskDictionary:(NSDictionary *)taskDictionary NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)convertToDictionary;

- (BOOL)isEqualToTaskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END

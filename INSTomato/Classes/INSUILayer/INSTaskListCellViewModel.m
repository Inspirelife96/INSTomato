//
//  INSTaskListCellViewModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSTaskListCellViewModel.h"

#import "INSTaskModel.h"

#import "UIImage+INS_ContentWithColor.h"
#import "INSColorHelper.h"

@implementation INSTaskListCellViewModel

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel {
    if (self = [super init]) {
        _taskModel = taskModel;
        _taskName = taskModel.name;
        _taskTomatoMinutes = [NSString stringWithFormat:@"%@分钟", taskModel.tomatoMinutes];
        _taskColorImage = [[UIImage imageNamed:@"menu_slider_thumb_16x16_"] ins_contentWithColor:[INSColorHelper colorByName:taskModel.color]];
    }
    
    return self;
}

@end

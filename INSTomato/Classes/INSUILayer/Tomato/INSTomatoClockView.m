//
//  INSTomatoClockView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import "INSTomatoClockView.h"

#import <PulsingHalo/PulsingHalo-umbrella.h>

#import "INSTomatoTimer.h"
#import "INSDateHelper.h"

#import <ChameleonFramework/Chameleon.h>

#define RADIUS 80
#define POINT_RADIUS 8
#define CIRCLE_WIDTH 4
#define PROGRESS_WIDTH 6
#define TEXT_NAME_SIZE 48
#define TEXT_DATE_SIZE 16

@interface INSTomatoClockView ()

@property(nonatomic, strong) PulsingHaloLayer *halo;

@property(nonatomic, strong) NSString *taskName;

@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;

@end

@implementation INSTomatoClockView

- (instancetype)initWithTaskName:(NSString *)taskName {
    if (self = [super init]) {
        _taskName = taskName;
        _startAngle = -0.5 * M_PI;
        _endAngle = self.startAngle;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// 时钟更新分为几个步骤
// 1. 默认的圆圈
// 2. 进度条
// 3. 中间的计时数字
- (void)drawRect:(CGRect)rect {
    [self drawClockCircle];
    
    [self drawProgressCircle];
    
    if ([INSTomatoTimer sharedInstance].tomatoTimerStatus ==  INSTomatoTimerStatusStop) {
        [self drawStatusLabel];
    } else {
        [self drawProgressLabel];
    }
}

- (void)drawClockCircle {
    CGRect rect = self.frame;
    CGFloat radius = (rect.size.width - 20)/2;

    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                      radius:radius
                  startAngle:0
                    endAngle:2 * M_PI
                   clockwise:YES];
    
    circle.lineWidth = CIRCLE_WIDTH;
    [FlatWhiteDark setStroke];
    [circle stroke];
}

- (void)drawProgressCircle {
    CGFloat leftSeconds = [INSTomatoTimer sharedInstance].leftSeconds;
    CGFloat totalSeconds = [INSTomatoTimer sharedInstance].totalSeconds;
    
    CGFloat startAngle = -0.5 * M_PI;
    CGFloat endAngle = ((totalSeconds - leftSeconds) / totalSeconds) * 2 * M_PI + startAngle;
    
    // 更新进度条
    CGRect rect = self.frame;
    CGFloat radius = (rect.size.width - 20)/2;
    
    UIBezierPath *progress = [UIBezierPath bezierPath];
    [progress addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                        radius:radius
                    startAngle:startAngle
                      endAngle:endAngle
                     clockwise:YES];
    progress.lineWidth = PROGRESS_WIDTH;
    [FlatWhite setStroke];
    [progress stroke];
}

- (void)drawProgressLabel {
    // 更新剩余时间
    
    NSInteger leftSeconds = [INSTomatoTimer sharedInstance].leftSeconds;
    
    CGRect rect = self.frame;
    
    NSString *textContent = [INSDateHelper minutesFormatBySeconds:leftSeconds];
    
    UIFont *textFont = [UIFont fontWithName:@"-" size: TEXT_NAME_SIZE];
    CGSize textSize = [textContent sizeWithAttributes:@{NSFontAttributeName:textFont}];
    CGRect textRect = CGRectMake(rect.size.width / 2 - textSize.width / 2,
                                 rect.size.height / 2 - textSize.height / 2,
                                 textSize.width , textSize.height);
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
    
    [textContent drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
}

- (void)drawStatusLabel {
    NSString *taskOrRestName = self.taskName;
    if ([INSTomatoTimer sharedInstance].tomatoTimerMode == INSTomatoTimerModeRest) {
        taskOrRestName = @"休息";
    }
    
    NSInteger fontSize = TEXT_NAME_SIZE;
    
    UIFont *taskNameFont = [UIFont fontWithName:@"-" size: fontSize];
    CGSize taskNameSize = [taskOrRestName sizeWithAttributes:@{NSFontAttributeName:taskNameFont}];
    
    while (taskNameSize.width > (self.frame.size.width - 20)) {
        fontSize -= 2;
        taskNameFont = [UIFont fontWithName:@"-" size: fontSize];
        taskNameSize = [taskOrRestName sizeWithAttributes:@{NSFontAttributeName:taskNameFont}];
    }
    
    CGRect rect = self.frame;
    
    CGFloat taskNameX = 10;
    CGFloat taskNameY = (rect.size.height - taskNameSize.height)/2 - 10;
    CGFloat taskNameWidth = self.frame.size.width - 20;
    CGFloat taskNameHeight = taskNameSize.height;
    
    CGRect taskNameRect = CGRectMake(taskNameX, taskNameY, taskNameWidth, taskNameHeight);
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
    
    [taskOrRestName drawInRect:taskNameRect withAttributes:@{NSFontAttributeName:taskNameFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
    
    NSString *dateToday = [INSDateHelper stringOfDayWithWeekDay:[NSDate date]];
    UIFont *dateFont = [UIFont fontWithName:@"-" size: TEXT_DATE_SIZE];
    CGSize dateSize = [dateToday sizeWithAttributes:@{NSFontAttributeName:dateFont}];
    
    CGFloat dateX = (rect.size.width - dateSize.width)/2;
    CGFloat dateY = taskNameY + taskNameHeight + 5;
    CGFloat dateWidth = dateSize.width;
    CGFloat dateHeight = dateSize.height;
    
    CGRect dateRect = CGRectMake(dateX, dateY, dateWidth, dateHeight);
    
    [dateToday drawInRect:dateRect withAttributes:@{NSFontAttributeName:dateFont, NSForegroundColorAttributeName:FlatWhite, NSParagraphStyleAttributeName:textStyle}];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [FlatWhite setStroke];
    CGContextMoveToPoint(context, dateX, dateY - 2);
    CGContextAddLineToPoint(context, dateX + dateWidth, dateY - 2);
    CGContextMoveToPoint(context, dateX, dateY + dateHeight + 2);
    CGContextAddLineToPoint(context, dateX + dateWidth, dateY + dateHeight + 2);
    CGContextStrokePath(context);
}

// 添加动态脉冲
- (void)startHalo {
    [self.superview.layer insertSublayer:self.halo below:self.layer];
    [self.halo start];
}

// 删除动态脉冲
- (void)endHalo {
    [self.halo stop];
    [self.halo removeFromSuperlayer];
    self.halo = nil;
}

- (void)updateProgress {
    [self setNeedsDisplay];
}

#pragma mark - Getter and Setter

- (PulsingHaloLayer *)halo {
    if (!_halo) {
        _halo = [PulsingHaloLayer layer];
        _halo.haloLayerNumber   = 3;
        _halo.backgroundColor = FlatWhiteDark.CGColor;
        _halo.radius            = 160;
        _halo.animationDuration = 5;
        _halo.position = self.center;
    }
    
    return _halo;
}

@end

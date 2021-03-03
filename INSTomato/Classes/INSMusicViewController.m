//
//  INSMusicViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSMusicViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "INSTaskModel.h"

#import "INSTomatoConfigurationTableManager.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSMusicViewController () <AVAudioPlayerDelegate>

@property(nonatomic, strong) NSArray *musicNameArray;
@property(nonatomic, strong) NSArray *musicUrlPathArray;
@property(nonatomic, strong) AVAudioPlayer *musicPlayer;

@end

@implementation INSMusicViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger selectedIndex = [self.musicNameArray indexOfObject:self.taskModel.music];
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
    [self playMusic:selectedIndex];
}

#pragma Mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.musicNameArray count];
}

#pragma Mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self playMusic:row];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.musicNameArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            CGFloat y = singleLine.frame.origin.y;
            CGFloat height = singleLine.frame.size.height;
            [singleLine setFrame:CGRectMake(12, y, self.view.frame.size.width - 24, height)];
            singleLine.backgroundColor = FlatWhiteDark;
            singleLine.alpha = 0.3;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setTextColor:FlatWhite];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:18]];
    }

    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger selectedIndex =[self.pickerView selectedRowInComponent:0];
    self.taskModel.music = self.musicNameArray[selectedIndex] ;
    
    [self.musicPlayer stop];
    self.musicPlayer = nil;
    
    [super clickCloseButton:sender];
}

#pragma mark - Private Method

- (void)playMusic:(NSInteger)index {
    if (self.musicPlayer != nil) {
        [self.musicPlayer stop];
        self.musicPlayer = nil;
    }
    
    NSURL *musicUrl = [NSURL fileURLWithPath:self.musicUrlPathArray[index]];
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    self.musicPlayer.delegate = self;
    self.musicPlayer.numberOfLoops = -1;
    self.musicPlayer.volume = 1;
    [self.musicPlayer prepareToPlay];
    self.musicPlayer.meteringEnabled = YES;
    [self.musicPlayer play];
}

#pragma mark - Getter and Setter

- (NSArray *)musicNameArray {
    if (!_musicNameArray) {
        _musicNameArray = [[INSTomatoConfigurationTableManager sharedInstance] musicNameArray];
    }
    
    return _musicNameArray;
}

- (NSArray *)musicUrlPathArray {
    if (!_musicUrlPathArray) {
        _musicUrlPathArray = [[INSTomatoConfigurationTableManager sharedInstance] musicUrlPathArray];
    }
    
    return _musicUrlPathArray;
}

@end

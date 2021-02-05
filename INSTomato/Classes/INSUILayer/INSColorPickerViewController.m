//
//  INSColorPickerViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSColorPickerViewController.h"

#import "INSTaskModel.h"
#import "INSColorView.h"

#import "INSColorHelper.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSColorPickerViewController ()

@property (nonatomic, strong) NSArray *colorNameArray;

@end

#pragma mark - Life Cycle

@implementation INSColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger selectedIndex = [self.colorNameArray indexOfObject:self.taskModel.color];
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.colorNameArray count];
}

#pragma Mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width - 24;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.colorNameArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            CGFloat y = singleLine.frame.origin.y;
            CGFloat height = singleLine.frame.size.height;
            [singleLine setFrame:CGRectMake(12, y, self.view.frame.size.width - 24, height)];
            singleLine.backgroundColor = FlatWhiteDark;
            singleLine.alpha = 0.3;
        }
    }
    
    NSString *colorName = self.colorNameArray[row];
    UIColor *color = [INSColorHelper colorByName:colorName];
    
    INSColorView* colorView = (INSColorView *)view;
    if (!colorView){
        colorView = [[INSColorView alloc] initWithColorName:colorName andColor:color];
    }
    
    return colorView;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger selectedIndex = [self.pickerView selectedRowInComponent:0];
    self.taskModel.color = self.colorNameArray[selectedIndex];
    
    [super clickCloseButton:sender];
}

#pragma mark - Getter and Setter

- (NSArray *)colorNameArray {
    if (!_colorNameArray) {
        _colorNameArray = [INSColorHelper colorNameList];
    }
    
    return _colorNameArray;
}
@end

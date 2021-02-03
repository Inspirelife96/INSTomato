//
//  INSTaskConfigurationSwitchCell.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTaskConfigurationSwitchCell.h"

@interface INSTaskConfigurationSwitchCell ()

@end

@implementation INSTaskConfigurationSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.backgroundColor = ClearColor;
    self.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
    self.textLabel.textColor = FlatWhite;
    self.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    self.detailTextLabel.textColor = FlatWhiteDark;
    
    [self.contentView addSubview:self.configurationSwitch];
    [self.configurationSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-24.0f);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40.0f);
        make.height.mas_equalTo(32.0f);
    }];
}


- (UISwitch *)configurationSwitch {
    if (!_configurationSwitch) {
        _configurationSwitch = [[UISwitch alloc] init];
        _configurationSwitch.onTintColor = FlatGreen;
        _configurationSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
    }
    
    return _configurationSwitch;
}

@end

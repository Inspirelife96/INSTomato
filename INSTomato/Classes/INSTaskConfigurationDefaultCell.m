//
//  INSTaskConfigurationDefaultCell.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTaskConfigurationDefaultCell.h"

#import "INSTomatoBundle.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSTaskConfigurationDefaultCell ()

@end

@implementation INSTaskConfigurationDefaultCell

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
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([INSTaskConfigurationDefaultCell class])]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryView = [INSTomatoBundle accessoryView];
    self.backgroundColor = ClearColor;
    self.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
    self.textLabel.textColor = FlatWhite;
    self.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
    self.detailTextLabel.textColor = FlatWhiteDark;
}

@end

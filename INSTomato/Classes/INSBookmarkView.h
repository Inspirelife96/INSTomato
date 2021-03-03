//
//  INSBookmarkView.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/11.
//

#import <UIKit/UIKit.h>

@class INSBookmarkModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSBookmarkView : UIView

- (void)configWithBookMarkModel:(INSBookmarkModel *)bookMarkModel;

@end

NS_ASSUME_NONNULL_END

//
//  INSBookmarkModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSBookmarkModel.h"

#import "INSPersistenceConstants.h"

@implementation INSBookmarkModel

- (NSDictionary *)toDictionary {
    NSDictionary *dictionary = @{
        kBookMarkDate: self.date,
        kBookMarkTitle: self.title,
        kBookMarkWords: self.words,
        kBookMarkImageData: UIImageJPEGRepresentation(self.image, 0.5)
    };
    
    return dictionary;
}

@end

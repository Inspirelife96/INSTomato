//
//  INSBookmarkTableManager.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSBookmarkTableManager.h"

#import "INSBookmarkTablePersistence.h"

#import "INSBookmarkModel.h"

#import "INSPersistenceConstants.h"

#import "INSDateHelper.h"

#import "INSNetworkOperation.h"

#import "INSNetworkOperation.h"

static INSBookmarkTableManager *sharedInstance = nil;

@interface INSBookmarkTableManager ()

@property (strong, nonatomic) NSDictionary *bookmarkTableDictionary;

@end

@implementation INSBookmarkTableManager

+ (void)createBookmarkTable {
    if ([INSBookmarkTablePersistence readBookmarkTable]) {
        return;
    }
    
    [INSBookmarkTablePersistence createBookmarkTable];
}

+ (void)updateBookmarkTable {
    // 先判断是不是同一天
    NSDictionary *bookmarkTableDictionary = [INSBookmarkTablePersistence readBookmarkTable];
    NSDate *bookmarkDate = bookmarkTableDictionary[kBookMarkDate];
    NSDate *today = [NSDate date];

    // 是，则什么都不做，今日图片已经更新完毕
    if ([INSDateHelper isSameDay:today date2:bookmarkDate]) {
        return;
    }
    
    // 不是，则下载今日的图片
    INSNetworkOperation *networkOperation = [[INSNetworkOperation alloc] init];
    
    [networkOperation downloadBookmarkData:^(INSBookmarkModel * _Nonnull bookmarkModel, NSError * _Nullable error) {
        if (error) {
            
        } else {
            if (bookmarkModel.image && bookmarkModel.title && bookmarkModel.words) {
                NSDictionary *bookMarkDataDictionary = [bookmarkModel toDictionary];
                [INSBookmarkTablePersistence saveBookmarkTable:bookMarkDataDictionary];
            }
        }
    }];
}


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [INSBookmarkTableManager sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [INSBookmarkTableManager sharedInstance] ;
}

- (instancetype)init {
    if (self = [super init]) {
        _bookmarkTableDictionary = [INSBookmarkTablePersistence readBookmarkTable];
        if (!_bookmarkTableDictionary) {
            [INSBookmarkTablePersistence createBookmarkTable];
            _bookmarkTableDictionary = [INSBookmarkTablePersistence readBookmarkTable];
        }
    }
    
    return self;
}

- (INSBookmarkModel *)prepareBookmarkModel {
    INSBookmarkModel *bookmarkModel = [[INSBookmarkModel alloc] init];
    bookmarkModel.date = self.bookmarkTableDictionary[kBookMarkDate];
    bookmarkModel.title = self.bookmarkTableDictionary[kBookMarkTitle];
    bookmarkModel.words = self.bookmarkTableDictionary[kBookMarkWords];
    bookmarkModel.image = [UIImage imageWithData:self.bookmarkTableDictionary[kBookMarkImageData]];
    
    return bookmarkModel;
}

@end

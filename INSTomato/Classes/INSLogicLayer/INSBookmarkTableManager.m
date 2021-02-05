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
//    dispatch_group_t downloadDataGroup = dispatch_group_create();
//    
//    dispatch_group_enter(downloadDataGroup);
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    manager.responseSerializer = [AFImageResponseSerializer serializer];
//    
//    NSURL *URL = [NSURL URLWithString:imageUrlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            self.error = error;
//        } else {
//            self.storyImage = responseObject;
//        }
//        dispatch_group_leave(self.requestGroup);
//    }];
//    
//    [dataTask resume];
    
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

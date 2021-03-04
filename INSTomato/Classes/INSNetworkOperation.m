//
//  INSNetworkOperation.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSNetworkOperation.h"

#import "INSBookmarkModel.h"

#import <AFNetworking/AFNetworking.h>

NSString *const kBingImageURL = @"http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1";
NSString *const kBingImageFullPathFormat = @"http://www.bing.com%@%@";

// 由于不是Https，不再使用
// NSString *const kICIBAWordsURL = @"http://open.iciba.com/dsapi/";

NSString *kHitokotoURL = @"https://v1.hitokoto.cn/";

// 备选 扇贝
// https://apiv3.shanbay.com/weapps/dailyquote/quote/

NSString *const kBingImageURLImages = @"images";
NSString *const kBingImageURLUrlBase = @"urlbase";
NSString *const kBingImageCopyright = @"copyright";
NSString *const kBingImageURLImageData = @"imageData";

NSString *const kImageTypes = @"_1080x1920.jpg";

NSString *const kHitokoto = @"hitokoto";

@interface INSNetworkOperation ()

@property (nonatomic, strong) dispatch_group_t downloadBookMarkDataDispatchGroup;
@property (nonatomic, strong) INSBookmarkModel *bookmarkModel;
@property (nonatomic, strong) NSError *error;

@end

@implementation INSNetworkOperation


- (dispatch_group_t)downloadBookMarkDataDispatchGroup {
    if (!_downloadBookMarkDataDispatchGroup) {
        _downloadBookMarkDataDispatchGroup = dispatch_group_create();
    }
    
    return _downloadBookMarkDataDispatchGroup;
}

- (INSBookmarkModel *)bookmarkModel {
    if (!_bookmarkModel) {
        _bookmarkModel = [[INSBookmarkModel alloc] init];
        _bookmarkModel.date = [NSDate date];
    }
    
    return _bookmarkModel;
}

- (void)downloadBookmarkData:(void (^_Nullable)(INSBookmarkModel *bookmarkModel, NSError *_Nullable error))block {
    [self downloadBingImageDataDictionary];
    [self downloadHitokoto];
    
    dispatch_group_notify(self.downloadBookMarkDataDispatchGroup, dispatch_get_main_queue(), ^{
        block(self.bookmarkModel, self.error);
    });
}

- (void)downloadBingImageDataDictionary {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kBingImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    dispatch_group_enter(self.downloadBookMarkDataDispatchGroup);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            self.error = error;
        } else {
            NSArray *imagesArray = ((NSDictionary *)responseObject)[kBingImageURLImages];
            
            if (imagesArray && imagesArray.count >= 1) {
                NSDictionary *imageDictionary = imagesArray[0];
                if (imageDictionary[kBingImageURLUrlBase]) {
                    NSString *imageURLString = [NSString stringWithFormat:kBingImageFullPathFormat, imageDictionary[kBingImageURLUrlBase], kImageTypes];
                    [self downloadBingImage:imageURLString];
                }
                
                if (imageDictionary[kBingImageCopyright]) {
                    self.bookmarkModel.title = imageDictionary[kBingImageCopyright];
                }
            }
        }
        
        dispatch_group_leave(self.downloadBookMarkDataDispatchGroup);
    }];
    
    [dataTask resume];
}

- (void)downloadBingImage:(NSString *)imageURLString {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    dispatch_group_enter(self.downloadBookMarkDataDispatchGroup);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            self.error = error;
        } else {
            if ([responseObject isKindOfClass:[UIImage class]]) {
                self.bookmarkModel.image = responseObject;
            }
        }
        
        dispatch_group_leave(self.downloadBookMarkDataDispatchGroup);
    }];
    
    [dataTask resume];
}

- (void)downloadHitokoto {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURL *URL = [NSURL URLWithString:kHitokotoURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    dispatch_group_enter(self.downloadBookMarkDataDispatchGroup);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            self.error = error;
        } else {
            //NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *hitokotoDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (hitokotoDictionary[kHitokoto]) {
                self.bookmarkModel.words = hitokotoDictionary[kHitokoto];
            }
        }
        
        dispatch_group_leave(self.downloadBookMarkDataDispatchGroup);
    }];
    
    [dataTask resume];
}


@end

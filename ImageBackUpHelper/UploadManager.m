//
//  UploadManager.m
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/7.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import "UploadManager.h"
#import "AFNetworking.h"
#import "AFHttpSessionManager.h"
#import <Photos/Photos.h>

@implementation UploadManager

static UploadManager *defaultManager = nil;


+ (UploadManager*)defaultManager
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(defaultManager == nil)
        {
            defaultManager = [[self alloc] init];
        }
    });
    return defaultManager;
}


+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(defaultManager == nil)
        {
            defaultManager = [super allocWithZone:zone];
        }
    });
    return defaultManager;
}


- (id)copy
{
    return self;
}


- (id)mutableCopy
{
    return self;
}


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        // init your singleton here
        
        _totalTasks = 0;
        _finishedTasks = 0;
        _failedTasks = 0;

    }
    return self;
}


- (NSURLSessionUploadTask*)uploadTaskWithImageData:(NSData*)imageData completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.operationQueue.maxConcurrentOperationCount = 5;
    
    NSString *urlString = @"http://127.0.0.1:8080";
    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat =@"yyyyMMddHHmmssSSS";
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    NSLog(@"fileName %@", fileName);

    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } error:nil];
    
    NSLog(@"request %@", request);
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:completionBlock];
    

    return uploadTask;

}


- (void)uploadAssets:(NSArray *)assets{

    
    _totalTasks = assets.count;
    _finishedTasks = 0;
    _failedTasks = 0;
    for (int i = 0 ; i < _totalTasks ; i++ ) {
        
        __block NSData *data;
        
        PHAsset* asset = assets[i];
        if (asset.mediaType == PHAssetMediaTypeImage) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                              options:options
                                                        resultHandler:
             ^(NSData *imageData,
               NSString *dataUTI,
               UIImageOrientation orientation,
               NSDictionary *info) {
                 data = [NSData dataWithData:imageData];
             }];
        }
        
        
        NSURLSessionUploadTask* uploadTask = [[UploadManager defaultManager] uploadTaskWithImageData:data completion:^(NSURLResponse *response, NSDictionary* responseObject, NSError *error) {
            if (error) {
                NSLog(@"upload failure %@", error);
                _failedTasks += 1;
                if ([_delegate respondsToSelector:@selector(updateTaskState:finished:failed:)]) {
                    [_delegate updateTaskState:_totalTasks finished:_finishedTasks failed:_failedTasks];
                }
                
            } else {
                _finishedTasks += 1;
                NSLog(@"upload success %@", responseObject);
                if ([_delegate respondsToSelector:@selector(updateTaskState:finished:failed:)]) {
                    [_delegate updateTaskState:_totalTasks finished:_finishedTasks failed:_failedTasks];
                }
                
            }
        }];
        
        [uploadTask resume];

        
    }
    
}

@end

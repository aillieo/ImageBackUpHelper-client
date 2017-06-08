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

+ (NSURLSessionUploadTask*)uploadTaskWithImageData:(NSData*)imageData completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"http://127.0.0.1:8080";
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:@"name" forKey:@"name"];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmssSSS";
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


+ (void)uploadAssets:(NSArray *)assets{

    
    NSInteger count = assets.count;
    for (int i = 0 ; i < count ; i++ ) {
        
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
        
        
        NSURLSessionUploadTask* uploadTask = [UploadManager uploadTaskWithImageData:data completion:^(NSURLResponse *response, NSDictionary* responseObject, NSError *error) {
            if (error) {
                NSLog(@"upload failure %@", error);
            } else {
                NSLog(@"upload success %@", responseObject);
            }
        }];
        
        [uploadTask resume];

        
    }
    
}

@end

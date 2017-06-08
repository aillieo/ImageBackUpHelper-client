//
//  UploadManager.h
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/7.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadManager : NSObject


+ (NSURLSessionUploadTask*)uploadTaskWithImageData:(NSData *)imageData
                                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;

+ (void)uploadAssets:(NSArray *)assets;

@end

//
//  UploadManager.h
//  ImageBackUpHelper
//
//  Created by yiyiran on 17/6/7.
//  Copyright © 2017年 AillieoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UploadManagerDelegate

- (void)updateTaskState:(NSInteger)totalTasks
            finished:(NSInteger)finishedTasks
            failed:(NSInteger)failedTasks;

@end

@interface UploadManager : NSObject
<UploadManagerDelegate>

+(UploadManager*)defaultManager;

@property (weak, nonatomic) id delegate;

- (NSURLSessionUploadTask*)uploadTaskWithImageData:(NSData *)imageData
                                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;

- (void)uploadAssets:(NSArray *)assets;

@property (assign, atomic) unsigned long totalTasks;
@property (assign, atomic) unsigned long finishedTasks;
@property (assign, atomic) unsigned long failedTasks;


@end

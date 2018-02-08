//
//  CKMenoUtil.m
//  CKMemoUtil
//
//  Created by mk on 2018/1/22.
//

#import "CKMemoUtil.h"
#import <iflyMSC/IFlyMSC.h>
#import "VoiceConvert.h"

#define APPID_VALUE           @"5a653fb7"

#define CompressionVideoPath [NSHomeDirectory() stringByAppendingFormat:@"/Documents/CompressionVideoField"]


static CKMemoUtil *SharedInstance = nil;

@interface CKMemoUtil()

@property(nonatomic, strong) CKSpeechSynthesizer * speechSynthesizer;
@property(nonatomic, strong) CKSpeechRecognizer * speechRecognizer;

@end

@implementation CKMemoUtil

+(CKMemoUtil *) shared {
    @synchronized(self){
        if (!SharedInstance) {
            SharedInstance = [[self alloc] init];
        }
    }
    return SharedInstance;
}

-(void) setup {
    //Set log level
    [IFlySetting setLogFile:LVL_ALL];
    
    //Set whether to output log messages in Xcode console
    [IFlySetting showLogcat:YES];
    
    //Set the local storage path of SDK
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
    
}

#pragma mark: -  audio compress

-(BOOL) compressWavePath:(NSString *) wavePath toPath:(NSString *) toPath {
    if([VoiceConvert ConvertWavToAmr:wavePath amrSavePath:toPath] == 1) {
        return YES;
    }
    return  NO;
}

-(BOOL) decompressFilePath:(NSString *) compressedFilePath toPath:(NSString *) toPath {
    if([VoiceConvert ConvertAmrToWav:compressedFilePath wavSavePath:toPath] == 1) {
        return YES;
    }
    return  NO;
}

#pragma mark: - video compress

- (void)compressedVideoOtherMethodWithURL:(NSURL *)url compressionType:(NSString *)compressionType compressionResultPath:(CompressionSuccessBlock)resultPathBlock {
    
    NSString *resultPath;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    // 所支持的压缩格式中是否有 所选的压缩格式
    if ([compatiblePresets containsObject:compressionType]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressionType];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];// 用时间, 给文件重新命名, 防止视频存储覆盖,
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isExists = [manager fileExistsAtPath:CompressionVideoPath];
        
        if (!isExists) {
            [manager createDirectoryAtPath:CompressionVideoPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        resultPath = [CompressionVideoPath stringByAppendingPathComponent:[NSString stringWithFormat:@"outputJFVideo-%@.mov", [formater stringFromDate:[NSDate date]]]];
        NSLog(@"resultPath = %@",resultPath);
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
             if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 float kbSize = [self getFileSize: resultPath];
                 NSLog(@"视频压缩后大小 %f", kbSize);
                 resultPathBlock (resultPath, kbSize);
             } else {
                 NSLog(@"压缩失败");
             }
         }];
        
    } else {
        NSLog(@"不支持 %@ 格式的压缩", compressionType);
    }
}

-(long long) getFileSize:(NSString *) path {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    long long fileSize = [fileSizeNumber longLongValue];
    return fileSize;
}

#pragma mark: -  speech synthesizer

- (CKSpeechSynthesizer *) createSpeechSynthesizer {
    self.speechSynthesizer = [[CKSpeechSynthesizer alloc] init];
    return self.speechSynthesizer;
}

#pragma mark: -  speech recognize

- (CKSpeechRecognizer *) createSpeechRecognizer {
    self.speechRecognizer = [[CKSpeechRecognizer alloc] init];
    return self.speechRecognizer;
}


@end


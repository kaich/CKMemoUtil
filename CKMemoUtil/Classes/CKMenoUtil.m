//
//  CKMenoUtil.m
//  CKMemoUtil
//
//  Created by mk on 2018/1/22.
//

#import "CKMenoUtil.h"
#import <iflyMSC/IFlyMSC.h>
#import "VoiceConvert.h"

#define APPID_VALUE           @"5a653fb7"

static CKMenoUtil *SharedInstance = nil;

@interface CKMenoUtil()

@property(nonatomic, strong) CKSpeechSynthesizer * speechSynthesizer;
@property(nonatomic, strong) CKSpeechRecognizer * speechRecognizer;

@end

@implementation CKMenoUtil

+(CKMenoUtil *) shared {
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


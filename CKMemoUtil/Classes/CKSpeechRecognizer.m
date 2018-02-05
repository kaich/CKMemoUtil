//
//  CKMenoSpeechRecognizer.m
//  CKMemoUtil
//
//  Created by mk on 2018/1/22.
//

#import "CKSpeechRecognizer.h"
#import <iflyMSC/IFlyMSC.h>
#import "NSString+ISR.h"


@interface CKSpeechRecognizer()<IFlySpeechRecognizerDelegate>
@property(nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;
@end

@implementation CKSpeechRecognizer

-(instancetype)init {
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    //创建语音识别对象
    //recognition singleton without view
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    //set recognition domain
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    _iFlySpeechRecognizer.delegate = self;
    
    if (_iFlySpeechRecognizer != nil) {
        
        //set timeout of recording
        [_iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //set VAD timeout of end of speech(EOS)
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //set VAD timeout of beginning of speech(BOS)
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //set network timeout
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //set sample rate, 16K as a recommended option
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //set language
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //set accent
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        
        //set whether or not to show punctuation in recognition results
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }

}


- (BOOL) startListening {
    [self configRecognizer];
    BOOL isOK = [self.iFlySpeechRecognizer startListening];
    if(isOK) {
        if([self isStream]) {
            [self writeAudioData];
        }
    }
    return isOK;
}

/*!
 *  停止录音<br>
 *  调用此函数会停止录音，并开始进行语音识别
 */
- (void) stopListening {
    [self.iFlySpeechRecognizer stopListening];
}

/*!
 *  取消本次会话
 */
- (void) cancel {
    [self.iFlySpeechRecognizer cancel];
}

-(void) configRecognizer {
    if([self isStream]) {
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_STREAM forKey:@"audio_source"];
    }
    else {
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    }
}


-(void) writeAudioData {
    if(self.audioData || self.audioData) {
        if(self.audioData) {
            [self.iFlySpeechRecognizer writeAudio:self.audioData];
        }
        else if(self.audioPath) {
            self.audioData = [NSData dataWithContentsOfFile: self.audioPath];
            [self.iFlySpeechRecognizer writeAudio:self.audioData];
            self.audioData = nil;
        }
        [self stopListening];
    }
}

-(BOOL) isStream {
    return  self.audioPath || self.audioData;
}

#pragma mark: - IFlySpeechRecognizerDelegate

- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic){
        [result appendFormat:@"%@",key];//合并结果
    }
    NSString * finalResult = [result jsonToString];
    if(_completeBlock) {
        self.completeBlock(finalResult);
    }
}

- (void) onError:(IFlySpeechError *)error {
    if(error.errorCode == 0) {
        NSLog(@"+++++++++++++++++++++ 正常结束");
    }
    else {
        NSLog(@"+++++++++++++++++++++ speech Error: %d : %d : %@", error.errorType, error.errorCode , error.errorDesc);
    }
}


@end

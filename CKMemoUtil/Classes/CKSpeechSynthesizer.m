//
//  CKSpeechSynthesizer.m
//  CKMemoUtil
//
//  Created by mk on 2018/1/23.
//

#import "CKSpeechSynthesizer.h"
#import <iflyMSC/IFlyMSC.h>

@interface CKSpeechSynthesizer()<IFlySpeechSynthesizerDelegate>

@property(nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@end

@implementation CKSpeechSynthesizer

-(void) speechSynthesize:(NSString *) message
{
    self.iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    //设置协议委托对象
    self.iFlySpeechSynthesizer.delegate = self;
    //设置合成参数
    //设置在线工作方式
    [self.iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置音量，取值范围 0~100
    [self.iFlySpeechSynthesizer setParameter:@"50"
                                      forKey: [IFlySpeechConstant VOLUME]];
    //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
    [self.iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                      forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [self.iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                      forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //启动合成会话
    [self.iFlySpeechSynthesizer startSpeaking: message];
}

- (void) pauseSpeaking {
    [self.iFlySpeechSynthesizer pauseSpeaking];
}

- (void) resumeSpeaking {
    [self.iFlySpeechSynthesizer resumeSpeaking];
}

- (void) stopSpeaking {
    [self.iFlySpeechSynthesizer stopSpeaking];
}

#pragma mark: - IFlySpeechSynthesizerDelegate

- (void) onCompleted:(IFlySpeechError*) error {
    NSLog(@"+++++++++++++++++++++ speech Error: %d : %d : %@", error.errorType, error.errorCode , error.errorDesc);
}

@end

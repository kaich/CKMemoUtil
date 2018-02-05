//
//  CKMenoSpeechRecognizer.h
//  CKMemoUtil
//
//  Created by mk on 2018/1/22.
//

#import <Foundation/Foundation.h>

@interface CKSpeechRecognizer : NSObject

@property(nonatomic, strong) NSString * audioPath;
@property(nonatomic, strong) NSData * audioData;
@property(nonatomic, copy) void (^completeBlock)(NSString *);

/*!
 *  开始识别
 *
 *  同时只能进行一路会话，这次会话没有结束不能进行下一路会话，否则会报错。若有需要多次回话，请在onError回调返回后请求下一路回话。
 *
 *  @return 成功返回YES；失败返回NO
 */
- (BOOL) startListening;

/*!
 *  停止录音<br>
 *  调用此函数会停止录音，并开始进行语音识别
 */
- (void) stopListening;

/*!
 *  取消本次会话
 */
- (void) cancel;

@end

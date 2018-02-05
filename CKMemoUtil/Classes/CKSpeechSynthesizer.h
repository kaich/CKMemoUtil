//
//  CKSpeechSynthesizer.h
//  CKMemoUtil
//
//  Created by mk on 2018/1/23.
//

#import <Foundation/Foundation.h>

@interface CKSpeechSynthesizer : NSObject

-(void) speechSynthesize:(NSString *) message;

- (void) pauseSpeaking;

- (void) resumeSpeaking;

- (void) stopSpeaking;

@end

//
//  CKMenoUtil.h
//  CKMemoUtil
//
//  Created by mk on 2018/1/22.
//

#import <Foundation/Foundation.h>
#import "CKSpeechRecognizer.h"
#import "CKSpeechSynthesizer.h"

typedef void(^CompressionSuccessBlock)(NSString* path, long long size);

@interface CKMenoUtil : NSObject

+(CKMenoUtil *) shared;

-(void) setup;

- (CKSpeechSynthesizer *) createSpeechSynthesizer;

- (CKSpeechRecognizer *) createSpeechRecognizer;

-(BOOL) compressWavePath:(NSString *) wavePath toPath:(NSString *) toPath;

- (void)compressedVideoOtherMethodWithURL:(NSURL *)url compressionType:(NSString *)compressionType compressionResultPath:(CompressionSuccessBlock)resultPathBlock;

@end

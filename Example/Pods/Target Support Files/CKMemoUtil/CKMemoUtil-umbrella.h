#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "amrFileCodec.h"
#import "interf_dec.h"
#import "interf_enc.h"
#import "dec_if.h"
#import "if_rom.h"
#import "VoiceConvert.h"
#import "CKMemoUtil.h"
#import "CKSpeechRecognizer.h"
#import "CKSpeechSynthesizer.h"
#import "NSString+ISR.h"

FOUNDATION_EXPORT double CKMemoUtilVersionNumber;
FOUNDATION_EXPORT const unsigned char CKMemoUtilVersionString[];


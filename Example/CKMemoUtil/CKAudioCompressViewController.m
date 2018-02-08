//
//  CKAudioCompressViewController.m
//  CKMemoUtil_Example
//
//  Created by mk on 2018/1/22.
//  Copyright © 2018年 chengkai1853@163.com. All rights reserved.
//

#import "CKAudioCompressViewController.h"
#import <AVKit/AVKit.h>
#import <CKMemoUtil/CKMemoUtil.h>

@interface CKAudioCompressViewController ()
{
    NSURL * _compressedURL;
    AVAudioPlayer * _player;
}
@property (weak, nonatomic) IBOutlet UILabel *lblWave;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end

@implementation CKAudioCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _compressedURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"compressed.amr"];
    
    NSString * wavePath = [[self waveURL] path];
    unsigned long long waveFileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:wavePath error:nil] fileSize];
    _lblWave.text = [NSString stringWithFormat:@"WAVE: %lld", waveFileSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *) waveURL {
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"wav"];
    return url;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)compress:(id)sender {
    NSString * wavePath = [[self waveURL] path];
    NSString * toPath = [_compressedURL path];
    [CKMemoUtil.shared compressWavePath:wavePath toPath:toPath];

    unsigned long long waveFileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:wavePath error:nil] fileSize];
    unsigned long long toFileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:toPath error:nil] fileSize];
    _lblWave.text = [NSString stringWithFormat:@"WAVE: %lld", waveFileSize];
    _lblResult.text = [NSString stringWithFormat:@"压缩完毕: %lld", toFileSize];
}



- (IBAction)playWave:(id)sender {
    NSURL * url = [self waveURL];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player play];
}

- (IBAction)playAmr:(id)sender {
    
}
@end

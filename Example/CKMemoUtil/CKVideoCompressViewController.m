//
//  CKVideoCompressViewController.m
//  CKMemoUtil_Example
//
//  Created by mk on 2018/2/8.
//  Copyright © 2018年 chengkai1853@163.com. All rights reserved.
//

#import "CKVideoCompressViewController.h"
#import <CKMemoUtil/CKMemoUtil.h>
#import <AVFoundation/AVFoundation.h>

@interface CKVideoCompressViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblOriginSize;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalSize;
@property(nonatomic,strong) NSURL * videoUrl;
@end

@implementation CKVideoCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickCompress:(id)sender {
    [self selectAction];
}

- (void)selectAction{
    
    NSLog(@"从相册选择");
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    
    picker.delegate=self;
    picker.allowsEditing=NO;
    picker.videoMaximumDuration = 1.0;//视频最长长度
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;//视频质量
    
    //媒体类型：@"public.movie" 为视频  @"public.image" 为图片
    //这里只选择展示视频
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie",nil];
    
    picker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.movie"]){
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
        NSLog(@"url %@",url);
        self.videoUrl = url;
        
        unsigned long long waveFileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:url.path error:nil] fileSize];
        self.lblOriginSize.text = [NSString stringWithFormat:@"Original: %lld", waveFileSize];
        
        [[CKMemoUtil shared] compressedVideoOtherMethodWithURL:url compressionType:AVAssetExportPresetLowQuality compressionResultPath:^(NSString *path, long long size) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lblFinalSize.text = [NSString stringWithFormat:@"Compressed: %lld", size];
            });
        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

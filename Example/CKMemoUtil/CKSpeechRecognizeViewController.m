//
//  CKSpeechRecognizeViewController.m
//  CKMemoUtil_Example
//
//  Created by mk on 2018/1/22.
//  Copyright © 2018年 chengkai1853@163.com. All rights reserved.
//

#import "CKSpeechRecognizeViewController.h"
#import <CKMemoUtil/CKMenoUtil.h>

@interface CKSpeechRecognizeViewController ()
@property(nonatomic, strong) CKSpeechRecognizer * recognizer;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@end

@implementation CKSpeechRecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)start:(id)sender {
    _tvContent.text = @"开始识别";
    self.recognizer = [CKMenoUtil.shared createSpeechRecognizer];
    __weak typeof(self) weakSelf = self;
    [self.recognizer setCompleteBlock:^(NSString * message) {
        weakSelf.tvContent.text = message;
    }];
    [self.recognizer startListening];
}

- (IBAction)stop:(id)sender {
    _tvContent.text = @"按住开始按钮进行识别";
//    [self.recognizer stopListening];
}

@end

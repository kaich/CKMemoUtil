//
//  CKSpeechSynthesizeViewController.m
//  CKMemoUtil_Example
//
//  Created by mk on 2018/1/22.
//  Copyright © 2018年 chengkai1853@163.com. All rights reserved.
//

#import "CKSpeechSynthesizeViewController.h"
#import <CKMemoUtil/CKMemoUtil.h>

@interface CKSpeechSynthesizeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tvMessage;
@property (strong, nonatomic) CKSpeechSynthesizer * speechSynthesizer;
@end

@implementation CKSpeechSynthesizeViewController

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
    self.speechSynthesizer = [[CKMemoUtil shared] createSpeechSynthesizer];
}

- (IBAction)stop:(id)sender {
    [self.speechSynthesizer pauseSpeaking];
}

@end

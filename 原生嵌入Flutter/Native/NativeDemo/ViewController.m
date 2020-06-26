//
//  ViewController.m
//  NativeDemo
//
//  Created by 王帅 on 2020/6/26.
//  Copyright © 2020 ws. All rights reserved.
//

//Flutter引擎!
/**

FlutterMethodChannel   //调用方法(method invocation) 一次通讯的
以下两种都是持续通讯的!!
   FlutterBasicMessageChannel //传递字符&半结构化的信息
   FlutterEventChannel        //用于数据链(stream)的通讯
*/


#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()
@property (nonatomic, strong) FlutterEngine *flutterEngine;
@property (nonatomic, strong) FlutterViewController *flutterVC;
@property (nonatomic, strong) FlutterBasicMessageChannel *messageChannel;
@end

@implementation ViewController

- (FlutterEngine *)flutterEngine {
    if (!_flutterEngine) {
        FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"hank"];
        if (flutterEngine.run) {
            _flutterEngine = flutterEngine;
        }
        [_flutterEngine run];
    }
    return _flutterEngine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.flutterVC = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
    
    self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"messageChannel" binaryMessenger:self.flutterVC];
    [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"接收到Flutter的:%@", message);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 0;
    [self.messageChannel sendMessage:[NSString stringWithFormat:@"%d", a++]];
}


- (IBAction)pushFlutter:(id)sender {
//    FlutterViewController *flutterVC = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
//    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
//    [flutterVC setInitialRoute:@"one"];
    
    
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"one_page" binaryMessenger:self.flutterVC];
    [methodChannel invokeMethod:@"one" arguments:nil];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [self presentViewController:self.flutterVC animated:YES completion:nil];
}

- (IBAction)pushFlutterTwo:(id)sender {
//    FlutterViewController *flutterVC = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
//    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
//    [flutterVC setInitialRoute:@"two"];
    
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"two_page" binaryMessenger:self.flutterVC];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [methodChannel invokeMethod:@"two" arguments:nil];
    [self presentViewController:self.flutterVC animated:YES completion:nil];
    
    
}
@end

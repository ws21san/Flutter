#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@interface AppDelegate ()

@property (nonatomic, strong) FlutterMethodChannel *methodChannel;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    FlutterViewController *flutterVC = (FlutterViewController *)self.window.rootViewController;
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"MethodChannelDemo" binaryMessenger:flutterVC];
    UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
    imageVC.delegate = self;
    //监听flutter消息
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"chooseImage"]) {
            if ([call.arguments isEqual:@"photo"]) {
                imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            if ([call.arguments isEqual:@"camera"]) {
                imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            [flutterVC presentViewController:imageVC animated:YES completion:nil];
        }
    }];
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *imagePath = [NSString stringWithFormat:@"%@", info[@"UIImagePickerControllerImageURL"]];
        [self.methodChannel invokeMethod:@"imagePath" arguments:imagePath];
    }];
}

@end

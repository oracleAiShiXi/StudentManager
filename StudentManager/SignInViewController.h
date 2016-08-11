//
//  SignInViewController.h
//  StudentManager
//
//  Created by newmac on 16/8/3.
//  Copyright © 2016年 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UIButton *again;

- (IBAction)afresh:(id)sender;


- (IBAction)upload:(id)sender;

@end

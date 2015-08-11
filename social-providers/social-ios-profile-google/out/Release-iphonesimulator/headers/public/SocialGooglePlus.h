/*
 Copyright (C) 2012-2014 Soomla Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "IAuthProvider.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface SocialGooglePlus : NSObject<IAuthProvider, GIDSignInDelegate, GIDSignInUIDelegate>{
    loginSuccess loginSuccess;
    loginFail loginFail;
    loginCancel loginCancel;
    logoutSuccess logoutSuccess;
    logoutFail logoutFail;
    userProfileSuccess userProfileSuccess;
    userProfileFail userProfileFail;
}

@property (strong, nonatomic) loginSuccess loginSuccess;
@property (strong, nonatomic) loginFail loginFail;
@property (strong, nonatomic) loginCancel loginCancel;
@property (strong, nonatomic) logoutSuccess logoutSuccess;
@property (strong, nonatomic) logoutFail logoutFail;
@property (strong, nonatomic) userProfileSuccess userProfileSuccess;
@property (strong, nonatomic) userProfileFail userProfileFail;
@property (strong, nonatomic, readonly) NSString *clientId;

@end

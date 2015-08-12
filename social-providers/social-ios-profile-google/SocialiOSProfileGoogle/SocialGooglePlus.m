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

#import "SocialGooglePlus.h"
#import "UserProfile.h"
#import "SocialUtils.h"

@interface SocialGooglePlus ()
@property(nonatomic, strong) id lastPageToken;
@end

@implementation SocialGooglePlus

@synthesize loginSuccess, loginFail, loginCancel, logoutSuccess, logoutFail, userProfileSuccess, userProfileFail, clientId;

static NSString *TAG = @"SOCIAL SocialGooglePlus";

- (id)init{
    self = [super init];
    
    if (!self)
        return nil;
    
    //subscribe to notification from unity via UnityAppController AppController_SendNotificationWithArg(kUnityOnOpenURL, notifData)
    LogDebug(TAG, @"addObserver kUnityOnOpenURL notification");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(innerHandleOpenURL:)
                                                 name:@"kUnityOnOpenURL"
                                               object:nil];
    
    return self;
}

- (void)applyParams:(NSDictionary *)providerParams{
    if (providerParams){
        clientId = [providerParams objectForKey:@"clientId"];
    }
}

- (void)login:(loginSuccess)success fail:(loginFail)fail cancel:(loginCancel)cancel{
    LogDebug(TAG, @"Login");
    
    [self setLoginBlocks:success fail:fail cancel:cancel];
    
    NSString *authParamsCheckResult = [self checkAuthParams];
    
    if (authParamsCheckResult){
        fail([NSString stringWithFormat:@"Authentication params check failed: %@", authParamsCheckResult]);
        return;
    }
    
    [self startGooglePlusAuth];
}

- (void)startGooglePlusAuth{
    LogDebug(TAG,@"startGooglePlusAuth");
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    //NSArray* scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,kGTLAuthScopePlusUserinfoProfile, nil];
    
    signIn.shouldFetchBasicProfile = YES;
    signIn.allowsSignInWithBrowser = NO;
    signIn.clientID = self.clientId;
    //signIn.scopes = scopes;
    
    signIn.delegate = self;
    signIn.uiDelegate = self;
    [signIn signIn];
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    LogDebug(TAG,@"signIn: didSignInForUser: withError:");
    if (error) {
        if ([error code] == -1)
            self.loginCancel();
        else
            self.loginFail([error localizedDescription]);
    }else {
        [self reportAuthStatus];
    }
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    LogDebug(TAG,@"signIn: didDisconnectWithUser: withError:");
    if (error) {
         self.logoutFail([error localizedDescription]);
    } else {
        [self clearLoginBlocks];
        [self clearUserProfileBlocks];
        self.logoutSuccess();
        [self reportAuthStatus];
    }
}

/** Google Sign-In SDK
 @date July 19, 2015
 */
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    LogDebug(TAG,@"signIn: presentViewController:");
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:viewController animated:YES completion:nil];
}

/** Google Sign-In SDK
 @date July 19, 2015
 */
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    LogDebug(TAG,@"signIn: dismissViewController:");
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper methods

- (void)reportAuthStatus {
    LogDebug(TAG,@"reportAuthStatus");
    GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    if (googleUser.authentication != nil) {
        self.loginSuccess(GOOGLE);
    } else {
        self.loginFail(@"GooglePlus Authentication failed.");
        [self clearLoginBlocks];
        [self clearUserProfileBlocks];
    }
}

// Update the interface elements containing user data to reflect the
// currently signed in user.
- (void)refreshUserInfo {
    LogDebug(TAG,@"refreshUserInfo");
    GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    if (googleUser.authentication != nil) {
        LogDebug(TAG,@"parseGoogleContact");
        NSString* displayName = googleUser.profile.name;
        NSString* firstName, *lastName;

        if (displayName)
        {
            NSArray *names = [displayName componentsSeparatedByString:@" "];
            if (names && ([names count] > 0)) {
                firstName = names[0];
                if ([names count] > 1) {
                    lastName = names[1];
                }
            }
        }
  
        UserProfile * userProfile = [[UserProfile alloc] initWithProvider:GOOGLE
                                                             andProfileId:googleUser.userID
                                                              andUsername:@""
                                                                 andEmail:googleUser.profile.email
                                                             andFirstName:firstName
                                                              andLastName:lastName];
        
        if (googleUser.profile.hasImage)
        {
            NSUInteger dimension = round(50 * 50);
            NSURL *imageURL = [googleUser.profile imageURLWithDimension:dimension];
            userProfile.username = @"";
            userProfile.avatarLink = [imageURL absoluteString];
        }
        
        self.userProfileSuccess(userProfile);
    }else{
        LogError(TAG, @"Failed getting user profile");
        self.userProfileFail(@"Failed getting user profile");
        return;
    }
}

- (void)getUserProfile:(userProfileSuccess)success fail:(userProfileFail)fail{
    LogDebug(TAG, @"getUserProfile");
    [self setUserProfileBlocks:success fail:fail];
    [self refreshUserInfo];
}

- (void)logout:(logoutSuccess)success fail:(logoutFail)fail{
    LogDebug(TAG, @"logout");
    self.logoutSuccess = success;
    self.logoutFail = fail;
    [[GIDSignIn sharedInstance] disconnect];
}

- (void)getAccessToken:(accessTokenSuccess)success fail:(accessTokenFail)fail cancel:(accessTokenCancel)cancel{
    LogDebug(TAG, @"getAccessToken");

    if ([self isLoggedIn]) {
        //NSString *accessToken = GIDSignIn.sharedInstance.currentUser.authentication.accessToken;
        NSString *accessToken = [[GIDSignIn sharedInstance] currentUser].authentication.accessToken;
        success(accessToken);
    } else {
        fail(@"Get access token failed");
    }

}

- (BOOL)isLoggedIn{
    LogDebug(TAG, @"isLoggedIn");
    return ([[GIDSignIn sharedInstance] currentUser].authentication != nil);
}

- (BOOL)tryHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [[GIDSignIn sharedInstance] handleURL:url
           sourceApplication:sourceApplication
                         annotation:annotation];
}

- (Provider)getProvider {
    return GOOGLE;
}

-(void)setLoginBlocks:(loginSuccess)success fail:(loginFail)fail cancel:(loginCancel)cancel{
    self.loginSuccess = success;
    self.loginFail = fail;
    self.loginCancel = cancel;
}

- (void)clearLoginBlocks {
    self.loginSuccess = nil;
    self.loginFail = nil;
    self.loginCancel = nil;
}

-(void)setUserProfileBlocks:(userProfileSuccess)success fail:(userProfileFail)fail{
    self.userProfileSuccess = success;
    self.userProfileFail = fail;
}

- (void)clearUserProfileBlocks {
    self.userProfileSuccess = nil;
    self.userProfileFail = nil;}

- (NSString *)checkAuthParams{
    if (!clientId)
        return @"Missing client id";
    return nil;
}

- (void)innerHandleOpenURL:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"kUnityOnOpenURL"]) {
        LogDebug(TAG, @"Successfully received the kUnityOnOpenURL notification!");
        
        NSURL *url = [[notification userInfo] valueForKey:@"url"];
        NSString *sourceApplication = [[notification userInfo] valueForKey:@"sourceApplication"];
        id annotation = [[notification userInfo] valueForKey:@"annotation"];
        BOOL urlWasHandled = [[GIDSignIn sharedInstance] handleURL:url
                                    sourceApplication:sourceApplication
                                           annotation:annotation];
        
        LogDebug(TAG,
                 ([NSString stringWithFormat:@"urlWasHandled: %@",
                   urlWasHandled ? @"True" : @"False"]));
    }
}

- (void)dealloc {
    LogDebug(TAG, @"removeObserver kUnityOnOpenURL notification");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

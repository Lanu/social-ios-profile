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

#import "SocialProfile.h"
#import "AuthController.h"
#import "UserProfileUtils.h"
#import "ProfileEventHandling.h"
#import "UserProfileNotFoundException.h"
#import "UserProfileStorage.h"
#import "SocialUtils.h"
#import "AccessTokenStorage.h"

#import <UIKit/UIKit.h>

// if using Unity social provider this is YES
BOOL UsingExternalProvider;

@implementation SocialProfile

static NSString *TAG = @"SOCIAL SOCIALIOSPROFILE";

+ (void)usingExternalProvider:(BOOL)isExternal {
    
    UsingExternalProvider = isExternal;
}

+ (BOOL)isUsingExternalProvider {
    return UsingExternalProvider;
}

- (void)initialize {
    [self initialize:nil];
}

- (void)initialize:(NSDictionary *)customParams {
    if (UsingExternalProvider) {
        authController = [[AuthController alloc] initWithoutLoadingProviders];
    }
    else {
        authController = [[AuthController alloc] initWithParameters:customParams];
    }
    
    [ProfileEventHandling postProfileInitialized];
}

- (void)loginWithProvider:(Provider)provider {
    [self loginWithProvider:provider andPayload:@""];
}

- (void)loginWithProvider:(Provider)provider andPayload:(NSString *)payload {
    @try {
        [authController loginWithProvider:provider andPayload:payload];
    }
    @catch (NSException *exception) {
        LogError(TAG, ([NSString stringWithFormat:@"loginWithProvider error: %@", exception.description]));
    }
}

- (void)logoutWithProvider:(Provider)provider {
    @try {
        [authController logoutWithProvider:provider];
    }
    @catch (NSException *exception) {
        LogError(TAG, ([NSString stringWithFormat:@"logoutWithProvider error: %@", exception.description]));
    }
}

- (BOOL)isLoggedInWithProvider:(Provider)provider {
    @try {
        return [authController isLoggedInWithProvider:provider];
    }
    @catch (NSException *exception) {
        LogError(TAG, ([NSString stringWithFormat:@"isLoggedInWithProvider error: %@", exception.description]));
    }
}

- (void)getAccessTokenWithProvider:(Provider)provider andRequestNew:(BOOL)requestNew andPayload:(NSString *)payload andCallback:(GPTokenSuccessCallback)callback{
    @try {
        [authController getAccessTokenWithProvider:provider andRequestNew:requestNew andPayload:payload andCallback:callback];
    }
    @catch (NSException *exception) {
        LogError(TAG, ([NSString stringWithFormat:@"getAccessTokenWithProvider error: %@", exception.description]));
    }
}

- (UserProfile *)getStoredUserProfileWithProvider:(Provider)provider {
    @try {
        return [authController getStoredUserProfileWithProvider:provider];
    }
    @catch (NSException *exception) {
        LogError(TAG, ([NSString stringWithFormat:@"getStoredUserProfileWithProvider error: %@", exception.description]));
    }
}

- (NSArray *)getStoredUserProfiles {
    NSArray* providers = [UserProfileUtils availableProviders];
    NSMutableArray* userProfiles = [NSMutableArray array];
    for(NSNumber* providerNum in providers) {
        @try {
            UserProfile* userProfile = [UserProfileStorage getUserProfile:(Provider)[providerNum intValue]];
            if (userProfile) {
                [userProfiles addObject:userProfile];
            }
        }@catch (NSException *exception) {
            // Skip
        }
    }
    return userProfiles;
}

- (BOOL)tryHandleOpenURL:(Provider)provider openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [authController tryHandleOpenURL:provider openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)tryHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [authController tryHandleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

// private

+ (SocialProfile*)getInstance {
    static SocialProfile* _instance = nil;
    
    @synchronized( self ) {
        if( _instance == nil ) {
            _instance = [[SocialProfile alloc ] init];
        }
    }
    
    return _instance;
}

@end

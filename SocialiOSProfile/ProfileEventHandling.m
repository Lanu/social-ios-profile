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

#import "ProfileEventHandling.h"
#import "UserProfile.h"


@implementation ProfileEventHandling

+ (void)observeAllEventsWithObserver:(id)observer withSelector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_PROFILE_INITIALIZED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_USER_PROFILE_UPDATED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_ACCESS_TOKEN_UPDATED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGIN_STARTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGIN_FINISHED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGIN_CANCELLED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGIN_FAILED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGOUT_STARTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGOUT_FINISHED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_LOGOUT_FAILED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_GET_ACCESSTOKEN_STARTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_GET_ACCESSTOKEN_FINISHED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_GET_ACCESSTOKEN_CANCELLED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:EVENT_UP_GET_ACCESSTOKEN_FAILED object:nil];
}

+ (void)postProfileInitialized {
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_PROFILE_INITIALIZED object:self userInfo:@{}];
}

+ (void)postUserProfileUpdated:(UserProfile *)userProfile {
    NSDictionary *userInfo = @{DICT_ELEMENT_USER_PROFILE: userProfile};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_USER_PROFILE_UPDATED object:self userInfo:userInfo];
}

+ (void)postAccessTokenUpdated:(Provider)provider andAccessToken:(NSString *)accessToken {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_ACCESSTOKEN: accessToken};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_ACCESS_TOKEN_UPDATED object:self userInfo:userInfo];
}

+ (void)postLoginStarted:(Provider)provider withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: [NSNumber numberWithInt:provider], DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGIN_STARTED object:self userInfo:userInfo];
}

+ (void)postLoginFinished:(UserProfile *)userProfile withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_USER_PROFILE: userProfile, DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGIN_FINISHED object:self userInfo:userInfo];
}

+ (void)postLoginCancelled:(Provider)provider withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGIN_CANCELLED object:self userInfo:userInfo];
}

+ (void)postLoginFailed:(Provider)provider withMessage:(NSString *)message withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_MESSAGE: message, DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGIN_FAILED object:self userInfo:userInfo];
}

+ (void)postLogoutStarted:(Provider)provider {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider)};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGOUT_STARTED object:self userInfo:userInfo];
}

+ (void)postLogoutFinished:(Provider)provider {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider)};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGOUT_FINISHED object:self userInfo:userInfo];
}

+ (void)postLogoutFailed:(Provider)provider withMessage:(NSString *)message {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_MESSAGE: message};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_LOGOUT_FAILED object:self userInfo:userInfo];
}

+ (void)postGetAccessTokenStarted:(Provider)provider withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER:[NSNumber numberWithInt:provider], DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_GET_ACCESSTOKEN_STARTED object:self userInfo:userInfo];
}

+ (void)postGetAccessTokenFinished:(Provider)provider withAccessToken:(NSString *)accessToken withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER:[NSNumber numberWithInt:provider], DICT_ELEMENT_ACCESSTOKEN: accessToken, DICT_ELEMENT_PAYLOAD: payload};

    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_GET_ACCESSTOKEN_FINISHED object:self userInfo:userInfo];
}

+ (void)postGetAccessTokenCancelled:(Provider)provider withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_GET_ACCESSTOKEN_CANCELLED object:self userInfo:userInfo];
}

+ (void)postGetAccessTokenFailed:(Provider)provider withMessage:(NSString *)message withPayload:(NSString *)payload {
    NSDictionary *userInfo = @{DICT_ELEMENT_PROVIDER: @(provider), DICT_ELEMENT_MESSAGE: message, DICT_ELEMENT_PAYLOAD: payload};
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_UP_GET_ACCESSTOKEN_FAILED object:self userInfo:userInfo];
}
@end

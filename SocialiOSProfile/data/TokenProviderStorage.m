//
//  TokenProviderStorage.m
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "TokenProviderStorage.h"
#import "TokenProvider.h"
#import "ProfileEventHandling.h"
#import "KeyValueStorage.h"
#import "SocialUtils.h"

@implementation TokenProviderStorage

static NSString* DB_KEY_PREFIX  = @"social.profile.";
static NSString* TAG            = @"SOCIAL TokenProviderStorage";


+ (void)setTokenProvider:(TokenProvider *)tokenProvider {
    [self setTokenProvider:tokenProvider andNotify:YES];
}

+ (void)setTokenProvider:(TokenProvider *)tokenProvider andNotify:(BOOL)notify {
    
    NSString* value = [SocialUtils dictToJsonString:[tokenProvider toDictionary]];
    NSString* key = [self keyTokenProvider:tokenProvider.provider];
    [KeyValueStorage setValue:value forKey:key];
    if (notify) {
        [ProfileEventHandling postTokenProviderUpdated:tokenProvider];
    }
}

+ (void)removeTokenProvider:(TokenProvider *)tokenProvider {
    NSString* key = [self keyTokenProvider:tokenProvider.provider];
    [KeyValueStorage deleteValueForKey:key];
}

+ (TokenProvider *)getTokenProvider:(Provider)provider {
    
    NSString* key = [self keyTokenProvider:provider];
    NSString* tokenProviderJSON = [KeyValueStorage getValueForKey:key];
    if (!tokenProviderJSON || [tokenProviderJSON length] == 0) {
        return nil;
    }
    
    NSDictionary* tokenProviderDict = [SocialUtils jsonStringToDict:tokenProviderJSON];
    TokenProvider* tokenProvider = [[TokenProvider alloc] initWithDictionary:tokenProviderDict];
    return tokenProvider;
}

+ (NSString *)keyTokenProvider:(Provider)provider {
    return [NSString stringWithFormat:@"%@tokenProvider.%@", DB_KEY_PREFIX, [UserProfileUtils providerEnumToString:provider]];
}

@end

//
//  Typedefs.h
//  SocialiOSProfile
//
//  Created by Banu on 21/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#ifndef SocialiOSProfile_Typedefs_h
#define SocialiOSProfile_Typedefs_h

// Because the world needs one more boolean type
// (and because we have to guarantee that this boolean type is 4 bytes long, as expected
// by C#)
typedef int32_t GPBOOL;  // 4 bytes
#define GPTRUE 1
#define GPFALSE 0


// Callback type for success/failure
typedef void (*GPTokenSuccessCallback)(GPBOOL success, const char *token, const char *provider, const char *payload);


#endif

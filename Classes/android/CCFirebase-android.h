//
//  CCFirebase-android.h
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#ifndef CCFirebase_android_h
#define CCFirebase_android_h

#include <memory>
#include <string>
#include <vector>

#include "CCFirebase.h"

namespace oke_ya{

class FirebaseAndroid : public Firebase
{
    virtual void showAds() const override;
};

}

#endif /* CCFirebase_android_h */

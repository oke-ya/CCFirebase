//
//  CCFirebase-ios.h
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#ifndef CCFirebase_ios_h
#define CCFirebase_ios_h

#include <memory>
#include <string>
#include <vector>

#include "CCFirebase.h"

namespace oke_ya{

class FirebaseIos : public Firebase
{
    virtual void showAds() const override;
};

}

#endif /* CCFirebase_ios_h */

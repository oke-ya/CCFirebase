//
//  CCFirebase.cpp
//  CCFirebase
//
//  Created by Atsushi Yoshida on 2016/08/23.
//
//

#include "CCFirebase.h"

namespace oke_ya{

Firebase* Firebase::s_sharedFirebase = nullptr;

bool Firebase::init()
{
    return true;
}

}
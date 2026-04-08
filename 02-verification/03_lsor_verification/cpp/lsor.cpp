#include "Hector.h"
#include <stdint.h>
#include <cmath>
#include <algorithm>

int DPV_wrapper () {
    uint64_t x,x_no_lso;
    Hector::registerInput ("x", x);
    Hector::registerOutput ("x_no_lso", x_no_lso);

    Hector::beginCapture();
    x_no_lso = x & (x - 1);
    Hector::endCapture();
    
    return 0;
}

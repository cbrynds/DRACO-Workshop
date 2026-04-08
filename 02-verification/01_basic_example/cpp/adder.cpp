#include "Hector.h"
#include <stdint.h>
#include <cmath>
#include <algorithm>

int DPV_wrapper () {
    uint64_t x,y,cin,sum;
    Hector::registerInput ("x", x);
    Hector::registerInput ("y", y);
    Hector::registerInput ("cin", cin);
    Hector::registerOutput ("sum", sum);

    Hector::beginCapture();
    sum = x + y + cin;
    Hector::endCapture();
    return 0;
}


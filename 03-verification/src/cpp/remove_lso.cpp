#include "Hector.h"
#include <stdint.h>
#include <cmath>
#include <algorithm>

void remove_lso(uint64_t x, uint64_t &x_no_lso) {
    x_no_lso = x & (x - 1);
}       

int DPV_wrapper () {
    uint64_t x,x_no_lso;
    Hector::registerInput ("x", x);
    Hector::registerOutput ("x_no_lso", x_no_lso);

    Hector::beginCapture();
    remove_lso(x, x_no_lso);
    Hector::endCapture();
    return 0;
}

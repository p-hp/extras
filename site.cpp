#define _CRT_SECURE_NO_WARNINGS
#pragma GCC Optimize("Ofast")
#include <iostream>
#include <vector>
#include <set>
#include <string>
#include <time.h>
#include <unordered_set>
#include <map>
#include <queue>
#include <algorithm>
#include <fstream>
#include <cstddef>
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
using namespace std;
 
#define vi vector<int>
#define vec vector
int c[1024];
int go(vi& a) {
    int r = 0;
    for (int i = 0; i < a.size(); ++i)
        r += (1 << (a[i] - 1));
    return r;
}
int code(vi& a) {
    int r = go(a);
    return c[r];
}
 
int decode(vi& a) {
    int r = go(a);
    for (auto& e : a) {
        int w = r ^ (1 << (e - 1));
        if (e == c[w]) {
            return e;
        }
    }
}
 
int popcount(int x) {
    int r = 0;
    while (x) r += x & 1, x >>= 1;
    return r;
}
 
int gen(int x, int nq = -1) {
    for (int i = 0; i < 10; ++i)
        if (!((1 << i) & x) && i != nq) {
            int cnt = 0;
            c[x] = i + 1;
            for (int j = 0; j < 10; ++j)
                if ((1 << j) & x) {
                    int nw = (1 << i) | (x ^ (1 << j));
                    if (!c[nw])
                        c[nw] = gen(nw, j);
                    if (c[nw] != j + 1)
                        cnt++;
                }
            if (cnt == 3)
                return i + 1;
        }
}
 
int main() {
    vi x;
    for (int i = 0; i < 1024; ++i) {
        if (popcount(i) == 3) {
            c[i] = gen(i);
        }
    }
    for (int i = 0; i < 1024; ++i) {
        if (popcount(i) == 3) {
            vi a;
            for (int j = 0; j < 10; ++j)
                if ((1 << j) & i) a.push_back(j + 1);
            int v = code(a);
            a.push_back(v);
            if (v != decode(a)) {
                v = v; cout << "err"; exit(-1);
            }
        }
    }
}

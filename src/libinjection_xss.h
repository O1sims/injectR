#ifndef LIBINJECTION_XSS
#define LIBINJECTION_XSS

#ifdef __cplusplus
extern "C" {
#endif

#include <string.h>

  int libinjection_is_xss(const char* s, size_t len, int flags);
  int libinjection_xss(const char** s, int *len, int *b);
  
#ifdef __cplusplus
}
#endif
#endif

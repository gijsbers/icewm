#include "config.h"
#include "ykey.h"
#include "sysdep.h"

#include "bindkey.h"
#include "default.h"
#define CFGDEF
#define CFGDESC
#define GENPREF
#include "bindkey.h"
#include "default.h"

#include "intl.h"

int main() {
    unsigned int i;

    printf(_("# preferences(%s) - generated by genpref\n\n"), VERSION);
    printf(_("# NOTE: All settings are commented out by default, be sure to\n"
             "        uncomment them if you change them!\n\n"));

#ifndef NO_CONFIGURE
    for (i = 0; i < ACOUNT(bool_options); i++) {
        if (bool_options[i].description)
            printf("#  %s\n", bool_options[i].description);
        printf("# %s=%d # 0/1\n",
               bool_options[i].option, (*bool_options[i].value) ? 1 : 0);
        if (bool_options[i].description)
            puts("");
    }
    puts("");
    for (i = 0; i < ACOUNT(uint_options); i++) {
        if (uint_options[i].description)
            printf("# %s\n", uint_options[i].description);
        printf("# %s=%d # [%d-%d]\n",
               uint_options[i].option, *uint_options[i].value,
               uint_options[i].min, uint_options[i].max);
        if (uint_options[i].description)
            puts("");
    }
    puts("");
    for (i = 0; i < ACOUNT(string_options); i++) {
        if (string_options[i].description && string_options[i].description[0])
            printf("# %s\n", string_options[i].description);
        /// !!! fix strings to be escaped (C style)
        printf("# %s=\"%s\"\n",
               string_options[i].option,
               (*string_options[i].value) ? (*string_options[i].value) : "");
        if (string_options[i].description && string_options[i].description[0])
            puts("");
    }
    puts("");
#ifndef NO_KEYBIND
    for (i = 0; i < ACOUNT(key_options); i++) {
        if (key_options[i].description && key_options[i].description[0])
            printf("# %s\n", key_options[i].description);

        WMKey *key = key_options[i].value;

        printf("# %s=\"%s\"\n", key_options[i].option, key->name);
        if (key_options[i].description && key_options[i].description[0])
            puts("");
    }
#endif
    puts("");

    // special case, for now
    puts("WorkspaceNames=\" 1 \", \" 2 \", \" 3 \", \" 4 \"");
#endif
}

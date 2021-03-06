/*
 * See Licensing and Copyright notice in naev.h
 */



#ifndef WGT_TABWIN_H
#  define WGT_TABWIN_H


/**
 * @brief The button widget.
 */
typedef struct WidgetTabbedWindowData_ {
   int ntabs; /**< Number of tabs. */
   char **tabnames; /**< Names of the tabs. */
   unsigned int *windows; /**< Window IDs. */
   int active; /**< Currently active window. */

   /* Internal usage. */
   int *namelen;
   void(*onChange)(unsigned int,char*,int);
} WidgetTabbedWindowData;


/* Required functions. */
unsigned int* window_addTabbedWindow( const unsigned int wid,
      const int x, const int y, /* position */
      const int w, const int h, /* size */
      const char* name, int ntabs, const char **tabnames );


int window_tabWinSetActive( const unsigned int wid, const char *tab, int active );
int window_tabWinOnChange( const unsigned int wid, const char *tab,
      void(*onChange)(unsigned int,char*,int) );


#endif /* WGT_TABWIN_H */


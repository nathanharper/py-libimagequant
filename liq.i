%module liq
%{
#include "lib/libimagequant.h"
#include "lib/mempool.h"
#include "lib/pam.h"
#include "lib/mediancut.h"
#include "lib/nearest.h"
#include "lib/blur.h"
#include "lib/viter.h"
%}

typedef struct liq_attr liq_attr;
typedef struct liq_image liq_image;
typedef struct liq_result liq_result;

typedef struct liq_color {
    unsigned char r, g, b, a;
} liq_color;

typedef struct liq_palette {
    unsigned int count;
    liq_color entries[256];
} liq_palette;

typedef enum liq_error {
    LIQ_OK = 0,
    LIQ_VALUE_OUT_OF_RANGE = 100,
    LIQ_OUT_OF_MEMORY,
    LIQ_NOT_READY,
    LIQ_BITMAP_NOT_AVAILABLE,
    LIQ_BUFFER_TOO_SMALL,
    LIQ_INVALID_POINTER,
} liq_error;

enum liq_ownership {LIQ_OWN_ROWS=4, LIQ_OWN_PIXELS=8};

liq_attr* liq_attr_create(void);
liq_attr* liq_attr_create_with_allocator(void* (*malloc)(size_t), void (*free)(void*));
liq_attr* liq_attr_copy(liq_attr *orig);
void liq_attr_destroy(liq_attr *attr);

liq_error liq_set_max_colors(liq_attr* attr, int colors);
liq_error liq_set_speed(liq_attr* attr, int speed);
liq_error liq_set_min_opacity(liq_attr* attr, int min);
liq_error liq_set_quality(liq_attr* attr, int minimum, int maximum);
void liq_set_last_index_transparent(liq_attr* attr, int is_last);

typedef void liq_log_callback_function(const liq_attr*, const char *message, void* user_info);
typedef void liq_log_flush_callback_function(const liq_attr*, void* user_info);
void liq_set_log_callback(liq_attr*, liq_log_callback_function*, void* user_info);
void liq_set_log_flush_callback(liq_attr*, liq_log_flush_callback_function*, void* user_info);

liq_image *liq_image_create_rgba_rows(liq_attr *attr, void* rows[], int width, int height, double gamma);
liq_image *liq_image_create_rgba(liq_attr *attr, void* bitmap, int width, int height, double gamma);

typedef void liq_image_get_rgba_row_callback(liq_color row_out[], int row, int width, void* user_info);
liq_image *liq_image_create_custom(liq_attr *attr, liq_image_get_rgba_row_callback *row_callback, void* user_info, int width, int height, double gamma);

liq_error liq_image_set_memory_ownership(liq_image *image, int ownership_flags);
int liq_image_get_width(const liq_image *img);
int liq_image_get_height(const liq_image *img);

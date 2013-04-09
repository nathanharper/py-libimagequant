#include "Python.h"
#include "lib/libimagequant.h"

/* Docstrings */
static char module_docstring[] =
    "A Python wrapper for libimagequant.";
/* static char attr_create_docstring[] = */
/*     "Create object to hold initial settings."; */

/* The main liq_attr object */
struct liq_attr MY_ATTR = {};
/* static liq_attr *MY_ATTR; */
         
/* Available functions */
static PyObject *attr_create(PyObject *self, PyObject *args);
static PyObject *attr_destroy(PyObject *self, PyObject *args);
static PyObject *set_max_colors(PyObject *self, PyObject *args);

static PyObject *attr_create(PyObject *self, PyObject *args)
{
    MY_ATTR = liq_attr_create();
    if (MY_ATTR == NULL) return NULL;
    return Py_BuildValue("");
}

static PyObject *attr_destroy(PyObject *self, PyObject *args)
{
    liq_attr_destroy(MY_ATTR);
    return Py_BuildValue("");
}

static PyObject *set_max_colors(PyObject *self, PyObject *args)
{
    if (MY_ATTR == NULL) return NULL;
    int colors;
    if(PyArg_ParseTuple(args, "i", &colors)) {
        if (liq_set_max_colors(MY_ATTR, colors) == LIQ_VALUE_OUT_OF_RANGE)
            return Py_BuildValue("");
    }
    /* return Py_BuildValue(""); */
    return Py_BuildValue("i", MY_ATTR.max_colors);
}

static PyObject *set_quality(PyObject *self, PyObject *args)
{
    int minimum, maximum;
    if(!PyArg_ParseTuple(args, "ii", &minimum, &maximum)) {
        return NULL;
    }
    if(liq_set_quality(MY_ATTR, minimum, maximum) == LIQ_VALUE_OUT_OF_RANGE) {
        return Py_BuildValue("");
    }
    /* return Py_BuildValue(""); */
    return Py_BuildValue("i", MY_ATTR.max_colors);
}

static PyMethodDef QuantMethods[] = {
    {"attr_create", attr_create, METH_VARARGS, "Python bindings for libimagequant"},
    {"attr_destroy", attr_destroy, METH_VARARGS, "Python bindings for libimagequant"},
    {"set_max_colors", set_max_colors, METH_VARARGS, "Python bindings for libimagequant"},
    {NULL, NULL, 0, NULL}
};
 
PyMODINIT_FUNC
init_liq(void)
{
    PyObject *m = Py_InitModule3("_liq", QuantMethods, module_docstring);
    if (m == NULL)
        return;
    /* (void) Py_InitModule("liq", QuantMethods); */
}

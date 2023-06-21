/// Separate module to not accidentally run the preprocessor on these methods
module python.statics;

import python.c;

extern(C):

// static inline function in the header
int Py_IS_TYPE(const PyObject *ob, const PyTypeObject *type) @safe @nogc pure nothrow {
    return ob.ob_type == type;
}

PyTypeObject* Py_TYPE_(PyObject *ob) @safe @nogc pure nothrow {
    return ob.ob_type;
}

// the check is here since this doesn't exist in Python 3.8
static if(is(typeof(Py_IS_TYPE(null, null)))) {
    // copied from 3.10 object.h
    int PyObject_TypeCheck_(PyObject *ob, PyTypeObject *type) @trusted nothrow {
        return Py_IS_TYPE(ob, type) || PyType_IsSubtype(( ( cast( PyObject * ) ( ob ) ) . ob_type ), type);
    }

    // translation fails here still
    alias PyObject_TypeCheck = PyObject_TypeCheck_;
}

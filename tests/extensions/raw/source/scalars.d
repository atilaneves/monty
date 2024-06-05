import python.c;


extern(C) nothrow @nogc:


PyObject* theAnswer(PyObject* self, PyObject *args) {
    return PyLong_FromUnsignedLong(42UL);
}

PyObject* alwaysTrue(PyObject *self, PyObject* args) {
    return Py_True;
}

PyObject* alwaysFalse(PyObject *self, PyObject* args) {
    return Py_False;
}

import python.c;


extern(C) nothrow @nogc:


PyObject* theAnswer(PyObject* self, PyObject *args) {
    return PyLong_FromUnsignedLong(42UL);
}

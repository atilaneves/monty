import python.c;


extern(C) nothrow @nogc:


PyObject* the_answer(PyObject* self, PyObject *args) {
    return PyLong_FromUnsignedLong(42UL);
}

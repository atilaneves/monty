import python.c;

import scalars: theAnswer;

extern(C) nothrow:

export PyObject* PyInit_raw() {

    import core.runtime: rt_init;

    try
        rt_init;
    catch(Exception _)
        return null;

    static PyMethodDef[1 + 1] methods;
    methods = [
        PyMethodDef("the_answer", &theAnswer, METH_VARARGS, "The answer to the ultimate question"),
        PyMethodDef(null, null, 0, null), // sentinel
    ];

    static PyModuleDef moduleDef;
    moduleDef = PyModuleDef(
        pyModuleDefHeadInit(),
        "raw",
        null, // doc
        -1, // global state
        &methods[0],
    );

    return PyModule_Create(&moduleDef);
}

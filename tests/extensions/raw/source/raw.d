import python.c;


extern(C) nothrow:

export PyObject* PyInit_raw() {

    import core.runtime: rt_init;
    import scalars;
    import udt;

    try
        rt_init;
    catch(Exception _)
        return null;

    pyDateTimeImport;

    enum numMethods = 5;
    static PyMethodDef[numMethods + 1] methods;
    methods = [
        PyMethodDef("the_answer",      &theAnswer,   METH_VARARGS, "The answer to the ultimate question"),
        PyMethodDef("always_true",     &alwaysTrue,  METH_VARARGS, "Truthiness"),
        PyMethodDef("always_false",    &alwaysFalse, METH_VARARGS, "Falsiness"),
        PyMethodDef("struct_func_new", &struct_func_new, METH_VARARGS, "returns struct"),
        PyMethodDef("struct_func_old", &struct_func_old, METH_VARARGS, "returns struct"),
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

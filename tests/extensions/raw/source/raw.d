import python.c;


extern(C) nothrow:

export PyObject* PyInit_raw() {

    import core.runtime: rt_init, rt_term;
    import scalars;
    import udt;

    try
        rt_init;
    catch(Exception _)
        assert(0, "DRuntime initialization should never fail.");

    pyDateTimeImport;

    enum numMethods = 4;
    static PyMethodDef[numMethods + 1] methods;
    methods = [
        PyMethodDef("the_answer",      &theAnswer,   METH_VARARGS, "The answer to the ultimate question"),
        PyMethodDef("always_true",     &alwaysTrue,  METH_VARARGS, "Truthiness"),
        PyMethodDef("always_false",    &alwaysFalse, METH_VARARGS, "Falsiness"),
        PyMethodDef("struct_func",     &struct_func, METH_VARARGS, "returns struct"),
        PyMethodDef(null, null, 0, null), // sentinel
    ];

    static extern(C) void terminateDRuntime(void*) nothrow {
        try
            rt_term;
        catch(Exception _)
            assert(0, "DRuntime termination should never fail.");
    }

    static PyModuleDef moduleDef;
    moduleDef = PyModuleDef(
        pyModuleDefHeadInit(),
        "raw",
        null, // doc
        -1, // global state
        &methods[0],
    );
    moduleDef.m_free = &terminateDRuntime;

    return PyModule_Create(&moduleDef);
}

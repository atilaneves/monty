module python.d;

import python.c: PyDateTime_CAPI;
// This is required to avoid linker errors. Before it was in the string mixin,
// but there's no need for it there, instead we declare it here in the library
// instead.
export __gshared extern(C) PyDateTime_CAPI* PyDateTimeAPI;


/**
   A utility function that does the same thing as PyModule_Create, but easier,
   by creating the appropriate PyMethodDef array for the passed-in C functions.
   It also initialises the D runtime.
   Parameters:
       name = The name of the Python module
       functions = C functions that are either:
           * PyObject* (PyObject* self, PyObject* args) or
           * PyObject* (PyObject* self, PyObject* args, PyObject* kwargs)
 */
imported!"python.c".PyObject* createPythonModule(string name, functions...)() nothrow {
    import python.c: PyModule_Create, PyModuleDef, pyModuleDefHeadInit, PyMethodDef,
        PyCFunction, PyCFunctionWithKeywords, PyObject,
        METH_VARARGS, METH_KEYWORDS, pyDateTimeImport;
    import core.runtime: rt_init;

    try
        rt_init;
    catch(Exception _)
        return null;

    pyDateTimeImport;

    static PyMethodDef[functions.length + 1] methodDefs;

    enum isPythonCFunction(alias F) = is(typeof(() nothrow { PyObject* obj; obj = F(obj, obj); }));
    enum isPythonCFunctionKwargs(alias F) = is(typeof(() nothrow { PyObject* obj; obj = F(obj, obj, obj); }));

    static foreach(i, F; functions) {{
        enum isCFun = isPythonCFunction!F;
        enum isKwargs = isPythonCFunctionKwargs!F;
        static if(!isCFun && !isKwargs) {
            import std.conv: text;
            import std.traits: fullyQualifiedName;

            static assert(
                false,
                text("\nCannot create a Python method from ", fullyQualifiedName!F, "\n",
                     "of type ", typeof(F).stringof, "\n",
                     "Functions must be either:\n",
                     "extern(C) PyObject* (PyObject*, PyObject*) nothrow\n",
                     "or\n",
                     "extern(C) PyObject* (PyObject*, PyObject*, PyObject*) nothrow\n",
                )
            );
        }

        methodDefs[i] = PyMethodDef(
            __traits(identifier, F),
            &F,
            isKwargs
                ? (METH_VARARGS | METH_KEYWORDS)
                : METH_VARARGS,
            null, // doc
        );
    }}

    static PyModuleDef moduleDef;
    moduleDef = PyModuleDef(
        pyModuleDefHeadInit(),
        name,
        null, // doc
        -1, // size,
        &methodDefs[0],
    );

    return PyModule_Create(&moduleDef);
}

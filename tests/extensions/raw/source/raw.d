import python.c;

import scalars: the_answer;

extern(C) nothrow:

PyObject* PyInit_raw() {

    auto methods = [
        PyMethodDef(null, null, 0, null),
    ];

    auto module_ = PyModuleDef(
        PyModuleDef_Base(),
        "raw",
        null, // doc
        -1, // global state
        &methods[0],
    );


    return pyModuleCreate(&module_);
}

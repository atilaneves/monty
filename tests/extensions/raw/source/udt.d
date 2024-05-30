import python.c;


extern(C) nothrow @nogc:


// New-style Py_T_INT
PyObject* struct_func_new(PyObject* self, PyObject *args) nothrow @nogc {

    static struct MyType {
        mixin PyObjectHead;
        int i = 2;
        double d = 3;
    }

    // either this of PyGetSetDef
    static PyMemberDef[3] members;
    members[0].name = cast(typeof(PyMemberDef.name)) &"the_int"[0];
    members[0].type = Py_T_INT;
    members[0].offset = MyType.i.offsetof;
    members[1].name = cast(typeof(PyMemberDef.name)) &"the_double"[0];
    members[1].type = Py_T_DOUBLE;
    members[1].offset = MyType.d.offsetof;

    static PyTypeObject type;

    if(type == type.init) {
        type.tp_name = &"MyType"[0];
        type.tp_basicsize = MyType.sizeof;
        type.tp_members = &members[0];
        //type.tp_flags = Py_TPFLAGS_DEFAULT;
        type.tp_flags = TypeFlags.Default;

        if(PyType_Ready(&type) < 0) {
            PyErr_SetString(PyExc_TypeError, &"not ready"[0]);
            return null;
        }
    }

    auto obj = pyObjectNew!MyType(&type);
    obj.i = 42;
    obj.d = 33.3;

    return cast(typeof(return)) obj;
}

// Old-style Py_T_INT
PyObject* struct_func_old(PyObject* self, PyObject *args) nothrow @nogc {
    import python.c: T_INT;
    static struct MyType {
        mixin PyObjectHead;
        int i = 2;
        double d = 3;
    }

    // either this of PyGetSetDef
    static PyMemberDef[3] members;
    members[0].name = cast(typeof(PyMemberDef.name)) &"the_int"[0];
    members[0].type = T_INT;
    members[0].offset = MyType.i.offsetof;
    members[1].name = cast(typeof(PyMemberDef.name)) &"the_double"[0];
    members[1].type = T_DOUBLE;
    members[1].offset = MyType.d.offsetof;

    static PyTypeObject type;

    if(type == type.init) {
        type.tp_name = &"MyType"[0];
        type.tp_basicsize = MyType.sizeof;
        type.tp_members = &members[0];
        //type.tp_flags = Py_TPFLAGS_DEFAULT;
        type.tp_flags = TypeFlags.Default;

        if(PyType_Ready(&type) < 0) {
            PyErr_SetString(PyExc_TypeError, &"not ready"[0]);
            return null;
        }
    }

    auto obj = pyObjectNew!MyType(&type);
    obj.i = 7;
    obj.d = 22.2;

    return cast(typeof(return)) obj;
}

def test_the_answer():
    from raw import the_answer
    assert the_answer() == 42

def test_always_true():
    from raw import always_true
    assert always_true() is True

def test_always_false():
    from raw import always_false
    assert always_false() is False

def test_struct_func_new():
    from raw import struct_func_new
    mytype = struct_func_new()
    assert mytype.the_int == 42
    assert mytype.the_double == 33.3

def test_struct_func_old():
    from raw import struct_func_old
    mytype = struct_func_old()
    assert mytype.the_int == 42
    assert mytype.the_double == 33.3

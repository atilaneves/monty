def test_the_answer():
    from raw import the_answer
    assert the_answer() == 42

def test_always_true():
    from raw import always_true
    assert always_true() is True

def test_always_false():
    from raw import always_false
    assert always_false() is False

def test_struct_func():
    from raw import struct_func
    mytype = struct_func()
    assert mytype.the_int == 42
    assert mytype.the_double == 33.3

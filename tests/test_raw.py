def test_the_answer():
    from raw import the_answer
    assert the_answer() == 42

def test_always_true():
    from raw import always_true
    assert always_true() is True

def test_always_false():
    from raw import always_false
    assert always_false() is False

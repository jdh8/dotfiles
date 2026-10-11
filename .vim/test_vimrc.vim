" Run: vim -Nu .vimrc -i NONE -n -es -V1 -S .vim/test_vimrc.vim
call assert_equal('', v:errmsg)
call assert_equal(exists('##TermResponseAll'), exists('#TermResponseAll#background'))
if !empty(v:errors)
    echo join(v:errors, "\n")
    cquit
endif
qa!

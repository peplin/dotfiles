function makedebug() {
    make $@ -d | egrep --color -i '(considering|older|newer|remake)'
}

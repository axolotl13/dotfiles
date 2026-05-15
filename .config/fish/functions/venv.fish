function venv --description 'Create Activate a Python virtual environment'
    type -q python; or return 1
    test -d venv

    or python -m venv venv

    test -f venv/bin/activate.fish

    and source venv/bin/activate.fish
end

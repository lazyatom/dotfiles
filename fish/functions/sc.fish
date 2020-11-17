function sc
    if test -f bin/rails
        bin/rails c $argv
    else if test -f bin/spring
        spring rails console $argv
    else if test -f script/console
        ruby script/console $argv
    else if test -f script/rails
        ruby script/rails console $argv
    else
        echo "Neither ./bin/rails, ./bin/spring, ./script/rails nor ./script/console found. Maybe this isn't a rails project?"
    end
end

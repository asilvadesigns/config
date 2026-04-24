# Loads ~/.config/.env.private into every fish session as global exported vars.
# The file is git-ignored and intended to hold work secrets.

set -l env_file "$HOME/.config/.env.private"

if not test -r "$env_file"
    exit
end

while read -l line
    set line (string trim -- $line)

    test -z "$line"; and continue
    string match -qr '^#' -- $line; and continue

    set line (string replace -r '^export\s+' '' -- $line)

    set -l kv (string split -m 1 '=' -- $line)
    test (count $kv) -ne 2; and continue

    set -l key (string trim -- $kv[1])
    set -l value (string trim -- $kv[2])

    set value (string replace -r '^"(.*)"$' '$1' -- $value)
    set value (string replace -r "^'(.*)'\$" '$1' -- $value)

    set -gx $key $value
end < $env_file

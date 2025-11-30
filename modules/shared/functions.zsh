# Shell Functions

# Compress/Decompress
function compress() {
    tar -czvf "$1" "$\{2:-\.}"
}

function decompress() {
    tar -xzvf "$1"
}

# ISO to SD Card (Dangerous!)
function iso2sd() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: iso2sd [image.iso] [/dev/diskN]"
        return 1
    fi
    echo "Writing $1 to $2..."
    sudo dd if="$1" of="$2" bs=4m status=progress
}

# Format Drive (exFAT)
function format-drive() {
    if [ -z "$1" ]; then
        echo "Usage: format-drive [/dev/diskN]"
        return 1
    fi
    echo "Formatting $1 to exFAT..."
    sudo diskutil eraseDisk ExFAT "External" "$1"
}

# Image Conversion (using sips on macOS)
function img2jpg() {
    for file in "$@"; do
        sips -s format jpeg -s formatOptions 100 "$file" --out "$\{file%.*}.jpg"
    done
}

function img2jpg-small() {
    for file in "$@"; do
        sips -Z 1920 -s format jpeg -s formatOptions 90 "$file" --out "$\{file%.*}.jpg"
    done
}

function img2png() {
    for file in "$@"; do
        sips -s format png "$file" --out "$\{file%.*}.png"
    done
}

VENV_FOLDER=.venv

if [ ! -d "$VENV_FOLDER" ]; then
    echo "Creating virtual environment"
    python3 -m venv .venv
    source .venv/bin/activate
else
    echo "Virtual environment already installed"
fi

echo "Installing Python requirements"
pip install -qr requirements.txt

if [ ! -f "$VENV_FOLDER/bin/chromedriver" ]; then
    echo "Installing Chrome WebDriver"
    # platform options: linux32, linux64, mac64, win32
    PLATFORM=mac64
    VERSION=88.0.4324.96
    curl -s http://chromedriver.storage.googleapis.com/$VERSION/chromedriver_$PLATFORM.zip | bsdtar -xvf - -C $VENV_FOLDER/bin
    chmod a+x $VENV_FOLDER/bin/chromedriver
else   
    echo "Chrome WebDriver already installed"
fi

export CHROMEDRIVER_PATH="$(pwd)/$VENV_FOLDER/bin/chromedriver"
echo "CHROMEDRIVER_PATH set to $CHROMEDRIVER_PATH"

[ ! -d "downloads" ] && mkdir downloads
export DOWNLOAD_DIR="$(pwd)/downloads"
echo "DOWNLOAD_DIR set to $DOWNLOAD_DIR"
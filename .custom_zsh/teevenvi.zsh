teevenvi () {
  asd=$(pyenv versions | fzf --tmux | grep -oP "(\d+\.\d+\.\d+)")

  if [ -z "$asd" ]
  then
    echo "Aborted."
    return 1
  else
    echo "Activating Python ${asd} shell with pyenv"
    pyenv shell $asd
    echo "Activated."
  fi
  echo "Creating venv with Python ${asd}"
  python -m venv venv
  echo "Created."
  source venv/bin/activate
  echo "Venv activated"

  pyenv shell --unset
  echo "Pyenv shell deactivated."
}

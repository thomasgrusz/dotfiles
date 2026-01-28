
alias getannakarenina='wget https://www.gutenberg.org/cache/epub/1399/pg1399.txt -O annakarenina.txt'
alias y='yt-dlp'
alias la='ls -la'
alias l='ls -l'
alias ip='ip -c'
alias unclutter='grep -vE "^$|^\s*#"'
alias mypath='echo $PATH | tr ":" "\n"'
alias fp="dpkg -l | grep -i"
alias simpleserver='python3 -m http.server 8000'
alias mkv2mp4='ffmpeg -i input.mkv -c:v copy -c:a copy -c:s mov_text -map 0 output.mp4'
alias makevenv='python3 -m venv venv && source venv/bin/activate && pip install --upgrade pip && pip install flake8 yapf'
alias makejs='npm init -y && npm install eslint prettier --save-dev && echo -e "{\n\"include\": [\"**/*.js\"],\n\"exclude\": [\"node_modules\"]\n}" > jsconfig.json && npm ini @eslint/config@latest'

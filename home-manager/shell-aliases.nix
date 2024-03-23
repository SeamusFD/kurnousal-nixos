{...}: {
  programs.bash.shellAliases = {
    # ls aliases
    ll = "ls -l";
    la = "ls -a";
    # Git aliases
    gita = "git add";
    gitaa = "git add .";
    gitau = "git add -u";
    gitc = "git commit -m";
    gitco = "git checkout";
    gitb = "git branch";
    gitp = "git pull";
    gitpu = "git push";
    gitnb = "git checkout -b";
  };
}

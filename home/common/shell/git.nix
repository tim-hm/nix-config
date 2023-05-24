{ ... }: {


  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;

      userEmail = "tim@holmie.xyz";
      userName = "Tim Holmes-Mitra";

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        push = {
          default = "matching";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
      };

      ignores = [
        "*.fdb_latexmk"
        "*.fls"
        "*.aux"
        "*.glo"
        "*.idx"
        "*.log"
        "*.toc"
        "*.ist"
        "*.acn"
        "*.acr"
        "*.alg"
        "*.bbl"
        "*.blg"
        "*.dvi"
        "*.glg"
        "*.gls"
        "*.ilg"
        "*.ind"
        "*.lof"
        "*.lot"
        "*.maf"
        "*.mtc"
        "*.mtc1"
        "*.out"
        "*.synctex.gz"
        "*.module.js"
        "*.routing.js"
        "*.component.js"
        "*.service.js"
        "*.map"
        ".DS_Store"
        ".vscode/"
        "node_modules/"
        "dist/"
        "bin/"
        ".tox/"
        ".mypy*/"
        "venv/"
        ".venv/"
        "__pycache__/"
      ];
    };
  };
}

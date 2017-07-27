{ config, pkgs, ... }:

let
  packageGroups = import ./package-groups.nix {
    inherit pkgs;
  };
in

{

  environment = {
    systemPackages = with pkgs; packageGroups.desktop ++ [
      wget
      vim
      i3lock
      flashrom
      hwinfo
      connman_dmenu
      gitAndTools.gitFull
      gitAndTools.git-extras
      gitAndTools.hub
      virtmanager
      mkpasswd
      openssl
      acpi
      acpitool
      bridge-utils
      unzip
      file
      sudo
      lxc
      which
      gist
      iptables
      paprefs
      pavucontrol
      mplayer
      mpv
      slock
      rxvt_unicode-with-plugins
      xorg.xrandr
      wpa_supplicant_gui
      x11_ssh_askpass
      chromium
      mtr
      wireshark
      iftop
      jnettop
      lftp
      whois
      autossh
      nmap
      tcpdump
      htop
      atop
      iotop
      strace
      manpages
      bashCompletion
      zsh
      gnupg
      gnupg1compat
      pwgen
      lsof
      screen
      mosh
      tmux
      dnsmasq
      dhcpcd
      clipit
      scrot
      imagemagick
      nox
      pciutils
      xsel
      xclip
      yubico-piv-tool
      yubikey-neo-manager
      yubikey-personalization
      yubikey-personalization-gui
      #ykpers
      gcc
      virtualboxHardened
      ndisc6
      dmidecode
      lshw
    ];

    variables = {
      TERMINAL = [ "xterm" ];
      EDITOR="vim";
    };
    
    pathsToLink = [ "/etc/gconf" ];

    etc = {
      "lock" = {
        text = ''
          #!/bin/sh -e
          scrot /tmp/screen_locked.png
          mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
          i3lock -i /tmp/screen_locked.png
          sleep 60; pgrep i3lock && xset dpms force off
        '';
      };
      "i3config" = {
        text = ''
          set $mod Mod4
          font pango:monospace 8
          floating_modifier $mod
          bindsym $mod+l exec "~/bin/lock.sh" 
          exec --no-startup-id clipit
          exec i3-sensible-terminal
          bindsym $mod+Return exec i3-sensible-terminal
          bindsym $mod+Shift+q kill
          bindsym $mod+d exec /nix/store/9qsripch0whyv3xyd656rcmkbs9f21d2-dmenu-4.6/bin/dmenu_run
          bindsym $mod+Left focus left
          bindsym $mod+Down focus down
          bindsym $mod+Up focus up
          bindsym $mod+Right focus right
          bindsym $mod+Shift+j move left
          bindsym $mod+Shift+k move down
          bindsym $mod+Shift+l move up
          bindsym $mod+Shift+semicolon move right
          bindsym $mod+Shift+Left move left
          bindsym $mod+Shift+Down move down
          bindsym $mod+Shift+Up move up
          bindsym $mod+Shift+Right move right
          bindsym $mod+h split h
          bindsym $mod+v split v
          bindsym $mod+f fullscreen toggle
          bindsym $mod+s layout stacking
          bindsym $mod+w layout tabbed
          bindsym $mod+e layout toggle split
          bindsym $mod+Shift+space floating toggle
          bindsym $mod+space focus mode_toggle
          bindsym $mod+a focus parent
          bindsym $mod+1 workspace 1
          bindsym $mod+2 workspace 2
          bindsym $mod+3 workspace 3
          bindsym $mod+4 workspace 4
          bindsym $mod+5 workspace 5
          bindsym $mod+6 workspace 6
          bindsym $mod+7 workspace 7
          bindsym $mod+8 workspace 8
          bindsym $mod+9 workspace 9
          bindsym $mod+0 workspace 10
          bindsym $mod+Shift+1 move container to workspace 1
          bindsym $mod+Shift+2 move container to workspace 2
          bindsym $mod+Shift+3 move container to workspace 3
          bindsym $mod+Shift+4 move container to workspace 4
          bindsym $mod+Shift+5 move container to workspace 5
          bindsym $mod+Shift+6 move container to workspace 6
          bindsym $mod+Shift+7 move container to workspace 7
          bindsym $mod+Shift+8 move container to workspace 8
          bindsym $mod+Shift+9 move container to workspace 9
          bindsym $mod+Shift+0 move container to workspace 10
          bindsym $mod+Shift+c reload
          bindsym $mod+Shift+r restart
          bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
          mode "resize" {
                  bindsym j resize shrink width 10 px or 10 ppt
                  bindsym k resize grow height 10 px or 10 ppt
                  bindsym l resize shrink height 10 px or 10 ppt
                  bindsym semicolon resize grow width 10 px or 10 ppt
                  bindsym Left resize shrink width 10 px or 10 ppt
                  bindsym Down resize grow height 10 px or 10 ppt
                  bindsym Up resize shrink height 10 px or 10 ppt
                  bindsym Right resize grow width 10 px or 10 ppt
                  bindsym Return mode "default"
                  bindsym Escape mode "default"
          }
          bindsym $mod+r mode "resize"
          bar {
                  status_command /nix/store/zfxa73x17db8xw20k9np3lxymibx0fqg-i3status-2.11/bin/i3status
          }
          '';
      };
      "vimrc" = {
        text = ''
          set history=700
          filetype plugin on
          filetype indent on
          set autoread
          let mapleader = ","
          let g:mapleader = ","
          nmap <leader>w :w!<cr>
          set so=7
          set wildmenu
          set wildignore=*.o,*~,*.pyc
          set ruler
          set cmdheight=2
          set hid
          set backspace=eol,start,indent
          set whichwrap+=<,>,h,l
          set ignorecase
          set smartcase
          set hlsearch
          set incsearch 
          set lazyredraw 
          set magic
          set showmatch 
          set mat=2
          set noerrorbells
          set novisualbell
          set t_vb=
          set tm=500
          syntax enable 
          try
              colorscheme desert
          catch
          endtry
          set background=dark
          if has("gui_running")
              set guioptions-=T
              set guioptions+=e
              set t_Co=256
              set guitablabel=%M\ %t
          endif
          set encoding=utf8
          set ffs=unix,dos,mac
          set nobackup
          set nowb
          set noswapfile
          set expandtab
          set smarttab
          set shiftwidth=2
          set tabstop=2
          set lbr
          set tw=500
          set ai "Auto indent
          set si "Smart indent
          set wrap "Wrap lines
          vnoremap <silent> * :call VisualSelection('f')<CR>
          vnoremap <silent> # :call VisualSelection('b')<CR>
          map j gj
          map k gk
          map <space> /
          map <c-space> ?
          map <silent> <leader><cr> :noh<cr>
          map <C-j> <C-W>j
          map <C-k> <C-W>k
          map <C-h> <C-W>h
          map <C-l> <C-W>l
          map <leader>bd :Bclose<cr>
          map <leader>ba :1,1000 bd!<cr>
          map <leader>tn :tabnew<cr>
          map <leader>to :tabonly<cr>
          map <leader>tc :tabclose<cr>
          map <leader>tm :tabmove 
          map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
          map <leader>cd :cd %:p:h<cr>:pwd<cr>
          try
            set switchbuf=useopen,usetab,newtab
            set stal=2
          catch
          endtry
          autocmd BufReadPost *
               \ if line("'\"") > 0 && line("'\"") <= line("$") |
               \   exe "normal! g`\"" |
               \ endif
          set viminfo^=%
          set laststatus=2
          set statusline=\ %F%m%r%h\ %w\ \ Type:\ %y\ CWD:\ %r%{getcwd()}%h\ \ \ %=%-20.(Line:\ %l/%L\ Column:\ %c\ (%P)%) 
          map 0 ^
          nmap <M-j> mz:m+<cr>`z
          nmap <M-k> mz:m-2<cr>`z
          vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
          vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
          if has("mac") || has("macunix")
            nmap <D-j> <M-j>
            nmap <D-k> <M-k>
            vmap <D-j> <M-j>
            vmap <D-k> <M-k>
          endif
          func! DeleteTrailingWS()
            exe "normal mz"
            %s/\s\+$//ge
            exe "normal `z"
          endfunc
          autocmd BufWrite *.py :call DeleteTrailingWS()
          autocmd BufWrite *.coffee :call DeleteTrailingWS()
          vnoremap <silent> gv :call VisualSelection('gv')<CR>
          map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
          map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>
          vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
          map <leader>cc :botright cope<cr>
          map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
          map <leader>n :cn<cr>
          map <leader>p :cp<cr>
          map <leader>ss :setlocal spell!<cr>
          map <leader>sn ]s
          map <leader>sp [s
          map <leader>sa zg
          map <leader>s? z=
          noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
          map <leader>q :e ~/buffer<cr>
          map <leader>pp :setlocal paste!<cr>
          nnoremap <F2> :set invpaste paste?<CR>
          set pastetoggle=<F2>
          set showmode
        '';
      };
    };
  };

}


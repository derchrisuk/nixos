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
      #mailutils
      xfontsel
      xorg.xmodmap
      i3blocks
      i3cat
      weechat
      dunst
      libnotify
      python27
      automake
      gnumake
      ocaml_make
      omake
      opam
      ocamlPackages.core
      ocaml
      ocamlPackages.findlib
      ocamlPackages.camlp4
      ocamlPackages.yojson
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
      "dunstrc" = {
        text = ''
          # 
          [global]
              font = "FontAwesome, Noto Sans 11"
              allow_markup = yes

              # The format of the message. Possible variables are:
              #   %a  appname
              #   %s  summary
              #   %b  body
              #   %i  iconname (including its path)
              #   %I  iconname (without its path)
              #   %p  progress value if set ([  0%] to [100%]) or nothing
              # Markup is allowed
              format = "<b>  %s</b>\n%b"

              sort = yes
              indicate_hidden = yes
              alignment = center
              bounce_freq = 0
              show_age_threshold = 60
              word_wrap = yes
              ignore_newline = no
              geometry = "300x5+20-20"
              transparency = 10
              idle_threshold = 90
              monitor = 0
              follow = mouse
              sticky_history = yes
              line_height = 0
              separator_height = 2
              padding = 8
              horizontal_padding = 8
              separator_color = auto
              startup_notification = true

              # dmenu path
              dmenu = /nix/store/9qsripch0whyv3xyd656rcmkbs9f21d2-dmenu-4.6/bin/dmenu_run -p dunst:

              # browser for opening urls in context menu
              browser = /home/derchris/.nix-profile/bin/chromium

          [frame]
              width = 2
              color = "#00c3ff"

          [shortcuts]
              close = ctrl+space
              close_all = ctrl+shift+space
              history = ctrl+grave
              context = ctrl+shift+period

          [urgency_low]
              background = "#1D596B"
              foreground = "#7BA8B5"
              timeout = 10

          [urgency_normal]
              background = "#E3AD0B"
              foreground = "#524218"
              timeout = 10

          [urgency_critical]
              background = "#BA3220"
              foreground = "#F0D1C5"
              timeout = 0

          [scrot]
              summary = scrot
              format = "<b>  %s</b>\n%b"

          [usb]
              summary = Automount
              format = "<b> %s</b>\n%b"

          [weechat]
              appname = weechat
              format = "<b>  %s</b>\n%b"
        '';
      };
      "i3blocks" = {
        text = ''
          interval=5
          signal=10

          [iface]
        '';
      };
      "i3cat" = {
        text = ''
          /nix/store/zfxa73x17db8xw20k9np3lxymibx0fqg-i3status-2.11/bin/i3status -c ~/.config/i3status/config
        '';
      };
      "i3status" = {
        text = ''
          general {
                  colors = true
                  interval = 5
                  output_format = i3bar
          }

          order += "ipv6"
          order += "disk /"
          order += "wireless _first_"
          order += "ethernet _first_"
          order += "battery all"
          order += "load"
          order += "tztime local"

          wireless _first_ {
                  format_up = "W: (%quality at %essid) %ip"
                  format_down = "W: down"
          }

          ethernet _first_ {
                  # if you use %speed, i3status requires root privileges
                  format_up = "E: %ip (%speed)"
                  format_down = "E: down"
          }

          battery all {
                  format = "%status %percentage %remaining"
          }

          tztime local {
                  format = "%Y-%m-%d %H:%M:%S"
          }

          load {
                  format = "%1min"
          }

          disk "/" {
                  format = "%avail"
          }
        '';
      };
      "xresources" = {
        text = ''
          !XTerm*Background: black
          XTerm*Foreground: white
          !XTerm*faceName: Consolas
          !XTerm*faceSize: 10
          XTerm*font: -*-terminus-medium-*-*-*-14-*-*-*-*-*-iso10646-1
          XTerm*font1: -*-terminus-medium-*-*-*-12-*-*-*-*-*-iso10646-1
          XTerm*font2: -*-terminus-medium-*-*-*-14-*-*-*-*-*-iso10646-1
          XTerm*font3: -*-terminus-medium-*-*-*-16-*-*-*-*-*-iso10646-1
          XTerm*font4: -*-terminus-medium-*-*-*-18-*-*-*-*-*-iso10646-1
          XTerm*font5: -*-terminus-medium-*-*-*-20-*-*-*-*-*-iso10646-1
          XTerm*font6: -*-terminus-medium-*-*-*-22-*-*-*-*-*-iso10646-1
          XTerm*font7: -*-terminus-medium-*-*-*-24-*-*-*-*-*-iso10646-1
          XTerm*font8: -*-terminus-medium-*-*-*-28-*-*-*-*-*-iso10646-1
          XTerm*font9: -*-terminus-medium-*-*-*-32-*-*-*-*-*-iso10646-1
          XTerm*loginshell: true
          XTerm*saveLines: 16384000
          XTerm*charClass: 33:48,36-47:48,58-59:48,61:48,63-64:48,95:48,126:48
          XTerm*scrollTtyOutput: false
          XTerm*scrollKey: true
          XTerm*termName: xterm-256color
          !XTerm*metaSendsEscape: true
          XTerm*bellIsUrgent: true
          XTerm*translations: #override \n\
            Shift Ctrl <Key>C: copy-selection(CLIPBOARD) \n\
            Shift Ctrl <Key>V: insert-selection(CLIPBOARD) \n\
            Shift <KeyPress>Up :larger-vt-font() \n\
            Shift <KeyPress>Down :smaller-vt-font() \n\
            Shift <Btn1Up>: exec-formatted("chromium '%t'", PRIMARY)
          XTerm*on3Clicks: regex ([[:alpha:]]+://)?([[:alnum:]!#+,./=?@_~-]|(%[[:xdigit:]][[:xdigit:]]))+

          #define S_yellow        #b58900
          #define S_orange        #cb4b16
          #define S_red           #dc322f
          #define S_magenta       #d33682
          #define S_violet        #6c71c4
          #define S_blue          #268bd2
          #define S_cyan          #2aa198
          #define S_green         #859900

          ! Dark

          #define S_base03        #002b36
          #define S_base02        #073642
          #define S_base01        #586e75
          #define S_base00        #657b83
          #define S_base0         #839496
          #define S_base1         #93a1a1
          #define S_base2         #eee8d5
          #define S_base3         #fdf6e3

          ! Light

          !#define S_base03        #fdf6e3
          !#define S_base02        #eee8d5
          !#define S_base01        #93a1a1
          !#define S_base00        #839496
          !#define S_base0         #657b83
          !#define S_base1         #586e75
          !#define S_base2         #073642
          !#define S_base3         #002b36

          XTerm*background:              S_base03
          !XTerm*foreground:              S_base0
          XTerm*fading:                  40
          XTerm*fadeColor:               S_base03
          XTerm*cursorColor:             S_base1
          XTerm*pointerColorBackground:  S_base01
          XTerm*pointerColorForeground:  S_base1

          *color0:                  S_base02
          *color1:                  S_red
          *color2:                  S_green
          *color3:                  S_yellow
          *color4:                  S_blue
          *color5:                  S_magenta
          *color6:                  S_cyan
          *color7:                  S_base2
          *color9:                  S_orange
          *color8:                  S_base03
          *color10:                 S_base01
          *color11:                 S_base00
          *color12:                 S_base0
          *color13:                 S_violet
          *color14:                 S_base1
          *color15:                 S_base3
        '';
      };
      "i3config" = {
        text = ''
          set $mod Mod4
          font pango:monospace 8
          #font pango:FontAwesome 8, pango: Droid Sans Mono 8
          floating_modifier $mod
          bindsym $mod+l exec "~/bin/lock.sh" 
          exec --no-startup-id clipit
          exec --no-startup-id dunst -config ~/.config/dunstrc
          exec --no-startup-id i3-sensible-terminal -name weechat weechat
          exec --no-startup-id chromium
          exec --no-startup-id i3-sensible-terminal -name xterm
          set $tag1 "1: irc"
          set $tag2 "2: www"
          set $tag3 "3: term"
          assign [instance=weechat] $tag1
          assign [instance=chromium] $tag2
          assign [instance=xterm] $tag3
          for_window [instance=chromium] layout tabbed
          for_window [instance=weechat] focus
          bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -q set Master 5%+ unmute
          bindsym XF86AudioLowerVolume exec --no-startup-id amixer -q set Master 5%- unmute
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
          bindsym $mod+1 workspace $tag1
          bindsym $mod+2 workspace $tag2
          bindsym $mod+3 workspace $tag3
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
                  status_command i3cat -cmd-file ~/.config/i3cat/config
          }
          workspace_auto_back_and_forth yes
          force_display_urgency_hint 0 ms
          focus_on_window_activation urgent
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


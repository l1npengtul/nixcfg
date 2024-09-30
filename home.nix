{
  pkgs,
  ...
}:
{

  programs = {
    git = {
      enable = true;
      userEmail = "l1npengtul@protonmail.com";
      userName = "l1npengtul";
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    configFile.source = ./config.nu;
    # for editing directly to config.nu
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell $spans | from json
      }
      $env.config = {
        hooks: {
          pre_prompt: [{ ||
            if (which direnv | is-empty) {
              return
            }

            direnv export json | from json | default {} | load-env
          }]
        }
       show_banner: false,
       completions: {
       case_sensitive: false # case-sensitive completions
       quick: true    # set to false to prevent auto-selecting completions
       partial: true    # set to false to prevent partial filling of the prompt
       algorithm: "fuzzy"    # prefix or fuzzy
       external: {
       # set to false to prevent nushell looking into $env.PATH to find more suggestions
           enable: true
       # set to lower can improve completion performance at the cost of omitting some options
           max_results: 100
           completer: $carapace_completer # check 'carapace_completer'
         }
       }
      }
      $env.PATH = ($env.PATH |
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )
    '';
  };

  programs.plasma = {
    enable = true;
    shortcuts = {
      "ActivityManager"."switch-to-activity-622e6a72-77d5-4d90-9c31-a657d9ad6a70" = [ ];
      "KDE Keyboard Layout Switcher"."Switch keyboard layout to English (US)" = [ ];
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
      "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
      "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
      "kcm_touchpad"."Toggle Touchpad" = ["Touchpad Toggle" "" "Meta+Ctrl+Zenkaku Hankaku,Touchpad Toggle" "Meta+Ctrl+Zenkaku Hankaku"];
      "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
      "kmix"."decrease_volume" = "Volume Down";
      "kmix"."decrease_volume_small" = "Shift+Volume Down";
      "kmix"."increase_microphone_volume" = "Microphone Volume Up";
      "kmix"."increase_volume" = "Volume Up";
      "kmix"."increase_volume_small" = "Shift+Volume Up";
      "kmix"."mic_mute" = ["Microphone Mute" "" "Meta+Volume Mute\\, ,Microphone Mute" "Meta+Volume Mute,Mute Microphone"];
      "kmix"."mute" = "Volume Mute";
      "ksmserver"."Halt Without Confirmation" = "none,,Shut Down Without Confirmation";
      "ksmserver"."Lock Session" = ["Meta+L" "" "Screensaver\\, ,Meta+L" "Screensaver,Lock Session"];
      "ksmserver"."Log Out" = "Ctrl+Alt+Del";
      "ksmserver"."Log Out Without Confirmation" = "none,,Log Out Without Confirmation";
      "ksmserver"."LogOut" = "none,,Log Out";
      "ksmserver"."Reboot" = "none,,Reboot";
      "ksmserver"."Reboot Without Confirmation" = "none,,Reboot Without Confirmation";
      "ksmserver"."Shut Down" = "none,,Shut Down";
      "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      "kwin"."Cube" = [ ];
      "kwin"."Cycle Overview" = [ ];
      "kwin"."Cycle Overview Opposite" = [ ];
      "kwin"."Decrease Opacity" = "\\, ,,Decrease Opacity of Active Window by 5%";
      "kwin"."Edit Tiles" = "Meta+T";
      "kwin"."Expose" = "Ctrl+F9";
      "kwin"."ExposeAll" = ["Ctrl+F10" "" "Launch (C)\\, ,Ctrl+F10" "Launch (C),Toggle Present Windows (All desktops)"];
      "kwin"."ExposeClass" = "Ctrl+F7";
      "kwin"."ExposeClassCurrentDesktop" = [ ];
      "kwin"."Grid View" = "Meta+G";
      "kwin"."Increase Opacity" = [ ];
      "kwin"."Kill Window" = "Meta+Ctrl+Esc";
      "kwin"."KrohnkiteBTreeLayout" = ",none,Krohnkite: BTree Layout";
      "kwin"."KrohnkiteDecrease" = ",none,Krohnkite: Decrease";
      "kwin"."KrohnkiteFloatAll" = ",none,Krohnkite: Float All";
      "kwin"."KrohnkiteFloatingLayout" = ",none,Krohnkite: Floating Layout";
      "kwin"."KrohnkiteFocusDown" = ",none,Krohnkite: Focus Down";
      "kwin"."KrohnkiteFocusLeft" = ",none,Krohnkite: Focus Left";
      "kwin"."KrohnkiteFocusNext" = ",Meta+.,Krohnkite: Focus Next";
      "kwin"."KrohnkiteFocusPrev" = "Meta+\\,,none,Krohnkite: Focus Previous";
      "kwin"."KrohnkiteFocusRight" = ",none,Krohnkite: Focus Right";
      "kwin"."KrohnkiteFocusUp" = ",none,Krohnkite: Focus Up";
      "kwin"."KrohnkiteGrowHeight" = ",none,Krohnkite: Grow Height";
      "kwin"."KrohnkiteIncrease" = ",none,Krohnkite: Increase";
      "kwin"."KrohnkiteMonocleLayout" = ",none,Krohnkite: Monocle Layout";
      "kwin"."KrohnkiteNextLayout" = ",none,Krohnkite: Next Layout";
      "kwin"."KrohnkitePreviousLayout" = ",none,Krohnkite: Previous Layout";
      "kwin"."KrohnkiteQuarterLayout" = ",none,Krohnkite: Quarter Layout";
      "kwin"."KrohnkiteRotate" = ",none,Krohnkite: Rotate";
      "kwin"."KrohnkiteRotatePart" = ",none,Krohnkite: Rotate Part";
      "kwin"."KrohnkiteSetMaster" = ",none,Krohnkite: Set master";
      "kwin"."KrohnkiteShiftDown" = "Meta+Ctrl+Right,none,Krohnkite: Move Down/Next";
      "kwin"."KrohnkiteShiftLeft" = ",none,Krohnkite: Move Left";
      "kwin"."KrohnkiteShiftRight" = ",none,Krohnkite: Move Right";
      "kwin"."KrohnkiteShiftUp" = "Meta+Ctrl+Left,none,Krohnkite: Move Up/Prev";
      "kwin"."KrohnkiteShrinkHeight" = ",none,Krohnkite: Shrink Height";
      "kwin"."KrohnkiteShrinkWidth" = ",none,Krohnkite: Shrink Width";
      "kwin"."KrohnkiteSpiralLayout" = ",none,Krohnkite: Spiral Layout";
      "kwin"."KrohnkiteSpreadLayout" = ",none,Krohnkite: Spread Layout";
      "kwin"."KrohnkiteStackedLayout" = ",none,Krohnkite: Stacked Layout";
      "kwin"."KrohnkiteStairLayout" = ",none,Krohnkite: Stair Layout";
      "kwin"."KrohnkiteTileLayout" = ",none,Krohnkite: Tile Layout";
      "kwin"."KrohnkiteToggleFloat" = ",none,Krohnkite: Toggle Float";
      "kwin"."KrohnkiteTreeColumnLayout" = ",none,Krohnkite: Tree Column Layout";
      "kwin"."KrohnkitegrowWidth" = ",none,Krohnkite: Grow Width";
      "kwin"."Move Tablet to Next Output" = [ ];
      "kwin"."MoveMouseToCenter" = "Meta+F6";
      "kwin"."MoveMouseToFocus" = "Meta+F5";
      "kwin"."MoveZoomDown" = [ ];
      "kwin"."MoveZoomLeft" = [ ];
      "kwin"."MoveZoomRight" = [ ];
      "kwin"."MoveZoomUp" = [ ];
      "kwin"."Overview" = "Meta+W";
      "kwin"."PoloniumCycleEngine" = ",none";
      "kwin"."PoloniumFocusAbove" = ",none";
      "kwin"."PoloniumFocusBelow" = ",none";
      "kwin"."PoloniumFocusLeft" = ",none";
      "kwin"."PoloniumFocusRight" = [ ];
      "kwin"."PoloniumInsertAbove" = ",none";
      "kwin"."PoloniumInsertBelow" = ",none";
      "kwin"."PoloniumInsertLeft" = ",none";
      "kwin"."PoloniumInsertRight" = ",none";
      "kwin"."PoloniumOpenSettings" = ",none";
      "kwin"."PoloniumResizeAbove" = ",none";
      "kwin"."PoloniumResizeBelow" = ",none";
      "kwin"."PoloniumResizeLeft" = ",none";
      "kwin"."PoloniumResizeRight" = ",none";
      "kwin"."PoloniumRetileWindow" = ",none";
      "kwin"."PoloniumSwitchBTree" = [ ];
      "kwin"."PoloniumSwitchHalf" = [ ];
      "kwin"."PoloniumSwitchKwin" = [ ];
      "kwin"."PoloniumSwitchMonocle" = [ ];
      "kwin"."PoloniumSwitchThreeColumn" = [ ];
      "kwin"."Setup Window Shortcut" = [ ];
      "kwin"."Show Desktop" = "Meta+D";
      "kwin"."Switch One Desktop Down" = "\\, Meta+Ctrl+Down\\, ,Meta+Ctrl+Down,Switch One Desktop Down";
      "kwin"."Switch One Desktop Up" = "\\, Meta+Ctrl+Up\\, ,Meta+Ctrl+Up,Switch One Desktop Up";
      "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left,Switch One Desktop to the Left";
      "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right,Switch One Desktop to the Right";
      "kwin"."Switch Window Down" = "Meta+Alt+Down";
      "kwin"."Switch Window Left" = "Meta+Alt+Left";
      "kwin"."Switch Window Right" = "Meta+Alt+Right";
      "kwin"."Switch Window Up" = "Meta+Alt+Up";
      "kwin"."Switch to Desktop 1" = "Ctrl+F1";
      "kwin"."Switch to Desktop 10" = [ ];
      "kwin"."Switch to Desktop 11" = [ ];
      "kwin"."Switch to Desktop 12" = [ ];
      "kwin"."Switch to Desktop 13" = [ ];
      "kwin"."Switch to Desktop 14" = [ ];
      "kwin"."Switch to Desktop 15" = [ ];
      "kwin"."Switch to Desktop 16" = [ ];
      "kwin"."Switch to Desktop 17" = [ ];
      "kwin"."Switch to Desktop 18" = [ ];
      "kwin"."Switch to Desktop 19" = [ ];
      "kwin"."Switch to Desktop 2" = "Ctrl+F2";
      "kwin"."Switch to Desktop 20" = [ ];
      "kwin"."Switch to Desktop 3" = "Ctrl+F3";
      "kwin"."Switch to Desktop 4" = "Ctrl+F4";
      "kwin"."Switch to Desktop 5" = [ ];
      "kwin"."Switch to Desktop 6" = [ ];
      "kwin"."Switch to Desktop 7" = [ ];
      "kwin"."Switch to Desktop 8" = [ ];
      "kwin"."Switch to Desktop 9" = [ ];
      "kwin"."Switch to Next Desktop" = "Ctrl+Alt+Right";
      "kwin"."Switch to Next Screen" = "Meta+Shift+Right";
      "kwin"."Switch to Previous Desktop" = "Ctrl+Alt+Left";
      "kwin"."Switch to Previous Screen" = "Meta+Shift+Left";
      "kwin"."Switch to Screen 0" = [ ];
      "kwin"."Switch to Screen 1" = [ ];
      "kwin"."Switch to Screen 2" = [ ];
      "kwin"."Switch to Screen 3" = [ ];
      "kwin"."Switch to Screen 4" = [ ];
      "kwin"."Switch to Screen 5" = [ ];
      "kwin"."Switch to Screen 6" = [ ];
      "kwin"."Switch to Screen 7" = [ ];
      "kwin"."Switch to Screen Above" = [ ];
      "kwin"."Switch to Screen Below" = [ ];
      "kwin"."Switch to Screen to the Left" = [ ];
      "kwin"."Switch to Screen to the Right" = [ ];
      "kwin"."Toggle Night Color" = [ ];
      "kwin"."Toggle Window Raise/Lower" = [ ];
      "kwin"."Walk Through Windows" = "Alt+Tab";
      "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
      "kwin"."Walk Through Windows Alternative" = [ ];
      "kwin"."Walk Through Windows Alternative (Reverse)" = [ ];
      "kwin"."Walk Through Windows of Current Application" = "Alt+`";
      "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
      "kwin"."Walk Through Windows of Current Application Alternative" = [ ];
      "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
      "kwin"."Window Above Other Windows" = [ ];
      "kwin"."Window Below Other Windows" = [ ];
      "kwin"."Window Close" = "Alt+F4";
      "kwin"."Window Fullscreen" = [ ];
      "kwin"."Window Grow Horizontal" = [ ];
      "kwin"."Window Grow Vertical" = [ ];
      "kwin"."Window Lower" = [ ];
      "kwin"."Window Maximize" = "Meta+PgUp";
      "kwin"."Window Maximize Horizontal" = [ ];
      "kwin"."Window Maximize Vertical" = [ ];
      "kwin"."Window Minimize" = "Meta+PgDown";
      "kwin"."Window Move" = [ ];
      "kwin"."Window Move Center" = [ ];
      "kwin"."Window No Border" = [ ];
      "kwin"."Window On All Desktops" = [ ];
      "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      "kwin"."Window One Screen Down" = [ ];
      "kwin"."Window One Screen Up" = [ ];
      "kwin"."Window One Screen to the Left" = "none,,Move Window One Screen to the Left";
      "kwin"."Window One Screen to the Right" = "none,,Move Window One Screen to the Right";
      "kwin"."Window Operations Menu" = "Alt+F3";
      "kwin"."Window Pack Down" = [ ];
      "kwin"."Window Pack Left" = [ ];
      "kwin"."Window Pack Right" = [ ];
      "kwin"."Window Pack Up" = [ ];
      "kwin"."Window Quick Tile Bottom" = "\\, Meta+Down\\, ,Meta+Down,Quick Tile Window to the Bottom";
      "kwin"."Window Quick Tile Bottom Left" = [ ];
      "kwin"."Window Quick Tile Bottom Right" = [ ];
      "kwin"."Window Quick Tile Left" = "\\, Meta+Left\\, ,Meta+Left,Quick Tile Window to the Left";
      "kwin"."Window Quick Tile Right" = "\\, Meta+Right\\, ,Meta+Right,Quick Tile Window to the Right";
      "kwin"."Window Quick Tile Top" = "\\, Meta+Up\\, ,Meta+Up,Quick Tile Window to the Top";
      "kwin"."Window Quick Tile Top Left" = [ ];
      "kwin"."Window Quick Tile Top Right" = [ ];
      "kwin"."Window Raise" = [ ];
      "kwin"."Window Resize" = [ ];
      "kwin"."Window Shade" = [ ];
      "kwin"."Window Shrink Horizontal" = [ ];
      "kwin"."Window Shrink Vertical" = [ ];
      "kwin"."Window to Desktop 1" = [ ];
      "kwin"."Window to Desktop 10" = [ ];
      "kwin"."Window to Desktop 11" = [ ];
      "kwin"."Window to Desktop 12" = [ ];
      "kwin"."Window to Desktop 13" = [ ];
      "kwin"."Window to Desktop 14" = [ ];
      "kwin"."Window to Desktop 15" = [ ];
      "kwin"."Window to Desktop 16" = [ ];
      "kwin"."Window to Desktop 17" = [ ];
      "kwin"."Window to Desktop 18" = [ ];
      "kwin"."Window to Desktop 19" = [ ];
      "kwin"."Window to Desktop 2" = [ ];
      "kwin"."Window to Desktop 20" = [ ];
      "kwin"."Window to Desktop 3" = [ ];
      "kwin"."Window to Desktop 4" = [ ];
      "kwin"."Window to Desktop 5" = [ ];
      "kwin"."Window to Desktop 6" = [ ];
      "kwin"."Window to Desktop 7" = [ ];
      "kwin"."Window to Desktop 8" = [ ];
      "kwin"."Window to Desktop 9" = [ ];
      "kwin"."Window to Next Desktop" = "";
      "kwin"."Window to Next Screen" = "Meta+Shift+Right";
      "kwin"."Window to Previous Desktop" = [ ];
      "kwin"."Window to Previous Screen" = "Meta+Shift+Left";
      "kwin"."Window to Screen 0" = [ ];
      "kwin"."Window to Screen 1" = [ ];
      "kwin"."Window to Screen 2" = [ ];
      "kwin"."Window to Screen 3" = [ ];
      "kwin"."Window to Screen 4" = [ ];
      "kwin"."Window to Screen 5" = [ ];
      "kwin"."Window to Screen 6" = [ ];
      "kwin"."Window to Screen 7" = [ ];
      "kwin"."view_actual_size" = "\\, Meta+0\\, ,Meta+0,Zoom to Actual Size";
      "kwin"."view_zoom_in" = ["Meta++" "Meta+=,Meta++" "Meta+=,Zoom In"];
      "kwin"."view_zoom_out" = "Meta+-";
      "mediacontrol"."mediavolumedown" = "none,,Media volume down";
      "mediacontrol"."mediavolumeup" = "none,,Media volume up";
      "mediacontrol"."nextmedia" = "Media Next";
      "mediacontrol"."pausemedia" = "Media Pause";
      "mediacontrol"."playmedia" = "none,,Play media playback";
      "mediacontrol"."playpausemedia" = "Media Play";
      "mediacontrol"."previousmedia" = "Media Previous";
      "mediacontrol"."stopmedia" = "Media Stop";
      "org_kde_powerdevil"."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
      "org_kde_powerdevil"."Decrease Screen Brightness" = "Monitor Brightness Down";
      "org_kde_powerdevil"."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
      "org_kde_powerdevil"."Hibernate" = "Hibernate";
      "org_kde_powerdevil"."Increase Keyboard Brightness" = "Keyboard Brightness Up";
      "org_kde_powerdevil"."Increase Screen Brightness" = "Monitor Brightness Up";
      "org_kde_powerdevil"."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
      "org_kde_powerdevil"."PowerDown" = "Power Down";
      "org_kde_powerdevil"."PowerOff" = "Power Off";
      "org_kde_powerdevil"."Sleep" = "Sleep";
      "org_kde_powerdevil"."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
      "org_kde_powerdevil"."Turn Off Screen" = [ ];
      "org_kde_powerdevil"."powerProfile" = ["Battery" "" "Meta+B\\, ,Battery" "Meta+B,Switch Power Profile"];
      "plasmashell"."activate application launcher" = ["Meta" "" "Alt+F1\\, ,Meta" "Alt+F1,Activate Application Launcher"];
      "plasmashell"."activate task manager entry 1" = "Meta+1";
      "plasmashell"."activate task manager entry 10" = ",Meta+0,Activate Task Manager Entry 10";
      "plasmashell"."activate task manager entry 2" = "Meta+2";
      "plasmashell"."activate task manager entry 3" = "Meta+3";
      "plasmashell"."activate task manager entry 4" = "Meta+4";
      "plasmashell"."activate task manager entry 5" = "Meta+5";
      "plasmashell"."activate task manager entry 6" = "Meta+6";
      "plasmashell"."activate task manager entry 7" = "Meta+7";
      "plasmashell"."activate task manager entry 8" = "Meta+8";
      "plasmashell"."activate task manager entry 9" = "Meta+9";
      "plasmashell"."clear-history" = "none,,Clear Clipboard History";
      "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
      "plasmashell"."cycle-panels" = "Meta+Alt+P";
      "plasmashell"."cycleNextAction" = [ ];
      "plasmashell"."cyclePrevAction" = [ ];
      "plasmashell"."manage activities" = "Meta+Q";
      "plasmashell"."next activity" = [ ];
      "plasmashell"."previous activity" = [ ];
      "plasmashell"."repeat_action" = "Meta+Ctrl+R";
      "plasmashell"."show dashboard" = "Ctrl+F12";
      "plasmashell"."show-barcode" = [ ];
      "plasmashell"."show-on-mouse-pos" = "Meta+V";
      "plasmashell"."stop current activity" = "Meta+S";
      "plasmashell"."switch to next activity" = [ ];
      "plasmashell"."switch to previous activity" = [ ];
      "plasmashell"."toggle do not disturb" = [ ];
      "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+Ctrl+Alt+Shift+Space";
      "services/org.kde.spectacle.desktop"."RecordWindow" = [ ];
    };
    configFile = {
      "baloofilerc"."General"."dbVersion" = 2;
      "baloofilerc"."General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      "baloofilerc"."General"."exclude filters version" = 9;
      "dolphinrc"."General"."ViewPropsTimestamp" = "2024,9,12,5,0,47.778";
      "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      "kactivitymanagerdrc"."activities"."622e6a72-77d5-4d90-9c31-a657d9ad6a70" = "Default";
      "kactivitymanagerdrc"."main"."currentActivity" = "622e6a72-77d5-4d90-9c31-a657d9ad6a70";
      "katerc"."General"."Days Meta Infos" = 30;
      "katerc"."General"."Last Session" = "nixcfg";
      "katerc"."General"."Save Meta Infos" = true;
      "katerc"."General"."Session Manager Sort Column" = 0;
      "katerc"."General"."Session Manager Sort Order" = 0;
      "katerc"."General"."Show Full Path in Title" = false;
      "katerc"."General"."Show Menu Bar" = true;
      "katerc"."General"."Show Status Bar" = true;
      "katerc"."General"."Show Tab Bar" = true;
      "katerc"."General"."Show Url Nav Bar" = true;
      "katerc"."KTextEditor Renderer"."Animate Bracket Matching" = false;
      "katerc"."KTextEditor Renderer"."Auto Color Theme Selection" = true;
      "katerc"."KTextEditor Renderer"."Color Theme" = "Breeze Light";
      "katerc"."KTextEditor Renderer"."Line Height Multiplier" = 1;
      "katerc"."KTextEditor Renderer"."Show Indentation Lines" = false;
      "katerc"."KTextEditor Renderer"."Show Whole Bracket Expression" = false;
      "katerc"."KTextEditor Renderer"."Text Font" = "Hack,10,-1,7,400,0,0,0,0,0,0,0,0,0,0,1";
      "katerc"."KTextEditor Renderer"."Text Font Features" = "";
      "katerc"."KTextEditor Renderer"."Word Wrap Marker" = false;
      "katerc"."KTextEditor::Search"."Replace History" = ",fcitx";
      "katerc"."KTextEditor::Search"."Search History" = "next,pkgs.,fctix";
      "katerc"."filetree"."editShade" = "183,220,246";
      "katerc"."filetree"."listMode" = false;
      "katerc"."filetree"."middleClickToClose" = false;
      "katerc"."filetree"."shadingEnabled" = true;
      "katerc"."filetree"."showCloseButton" = false;
      "katerc"."filetree"."showFullPathOnRoots" = false;
      "katerc"."filetree"."showToolbar" = true;
      "katerc"."filetree"."sortRole" = 0;
      "katerc"."filetree"."viewShade" = "211,190,222";
      "katerc"."lspclient"."AllowedServerCommandLines" = "/run/current-system/sw/bin/nil";
      "katerc"."lspclient"."AutoHover" = true;
      "katerc"."lspclient"."AutoImport" = true;
      "katerc"."lspclient"."BlockedServerCommandLines" = "";
      "katerc"."lspclient"."CompletionDocumentation" = true;
      "katerc"."lspclient"."CompletionParens" = true;
      "katerc"."lspclient"."Diagnostics" = true;
      "katerc"."lspclient"."FormatOnSave" = false;
      "katerc"."lspclient"."HighlightGoto" = true;
      "katerc"."lspclient"."IncrementalSync" = false;
      "katerc"."lspclient"."InlayHints" = false;
      "katerc"."lspclient"."Messages" = true;
      "katerc"."lspclient"."ReferencesDeclaration" = true;
      "katerc"."lspclient"."SemanticHighlighting" = true;
      "katerc"."lspclient"."ServerConfiguration" = "";
      "katerc"."lspclient"."SignatureHelp" = true;
      "katerc"."lspclient"."SymbolDetails" = false;
      "katerc"."lspclient"."SymbolExpand" = true;
      "katerc"."lspclient"."SymbolSort" = false;
      "katerc"."lspclient"."SymbolTree" = true;
      "katerc"."lspclient"."TypeFormatting" = false;
      "kcminputrc"."Libinput/1739/53160/SYNA802E:00 06CB:CFA8 Mouse"."PointerAcceleration" = "-0.400";
      "kcminputrc"."Libinput/1739/53160/SYNA802E:00 06CB:CFA8 Mouse"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Libinput/1739/53160/SYNA802E:00 06CB:CFA8 Touchpad"."NaturalScroll" = true;
      "kcminputrc"."Libinput/2/10/TPPS\\/2 Elan TrackPoint"."PointerAcceleration" = 0.4;
      "kcminputrc"."Libinput/2/10/TPPS\\/2 Elan TrackPoint"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Mouse"."cursorTheme" = "kasane-teto-cursors";
      "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      "kded5rc"."Module-device_automounter"."autoload" = false;
      "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "820,575";
      "kdeglobals"."General"."XftHintStyle" = "hintslight";
      "kdeglobals"."General"."XftSubPixel" = "none";
      "kdeglobals"."General"."fixed" = "ComicShannsMono Nerd Font Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."font" = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      "kdeglobals"."General"."menuFont" = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      "kdeglobals"."General"."smallestReadableFont" = "rainyhearts,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      "kdeglobals"."General"."toolBarFont" = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      "kdeglobals"."Icons"."Theme" = "Memphis98";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0.5;
      "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
      "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
      "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 140;
      "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      "kdeglobals"."Shortcuts"."Paste Selection" = "";
      "kdeglobals"."Sounds"."Theme" = "freedesktop";
      "kdeglobals"."WM"."activeBackground" = "239,207,239";
      "kdeglobals"."WM"."activeBlend" = "113,42,255";
      "kdeglobals"."WM"."activeFont" = "rainyhearts,12,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Medium";
      "kdeglobals"."WM"."activeForeground" = "77,34,203";
      "kdeglobals"."WM"."inactiveBackground" = "226,226,225";
      "kdeglobals"."WM"."inactiveBlend" = "75,71,67";
      "kdeglobals"."WM"."inactiveForeground" = "79,34,212";
      "krunnerrc"."General"."FreeFloating" = true;
      "krunnerrc"."General"."historyBehavior" = "ImmediateCompletion";
      "ksplashrc"."KSplash"."Theme" = "Lain";
      "kwalletrc"."Wallet"."First Use" = false;
      "kwinrc"."Desktops"."Id_1" = "e1b30ce8-3fdc-4fd0-bbca-31f3803ec38c";
      "kwinrc"."Desktops"."Id_2" = "3bcb0dc7-282c-4a0d-9856-6995ccf2c4bf";
      "kwinrc"."Desktops"."Id_3" = "b2b16750-2528-4ff9-ae34-27244e24aef6";
      "kwinrc"."Desktops"."Id_4" = "bb135642-f1af-4b8a-8a3a-995dbfd01b6f";
      "kwinrc"."Desktops"."Name_1" = "Floor 1";
      "kwinrc"."Desktops"."Name_2" = "Abandoned Factory";
      "kwinrc"."Desktops"."Name_3" = "S-23 Sirepenski";
      "kwinrc"."Desktops"."Name_4" = "HEADSPACE";
      "kwinrc"."Desktops"."Number" = 4;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."Effect-overview"."GridTouchBorderActivate" = 6;
      "kwinrc"."Effect-windowview"."TouchBorderActivateAll" = 2;
      "kwinrc"."Plugins"."cubeEnabled" = true;
      "kwinrc"."Plugins"."krohnkiteEnabled" = true;
      "kwinrc"."Plugins"."poloniumEnabled" = false;
      "kwinrc"."Script-krohnkite"."screenGapBottom" = 6;
      "kwinrc"."Script-krohnkite"."screenGapLeft" = 6;
      "kwinrc"."Script-krohnkite"."screenGapRight" = 6;
      "kwinrc"."Script-krohnkite"."screenGapTop" = 6;
      "kwinrc"."Script-krohnkite"."tileLayoutGap" = 6;
      "kwinrc"."Script-polonium"."Borders" = 3;
      "kwinrc"."Tiling"."padding" = 4;
      "kwinrc"."Tiling/5d380157-e978-540c-88f7-10b284aaee53"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/69695102-ff41-5858-880f-3125a6b3c4eb"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/6abcf14a-2ceb-5e73-a2ed-5c3ce35a7afa"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/7964f844-12f1-54d2-ac84-38ee55197d54"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b\x5d}";
      "kwinrc"."Tiling/a66921b3-c7a8-5090-bb3d-4faeeffb28a0"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/d02c035d-eef0-5c68-aa2f-2e83d0ba08b1"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      "kwinrc"."TouchEdges"."Bottom" = "ApplicationLauncher";
      "kwinrc"."TouchEdges"."Top" = "KRunner";
      "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
      "kwinrc"."Wayland"."InputMethod\x5b$e\x5d" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
      "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;
      "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
      "kwinrc"."Windows"."FocusStealingPreventionLevel" = 2;
      "kwinrc"."Windows"."RollOverDesktops" = true;
      "kwinrc"."Xwayland"."Scale" = 1.5;
      "kwinrc"."org.kde.kdecoration2"."theme" = "__aurorae__svg__Plasma-Overdose_x1.5";
      "kxkbrc"."Layout"."DisplayNames" = "";
      "kxkbrc"."Layout"."LayoutList" = "us";
      "kxkbrc"."Layout"."Options" = "korean:ralt_hangul,korean:rctrl_hanja,caps:backspace";
      "kxkbrc"."Layout"."ResetOldOptions" = true;
      "kxkbrc"."Layout"."Use" = true;
      "kxkbrc"."Layout"."VariantList" = "";
      "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
      "plasma-localerc"."Formats"."LC_ADDRESS" = "C";
      "plasma-localerc"."Formats"."LC_NAME" = "C";
      "plasma-localerc"."Formats"."LC_PAPER" = "C";
      "plasma-localerc"."Formats"."LC_TELEPHONE" = "C";
      "plasma-localerc"."Formats"."LC_TIME" = "C";
      "plasmanotifyrc"."Applications/com.usebottles.bottles"."Seen" = true;
      "plasmanotifyrc"."Applications/thunderbird"."Seen" = true;
      "plasmaparc"."General"."GlobalMute" = true;
      "plasmarc"."Wallpapers"."usersWallpapers" = "/home/l1npengtul/Downloads/Screenshot_20200828_135214.png";
      "spectaclerc"."Annotations"."annotationToolType" = 2;
      "spectaclerc"."Annotations"."freehandShadow" = false;
      "spectaclerc"."Annotations"."freehandStrokeWidth" = 15;
      "spectaclerc"."GuiConfig"."captureMode" = 0;
      "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
      "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
    };
    dataFile = {
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
      "kate/anonymous.katesession"."Document 0"."Encoding" = "ISO-8859-1";
      "kate/anonymous.katesession"."Document 0"."URL" = "file:///home/l1npengtul/.BitwigStudio/prefs/5.2.prefs";
      "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
      "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
      "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" = "0,1882,0";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" = "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,lspclient_symbol_outline";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" = 294;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" = 1099;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" = 1099;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" = 1882;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" = "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" = 245;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" = 1591;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" = "0,850,245";
      "kate/anonymous.katesession"."MainWindow0"."ToolBarsMovable" = "Disabled";
      "kate/anonymous.katesession"."MainWindow0 Settings"."ToolBarsMovable" = "Disabled";
      "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 10;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" = "MainWindow0-ViewSpace 0";
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 1882;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" = "file:///home/l1npengtul/.BitwigStudio/prefs/5.2.prefs";
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 1;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" = "file:///home/l1npengtul/.BitwigStudio/prefs/5.2.prefs";
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" = "file:///home/l1npengtul/.BitwigStudio/prefs/5.2.prefs";
      "kate/anonymous.katesession"."Open Documents"."Count" = 1;
      "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
      "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" = 1;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiless" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" = 128;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" = false;
    };
  };



  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  xdg.portal.config.common.default = "*";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home = {
    packages = with pkgs; [
      cowsay
      plasma-overdose-kde-theme
      xdg-desktop-portal-kde
      devenv maliit-keyboard maliit-framework kdePackages.plasma-thunderbolt
    ];

    stateVersion = "24.05";
  };
}

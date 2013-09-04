import XMonad
import XMonad.Hooks.DynamicLog -- enable status bar support
import XMonad.Hooks.ManageDocks -- manage xmobar
import XMonad.Hooks.ManageHelpers -- This module provides helper functions to be used in manageHook.
import XMonad.Util.Run(spawnPipe) -- This module provides several commands to run an external process.
import XMonad.Util.EZConfig(additionalKeys) -- emacs-like keybinding
import XMonad.Layout.NoBorders -- Make a given layout display without borders.
-- import XMonad.Actions.FloatKeys -- move & resize floating windows
-- import XMonad.Hooks.UrgencyHook -- configure an action to occur when a window demands your attention.
import System.IO

myManageHook = composeAll
  [ className =? "Steam" --> doFloat
  , manageDocks
  ]

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/threv/.xmonad/xmobarrc"
  xmonad $ defaultConfig {
        manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "skyblue" "" . shorten 63
                        -- , ppHiddenNoWindows = xmobarColor "grey" ""
                        }
        , borderWidth        = 1
        , normalBorderColor  = "#cccccc"
        , focusedBorderColor = "#00cc00"
        }

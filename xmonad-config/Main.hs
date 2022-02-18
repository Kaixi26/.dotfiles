{-# OPTIONS_GHC -Wno-deprecations #-}
import XMonad (ChangeLayout (NextLayout), Default (def), Full (Full), IncMasterN (IncMasterN), Resize (Expand, Shrink), Tall (Tall), XConfig (borderWidth, focusFollowsMouse, focusedBorderColor, handleEventHook, keys, layoutHook, manageHook, modMask, normalBorderColor, workspaces), composeAll, kill, mod4Mask, refresh, sendMessage, spawn, windows, withFocused, xmonad, (-->), (|||))
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Layout.Groups.Helpers (focusDown)
import XMonad.Layout.NoBorders (Ambiguity (Never), noBorders, smartBorders)
import XMonad.Layout.Spacing (Border (Border), spacing, spacingRaw)
import XMonad.Layout.ThreeColumns ()
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.Ungrab (unGrab)
import XMonad.Util.Replace (replace)

terminal :: String
terminal = "/usr/bin/env $TERM"

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 10]

manage =
  composeAll
    [ manageDocks,
      isFullscreen --> doFullFloat,
      manageHook def
    ]

handleEvent =
  mconcat
    [ docksEventHook,
      fullscreenEventHook,
      handleEventHook def
    ]

layout =
  let tiled =
        smartBorders $
          avoidStruts $
            spacingRaw False border True border True $
              Tall nmaster delta ratio
      full =
        noBorders Full

      border = Border 4 4 4 4
      nmaster = 1
      delta = 3 / 100
      ratio = 1 / 2
   in tiled ||| full

keyMap =
  let focusBinds =
        [ ("M-j", windows W.focusDown),
          ("M-k", windows W.focusUp),
          ("M-S-j", windows W.swapDown),
          ("M-S-k", windows W.swapUp)
        ]
      layoutBinds =
        [ ("M-h", sendMessage Shrink),
          ("M-l", sendMessage Expand),
          ("M-<Space>", sendMessage NextLayout),
          ("M-,", sendMessage (IncMasterN 1)),
          ("M-.", sendMessage (IncMasterN (-1))),
          ("M-t", withFocused $ windows . W.sink),
          ("M-n", refresh)
        ]
      appBinds =
        [ ("M-<Return>", spawn terminal),
          ("<Print>", unGrab *> spawn "flameshot"),
          ("M-d", spawn "rofi -show drun"),
          ("M-p", spawn "i3lock -c 000000"),
          ("<XF86MonBrightnessUp>", spawn "light -A 5"),
          ("<XF86MonBrightnessDown>", spawn "light -U 5"),
          ("<XF86AudioRaiseVolume>", spawn "pulsemixer --max-volume 100 --change-volume +5"),
          ("<XF86AudioLowerVolume>", spawn "pulsemixer --max-volume 100 --change-volume -5"),
          ("<XF86AudioMute>", spawn "pulsemixer --max-volume 100 --toggle-mute"),
          ("M-S-q", kill)
        ]
      workspaceBinds =
        [ ("M-" ++ mod ++ [key], windows $ fn wspc)
          | (wspc, key) <- zip myWorkspaces $ ['1' .. '9'] ++ ['0'],
            (fn, mod) <- [(W.greedyView, ""), (W.shift, "S-")]
        ]
   in concat
        [ appBinds,
          focusBinds,
          layoutBinds,
          workspaceBinds
        ]

main :: IO ()
main = do
  spawn "systemctl --user restart polybar.service"
  xmonad $
    ewmh $ -- TODO: ewmhFullscreen when contrib 0.17.0 is properly supported
      def
        { modMask = mod4Mask,
          keys = (`mkKeymap` keyMap),
          workspaces = myWorkspaces,
          borderWidth = 1,
          focusedBorderColor = "#5e81ac",
          normalBorderColor = "#000000",
          focusFollowsMouse = False,
          layoutHook = layout,
          manageHook = manage,
          handleEventHook = handleEvent
        }

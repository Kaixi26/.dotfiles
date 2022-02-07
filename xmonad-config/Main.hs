import XMonad (ChangeLayout (NextLayout), Default (def), Full (Full), IncMasterN (IncMasterN), Resize (Expand, Shrink), Tall (Tall), XConfig (borderWidth, focusFollowsMouse, focusedBorderColor, handleEventHook, keys, manageHook, modMask, normalBorderColor, workspaces), composeAll, kill, mod4Mask, refresh, sendMessage, spawn, windows, withFocused, xmonad, (-->), (|||))
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Groups.Helpers (focusDown)
import XMonad.Layout.NoBorders (Ambiguity (Never), noBorders, smartBorders)
import XMonad.Layout.Spacing (Border (Border), spacingRaw)
import XMonad.Layout.ThreeColumns ()
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (mkKeymap)
import XMonad.Util.Ungrab (unGrab)

terminal :: String
terminal = "/usr/bin/env $TERM"

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 10]

layout =
  let tiled =
        spacingRaw True border True border True $
          smartBorders $
            avoidStruts $
              Tall nmaster delta ratio

      border = Border 4 4 4 4
      nmaster = 1
      delta = 1 / 2
      ratio = 1 / 2
   in tiled ||| Full

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
  xmonad $
    ewmh $ -- TODO: ewmhFullscreen when contrib 0.17.0 is properly supported
      def
        { modMask = mod4Mask,
          keys = (`mkKeymap` keyMap),
          workspaces = myWorkspaces,
          borderWidth = 1,
          focusedBorderColor = "#5e81ac",
          normalBorderColor = "#e5e9f9",
          focusFollowsMouse = False,
          manageHook =
            composeAll
              [ manageDocks,
                isFullscreen --> doFullFloat,
                manageHook def
              ],
          handleEventHook =
            mconcat
              [ docksEventHook,
                fullscreenEventHook,
                handleEventHook def
              ]
        }

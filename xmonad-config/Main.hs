import Data.Bits ((.|.))
import Data.Default
import qualified Data.Map as M
import Data.Monoid
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops as EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout
import XMonad.Layout.Fullscreen as Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.Hidden
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)

main :: IO ()
main = do
  --    xmonad =<< xmobar customCfg
  --      spawn "sh .scripts/setwallpaper.sh"
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.config"
  spawn "! (pidof trayer) && trayer --align right --edge top --width 5 --height 21 --transparent true --tint 0x282a36 --alpha 0"
  xmonad $
    ewmh
      customCfg
        { logHook = myLogHook xmproc
        }

-- Global Configuration
customCfg =
  def
    { modMask = myModMask,
      borderWidth = 1,
      focusedBorderColor = "#ff79c6",
      normalBorderColor = "#6272a4",
      focusFollowsMouse = False,
      workspaces = myWorkspaces,
      keys = customKeys,
      manageHook = myManageHook,
      handleEventHook = myHandleEventHook,
      layoutHook = customLayout
    }

myModMask = mod4Mask

-- Layout Configuration
customLayout = tiled ||| tiledMirror ||| fullscreen
  where
    border = Border 4 4 4 4
    tiled =
      avoidStruts $
        smartBorders $
          spacingRaw True border True border True $
            Tall nmaster delta ratio

    tiledMirror =
      avoidStruts $
        smartBorders $
          Mirror $
            spacingRaw True border True border True $
              Tall nmaster delta ratio

    fullscreen = fullscreenFull $ noBorders Full
    --grid = avoidStruts $ smartBorders Grid
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

-- Hooks Configuration
myManageHook =
  composeAll
    [ manageDocks,
      isFullscreen --> doFullFloat,
      manageHook def
    ]

myHandleEventHook =
  mconcat
    [ docksEventHook,
      EwmhDesktops.fullscreenEventHook,
      handleEventHook def
    ]

myLogHook xmproc =
  dynamicLogWithPP
    xmobarPP
      { ppOutput = hPutStrLn xmproc . fixEncoding,
        ppCurrent = const "<fc=#c678dd>●</fc>", --xmobarColor "#ff79c6" ""
        ppVisible = const "<fc=#c678dd>◉</fc>", --xmobarColor "#f8f8f2" ""
        ppHidden = const "<fc=#abb2bf>●</fc>", --xmobarColor "#6272a4" ""
        ppTitle = const "", --xmobarColor "white" "" . shorten 50
        ppHiddenNoWindows = const "<fc=#abb2bf>◯</fc>",
        ppWsSep = " ",
        ppLayout = const ""
      }
  where
    fixEncoding :: String -> String
    fixEncoding [] = []
    fixEncoding ('\226' : '\151' : '\143' : xs) = '●' : fixEncoding xs
    fixEncoding ('\226' : '\151' : '\175' : xs) = '◯' : fixEncoding xs
    fixEncoding (x : xs) = x : fixEncoding xs

-- Workspaces
myWorkspaces :: [String]
myWorkspaces = map show [1 .. 10]

myWorkspacesBindings =
  [ ((m .|. myModMask, k), windows $ f i)
    | (i, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0]),
      (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ]

-- Key Configuration
customKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
customKeys conf@XConfig {XMonad.modMask = modMask} =
  M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_q), kill), -- %! Close the focused window
      ((modMask, xK_space), sendMessage NextLayout), -- %! Rotate through the available layout algorithms
      ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf), -- %!  Reset the layouts on the current workspace to default
      ((modMask, xK_n), refresh), -- %! Resize viewed windows to the correct size

      -- move focus up or down the window stack
      ((modMask, xK_j), windows W.focusDown), -- %! Move focus to the next window
      ((modMask, xK_k), windows W.focusUp), -- %! Move focus to the previous window

      -- modifying the window order
      ((modMask .|. shiftMask, xK_Return), windows W.swapMaster), -- %! Swap the focused window and the master window
      ((modMask .|. shiftMask, xK_j), windows W.swapDown), -- %! Swap the focused window with the next window
      ((modMask .|. shiftMask, xK_k), windows W.swapUp), -- %! Swap the focused window with the previous window

      -- resizing the master/slave ratio
      ((modMask, xK_h), sendMessage Shrink), -- %! Shrink the master area
      ((modMask, xK_l), sendMessage Expand), -- %! Expand the master area

      -- floating layer support
      ((modMask, xK_t), withFocused $ windows . W.sink), -- %! Push window back into tiling

      -- increase or decrease number of windows in the master area
      ((modMask, xK_comma), sendMessage (IncMasterN 1)), -- %! Increment the number of windows in the master area
      ((modMask, xK_period), sendMessage (IncMasterN (-1))), -- %! Deincrement the number of windows in the master area

      -- quit, or restart
      ((modMask, xK_r), spawn "xmonad --recompile 2>&1 | xargs -I {} notify-send {} && xmonad --restart && notify-send 'Restarted'") -- %! Restart xmonad
    ]
      ++ myWorkspacesBindings

--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad

import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.Run(spawnPipe)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Place

import XMonad.Layout.NoBorders
import XMonad.Layout.Maximize
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.AutoMaster
import XMonad.Layout.Renamed
import XMonad.Layout.Grid

import XMonad.Prompt
import XMonad.Prompt.DirExec

import XMonad.Actions.WindowBringer
import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces

import Graphics.X11.ExtraTypes.XF86

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings.
--
myModMask       = mod3Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = map show [1..9]

-- Border colors for unfocused and focused windows, respectively.

myFocusedBorderColor  = "#8a999e"
myNormalBorderColor = "#343d55"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask,        xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modMask,               xK_d     ), spawn "dmenu_run")

    , ((modMask,               xK_a     ), dirExecPromptNamed
            def spawn "/home/peplin/.xmonad/actions" "Scripts: ")

    -- Screeenshot selected area and save to /tmp
    , ((modMask, xK_s     ), spawn "maim -s | xclip -selection clipboard -t image/png && xclip -selection clipboard -o > /tmp/Screenshot-$(date +%Y-%m-%d-%T).png")

    -- launch application launcher
    , ((mod1Mask, xK_F2 ), spawn "gmrun")

    -- close focused window
    , ((modMask .|. shiftMask, xK_c     ), kill)
    -- preserve normal alt-f4 behavior to close focused window
    , ((mod1Mask, xK_F4     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Preserve traditional alt-tab like behavior but switch between
    -- workspaces instead of windows
    , ((mod1Mask, xK_Tab), cycleRecentWS [xK_Alt_L] xK_Tab xK_grave)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask, xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask, xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask, xK_q     ), restart "xmonad" True)

    -- to hide/unhide the panel
    , ((modMask, xK_b), sendMessage ToggleStruts)

    -- lock the screen
    , ((modMask, xK_z), spawn "loginctl lock-session")

    , ((modMask, xK_x), goToSelected def)

    -- temporarily maximize a window
    , ((modMask, xK_backslash), withFocused (sendMessage . maximizeRestore))

    -- toggle master pane on left/right
    , ((modMask, xK_f), sendMessage $ Toggle REFLECTX)

    -- audio
    , ((0, xF86XK_AudioLowerVolume), spawn "updatevolume.sh -")
    , ((0, xF86XK_AudioRaiseVolume), spawn "updatevolume.sh +")
    , ((0, xF86XK_AudioMute), spawn "mute.sh")

    -- lcd brightness
    , ((0, xF86XK_MonBrightnessUp), spawn "light -A 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "light -U 5")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- dynamic workspaces
    [
      -- ((modMask, xK_BackSpace), removeWorkspace)
      ((modMask, xK_v      ), selectWorkspace def)
      , ((modMask, xK_m                    ), withWorkspace def (windows . W.shift))
      , ((modMask, xK_n                    ), addWorkspacePrompt def)]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- allow dragging with traditional alt
    [ ((mod1Mask, button1), (\w -> focus w >> mouseMoveWindow w))

    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = mkToggle(single REFLECTX) $
        tiled ||| mirrored ||| fullscreen ||| grid
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = renamed [Replace "Tiled"] $ maximize(reflectHoriz $ Tall nmaster delta ratio)

     -- rotated 90 degrees
     mirrored = Mirror tiled

     fullscreen = Full

     grid = Grid

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 3/5

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "gmrun"  --> doFloat
    , className =? "Peek"           --> doFloat
    , className =? "Xfce4-notifyd" --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
    , isFullscreen --> doFullFloat
    , isDialog --> doCenterFloat ]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-- myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmobar <- spawnPipe "xmobar"
    trayproc <- spawnPipe "killall trayer -q; sleep 10; trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --width 4 --alpha 0 --transparent true --height 18 --tint 000000"
    xmonad $ docks $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = smartBorders $ avoidStruts $ myLayout,
        manageHook         = placeHook simpleSmart <+> manageDocks <+> myManageHook,
        logHook            =  (dynamicLogWithPP xmobarPP {ppOutput = hPutStrLn xmobar}),
        startupHook        = myStartupHook,
        handleEventHook    = handleEventHook def <+> fullscreenEventHook
    }

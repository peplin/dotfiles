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
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Place

import XMonad.Layout.NoBorders
import XMonad.Layout.Maximize
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.AutoMaster
import XMonad.Layout.Renamed

import XMonad.Prompt
import XMonad.Prompt.DirExec

import XMonad.Actions.WindowBringer
import XMonad.Actions.Submap
import XMonad.Actions.Search
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"

-- multimedia keys
xK_XF86AudioLowerVolume = 0x1008ff11
xK_XF86AudioRaiseVolume = 0x1008ff13
xK_XF86AudioMute        = 0x1008ff12
xK_XF86AudioNext        = 0x1008ff17
xK_XF86AudioPrev        = 0x1008ff16
xK_XF86AudioPlay        = 0x1008ff14
xK_XF86AudioStop        = 0x1008ff15
xK_XF86AudioMedia       = 0x1008ff32

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
myWorkspaces    = ["web", "code", "email", "music"] ++ map show [5..9]

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
            defaultXPConfig spawn "/home/peplin/.xmonad/actions" "Scripts: ")


    -- launch application launcher
    , ((modMask,               xK_p     ), spawn "gmrun")
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

    -- Move focus to the master window
    , ((modMask, xK_m     ), windows W.focusMaster  )

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
    , ((modMask, xK_z), spawn "xscreensaver-command --lock")

    -- window bringer
    , ((modMask .|. shiftMask, xK_g     ), gotoMenu)
    , ((modMask .|. shiftMask, xK_b     ), bringMenu)

    , ((modMask, xK_x), goToSelected defaultGSConfig)

    -- temporarily maximize a window
    , ((modMask, xK_backslash), withFocused (sendMessage . maximizeRestore))

    -- toggle master pane on left/right
    , ((modMask, xK_f), sendMessage $ Toggle REFLECTX)

    -- music
    , ((mod4Mask, xK_c), spawn "ncmpcpp toggle")
    , ((mod4Mask, xK_b), spawn "ncmpcpp next")
    , ((mod4Mask, xK_z), spawn "ncmpcpp prev")

    -- audi
    , ((modMask, xK_KP_Subtract), spawn "$HOME/.dotfiles/bin/updatevolume.sh -")
    , ((0, xK_XF86AudioLowerVolume), spawn "$HOME/.dotfiles/bin/updatevolume.sh -")
    , ((modMask, xK_KP_Add), spawn "$HOME/.dotfiles/bin/updatevolume.sh +")
    , ((0, xK_XF86AudioRaiseVolume), spawn "$HOME/.dotfiles/bin/updatevolume.sh +")
    , ((0, xK_XF86AudioMute), spawn "$HOME/.dotfiles/bin/mute.sh")

    -- Search commands
    , ((modMask, xK_s), promptSearch defaultXPConfig google)
    , ((modMask .|. shiftMask, xK_s), selectSearch google)

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

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- dynamic workspaces
    [((modMask, xK_BackSpace), removeWorkspace)
      , ((modMask, xK_v      ), selectWorkspace defaultXPConfig)
      , ((modMask, xK_m                    ), withWorkspace defaultXPConfig (windows . W.shift))
      , ((modMask, xK_n                    ), addWorkspacePrompt defaultXPConfig)]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- also allow dragging with traditional alt
    , ((mod1Mask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
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
        tiled ||| mirrored ||| fullscreen
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = renamed [Replace "Tiled"] $ maximize(reflectHoriz $ Tall nmaster delta ratio)

     -- rotated 90 degrees
     mirrored = Mirror tiled

     fullscreen = Full

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 4/6

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
    [ className =? "MPlayer"        --> doFloat
    , className =? "google-chrome"       --> doShift "web"
    , className =? "Thunderbird"       --> doShift "email"
    , className =? "VirtualBox"     --> doShift "vm"
    , className =? "VMware Player"     --> doShift "vm"
    , className =? "Gimp"           --> doFloat
    , className =? "gmrun"  --> doFloat
    , className =? "Skype"           --> doFloat
    , className =? "emulator-arm"           --> doFloat
    , className =? "Xfce4-notifyd" --> doIgnore
    , className =? "Eclipse" --> doShift "eclipse"
    , resource  =? "desktop_window" --> doIgnore ]

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
    trayproc <- spawnPipe "killall trayer; sleep 5; trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --width 3 --alpha 0 --transparent true --height 18 --tint 000000"
    xmonad $ ewmh defaultConfig {
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
        startupHook        = myStartupHook
    }
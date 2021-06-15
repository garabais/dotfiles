--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Util.SpawnOnce

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Spacing

import XMonad.Util.EZConfig

import XMonad.Actions.Promote
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS

import XMonad.Layout.SimplestFloat
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#292d3e"
myFocusedBorderColor = "#bbc5ff"



------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys = \c -> mkKeymap c $

	-- launch a terminal
    [ ("M-<Return>", spawn $ terminal c)

	-- Close the focused window
    , ("M-w", kill)

	-- Close the focused window
    , ("M-S-w", killAll)

	-- recompile and restart xmonad
    , (("M-<Esc>"), spawn "xmonad --recompile; xmonad --restart")

    -- launch dmenu
    , (("M-<Space>"), spawn "rofi -show")

    -- launch dmenu with gpu if hybrid mode is activated
    , (("M-C-M1-<Space>"), spawn "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=\"nvidia\" __VK_LAYER_NV_optimus=\"NVIDIA_only\" rofi -show")

    -- Move focus to the next window
    , (("M-j"), windows W.focusDown)

    -- Move focus to the previous window
    , (("M-k"), windows W.focusUp)

    -- Move focus to the next window
    , (("M-S-j"), windows W.swapDown)

    -- Move focus to the previous window
    , (("M-S-k"), windows W.swapUp)

	-- Move focus to the master window
	, ("M-m", windows W.focusMaster)

     -- Rotate through the available layout algorithms
	, (("M-<Tab>"), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , (("M-C-<Tab>"), setLayout $ XMonad.layoutHook c)

    -- Shrink the master area
    , (("M-h"), sendMessage Shrink)

    -- Expand the master area
    , (("M-l"), sendMessage Expand)

    -- Quit xmonad
    , (("M-S-<Esc>"), io (exitWith ExitSuccess))

    -- Increment the number of windows in the master area
    , (("M-/"), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , (("M-S-/"), sendMessage (IncMasterN (-1)))

	-- Run google chrome
    , (("M-n"), spawn "google-chrome-stable")

	-- Run Youtube Music
    , (("M-y"), spawn "gtk-launch chrome-cinhimbnkkaeohfgghhklpknlkffjgod-Default")

    -- Resize viewed windows to the correct size
    , (("M-s"), refresh)

	-- Swap the focused window and the master window
    , (("M-S-m"), promote)

    -- Push window back into tiling
    , (("M-t"), withFocused $ windows . W.sink)

    -- Push all floating windows back into tiling
    , (("M-S-t"), sinkAll)

	-- Decrease Volume
	, (("<XF86AudioLowerVolume>"), spawn "pulsemixer --change-volume -1")

	-- Increase Volume
	, (("<XF86AudioRaiseVolume>"), spawn "pulsemixer --change-volume +1")

	-- Mute Volume
	, (("<XF86AudioMute>"), spawn "pulsemixer --toggle-mute")

	-- Decrease monitor brightness
	, (("<XF86MonBrightnessDown>"), spawn "backlight -d 750")

	-- Increase monitor brightness
	, (("<XF86MonBrightnessUp>"), spawn "backlight -i 750")

	-- Pause audio source
	, (("<XF86AudioPlay>"), spawn "playerctl play-pause")

	-- Next audio source
	, (("<XF86AudioNext>"), spawn "playerctl next")

	-- Previous audio source
	, (("<XF86AudioPrev>"), spawn "playerctl previous")
	, (("M-q"), sendMessage ToggleStruts)

	-- Screanshoot
	-- , (("<Print>"), spawn "scrot -e 'mv $f ~/Pictures/Screenshoots/'")

	-- Screanshoot
	-- , (("C-<Print>"), spawn "scrot -s -f -e 'mv $f ~/Pictures/Screenshoots/'")

	, (("M-["), prevWS)
	, (("M-]"), nextWS)
	, (("M-S-["), shiftToPrev)
	, (("M-S-]"), shiftToNext)
	, (("M-C-["), shiftToPrev >> prevWS)
	, (("M-C-]"), shiftToNext >> nextWS)
	, (("M-\\"), toggleWS)
	, (("M-,"), prevScreen)
	, (("M-."), nextScreen)
	, (("M-S-,"), shiftPrevScreen)
	, (("M-S-."), shiftNextScreen)
	, (("M-C-,"), shiftPrevScreen >> prevScreen)
	, (("M-C-."), shiftNextScreen >> nextScreen)
	, (("M-M1-,"), swapPrevScreen)
	, (("M-M1-."), swapNextScreen)
    , (("M-`"), spawn "unipicker --command \"rofi -dmenu\" --copy")
    -- , (("M-`"), spawn "rofi -show window")
	, (("M-p"), spawn "multilockscreen --lock dim")
    ]
	++
	[ (m ++ i, windows $ f j)
		| (i, j) <- zip (map show [1..9]) (XMonad.workspaces c)
		, (m, f) <- [("M-", W.greedyView), ("M-S-", W.shift)]
	]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

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
myLayout =  avoidStruts $ spacingRaw False (Border 0 0 5 5) True (Border 5 5 5 5) True $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

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
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook =  ewmhDesktopsEventHook <+> fullscreenEventHook
-- myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
	spawnOnce "picom &"
	spawn"nitrogen --restore &"
	spawn "wm=\"xmonad\" $HOME/.config/polybar/launch.sh"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad $ ewmh $ docks defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

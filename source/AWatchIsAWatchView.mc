using Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

class AWatchIsAWatchView extends WatchUi.WatchFace {
    var isAwake;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        isAwake = true;
    }

    // Update the view
    function onUpdate(dc) {
		var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var systemStats = System.getSystemStats();
        View.findDrawableById("Date").setText(
        	date.year.format("%4d") + "-" + date.month.format("%02d") + "-" + date.day.format("%02d")
    	);
        View.findDrawableById("HoursAndMinutes").setText(
        	date.hour.format("%02d") + ":" + date.min.format("%02d")
    	);
    	View.findDrawableById("Seconds").setText(
			isAwake ? ":" + date.sec.format("%02d") : ""
		);
		View.findDrawableById("DayOfTheWeek").setText(
   			["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][date.day_of_week - 1]
    	);
        View.findDrawableById("Battery").setText(
        	systemStats.battery.format("%d") + "%"
    	);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	isAwake = true;
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	isAwake = false;
    }

}

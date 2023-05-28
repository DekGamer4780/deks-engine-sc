package openfl.display;

import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.system.System;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash import openfl.Lib;#end
#if !openfl_debug @:fileXml('tags="haxe,release"') @:noDebug #end
class FPS extends TextField{
public var currentFPS(default, null):Int;
var idk(default, null):String;
@:noCompletion private var cacheCount:Int;
@:noCompletion private var currentTime:Float;
@:noCompletion private var times:Array<Float>;
public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000,?idk:String = "") {
		super();
		this.x = x;
		this.y = y;
		this.idk = idk;
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, color);
		text = idk+"FPS: ";
		cacheCount = 0;
		currentTime = 0;
		times = [];
		#if flash addEventListener(Event.ENTER_FRAME, function(e){var time = Lib.getTimer(); __enterFrame(time - currentTime);});#end
	}
@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void {
		currentTime += deltaTime;
		times.push(currentTime);
		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		while (times[0] < currentTime - 1000) times.shift();
		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentCount != cacheCount) {
			if (mem < 1024)
				text = idk + "FPS: " + currentFPS+"\nRam: ("+mem+" MB)";
			#if debug
			textColor = 0x00ff00;
			#else
			textColor = 0xFFFFFFFF;
			#end
			if (mem > 3000/* || currentFPS <= ClientPrefs.framerate / 2*/)
				textColor = 0xFFFF0000;
			if (mem > 2500/* || currentFPS <= ClientPrefs.framerate / 4*/)
				textColor = 0xFFF8E800;

			#if (gl_stats && !disable_cffi && (!html5 || !canvas)) text += "\ntotalDC: " + Context3DStats.totalDrawCalls(); text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE); text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);#end
		}
		cacheCount = currentCount;
	}
}
package engine;

import openfl.events.UncaughtErrorEvent;
import flixel.text.FlxText;
import flixel.FlxSprite;
#if sys
import sys.FileSystem;
#end
import lime.app.Application;
class ErrorCheck {
    static var dekError:String = "Dek Engine Error";
    public static function loadSongError(song:String) {
        Application.current.window.alert("This song doesn't exist or you write wrong!\n"+song, dekError);
    }
    public static function updateError(string1:String,string2:String) {
        Application.current.window.alert(string1+"\n Error: "+string2, dekError);
    }
}
class WindowsMSGDE {
    public static function msg(string:String, title:String = "Dek Engine.exe") {
        Application.current.window.alert(string, title);
    }
}
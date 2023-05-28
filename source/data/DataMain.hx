package data;

#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end
import haxe.Json;

using StringTools;

//Note Data
typedef NoteFileData ={
    animToPlay:Array<String>,
    noteIdle:Array<String>,
    notePress:Array<String>,
    noteConfirm:Array<String>,
    input:Array<Int>,
    posX:Float,
    swidths:Float,
    offsetPos:Array<Float>,
    scaleStrum:String,
    keys:Int,
    notesSprites:Array<String>
}
//Title Data
typedef TitleData ={
    titlex:Float,
    titley:Float,
    gfx:Float,
    gfy:Float,
    //backgroundSprite:String,
    character:String,
    bpm:Int,
    oldMenu:Bool,
    gfVisible:Bool,
    //backgroundColorGet:Bool,
    haveCheer:Bool,
    tweenLogo:Bool,
    animationposTween:Bool
}
class DataMain {
    public static function getTitleFile():TitleData {
        var rawJson:String = null;
        var path:String = Paths.getPreloadPath('engine/gfDanceTitle.json');
        #if MODS_ALLOWED
        var modPath:String = Paths.modFolders('engine/gfDanceTitle.json');
        if(FileSystem.exists(modPath))
            rawJson = File.getContent(modPath);
        else if(FileSystem.exists(path))
            rawJson = File.getContent(path);
        #else
        if(Assets.exists(path))
            rawJson = Assets.getText(path);
        #end
        else
            return cast Json.parse('{	
                "titlex":-150,
                "titley":-100,
                "gfx":512,
                "gfy":40,
                "gfVisible": true,
                "oldMenu": false,
                "character": "gf",
                "bpm":102,
                "haveCheer": true,
                "tweenLogo": true,
                "animationposTween": true
            }');

        return cast Json.parse(rawJson);
    }
    public static function getnoteFile(noteValue:Int):NoteFileData {
        var rawJson:String = null;
        var path:String = Paths.getPreloadPath('notes/'+noteValue+'k.json');
        #if MODS_ALLOWED
        var modPath:String = Paths.modFolders('notes/'+noteValue+'k.json');
        if(FileSystem.exists(modPath))
            rawJson = File.getContent(modPath);
        else if(FileSystem.exists(path))
            rawJson = File.getContent(path);
        #else
        if(Assets.exists(path))
            rawJson = Assets.getText(path);
        #end
        else
            return cast Json.parse('{
                "animToPlay": ["singLEFT","singDOWN","singUP","singRIGHT"],
                "noteIdle": ["arrowLEFT","arrowDOWN","arrowUP","arrowRIGHT"],
                "notePress": ["purple press","blue press","green press","red press"],
                "noteConfirm": ["purple confirm","blue confirm","green confirm","red confirm"],
                "scaleStrum": "0.7",
                "offsetPos": [13,13],
                "swidths": 160,
                "posX": 50,
                "keys": 4,
                "notesSprites": ["purple","blue","green","red"]
            }');

        return cast Json.parse(rawJson);
    }
}
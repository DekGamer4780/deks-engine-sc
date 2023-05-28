package engine;
/*import others.PlatformUtil;
import characters.CharSelectState;*/
import flixel.FlxG;
import haxe.Json;
import data.DataMain;
/*import data.WeekData;
import characters.SelectorCharacterEditor;
import engine.CoolSystemStuff;
import editors.ChartingState;
import characters.SelectCharList;*/
//#if desktop import others.rpc.Discord.DiscordClient;#end
#if windows import lime.app.Application;#end
using StringTools;
class TitleChanger { //I hate translating everything
	#if desktop
	public static var leDate = Date.now();
    public static var daytitle:String;
	public static var titlecool:String;
	public static var titleget:String;
	public static var dekEngineNormal = "";
	//Title Engine
	public static var titletxtfile:String = "Friday Night Funkin' Dek Engine!";//public static var titletxtfile:EngineData;
	public static var songString = "";
	public static function susmogus(){
		//titletxtfile = DataMain.getEngineFile();
		dekEngineNormal = titletxtfile/*.titleText*/#if debug +" (Debug Mode)" #end;
/*		if (FlxG.random.bool(0.3)) titleget = "Friday Night Funkin': Vs " + CoolSystemStuff.getUsername() + " Mod"#if debug +" | (Debug Mode)" #end;
		else*/ titleget = dekEngineNormal;
	}
	public static function titleChangerState(?changer:String) { //set title in every state
		susmogus();
//		if (ClientPrefs.titleInfo){
			switch(changer){
/*			case "Freeplay":
				if (FlxG.save.data.dialogEs) titlecool = titleget + " | En Modo Libre";
				else if (FlxG.save.data.dialogUsa) titlecool = titleget + " | In Freeplay";
			case "Menu": titlecool = titleget + " | Menu";
			case "StoryMode":
				if (FlxG.save.data.dialogEs) titlecool = titleget + " | En Modo Historia";
				else if (FlxG.save.data.dialogUsa) titlecool = titleget + " | In StoryMode";
			case "SelectedCharacter":
				if (FlxG.save.data.dialogEs) titlecool = titleget + " | Selector De Personajes | Personaje: " + CharSelectState.justnoV3.name;
				else if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Selector Character | Character: " + CharSelectState.justnoV3.name;
			case "ChartingState":
				var keysSet = ChartingState.notesData.keys;
				var extraText = "";
				if (keysSet > 4 || keysSet < 4){
				if (FlxG.save.data.dialogEs) extraText =  " | Modo EK | Keys: "+keysSet+"k";
				else if (FlxG.save.data.dialogUsa) extraText =  " | EK Mode | Keys: "+keysSet+"k";
				}
				if (FlxG.save.data.dialogEs) titlecool = titleget + " | " + "Charteando Cancion | Song: "+songString+extraText;
				else if (FlxG.save.data.dialogUsa) titlecool = titleget + " | " + "Charting Song | Song: "+songString+extraText;
			case "Song":
				var weekName:String = "???"; 
				var mode:String = "";
				var ek:String = "";
				if (PlayState.isStoryMode) mode = "In StoryMode";
				else mode = "In Freeplay";
				if (!PlayState.chartingMode) weekName = WeekData.getCurrentWeek().weekName;
				if (PlayState.notesdata.keys > 4 || PlayState.notesdata.keys < 4) ek = " | EK Mode: (keys "+PlayState.notesdata.keys+")";
				else if (PlayState.notesdata.keys == 4) ek = "";
				titlecool = titleget+" | "+"Song: "+PlayState.SONG.song+" - "+CoolUtil.difficultyString().toLowerCase()+" | Week - "+weekName+ek+" | ("+mode+")";
			case "CharEditor":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | In Character Editor";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | En El Editor De Personajes";
			case "DialogueCharEditor":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | In Dialogue Character Editor";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | En El Editor De Personaje De Dialogos";
			case "Options":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | In Options";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | En Opciones";
			case "MenuEditor":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Menu Editor";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Editor De Menu";
			case "EditorSC":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Character Selector Editor | Character: " + SelectorCharacterEditor.characterName;
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Editor De Seleccion De Personajes | Character: " + SelectorCharacterEditor.characterName;
			case "Credits":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | "+changer;
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Creditos";
			case "TitleEditor":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Title Editor";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Editor De Titulo";
			case "StageEditor":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Stage Editor";
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Editor De Ecenario";
			case "StageEditorIn":
				if (FlxG.save.data.dialogUsa) titlecool = titleget + " | Stage Editor | Stage: "+editors.StageEditor.stageString;
				else if (FlxG.save.data.dialogEs) titlecool = titleget + " | Editor De Ecenario | Ecenario: "+editors.StageEditor.stageString;
			case "EngineOld":
				if (FlxG.save.data.dialogUsa) titlecool = "YOUR DEK ENGINE IS OLD!!!";
				else if (FlxG.save.data.dialogEs) titlecool = "TU DEK ENGINE ES VIEJO";*/
			default: titlecool = titleget;
			}
//		}
		//else if (!ClientPrefs.titleInfo) titlecool = titleget;
	Application.current.window.title = titlecool;
	getDiscordRpc(changer);
	}
	public static function getDiscordRpc(vString:String) {
		switch(vString){
		/*	case "Freeplay" | "Menu" | "StoryMode" | "Options" | "Credits": DiscordClient.changePresence(vString, null);
			case "SelectedCharacter": DiscordClient.changePresence(SelectCharList.textselectcharlenguage, "Character: " + CharSelectState.justnoV3.name, null); 
			case "ChartingState":
			var keysSet = ChartingState.notesData.keys;
			if (keysSet > 4 || keysSet < 4) DiscordClient.changePresence("Chart Editor", StringTools.replace(songString, '-', ' ') + " (" + (keysSet) + " keys)");
			else DiscordClient.changePresence("Chart Editor", StringTools.replace(songString, '-', ' '));
			//case "DialogueCharEditor": DiscordClient.changePresence("Editor Dialogue State", null);
			case "MenuEditor": DiscordClient.changePresence("Menu Editor", null);
			case "EditorSC": DiscordClient.changePresence("in Character Selector Editor", "Character: " + SelectorCharacterEditor.characterName, null); 
			case "TitleEditor": DiscordClient.changePresence("Edit Title", null);
			case "StageEditor": DiscordClient.changePresence("In Stage Editor", null); 
			case "StageEditorIn": DiscordClient.changePresence("In Stage Editor", "Stage: " + editors.StageEditor.stageString, null);
			case "EngineOld": DiscordClient.changePresence("THE DEK ENGINE IS OLD", null);
			default: DiscordClient.changePresence("Discord No Defined", null);*/
		}
	}
    public static function titledate() { //set date event title
		susmogus();// date of events
		if(leDate.getMonth() == 11 && leDate.getDate() >= 19 && leDate.getDate() <= 24) daytitle = dekEngineNormal + " christmas :3";
		else if(leDate.getMonth() == 0 && leDate.getDate() >= 28 && leDate.getDate() <= 28) daytitle = dekEngineNormal + " Happy Birthday DekGamer4780!";
		else if(leDate.getMonth() == 11 && leDate.getDay() == 31) daytitle = "Oh my Fucking god, this is joke day? but... WTF?";
		else daytitle = titleget;
        Application.current.window.title = daytitle;
    }
	#end
}
package substates;

import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
//import editors.CharacterEditorState;
import states.editors.ChartingState;
/*import editors.WeekEditorState;
import editors.DialogueCharEditor;
import editors.DialogueEditorState;
import menus.MenuEditor;
import characters.SelectorCharacterEditor;
import editors.EditorTitle;
import editors.StageEditor;
import states.LoadingState;*/

class EditorMainInMenus extends MusicBeatSubstate
{
    var grpMenuShit:FlxTypedGroup<Alphabet>;
    var menuItems:Array<String> = [
        //'Character Editor',
        'Charting Song',
        /*'Dialogue Editor',
        'Dialogue Portrait Editor',
        'Week Editor',
        'Menu Editor',
        'Character Selector Editor',
        'Title Editor',
        'Stage Editor',*/
        'Exit'];
    var levelInfo:FlxText;
    var curSelected:Int = 0;
    public function new()
        {
            super();
            var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            bg.alpha = 0;
            bg.scrollFactor.set();
            add(bg);

            levelInfo = new FlxText(20, 15, 0, "Editor", 16);
            levelInfo.scrollFactor.set();
            levelInfo.setFormat(Paths.font("vcr.tff"), 32);
            levelInfo.updateHitbox();
            add(levelInfo);
            levelInfo.alpha = 0;
            levelInfo.x = FlxG.width - (levelInfo.width + 20);

            FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
            FlxTween.tween(bg, {alpha: 0.7}, 0.4, {ease: FlxEase.quartInOut});

            grpMenuShit = new FlxTypedGroup<Alphabet>();
            add(grpMenuShit);
    
            for (i in 0...menuItems.length)
            {
                var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true);
                songText.isMenuItemCenter = true;
                songText.targetY = i;
                songText.scrollFactor.set();
                grpMenuShit.add(songText);
            }
    
            changeSelection();

            cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

            /*#if mobileC
            addVirtualPad(UP_DOWN, A_B);
            #end*/
        }

    override function update(elapsed:Float)
        {
            if (controls.UI_UP_P || FlxG.mouse.wheel > 0)
                changeSelection(-1);
            if (controls.UI_DOWN_P || FlxG.mouse.wheel < 0)
                changeSelection(1);
            if (FlxG.keys.justPressed.ESCAPE || FlxG.mouse.justPressedRight)
                close();
            if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed){
                var daSelected:String = menuItems[curSelected];
                switch(daSelected) {
                /*case 'Character Editor':LoadingState.loadAndSwitchState(new CharacterEditorState(Character.DEFAULT_CHARACTER, false));
                case 'Week Editor':MusicBeatState.switchState(new WeekEditorState());
                case 'Menu Editor':LoadingState.loadAndSwitchState(new MenuEditor());
                case 'Dialogue Portrait Editor':LoadingState.loadAndSwitchState(new DialogueCharEditor(), false);
                case 'Dialogue Editor':LoadingState.loadAndSwitchState(new DialogueEditorState(), false);*/
                case 'Charting Song':LoadingState.loadAndSwitchState(new ChartingState()/*, false*/);
                /*case 'Character Selector Editor':LoadingState.loadAndSwitchState(new SelectorCharacterEditor());
                case 'Title Editor':LoadingState.loadAndSwitchState(new EditorTitle());
                case 'Stage Editor':LoadingState.loadAndSwitchState(new StageEditor());*/
                case 'Exit':
                    close();
                    regenMenu();
                }
                switch(daSelected){
                    case 'Exit': FlxG.sound.music.volume = 1;
                    default: FlxG.sound.music.volume = 0;
                }
            }
            super.update(elapsed);
        }
        function changeSelection(change:Int = 0):Void
            {
                curSelected += change;
        
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        
                if (curSelected < 0)
                    curSelected = menuItems.length - 1;
                if (curSelected >= menuItems.length)
                    curSelected = 0;
        
                var bullShit:Int = 0;
        
                for (item in grpMenuShit.members)
                {
                    item.targetY = bullShit - curSelected;
                    bullShit++;
        
                    item.alpha = 0.6;
        
                    if (item.targetY == 0)
                        item.alpha = 1;
                }
            }
        function regenMenu():Void {
            for (i in 0...grpMenuShit.members.length) {
                this.grpMenuShit.remove(this.grpMenuShit.members[0], true);
            }
            for (i in 0...menuItems.length) {
                var item = new Alphabet(0, 70 * i + 30, menuItems[i], true);
                item.isMenuItem = true;
                item.targetY = i;
                grpMenuShit.add(item);
            }
            curSelected = 0;
            changeSelection();
        }
}
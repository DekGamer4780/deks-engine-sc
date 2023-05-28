package substates;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
//import characters.SelectCharList;
//import characters.CharSelectState;
import flixel.group.FlxGroup.FlxTypedGroup;
//import editors.CharacterEditorState;
import engine.TitleChanger;

class CharacterEditorMiniMenu extends MusicBeatSubstate 
{
    var curSelected:Int = 0;
    var porotosdeazucar:Array<String> = [];
    var grpMenuShit:FlxTypedGroup<Alphabet>;
    var lePlayState = PlayState;
    var levelInfo:FlxText;
    var charSelection:String = "";
    public function new(x:Float, y:Float)
        {
            if (FlxG.save.data.characterChangerVar) charSelection = CharSelectState.justnoV3.character;
            else if (!FlxG.save.data.characterChangerVar) charSelection = PlayState.SONG.player1;

            var mecagoenlaputa:Array<String> = ['Edit ' + PlayState.SONG.player2,'Edit ' + lePlayState.gf.curCharacter,'Edit ' + charSelection];
            
            for (i in mecagoenlaputa)porotosdeazucar.push(i);

            super();
        
            var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
            bg.alpha = 0;
            bg.scrollFactor.set();
            add(bg);

            levelInfo = new FlxText(20, 15, 0, "Editor Character Menu", 16);
            levelInfo.scrollFactor.set();
            levelInfo.setFormat(Paths.font(VersionEngine.fontnice), 32);
            levelInfo.updateHitbox();
            levelInfo.alpha = 0;
            add(levelInfo);

            FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
            FlxTween.tween(levelInfo, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

            grpMenuShit = new FlxTypedGroup<Alphabet>();
            add(grpMenuShit);

            for (i in 0...porotosdeazucar.length)
                {
                    var songText:Alphabet = new Alphabet(0, (70 * i) + 30, porotosdeazucar[i], true);
                    songText.isMenuItemCenter = true;
                    songText.targetY = i;
                    songText.scrollFactor.set();
                    grpMenuShit.add(songText);
                }

            levelInfo.x = FlxG.width - (levelInfo.width + 20);

            changeSelection();

            /*#if mobileC
            addVirtualPad(LEFT_FULL, A_B);
            addVirtualPadCamera(false);
            #end*/

            cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        }
        override function update(elapsed:Float)
            {
                if (FlxG.keys.justPressed.ESCAPE)
                    close();

                    var upP = controls.UI_UP_P;
                    var downP = controls.UI_DOWN_P;
                    var accepted = controls.ACCEPT;
            
                    if (upP) changeSelection(-1);
                    if (downP) changeSelection(1);
            
                    if (accepted)
                    {
                    var daSelected:Int = curSelected;
                    switch (daSelected)
                    {
                        case 0:
                            FlxG.switchState(new AnimationDebug(PlayState.SONG.player2));
                            #if desktop TitleChanger.titledate(); #end
                            close();
                            regenMenu();
                        case 1:
                            FlxG.switchState(new AnimationDebug(lePlayState.gf.curCharacter));
                            #if desktop TitleChanger.titledate(); #end
                            close();
                            regenMenu();
                        case 2:
                            FlxG.switchState(new AnimationDebug(PlayState.SONG.player1));
                            /*if (FlxG.save.data.characterChangerVar){
                            var charSelection = CharSelectState.justnoV3.character;
                            MusicBeatState.switchState(new CharacterEditorState(charSelection));
                            } else if (!FlxG.save.data.characterChangerVar)
                            MusicBeatState.switchState(new CharacterEditorState(PlayState.SONG.player1));*/
                            
                            #if desktop TitleChanger.titledate(); #end
                            close();
                            regenMenu();
                    }
                    }
                super.update(elapsed);
            }
            function changeSelection(change:Int = 0):Void
                {
                    curSelected += change;
            
                    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
            
                    if (curSelected < 0)
                        curSelected = porotosdeazucar.length - 1;
                    if (curSelected >= porotosdeazucar.length)
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
                    for (i in 0...porotosdeazucar.length) {
                        var item = new Alphabet(0, 70 * i + 30, porotosdeazucar[i], true);
                        item.isMenuItem = true;
                        item.targetY = i;
                        grpMenuShit.add(item);
                    }
                    curSelected = 0;
                    changeSelection();
                }
}
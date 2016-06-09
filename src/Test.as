package
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLVariables;
    import ru.ngl.utils.Console;
    import ru.pladform.api.event.AdvEvent;
    import ru.pladform.api.event.SeekEvent;
    import ru.pladform.api.event.TimeOffsetEvent;
    import ru.pladform.api.event.VideoInfoEvent;
    import ru.pladform.api.event.VideoQualityEvent;
    import ru.pladform.api.IPladformPlayer;
    import ru.pladform.api.event.ChangeVolumeEvent;
    import ru.pladform.api.event.PlaylistLoadEvent;
    import ru.pladform.api.event.VideoPlayProgressEvent;
    import ru.pladform.api.event.VideoStateEvent;
    import ru.pladform.api.PladformPlayerWrapper;
    
    /**
     * ...
     * @author Alexander Semikolenov
     */
    public class Test extends MovieClip
    {
        private var pl    :PladformPlayerWrapper;
        
        public function Test():void
        {
            if (stage)
            {
                addToStageHandler(null);
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
            }
        }
        
        private function addToStageHandler(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
            //Инициализация плеера
            pl                = new PladformPlayerWrapper(400, 300);
            addChild(pl);
            //загрузка плелиста
            pl.loadPlaylist("25077", new URLVariables("videoid=57"));
            pl.x            = 200;
            pl.y            = 200;
            //Инициализация событий
            pl.addEventListener(VideoStateEvent.CHANGE, changeVideoStateHandler);
            pl.addEventListener(PlaylistLoadEvent.COMPLETE, laylistLoadComplete);
            pl.addEventListener(VideoPlayProgressEvent.PROGRESS, videoPlayProgressHandler);
            pl.addEventListener(ChangeVolumeEvent.CHANGE_VOLUME, changeVolumeHandler);
            pl.addEventListener(PlaylistLoadEvent.COMPLETE, completeLoadPlaylistHandler);
            pl.addEventListener(SeekEvent.SEEK_START, seekHandler);
            pl.addEventListener(SeekEvent.SEEK_COMPLETE, seekHandler);
            pl.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
            pl.addEventListener(TimeOffsetEvent.CHANGE, changeTimeOffseHandler);
            
            pl.addEventListener(AdvEvent.START, advEventHandler);
            pl.addEventListener(AdvEvent.COMPLETE, advEventHandler);
            
            pl.addEventListener(VideoInfoEvent.UPDATE, videoInfoHandler);
            pl.addEventListener(VideoInfoEvent.ERROR, videoInfoHandler);
            pl.addEventListener(VideoQualityEvent.CHANGE_QUALITY_COUNT, videoQualityHandler);
            pl.addEventListener(VideoQualityEvent.CHANGE_QUALITY_INDEX, videoQualityHandler);
            
            var arName:Array = ["enabled?", "Start", "Stop", "Pause", "Pause(hide)", "Resume", "Volume","Mute", "Unmute", "NextVideo", "PreviusVideo", "Play Random", "Load Playlist", "10%", "20 sek", "Get playlist", "Index", "arQuality", "Get bitrate", "Set bitrate", "Change scale", "Delete player"];
            //Инициализация кнопок
            for (var i:int = 0; i < arName.length; i++) 
            {
                var btItem  :Bt = new Bt();
                btItem.x        = 10;
                btItem.y        = 10 + i*(btItem.height + 5);
                btItem.text     = arName[i];
                addChild(btItem);
                btItem.addEventListener(MouseEvent.CLICK, btClickHandler);
            }
        }
        
        private function videoQualityHandler(e:VideoQualityEvent):void 
        {
            Console.log2("QualityChangeHandler", e.type,pl.qualityIndex)
        }
        
        private function videoInfoHandler(e:VideoInfoEvent):void 
        {
            Console.log2("videoInfoHandler:",e.type)
            if (e.type == VideoInfoEvent.UPDATE)
            {
                Console.log2(pl.playlist)
            }
            else if (e.type == VideoInfoEvent.ERROR)
            {
                Console.log2(pl.playlist)
            }
        }
        
        private function advEventHandler(e:AdvEvent):void 
        {
            switch(e.type)
            {
                case AdvEvent.START:
                {
                    Console.log2("AdvEvent.START isLinear:", e.isLinear)
                    break;
                }
                case AdvEvent.COMPLETE:
                {
                    Console.log2("AdvEvent.COMPLETE isLinear:", e.isLinear)
                    break;
                }
            }
        }
        
        private function changeTimeOffseHandler(e:TimeOffsetEvent):void 
        {
            Console.log2("changeTimeOffseHandler", e)
        }
        
        private function loadProgressHandler(e:ProgressEvent):void 
        {
        }
        
        private function seekHandler(e:SeekEvent):void 
        {
            if (e.type == SeekEvent.SEEK_START)
            {
                Console.log2("START : "+e.time)
            }
            else if (e.type == SeekEvent.SEEK_COMPLETE)
            {
                Console.log2("COMPLETE : "+e.time)
            }
        }
        
        private function completeLoadPlaylistHandler(e:PlaylistLoadEvent):void 
        {
            Console.log2(pl.playlist)
        }
        
        private function changeVolumeHandler(e:ChangeVolumeEvent):void 
        {
            Console.log2("changeVolume = "+e.value)
        }
        
        private function btClickHandler(e:MouseEvent):void 
        {
            var btItem    :Bt = e.currentTarget as Bt;
            var pladformPlayer: IPladformPlayer = pl as IPladformPlayer;//В интерфейсе описаны функции
            switch(btItem.text)
            {
                case "enabled?"         : Console.log2("pladformPlayer.enabled = "+pladformPlayer.enabled); break;
                case "Start"            : pladformPlayer.start(); break;
                case "Stop"             : pladformPlayer.stop(); break;
                case "Pause"            : pladformPlayer.pause(); break;
                case "Pause(hide)"      : pladformPlayer.pause(true); break;
                case "Resume"           : pladformPlayer.resume(); break;
                case "Resume"           : pladformPlayer.resume(); break;
                case "Mute"             : pladformPlayer.mute(); break;
                case "Unmute"           : pladformPlayer.unmute(); break;
                case "NextVideo"        : pladformPlayer.nextVideo(); break;
                case "PreviusVideo"     : pladformPlayer.previusVideo(); break;
                case "Play Random"      : pladformPlayer.playRandom(); break;
                case "Load Playlist"    : pladformPlayer.loadPlaylist("12251", new URLVariables("videoid=1")); break;
                case "10%"              : pladformPlayer.seekPercent(0.1); break;
                case "20 sek"           : pladformPlayer.seekSecond(20); break;
                case "Get playlist"     : Console.log2(pladformPlayer.playlist); break;
                case "Index"            : Console.log2(pl.playlistIndex); break;
                case "Delete player"    : if (pl.parent) removeChild(pl); break;
                case "arQuality"        : Console.log2("arQuality = "+pl.arQuality); break;
                case "Get bitrate"      : Console.log2("index = " + pl.arQuality, pl.qualityIndex, pl.arQuality[pl.qualityIndex]); break;
                case "Change scale"     :
                    pladformPlayer.scaleX = pladformPlayer.scaleY = (pladformPlayer.scaleX>1)?1:2
                    break;
                case "Set bitrate"      : 
                    var index :int= pl.qualityIndex + 1;
                    if (index >= pl.arQuality.length)
                    {
                        index=0
                    }
                    
                    pl.qualityIndex = index;
                    Console.log2("pl.qualityIndex = " + pl.qualityIndex)
                    break;
                case "Volume"           : pl.volume = (pl.volume < 1)?1:.5; break;
                
            }
        }
        
        private function videoPlayProgressHandler(e:VideoPlayProgressEvent):void
        {
            //Console.log2("progress :" + e.currentTime / e.duration);
        }
        
        private function laylistLoadComplete(e:PlaylistLoadEvent):void
        {
            //pl.startPlayer();
        }
        
        private function changeVideoStateHandler(e:VideoStateEvent):void
        {
            Console.log2("STATE = ", e.videoState);
        }
        
        private function keyDownHandler(e:KeyboardEvent):void
        {
            //Для уделаения плеера нужно просто удалить его со сцены
            removeChild(pl);
        }
    
    }

}
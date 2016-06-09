package 
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    /**
     * ...
     * @author Alexander Semikolenov
     */
    public class Bt extends Sprite
    {
        private var shape:Shape;
        public var txtBt	:TextField;
		
		private var txt		:String = ""
        public function Bt() 
        {
            shape = new Shape();
            shape.graphics.beginFill(0x999999);
            shape.graphics.lineStyle(0, 0);
            shape.graphics.drawRect(0, 0, 122, 26);
            shape.graphics.endFill();
            addChild(shape);
            
            txtBt = new TextField()
            txtBt.autoSize = TextFieldAutoSize.LEFT
            txtBt.multiline = false;
            txtBt.height = 26
            addChild(txtBt);
            if (stage)
			{
				addToStagehandler(null)
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, addToStagehandler);
			}
        }
        
        // STATIC METHODS
        
        // ACCESSORS
        
        // PUBLIC METHODS
        public function get text():String
        {
            return txt;
        }
        public function set text(str:String):void
        {
            txt			= str;
            txtBt.text	= str;
            txtBt.width	= (txtBt.textWidth + 4 > 104) ? txtBt.textWidth + 4 : 104;
            shape.width	= txtBt.width
        }
        
        // EVENT HANDLERS
        
        private function addToStagehandler(e:Event):void 
        {
            txtBt.autoSize = TextFieldAutoSize.CENTER;
            removeEventListener(Event.ADDED_TO_STAGE, addToStagehandler);
            this.mouseChildren	= false;
            this.buttonMode		= true;
        }
        
        // PRIVATE METHODS
    }

}
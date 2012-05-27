/**
 * @author Gapple
 * @QQ 821168116
 * @mail lzmst@126.com
 */
package view.draw
{
	import fl.controls.*;
	import fl.events.*;
	import flash.utils.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import view.ButtonBase;
	
	/**
	 * @class DrawTool
	 * @data  May 15, 2012
	 * @declaration public class DrawTool extends Sprite
	 */
	
	public class DrawTool extends Sprite
	{
		public var pencil:ButtonBase;//画笔
		public var eraser:ButtonBase;//橡皮
		public var colorPicker:ColorPicker;
		
		public var drawMain:DrawMain;
		
		private var _clickInterval:int;
		
		public function DrawTool()
		{
			super();
			init();
		}
		
		private function init():void
		{
			pencil.addEventListener(MouseEvent.CLICK,clickPencilHandler);
			eraser.addEventListener(MouseEvent.MOUSE_DOWN,downEraserHandler);
			eraser.addEventListener(MouseEvent.MOUSE_UP,upEraserHandler);
			colorPicker.addEventListener(ColorPickerEvent.CHANGE,changeColorHandler);
		}
		
		private function changeColorHandler(event:ColorPickerEvent):void
		{
			drawMain.currentColor=event.color;
		}
		
		private function upEraserHandler(evt:MouseEvent):void
		{
			if(getTimer() - _clickInterval > 500)
			{
				drawMain.clear();
			}	
		}
		
		private function downEraserHandler(evt:MouseEvent):void
		{
			_clickInterval = getTimer();
			drawMain.erasing = true;
			eraser.enabled = false;
			pencil.enabled = true;
		}
		
		private function clickPencilHandler(evt:MouseEvent):void
		{
			drawMain.erasing = false;
			eraser.enabled = true;
			pencil.enabled = false;
		}
	}
}
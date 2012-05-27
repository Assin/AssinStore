/**
 * @author Gapple
 * @QQ 821168116
 * @mail lzmst@126.com
 */
package view.draw
{
	
	import data.*;
	
	import fl.controls.*;
	import fl.events.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.*;
	
	import model.*;
	
	import view.ButtonBase;
	/**
	 * 绘图主文件
	 * @class DrawMain
	 * @data  May 12, 2012
	 * @declaration public class DrawMain extends Sprite
	 */
	
	public class DrawMain extends Sprite
	{

		private var content:BitmapData;
		private var _cachTrack:Array;//轨迹缓存

		public var currentColor:uint = 0x000000;
		public var erasing:Boolean=false;
		private var _lineThickness:Number=10.0;
		private var _lineAlpha:Number=1.0;
		private var _lockPoint:Point;
		private var _canvas:Sprite;
		private var _brushShape:Shape;
		private var _currentShape:Shape;
		
		public var colorPicker:ColorPicker;
		
		public function DrawMain()
		{
			super();
			init();
			addListeners();
		}
		
		public function init(evt:Event=null):void
		{
			_canvas = this.addChild(new Sprite()) as Sprite;
			_brushShape = this.addChild(new Shape()) as Shape;
			
			_canvas.blendMode="layer";
		}
		
		private function addListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_MOVE,moveBoardHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,downBoardHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,upBoardHandler);
			
		}
		
		
		
		/**
		 * 清除 
		 * 
		 */
		public function clear():void
		{
			while(_canvas.numChildren)
			{
				_canvas.removeChildAt(0);
			}
		}
		
		
		
		private function upBoardHandler(evt:MouseEvent):void
		{
			if(_cachTrack != null)
			{
				//TODO 与后台交互
				DataManager.getInstance().sendObjectToSocket({key:"draw",track:_cachTrack,color:this.currentColor,erasing:this.erasing});
			}
		}
		
		private function downBoardHandler(evt:MouseEvent):void
		{
			_currentShape=_canvas.addChild(new Shape()) as Shape;
			
			_currentShape.x=evt.localX;
			_currentShape.y=evt.localY;
			_currentShape.graphics.lineStyle(_lineThickness,currentColor,_lineAlpha);
			_currentShape.blendMode= erasing?"erase":"normal";
			
			_cachTrack = [evt.localX*1000+evt.localY];
		}
		
		
		private function moveBoardHandler(evt:MouseEvent):void
		{
			_brushShape.x=evt.localX;
			_brushShape.y=evt.localY;
			if(evt.buttonDown)//绘画
			{
				_currentShape.graphics.lineTo(evt.localX-_currentShape.x,evt.localY-_currentShape.y);
				_cachTrack.push(evt.localX*1000+evt.localY);
			}
		}
		
		/**
		 * 显示轨迹 
		 * @param track 轨迹点
		 * @param color 线条颜色
		 * @param erasing 擦除模式
		 */
		public function showTrack(track:Array,color:uint,erasing:Boolean):void
		{
			color = color==0 ? 0xFFFFFF : color;
			if(track != null && track.length > 0)
			{
				_currentShape=_canvas.addChild(new Shape()) as Shape;
				
				_currentShape.x=track[0]/1000;
				_currentShape.y=track[0]%1000;
				_currentShape.graphics.lineStyle(_lineThickness,color,_lineAlpha);
				_currentShape.blendMode = erasing?"erase":"normal";
				
				for(var i:int = 1,len:int = track.length; i<len;i++)
				{
					_brushShape.x=track[i]/1000;
					_brushShape.y=track[i]%1000;
					_currentShape.graphics.lineTo(_brushShape.x-_currentShape.x,_brushShape.y-_currentShape.y);
				}					
			}
		}
	}
}
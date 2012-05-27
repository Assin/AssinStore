/**
 * @author Gapple
 * @QQ 821168116
 * @mail lzmst@126.com
 */
package view
{
	
	import data.IDispose;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.Filters;
	
	/**
	 * @class ButtonBase 按钮简易基类
	 * @data  May 12, 2012
	 * @declaration public class ButtonBase extends Sprite
	 */
	
	public class ButtonBase extends Sprite implements IDispose
	{
		private var _enabled:Boolean;
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(v:Boolean):void
		{
			if(v)
			{
				this.filters = [];
				this.scaleX = this.scaleY = 1;
			}
			else
			{
				this.filters = [Filters.GLOW]
				this.scaleX = this.scaleY = 1.2;
			}
			this._enabled = v;
		}
		
		public function ButtonBase()
		{
			super();
			this.buttonMode = true;
			this.enabled = true;
			this.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
		}
		
		private function overHandler(evt:MouseEvent):void
		{
			if(_enabled)
			{
				this.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
				this.scaleX = this.scaleY = 1.2;
			}
			
		}
		
		private function outHandler(evt:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,outHandler);
			if(_enabled)
				this.scaleX = this.scaleY = 1;
		}
		
		public function dispose():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER,overHandler);
		}
	}
}
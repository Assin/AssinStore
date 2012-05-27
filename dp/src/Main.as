/**
 * @author Gapple
 * @QQ 821168116
 * @mail lzmst@126.com
 */
package
{
	
	import data.Global;
	import data.RoleType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import model.DataManager;
	
	import net.SocketConnectionControl;
	
	import flash.events.TimerEvent;
	
	import view.ScoreView;
	import view.draw.DrawMain;
	import view.draw.DrawTool;
	import view.map.Map;
	
	/**
	 * @class Main 主程序入口
	 * @data  May 12, 2012
	 * @declaration public class Main extends Sprite
	 */
	
	public class Main extends Sprite
	{

		
		public var map:Map;
		
		public var drawTool:DrawTool;
		
		public var drawMain:DrawMain;
		
		public var txtGold:TextField;
		
		public var txtTime:TextField;
		
		public function Main()
		{
			super();
			if(stage){
				this.addEventListener(Event.ADDED_TO_STAGE,init)
			}else
			{
				init();
			}
		}
		
		private function init(evt:Event=null):void
		{			
			Global.main = this;
			Global.currentMapTileDataTable = DataManager.getInstance().getMapTileDataTable().concat();
			map.initMap(Global.currentMapTileDataTable);
			map.initRoleView();
			map.initKeyboardEvent();
			
			drawTool.drawMain = this.drawMain;
			
			if(Global.currentRoleType == RoleType.CONTROLLER)
			{
				drawTool.visible = true;
				drawMain.mouseEnabled = true;
				drawMain.mouseChildren = true;
			}
			else
			{
				drawTool.visible = false;
				drawMain.mouseEnabled = false;
				drawMain.mouseChildren = false;
			}
			var count:int = 60;
			var timer:Timer = new Timer(1000,count);
			timer.addEventListener(TimerEvent.TIMER,function(evt:TimerEvent):void{
				count--;
				txtTime.text = count+"";
			});
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(evt:TimerEvent):void{
				while(numChildren)
				{
					removeChildAt(0);
				}
				var scoreView:ScoreView = new ScoreView();
				scoreView.x = 200;
				scoreView.y = 100;
				scoreView.txtScore.text = txtGold.text;
				addChild(scoreView);
			});
			timer.start();
		}
	}
}
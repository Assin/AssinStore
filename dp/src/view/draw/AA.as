/*=======超简易纯代码画板========
==========By:Swfdong==========
============================*/
import flash.display.*;
import flash.events.*;
import flash.ui.*;
import flash.geom.*;
var erasing:Boolean=false,historyPoint:uint=0;
var lineThickness:Number=3.0,lineAlpha:Number=1.0;
var lockPoint:Point;
var history:Array=new Array();
var keyHolder:Array=new Array();
var canvas:Sprite=addChild(new Sprite()) as Sprite,brushShape:Shape=addChild(new Shape()) as Shape,currentShape:Shape;
canvas.blendMode="layer";
Mouse.hide();
drawBrush();
stage.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
stage.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
stage.addEventListener(KeyboardEvent.KEY_DOWN,keyHandler);
stage.addEventListener(KeyboardEvent.KEY_UP,keyHandler);
function downHandler(e:MouseEvent):void{
	if(!e.ctrlKey){
		
		currentShape=canvas.addChild(new Shape()) as Shape;
		
		currentShape.x=e.stageX;
		currentShape.y=e.stageY;
		currentShape.graphics.lineStyle(lineThickness,0,lineAlpha);
		currentShape.blendMode=erasing?"erase":"normal";
	}
}
function moveHandler(e:MouseEvent):void{
	brushShape.x=e.stageX,brushShape.y=e.stageY;
	if(e.ctrlKey){
		lineThickness=Math.max(Math.min(50,(e.stageY-lockPoint.y)*0.125+lineThickness),2);
		lineAlpha=Math.max(Math.min(1.0,(e.stageX-lockPoint.x)*0.005+lineAlpha),0.02);
		lockPoint.x=e.stageX;
		lockPoint.y=e.stageY;
		drawBrush();
	}else if(e.buttonDown){
		currentShape.graphics.lineTo(e.stageX-currentShape.x,e.stageY-currentShape.y);
	}
}
function keyHandler(e:KeyboardEvent):void{
	if(e.type==KeyboardEvent.KEY_DOWN){
		if(keyHolder.indexOf(e.keyCode)==-1){
			keyHolder.push(e.keyCode);
		}
		if(e.ctrlKey){
			lockPoint=new Point(stage.mouseX,stage.mouseY);
		}
	}else if(e.type==KeyboardEvent.KEY_UP){
		if(keyHolder.indexOf(e.keyCode)>-1){
			keyHolder.splice(keyHolder.indexOf(e.keyCode),1);
		}
		if(e.keyCode==Keyboard.SHIFT){
			erasing=!erasing;
		}
	}
}
function drawBrush():void{
	brushShape.graphics.clear();
	brushShape.graphics.beginFill(0x0,lineAlpha);
	brushShape.graphics.drawCircle(0,0,lineThickness*0.5);
	brushShape.graphics.endFill();
}
package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BotRecolteur extends SuperBot
	{
		
		public function BotRecolteur(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function Update() : void
		{
			
			var elapsedTime:Number = TimeManager.timeManager.GetFrameDeltaTime();
			
			updateTime += elapsedTime;
				
			if (updateTime >=  directionChangeDelay)
			{
				//ChangeDirection();
				updateTime = 0;
			}			
			
			 targetPoint.x = x + direction.x * speed * elapsedTime / 1000 ;
			 targetPoint.y = y + direction.y * speed * elapsedTime / 1000;
			
			//on change de direction en cas de collisions avec les bords de la fenêtre 
			if (targetPoint.y<0) {
				ChangeDirection();
			}
			if (targetPoint.y >600) {
				ChangeDirection();
			}
			if (targetPoint.x<0) {
				ChangeDirection();
			}
			if (targetPoint.x>650) {
				ChangeDirection();
			}
			
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (!HasResource() && uneResource != null) {
				moveAt(uneResource.GetTargetPoint());
				if (moveAt(uneResource.GetTargetPoint())) {
					uneResource.DecreaseLife();
					SetResource(true);
					trace ("j'ai une resource");
				}
			}
			
			if (HasResource() && nidHome != null) {
				moveAt(nidHome.GetTargetPoint());
				if (moveAt(nidHome.GetTargetPoint())) {
					nidHome.AddResource();
					SetResource(false);
					trace("je suis arrivé au nid");
				}
			}
			
			/*if (uneResource != null) {
				moveAt(uneResource.GetTargetPoint());
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
					if (pointNidHome != null) { //et si je connais les coordonnees de mon nid je m'y rend
						moveAt(pointNidHome);
					}else {
						ChangeDirection();
					}
				}
			}*/
			
			
		}
		
	}

}
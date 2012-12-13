package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import com.novabox.MASwithTwoNests.TimeManager;
	import com.novabox.MASwithTwoNests.World;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BotRecolteur extends SuperBot
	{
		
		public function BotRecolteur(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			if (!HasResource() && uneResource != null) {
				moveAt(uneResource.GetTargetPoint());
				if (moveAt(uneResource.GetTargetPoint())) {
					if (uneResource.GetLife() > 0) { //évite un bug sinon les bots continu de vider une ressource nulle.
						uneResource.DecreaseLife();
						SetResource(true);
						trace ("j'ai pris une resource");
					}
				}
			}
			
			if (HasResource() && nidHome != null) {
				moveAt(nidHome.GetTargetPoint());
				if (moveAt(nidHome.GetTargetPoint())) {
					nidHome.AddResource();
					SetResource(false);
					trace("je suis arrivé au nid, je dépose mes ressources");
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
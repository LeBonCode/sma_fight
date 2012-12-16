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
			
			
			// RECOLTE DES RESSOURCES
			 
		/*	if (!HasResource() && uneResource != null) {
				moveAt(uneResource.GetTargetPoint());
				if (moveAt(uneResource.GetTargetPoint())) {
					if (uneResource.GetLife() > 0) { 
						//trace("vie uneRessource "+uneResource.GetLife());
						uneResource.DecreaseLife();
						SetResource(true);
						//trace ("j'ai pris une resource");
					}
				}
			}
			
			
			
			//RETOUR AU NID POUR DEPOSER LES RESSOURCES
			
			if (HasResource() && nidHome != null) {
				moveAt(nidHome.GetTargetPoint());
				if (moveAt(nidHome.GetTargetPoint())) {
					nidHome.AddResource();
					SetResource(false);
					//trace("je suis arrivé au nid, je dépose mes ressources");
				}
			}
			
			
			// VOL DES RESSOURCES A UN NID ENNEMI 
			  
			if (!HasResource() && uneResource != null && uneResource.GetLife() <= 0) {
				//trace ("jsui vide, et la ressource visée est vide " + uneResource.GetLife());
				moveAt(nidEnnemi.GetTargetPoint());
				if (moveAt(nidEnnemi.GetTargetPoint())) {
					if (nidEnnemi.HasResource()) {
						nidEnnemi.TakeResource();
						SetResource(true);
						//trace("je vol des ressources à l'ennemi");
					}
				}
			}
		*/	
		}
		
	}

}
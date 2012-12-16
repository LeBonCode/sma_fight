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
	/**
	 * ...
	 * @author ...
	 */
	public class BotTest extends SuperBot
	{
		
		public var nidEnnemi : BotHome;
		public var nidHome : BotHome;
		public var uneResource : Resource;
		
		public function BotTest(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
		
			if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME){
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" ) {
					//... et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					nidEnnemi = (collidedAgent as BotHome);
					if (!HasResource())
					{
						if (nidEnnemi.HasResource()) {
							(collidedAgent as BotHome).TakeResource();
							SetResource(true);
						}
					}
					if(nidHome != null){
						moveAt(nidHome.GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					nidHome = (collidedAgent as BotHome);
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					if(nidEnnemi != null){
						moveAt(nidEnnemi.GetTargetPoint());
					}else if (uneResource != null) {
						moveAt(uneResource.GetTargetPoint());
					}else {
						ChangeDirection();
					}
				}
			}
			
			if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				if (uneResource == null) {
					uneResource = (collidedAgent as Resource);
					//trace("coordonnées resources " + getUneResouce().GetTargetPoint());
					//trace("vie" + getUneResouce().GetLife());
				}
				
				if((collidedAgent as Resource).GetLife() > uneResource.GetLife()){
					uneResource = (collidedAgent as Resource);
					//trace("big ressource" + getUneResouce().GetTargetPoint());
					//trace("vie big" + getUneResouce().GetLife());
				}
				
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					if (uneResource.GetLife() > 0) { 
						(collidedAgent as Resource).DecreaseLife();
						SetResource(true);	
					}
				}
			
				if (nidHome != null) {
					moveAt(nidHome.GetTargetPoint());
				}else {
					ChangeDirection();
				}
			}
			
		}
		
	}

}
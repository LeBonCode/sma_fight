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
		
		//public var pointNidHome:Point;
		//public var pointNidEnnemi:Point;
		
		public function BotTest(_type:AgentType) 
		{
			super(_type);
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			//var pointNidHome:Point;
			//var pointNidEnnemi:Point;
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
				if (!HasResource()) // si je transporte pas de ressources alors je récolte la ressource
				{
					(collidedAgent as Resource).DecreaseLife();
					SetResource(true);
				}
				//moveAt(pointNid);
				ChangeDirection();
			}else if (collidedAgent.GetType() == AgentType.AGENT_BOT) {
				if ((collidedAgent as Bot).GetTeamId() != "TrioDeChoc") {
					if (!HasResource()) //.. alors si je transporte pas de ressources, je vol la ressource de l'agent ennemi
					{
						StealResource(collidedAgent as Bot);
						SetResource(true);
					}
				}
				ChangeDirection();*/

			/*}else*/ if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME){
				if ((collidedAgent as BotHome).GetTeamId() != "TrioDeChoc" ) {
					//... et qu'on ne transporte pas de ressource alors on vole le nid ennemi
					setPointNidEnnemi((collidedAgent as BotHome).GetTargetPoint());
					//pointNidEnnemi = (collidedAgent as BotHome).GetTargetPoint();
					if (!HasResource())
					{
						(collidedAgent as BotHome).TakeResource();
						SetResource(true);
					}
					if (pointNidHome != null) {
						trace("poindNidHome " + pointNidHome);
						moveAt(getPointNidHome());
					}else {
						ChangeDirection();
					}
				}else { // sinon c'est notre nid donc on dépose les ressources
					setPointNidHome((collidedAgent as BotHome).GetTargetPoint());
					//pointNidHome = (collidedAgent as BotHome).GetTargetPoint();
					if (HasResource())
					{
						(collidedAgent as BotHome).AddResource();
						SetResource(false);
					}
					if (pointNidEnnemi != null) {
						trace("poindNidEnnemi " + pointNidEnnemi);
						moveAt(getPointNidEnnemi());
					}else {
						ChangeDirection();
					}
				}
			}
			
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				moveAt((collidedAgent as Resource).GetTargetPoint());	
			}else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
				if ((collidedAgent as BotHome).GetTeamId() == "TrioDeChoc" ){
					moveAt((collidedAgent as BotHome).GetTargetPoint());
				}
			}*/
		}
		
	}

}
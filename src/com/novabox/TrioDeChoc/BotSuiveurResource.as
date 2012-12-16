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

	public class BotSuiveurResource extends SuperBot 
	{
		public function BotSuiveurResource(_type:AgentType) 
		{
			super(_type);
			//idBot = "suiveurR";
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			
			
			
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_BOT) {
				if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc" ) {
					if ((collidedAgent as SuperBot).getIdBot() == "explorer") {
						trace("collisions sur un bot explorer");
					}
				}
			}*/	
			
			//if (collidedAgent.GetType() == AgentType.AGENT_BOT) {
			//	if ((collidedAgent as Bot).GetTeamId() == "TrioDeChoc") {
				//	trace("collisions entre agent de notre equipe");
					/*if ((collidedAgent as SuperBot).getIdBot() == "explorer") {
						trace("collisions sur un bot explorer");
					}*/
		//		}
			//}
			
			/*if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE)
			{
				//on met à jour la resource (notament ses coordonnees) pour avoir sa position exacte
				//si la ressource collisioné est bien la ressource repérée par les bots explorateurs.
				if (collidedAgent == uneResource) {
					uneResource = (collidedAgent as Resource); 
					//trace("MAJ point resource " + uneResource.GetTargetPoint());
				}
			}*/
		}
		
	}

}
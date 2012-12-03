package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.AgentType;
	/**
	 * ...
	 * @author ...
	 */
	public class TrioDeChocType 
	{
		
		public static const BOT_GENERIQUE:AgentType = new AgentType(BotGenerique, 0.6);
		public static const BOT_VOLEUR_NID:AgentType = new AgentType(BotVoleurNid, 0.2);
		public static const BOT_VOLEUR_AGENT:AgentType = new AgentType(BotVoleurAgent, 0.2);
		
		/*public function TrioDeChocType() 
		{
			
		}*/
		
	}

}
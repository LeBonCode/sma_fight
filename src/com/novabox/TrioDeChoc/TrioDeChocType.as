package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.AgentType;
	/**
	 * ...
	 * @author ...
	 */
	public class TrioDeChocType 
	{
		
		public static const BOT_GENERIQUE:AgentType = new AgentType(BotGenerique, 0.4);
		public static const BOT_VOLEUR_NID:AgentType = new AgentType(BotVoleurNid, 0.3);
		public static const BOT_VOLEUR_AGENT:AgentType = new AgentType(BotVoleurAgent, 0.3);
		
		/*public function TrioDeChocType() 
		{
			
		}*/
		
	}

}
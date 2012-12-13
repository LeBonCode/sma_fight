package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.AgentType;
	/**
	 * ...
	 * @author ...
	 */
	public class TrioDeChocType 
	{
		
		public static const BOT_STUPIDE:AgentType = new AgentType(BotStupide, 0);
		public static const BOT_VOLEUR_NID:AgentType = new AgentType(BotVoleurNid, 0);
		public static const BOT_VOLEUR_AGENT:AgentType = new AgentType(BotVoleurAgent, 0);
		public static const BOT_TEST:AgentType = new AgentType(BotTest, 0);
		
		public static const BOT_SUIVEUR_RESOURCE:AgentType = new AgentType(BotSuiveurResource, 0);
		public static const BOT_SUIVEUR_NID_HOME:AgentType = new AgentType(BotSuiveurNidHome, 0);
		public static const BOT_EXPLORATEUR:AgentType = new AgentType(BotExplorateur, 0.2);
		public static const BOT_RECOLTEUR:AgentType = new AgentType(BotRecolteur, 0.8);
		
		/*public function TrioDeChocType() 
		{
			
		}*/
		
	}

}
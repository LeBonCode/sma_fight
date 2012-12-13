package com.novabox.TrioDeChoc 
{
	import com.novabox.MASwithTwoNests.AgentType;

	public class TrioDeChocType 
	{
		
		/* USELESS*/
		public static const BOT_VOLEUR_NID:AgentType = new AgentType(BotVoleurNid, 0);
		public static const BOT_VOLEUR_AGENT:AgentType = new AgentType(BotVoleurAgent, 0);
		
		/* USEFULL */
		public static const BOT_SUIVEUR_RESOURCE:AgentType = new AgentType(BotSuiveurResource, 0.1);
		public static const BOT_SUIVEUR_NID_HOME:AgentType = new AgentType(BotSuiveurNidHome, 0.1);
		public static const BOT_EXPLORATEUR:AgentType = new AgentType(BotExplorateur, 0.2);
		public static const BOT_RECOLTEUR:AgentType = new AgentType(BotRecolteur, 0.6);
		
		/*public function TrioDeChocType() 
		{
			
		}*/
		
	}
}
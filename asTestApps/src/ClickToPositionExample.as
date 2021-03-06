////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
// This file contains content from Ethan Brand by Nathaniel Hawthorne,
// now in the public domain.
//
////////////////////////////////////////////////////////////////////////////////
package {

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.elements.TextFlow;

	public class ClickToPositionExample extends Sprite
	{

		public function ClickToPositionExample()
		{
			super();

			// Set up the TextFlow with some text
			const markup:String = "<flow:TextFlow xmlns:flow='http://ns.adobe.com/textLayout/2008' fontSize='14' textIndent='15' paragraphSpaceAfter='15' paddingTop='4' paddingLeft='4'>" +
				"<flow:p>The following excerpt is from <flow:span>Ethan Brand</flow:span> by <flow:span>Nathaniel Hawthorne</flow:span>.</flow:p>" +
				"<flow:p><flow:span>There are many </flow:span><flow:span fontStyle='italic'>such</flow:span><flow:span> lime-kilns in that tract of country, for the purpose of burning the white marble which composes a large part of the substance of the hills. Some of them, built years ago, and long deserted, with weeds growing in the vacant round of the interior, which is open to the sky, and grass and wild-flowers rooting themselves into the chinks of the stones, look already like relics of antiquity, and may yet be overspread with the lichens of centuries to come. Others, where the lime-burner still feeds his daily and nightlong fire, afford points of interest to the wanderer among the hills, who seats himself on a log of wood or a fragment of marble, to hold a chat with the solitary man. It is a lonesome, and, when the character is inclined to thought, may be an intensely thoughtful occupation; as it proved in the case of Ethan Brand, who had mused to such strange purpose, in days gone by, while the fire in this very kiln was burning.</flow:span></flow:p><flow:p><flow:span>The man who now watched the fire was of a different order, and troubled himself with no thoughts save the very few that were requisite to his business. At frequent intervals, he flung back the clashing weight of the iron door, and, turning his face from the insufferable glare, thrust in huge logs of oak, or stirred the immense brands with a long pole. Within the furnace were seen the curling and riotous flames, and the burning marble, almost molten with the intensity of heat; while without, the reflection of the fire quivered on the dark intricacy of the surrounding forest, and showed in the foreground a bright and ruddy little picture of the hut, the spring beside its door, the athletic and coal-begrimed figure of the lime-burner, and the half-frightened child, shrinking into the protection of his father's shadow. And when again the iron door was closed, then reappeared the tender light of the half-full moon, which vainly strove to trace out the indistinct shapes of the neighboring mountains; and, in the upper sky, there was a flitting congregation of clouds, still faintly tinged with the rosy sunset, though thus far down into the valley the sunshine had vanished long and long ago.</flow:span></flow:p></flow:TextFlow>";
			var textFlow:TextFlow = TextConverter.importToFlow(markup, TextConverter.TEXT_LAYOUT_FORMAT);
			textFlow.interactionManager = new SelectionManager();

			var controller:ContainerController = new ContainerController(this, 500, 300);
			textFlow.flowComposer.addController(controller);
			textFlow.flowComposer.updateAllControllers();
			textFlow.interactionManager.selectRange(0, 0);
			textFlow.interactionManager.setFocus();

			// simulate clicking at (x, y)
			var x:Number = 100;
			var y:Number = 100;
			var event:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN, true, false, x, y);
			controller.container.dispatchEvent(event);
			textFlow.flowComposer.updateAllControllers();
		}
	}
}




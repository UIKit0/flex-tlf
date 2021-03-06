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
// This file contains content from Alice in Wonderland, by Lewis Carroll,
// now in the public domain.
//
////////////////////////////////////////////////////////////////////////////////

package UnitTest.Tests
{

    import UnitTest.ExtendedClasses.TestConfigurationLoader;
    import UnitTest.ExtendedClasses.TestSuiteExtended;
    import UnitTest.ExtendedClasses.VellumTestCase;
    import UnitTest.Fixtures.TestCaseVo;
    import UnitTest.Fixtures.TestConfig;
    import UnitTest.Helpers.SingleContainer;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import flashx.textLayout.compose.IFlowComposer;
    import flashx.textLayout.compose.TextFlowLine;
    import flashx.textLayout.container.ContainerController;
    import flashx.textLayout.conversion.TextConverter;
    import flashx.textLayout.edit.IEditManager;
    import flashx.textLayout.edit.SelectionManager;
    import flashx.textLayout.edit.SelectionState;
    import flashx.textLayout.elements.FlowElement;
    import flashx.textLayout.elements.TextFlow;
    import flashx.textLayout.elements.TextRange;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.utils.NavigationUtil;

    import org.flexunit.asserts.assertTrue;

    /** Test the state of selection after each operation is done, undone, and redone.
     */
    [TestCase(order=14)]
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ScrollingTest extends VellumTestCase
    {
        [DataPoints(loader=scrollWithInsideListLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var scrollWithInsideListDp:Array;

        public static var scrollWithInsideListLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "scrollWithInsideList");

        [DataPoints(loader=twoColumnsTestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var twoColumnsTestDp:Array;

        public static var twoColumnsTestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "twoColumnsTest");

        [DataPoints(loader=bug2988852Loader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var bug2988852Dp:Array;

        public static var bug2988852Loader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "bug2988852");

        [DataPoints(loader=bug2819924Case3TestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var bug2819924Case3TestDp:Array;

        public static var bug2819924Case3TestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "bug2819924Case3Test");

        [DataPoints(loader=bug2819924Case2TestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var bug2819924Case2TestDp:Array;

        public static var bug2819924Case2TestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "bug2819924Case2Test");

        [DataPoints(loader=bug2819924Case1TestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var bug2819924Case1TestDp:Array;

        public static var bug2819924Case1TestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "bug2819924Case1Test");

        [DataPoints(loader=largeLastLineLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var largeLastLineDp:Array;

        public static var largeLastLineLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ScrollingTest.xml", "largeLastLine");

        public function ScrollingTest()
        {
            //	super(methodName, testID, testConfig, testCaseXML);
            super("", "OperationTest2", TestConfig.getInstance());

            addDefaultTestSettings = false;
            TestData.fileName = "aliceExcerpt.xml";

            /*if (!TestData.hasOwnProperty("testFile"))
             TestData.fileName = "aliceExcerpt.xml";		// longer file so it exceeds container - default for this suite, tests may override in XML
             else
             TestData.fileName = TestData.testFile;   */

            metaData = {};
            // Note: These must correspond to a Watson product area (case-sensitive)
            metaData.productArea = "UI";
            metaData.productSubArea = "Scrolling";
        }

        public static function suiteFromXML(testListXML:XML, testConfig:TestConfig, ts:TestSuiteExtended):void
        {
            var testCaseClass:Class = ScrollingTest;
            VellumTestCase.suiteFromXML(testCaseClass, testListXML, testConfig, ts);
        }

        [Before]
        override public function setUpTest():void
        {
            TestData.fileName = "aliceExcerpt.xml";
            super.setUpTest();
        }

        [After]
        override public function tearDownTest():void
        {
            super.tearDownTest();
        }

        private function findFirstAndLastVisibleLine(flowComposer:IFlowComposer, controller:ContainerController):Array
        {
            var firstLine:int = flowComposer.findLineIndexAtPosition(controller.absoluteStart);
            var lastLine:int = flowComposer.findLineIndexAtPosition(controller.absoluteStart + controller.textLength - 1);
            var lastColumn:int = 0;
            var firstVisibleLine:int = -1;
            var lastVisibleLine:int = -1;
            for (var lineIndex:int = firstLine; lineIndex <= lastLine; lineIndex++)
            {
                var curLine:TextFlowLine = flowComposer.getLineAt(lineIndex);
                if (curLine.controller != controller)
                    continue;

                // skip until we find the lines in the last column
                if (curLine.columnIndex != lastColumn)
                    continue;

                if (curLine.textLineExists && curLine.getTextLine().parent)
                {
                    if (firstVisibleLine < 0)
                        firstVisibleLine = lineIndex;

                    lastVisibleLine = lineIndex;
                }
            }

            return [firstVisibleLine, lastVisibleLine];
        }

        /* Test Cases:  (explicit & wrap, vertical & horizontal, ltr, rtl)
         - Page forward, backward
         - Forward, backward by n lines
         - Partial line visible
         - On line boundary
         - Forward, backward by n pixels
         - Scroll to position horizontal scroll forward/backward (mimic typing off form field)
         - Scroll to position when position is visible
         - Scroll to position when position is partly visible (up/down/left/right)
         - Scroll to end
         - Scroll to start
         */

        private function pageForwardOrBackward(forward:Boolean):Array
        {
            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);
            var blockProgression:String = textFlow.computedFormat.blockProgression;

            var linePositionBefore:Array = findFirstAndLastVisibleLine(flowComposer, controller);

            var panelSize:Number = (blockProgression == BlockProgression.TB) ? controller.compositionHeight : controller.compositionWidth;
            var pageSize:Number = panelSize * .75;

            if (!forward)
                pageSize = -pageSize;

            if (blockProgression == BlockProgression.TB)
                controller.verticalScrollPosition += pageSize;
            else
                controller.horizontalScrollPosition -= pageSize;

            flowComposer.updateAllControllers();

            return linePositionBefore;
        }

        private function pageForward():void
        {
            var beforePosition:Array = pageForwardOrBackward(true);
            var beforeFirstVisibleLine:int = beforePosition[0];
            var beforeLastVisibleLine:int = beforePosition[1];

            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);
            var afterPosition:Array = findFirstAndLastVisibleLine(flowComposer, controller);
            var afterFirstVisibleLine:int = afterPosition[0];
            var afterLastVisibleLine:int = afterPosition[1];

            // Check that we did scroll forward, and check that some text that was visible before is still visible.
            assertTrue("PageForward didn't advance scroll", afterFirstVisibleLine > beforeFirstVisibleLine);
            assertTrue("PageForward didn't overlap previous text", afterFirstVisibleLine < beforeLastVisibleLine);
        }


        private function pageBackward():void
        {
            var beforePosition:Array = pageForwardOrBackward(false);
            var beforeFirstVisibleLine:int = beforePosition[0];
            var beforeLastVisibleLine:int = beforePosition[1];

            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);
            var afterPosition:Array = findFirstAndLastVisibleLine(flowComposer, controller);
            var afterFirstVisibleLine:int = afterPosition[0];
            var afterLastVisibleLine:int = afterPosition[1];

            // Check that we did scroll backward, and check that some text that was visible before is still visible.
            assertTrue("PageBackward didn't reverse scroll", afterFirstVisibleLine < beforeFirstVisibleLine);
            assertTrue("PageBackward didn't overlap previous text", afterLastVisibleLine > beforeFirstVisibleLine);
        }

        [Test]
        public function scrollByPageTest():void
        {
            pageForward();
            pageBackward();
        }

        private function pageForwardOrBackwardByLines(numberOfLines:int):void
        {
            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);
            var blockProgression:String = textFlow.computedFormat.blockProgression;

            var beforePosition:Array = findFirstAndLastVisibleLine(flowComposer, controller);

            var amount:Number = controller.getScrollDelta(numberOfLines);

            if (blockProgression == BlockProgression.TB)
                controller.verticalScrollPosition += amount;
            else
                controller.horizontalScrollPosition -= amount;

            flowComposer.updateAllControllers();

            var beforeFirstVisibleLine:int = beforePosition[0];
            var beforeLastVisibleLine:int = beforePosition[1];

            var afterPosition:Array = findFirstAndLastVisibleLine(flowComposer, controller);
            var afterFirstVisibleLine:int = afterPosition[0];
            var afterLastVisibleLine:int = afterPosition[1];

			var linesMatch:Boolean = afterFirstVisibleLine == beforeFirstVisibleLine + numberOfLines;
			var almostMatch:Boolean = afterFirstVisibleLine == beforeFirstVisibleLine + numberOfLines - 1;
			//added -1 because a line can be partially visible
            // Check that we did scroll forward, and check that some text that was visible before is still visible.
            assertTrue("scrollMultipleLines didn't advance scroll correctly", (linesMatch || almostMatch));
        }

        [Test]
        public function scrollMultipleLinesTest():void
        {
            pageForwardOrBackwardByLines(26);
            pageForwardOrBackwardByLines(-13);
            for (var i:int = 0; i < 6; ++i)
                pageForwardOrBackwardByLines(1);
        }

        [Test]
        public function scrollAndResizeTest():void
        {
            var textFlow:TextFlow = SelManager.textFlow;
            var position:int = textFlow.textLength - 1;

            // shrink it down
            var w:Number = TestFrame.compositionWidth;
            var h:Number = TestFrame.compositionHeight;
            TestFrame.setCompositionSize(w / 2, h / 2);
            textFlow.flowComposer.updateAllControllers();

            // select at the end
            SelManager.selectRange(position, position);
            TestFrame.scrollToRange(position, position);

            // restore size
            TestFrame.setCompositionSize(w, h);
            textFlow.flowComposer.updateAllControllers();

            // verify that the last line is in view
            var afterPosition:Array = findFirstAndLastVisibleLine(textFlow.flowComposer, TestFrame);
            var afterFirstVisibleLine:int = afterPosition[0];
            var afterLastVisibleLine:int = afterPosition[1];
            assertTrue("scrollAndResizeTest last line no longer in view", afterLastVisibleLine == textFlow.flowComposer.numLines - 1);
        }

        /* ************************************************************** */
        /* nextPage() test */
        /* ************************************************************** */

        [Test]
        public function nextPageTest():void
        {
            //Create a new TextFlow, IFlowComposer, ContainerController
            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);

            //set a textRange.
            var textRange:TextRange = new TextRange(textFlow, 0, 10);

            NavigationUtil.nextPage(textRange, false);

            //composes all the text up-to date.
            flowComposer.updateAllControllers();

            //find what the first line displayed in a scrolling container is
            var firstLineIndex:int = findFirstAndLastVisibleLine(flowComposer, controller)[0];

            //verify the position of textRange after nextPage applied
            assertTrue("first line index at first line is " + firstLineIndex + " and it should be large than 0",
                    firstLineIndex > 0);
        }

        /* ************************************************************** */
        /* previousPage() test */
        /* ************************************************************** */
        [Test]
        public function previousPageTest():void
        {
            //Create a new TextFlow, IFlowComposer, ContainerController?
            var textFlow:TextFlow = SelManager.textFlow;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var controller:ContainerController = flowComposer.getControllerAt(0);
            controller.verticalScrollPosition = 100;

            //set a textRange.
            var textRange:TextRange = new TextRange(textFlow, 1000, 1010);

            //find text index at the first line in the visible area befor change
            var firstLineIndexBefore:int = findFirstAndLastVisibleLine(flowComposer, controller)[0];

            NavigationUtil.previousPage(textRange, false);

            //composes all the text up-to date.
            flowComposer.updateAllControllers();

            //find text index at the first line in the visible area after change
            var firstLineIndexAfter:int = findFirstAndLastVisibleLine(flowComposer, controller)[0];

            //verify the position of textRange after previousPage applied
            assertTrue("last line index at last line is " + firstLineIndexAfter + " and it should be less than " + firstLineIndexBefore,
                    firstLineIndexAfter < firstLineIndexBefore);
        }


        private function testScrollLimitWithString(content:String):void
            // Scrolling from a long line to a short line should not scroll horizontally if end of short line already in view
        {
            var textFlow:TextFlow = TextConverter.importToFlow(content, TextConverter.PLAIN_TEXT_FORMAT);
            textFlow.lineBreak = LineBreak.EXPLICIT;
            var flowComposer:IFlowComposer = textFlow.flowComposer;
            var s:Sprite = new Sprite();
            var controller:ContainerController = new ContainerController(s, 100, 30);
            flowComposer.addController(controller);
            var selectionManager:SelectionManager = new SelectionManager();
            textFlow.interactionManager = selectionManager;
            selectionManager.selectRange(0, 0);
            selectionManager.setFocus();
            flowComposer.updateAllControllers();

            // Set cursor at the end of the 1st line
            var firstLine:TextFlowLine = flowComposer.getLineAt(0);
            selectionManager.selectRange(firstLine.absoluteStart + firstLine.textLength - 1, firstLine.absoluteStart + firstLine.textLength - 1);
            controller.scrollToRange(selectionManager.absoluteStart, selectionManager.absoluteEnd);
            var secondLine:TextFlowLine = flowComposer.getLineAt(1);
            var expectScrolling:Boolean = firstLine.textLength > secondLine.textLength;


            // Scroll down and back up
            scrollByKey(textFlow, Keyboard.DOWN, expectScrolling);
            scrollByKey(textFlow, Keyboard.UP, false);
            scrollByKey(textFlow, Keyboard.DOWN, false);
            scrollByKey(textFlow, Keyboard.UP, false);

            textFlow.interactionManager.selectRange(secondLine.absoluteStart + secondLine.textLength - 1, secondLine.absoluteStart + secondLine.textLength - 1);
            controller.scrollToRange(selectionManager.absoluteStart, selectionManager.absoluteEnd);
            flowComposer.updateAllControllers();

            // Scroll up and back down
            scrollByKey(textFlow, Keyboard.UP, !expectScrolling);
            scrollByKey(textFlow, Keyboard.DOWN, false);
            scrollByKey(textFlow, Keyboard.UP, false);
            scrollByKey(textFlow, Keyboard.DOWN, false);
        }

        private function scrollByKey(textFlow:TextFlow, keyCode:int, expectScrolling:Boolean):void
            // Scroll one line, and check that we only scrolled in vertical direction
        {
            var controller:ContainerController = textFlow.flowComposer.getControllerAt(0);

            // Save off old logical horizontal scroll pos
            var blockProgression:String = textFlow.computedFormat.blockProgression;
            var logicalHorizontalScrollPosition:Number = (blockProgression == BlockProgression.TB) ? controller.horizontalScrollPosition : controller.verticalScrollPosition;

            var kEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, keyCode);
            SelectionManager(textFlow.interactionManager).keyDownHandler(kEvent);

            if (expectScrolling)
                assertTrue("Logical horizontal scroll position should have changed",
                        logicalHorizontalScrollPosition != ((blockProgression == BlockProgression.TB) ? controller.horizontalScrollPosition : controller.verticalScrollPosition));
            else
                assertTrue("Logical horizontal scroll position should not have changed",
                        logicalHorizontalScrollPosition == ((blockProgression == BlockProgression.TB) ? controller.horizontalScrollPosition : controller.verticalScrollPosition));
        }

        /**
         * Test for Watson 2476646
         */
        [Test]
        public function scrollUpDownLimitTest():void
            // Scrolling from a long line to a short line or vice versa should not scroll horizontally if end of short line already in view
        {
            testScrollLimitWithString("A B C D E F G\n" + "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z");
            testScrollLimitWithString("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z\n" + "A B C D E F G");
        }

        [Test]
        public function scrollToSelectionAfterParagraphInsertion():void
        {
            var textFlow:TextFlow = SelManager.textFlow;
            textFlow.flowComposer.updateAllControllers();
            SelManager.selectRange(textFlow.textLength, textFlow.textLength);
            var paragraphCount:int = textFlow.computedFormat.blockProgression == BlockProgression.RL ? 12 : 7;
            for (var i:int = 0; i < paragraphCount; ++i)
                SelManager.splitParagraph();
            var controller:ContainerController = textFlow.flowComposer.getControllerAt(0);
            var firstLineIndex:int = findFirstAndLastVisibleLine(textFlow.flowComposer, controller)[0];
            assertTrue("Expected view to scroll to keep selection in view", firstLineIndex > 0);
        }

        [Test]
        public function scrollWithAdormentsAndInlines():void
        {
            var textFlow:TextFlow = SelManager.textFlow;
            textFlow.flowComposer.updateAllControllers();
            // underline everything
            SelManager.selectAll();
            var format:TextLayoutFormat = new TextLayoutFormat();
            format.textDecoration = TextDecoration.UNDERLINE;
            (SelManager as IEditManager).applyLeafFormat(format);
            // insert a graphic
            var shape:Shape = new Shape;
            shape.graphics.beginFill(0xff0000);
            shape.graphics.drawRect(0, 0, 25, 25);
            shape.graphics.endFill();
            SelManager.selectRange(0, 0);
            (SelManager as IEditManager).insertInlineGraphic(shape, 25, 25);
            // now page forward and then back
            pageForward();
            pageBackward();
            // check rendering - there should be decorations
        }

        [Test(dataProvider=scrollWithInsideListDp)]
        public function scrollWithInsideList(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var textFlow:TextFlow = SelManager.textFlow;
            textFlow.flowComposer.updateAllControllers();
            // now page forward and then back
            pageForward();
            pageBackward();
            // check rendering - the inside list should have proper markers
        }

        private function createFilledSprite(width:Number, height:Number, color:int):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(color);	// red
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            return sprite;
        }

        [Test(dataProvider=largeLastLineDp)]
        public function largeLastLine(testCaseVo:TestCaseVo):void		// 2739996
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var textFlow:TextFlow = SelManager.textFlow;
            SelManager.selectRange(textFlow.textLength - 1, textFlow.textLength - 1);
            SelManager.insertInlineGraphic(createFilledSprite(200, 200, 0xff0000), 200, 200, Float.NONE);
            textFlow.flowComposer.updateAllControllers();
            SelManager.selectRange(0, 0);
            textFlow.flowComposer.getControllerAt(0).scrollToRange(0, 0);
            var insertLineCount:int = textFlow.computedFormat.blockProgression == BlockProgression.RL ? 11 : 6;
            for (var i:int = 0; i < insertLineCount; ++i)		// gradually force the inline out of view
                SelManager.splitParagraph();
            var firstVisibleLine:int = findFirstAndLastVisibleLine(textFlow.flowComposer, textFlow.flowComposer.getControllerAt(0))[0];
            assertTrue("Shouldn't scroll down yet", firstVisibleLine == 0);
        }

        /**
         *  mjzhang : Watson#2819924 Error #1009 in flashx.textLayout.container::ContainerController::updateGraphics()
         */
        [Test(dataProvider=bug2819924Case1TestDp)]
        public function bug2819924Case1Test(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var textFlow:TextFlow = SelManager.textFlow;
            var controller:ContainerController = textFlow.flowComposer.getControllerAt(0);

            for (var i:int = 0; i < 15; i++)
            {
                textFlow.addChild(TextConverter.importToFlow(
                        '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008">xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx <img source="http://flex.apache.org/images/logo_01_fullcolor-sm.png"/> xxxx</TextFlow>',
                        TextConverter.TEXT_LAYOUT_FORMAT
                ).getChildAt(0));

                textFlow.addChild(
                        TextConverter.importToFlow(
                                '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008">xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxx</TextFlow>',
                                TextConverter.TEXT_LAYOUT_FORMAT
                        ).getChildAt(0));

                controller.verticalScrollPosition += 50;
                textFlow.flowComposer.updateAllControllers();
            }
        }

        private var singleCT:SingleContainer = new SingleContainer();

        /**
         * mjzhang : Watson#2819924 Error #1009 in flashx.textLayout.container::ContainerController::updateGraphics()
         */
        [Test(dataProvider=bug2819924Case2TestDp)]
        public function bug2819924Case2Test(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            SelManager.insertInlineGraphic(singleCT, 600, 400, Float.NONE);
        }

        /**
         * mjzhang : Watson#2819924 Error #1009 in flashx.textLayout.container::ContainerController::updateGraphics()  
         */
        [Test(dataProvider=bug2819924Case3TestDp)]
        public function bug2819924Case3Test(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var textFlow:TextFlow = SelManager.textFlow;
            var controller:ContainerController = textFlow.flowComposer.getControllerAt(0);

            var str:String = "";
            var i:int = 30;
            while (i > 0)
            {
                str += i + "\n";
                i--;
            }

            var tf:TextFlow = TextConverter.importToFlow(str, TextConverter.PLAIN_TEXT_FORMAT);
            var flowElem:FlowElement = tf.getChildAt(0);
            textFlow.addChild(flowElem);
            textFlow.addChild(TextConverter.importToFlow(
                    '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008"><img source="http://flex.apache.org/images/logo_01_fullcolor-sm.png"/> </TextFlow>',
                    TextConverter.TEXT_LAYOUT_FORMAT
            ).getChildAt(0));


            for (var j:int = 0; j < 100; j++)
            {
                textFlow.addChild(TextConverter.importToFlow("aaa", TextConverter.PLAIN_TEXT_FORMAT).getChildAt(0));
                textFlow.addChild(TextConverter.importToFlow(
                        '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008"><img source="http://flex.apache.org/images/logo_01_fullcolor-sm.png"/> </TextFlow>',
                        TextConverter.TEXT_LAYOUT_FORMAT
                ).getChildAt(0));

                controller.verticalScrollPosition += 10;
                textFlow.flowComposer.updateAllControllers();
            }

            textFlow.flowComposer.updateAllControllers();
        }

        [Test(dataProvider=bug2988852Dp)]
        public function bug2988852(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var tf:TextFlow = SelManager.textFlow;
            for (var i:int = 0; i < 15; i++)
            {
                tf.addChild(TextConverter.importToFlow(
                        '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008">The Apache Flex SDK is the evolution of the popular Adobe Flex SDK. The Apache Flex SDK is an application development framework for easily building Flash based applications for mobile devices, web browsers, and desktop platforms.<img source="http://flex.apache.org/images/logo_01_fullcolor-sm.png"/> Currently supported platforms</TextFlow>',
                        TextConverter.TEXT_LAYOUT_FORMAT
                ).getChildAt(0));
            }
            tf.flowComposer.updateAllControllers();

            SelManager.insertInlineGraphic(singleCT, "auto", "auto", Float.NONE, new SelectionState(tf, 500, 500));
            var controller:ContainerController = tf.flowComposer.getControllerAt(0);
            controller.verticalScrollPosition += 20;
            tf.flowComposer.updateAllControllers();

            controller.verticalScrollPosition += 2000;
            tf.flowComposer.updateAllControllers();

            controller.verticalScrollPosition -= 2100;
            tf.flowComposer.updateAllControllers();

            for (var scrollTimes:int = 0; scrollTimes < 10; scrollTimes++)
            {
                controller.verticalScrollPosition += (800 + 50 * scrollTimes);
                tf.flowComposer.updateAllControllers();

                controller.verticalScrollPosition -= (800 + 20 * scrollTimes);
                tf.flowComposer.updateAllControllers();
            }
        }

        [Test(dataProvider=twoColumnsTestDp)]
        public function twoColumnsTest(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            var tf:TextFlow = SelManager.textFlow;
            for (var i:int = 0; i < 60; i++)
            {
                tf.addChildAt(0, TextConverter.importToFlow(
                        '<TextFlow xmlns="http://ns.adobe.com/textLayout/2008"><list paddingRight="24" paddingLeft="24" listStyleType="upperAlpha"><li>upperAlpha item</li></list></TextFlow>',
                        TextConverter.TEXT_LAYOUT_FORMAT
                ).getChildAt(0));
            }
            var controller:ContainerController = tf.flowComposer.getControllerAt(0);
            controller.columnCount = 2;
            tf.flowComposer.updateAllControllers();

            controller.verticalScrollPosition += 100;
            tf.flowComposer.updateAllControllers();
            var tfl60:TextFlowLine = tf.flowComposer.getLineAt(59);
            assertTrue("The 60th line should be on the stage after scrolling down 100 pixels", controller.container.contains(tfl60.getTextLine()));
        }
    }
}

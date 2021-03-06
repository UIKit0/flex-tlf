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
package UnitTest.Tests
{
    import UnitTest.ExtendedClasses.TestConfigurationLoader;
    import UnitTest.ExtendedClasses.VellumTestCase;
    import UnitTest.Fixtures.TestCaseVo;
    import UnitTest.Fixtures.TestConfig;

    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.KeyLocation;

    import flashx.textLayout.container.ContainerController;
    import flashx.textLayout.elements.TextFlow;
    import flashx.textLayout.formats.BlockProgression;

    import org.flexunit.asserts.assertTrue;

    [TestCase(order=30)]
    [RunWith("org.flexunit.runners.Parameterized")]
    public class VerticalScrollingTest extends VellumTestCase
    {
        // List of available keyboard gestures
        // Note that on Mac: CTRL == COMMAND
        //              and: ALT == OPTION
        // These are directly mapped in flash player
        private static const CTRL_BACKSPACE:int = 100;
        private static const CTRL_DELETE:int = 101;
        private static const OPT_BACKSPACE:int = 102;
        private static const OPT_DELETE:int = 103;
        private static const CTRL_LEFT:int = 104;
        private static const CTRL_RIGHT:int = 105;
        private static const CTRL_UP:int = 106;
        private static const CTRL_DOWN:int = 107;
        private static const OPT_LEFT:int = 108;
        private static const OPT_RIGHT:int = 109;
        private static const OPT_UP:int = 110;
        private static const OPT_DOWN:int = 111;
        private static const SHIFT_CTRL_LEFT:int = 112;
        private static const SHIFT_CTRL_RIGHT:int = 113;
        private static const SHIFT_CTRL_UP:int = 114;
        private static const SHIFT_CTRL_DOWN:int = 115;
        private static const SHIFT_OPT_LEFT:int = 116;
        private static const SHIFT_OPT_RIGHT:int = 117;
        private static const SHIFT_OPT_UP:int = 118;
        private static const SHIFT_OPT_DOWN:int = 119;
        private static const HOME:int = 120;
        private static const END:int = 121;
        private static const SHIFT_HOME:int = 122;
        private static const SHIFT_END:int = 123;
        private static const CTRL_HOME:int = 124;
        private static const CTRL_END:int = 125;
        private static const SHIFT_CTRL_HOME:int = 126;
        private static const SHIFT_CTRL_END:int = 127;
        private static const PG_UP:int = 128;
        private static const PG_DOWN:int = 129;
        private static const SHIFT_PG_UP:int = 130;
        private static const SHIFT_PG_DOWN:int = 131;
        private static const UP:int = 132;
        private static const DOWN:int = 133;
        private static const LEFT:int = 134;
        private static const RIGHT:int = 135;

        private static const SHIFT_RIGHT:int = 136;
        private static const SHIFT_LEFT:int = 137;
        private static const SHIFT_UP:int = 138;
        private static const SHIFT_DOWN:int = 139;


        [DataPoints(loader=HOLTR_endKeyScrollingTestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var HOLTRTestDp:Array;

        public static var HOLTR_endKeyScrollingTestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/VerticalScrollingTests.xml", "HOLTR_endKeyScrollingTest");

        [DataPoints(loader=VOLTR_endKeyScrollingTestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var VOLTRTestDp:Array;

        public static var VOLTR_endKeyScrollingTestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/VerticalScrollingTests.xml", "VOLTR_endKeyScrollingTest");

        [DataPoints(loader=HORTL_endKeyScrollingTestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var HORTLTestDp:Array;

        public static var HORTL_endKeyScrollingTestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/VerticalScrollingTests.xml", "HORTL_endKeyScrollingTest");

        [DataPoints(loader=VORTL_endKeyScrollingTestLoader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var VORTLTestDp:Array;

        public static var VORTL_endKeyScrollingTestLoader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/VerticalScrollingTests.xml", "VORTL_endKeyScrollingTest");

        public function VerticalScrollingTest()
        {
            super("", "HorizontalScrollingTest", TestConfig.getInstance());

            metaData = {};

            // Note: These must correspond to a Watson product area (case-sensitive)
            metaData.productArea = "UI";
            metaData.productSubArea = "Scrolling";
        }

        [After]
        public override function tearDownTest():void
        {
            // Restore default configurations
            super.tearDownTest();
        }

        // Horizontal Orientation Left To Right Direction Scrolling Tests.
        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_endKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            endKeyScrollingTest(647, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_homeKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            homeKeyScrollingTest(4, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_cursorUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorUpScrollingTest(13, 645, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_cursorDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorDownScrollingTest(13, 5, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_dragUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragUpScrollingTest(12, 645, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_dragDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragDownScrollingTest(12, 5, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_characterEntryEndOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            characterEntryEndOfTextScrollingTest(647, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_spaceEntryMiddleOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            spaceEntryMiddleOfTextScrollingTest(5, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_deleteScrollingTest(testCaseVo:TestCaseVo):void
        {
            deleteScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_backspaceScrollingTest(testCaseVo:TestCaseVo):void
        {
            backspaceScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_pageUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageUpScrollingTest(229, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_pageDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageDownScrollingTest(417, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_mousewheelUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingTest(587, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_mousewheelUpScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingNoInteractionTest(587, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_mousewheelDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingTest(60, testCaseVo);
        }

        [Test(dataProvider=HOLTRTestDp)]
        public function HOLTR_mousewheelDownScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingNoInteractionTest(60, testCaseVo);
        }

        // Vertical Orientation Left To Right Direction Scrolling Tests.
        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_endKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            endKeyScrollingTest(1094, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_homeKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            homeKeyScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_cursorUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorUpScrollingTest(24, 1059, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_cursorDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorDownScrollingTest(24, 35, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_dragUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragUpScrollingTest(23, 1059, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_dragDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragDownScrollingTest(23, 35, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_characterEntryEndOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            characterEntryEndOfTextScrollingTest(1094, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_spaceEntryMiddleOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            spaceEntryMiddleOfTextScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_deleteScrollingTest(testCaseVo:TestCaseVo):void
        {
            deleteScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_backspaceScrollingTest(testCaseVo:TestCaseVo):void
        {
            backspaceScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_pageUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageUpScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_pageDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageDownScrollingTest(722, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_mousewheelUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingTest(1034, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_mousewheelUpScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingNoInteractionTest(1034, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_mousewheelDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingTest(60, testCaseVo);
        }

        [Test(dataProvider=VOLTRTestDp)]
        public function VOLTR_mousewheelDownScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingNoInteractionTest(60, testCaseVo);
        }

        // Horizontal Orientation Left To Right Direction Scrolling Tests.
        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_endKeyScrollingTest(testCaseVo:TestCaseVo):void
        {

            endKeyScrollingTest(647, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_homeKeyScrollingTest(testCaseVo:TestCaseVo):void
        {

            homeKeyScrollingTest(4, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_cursorUpScrollingTest(testCaseVo:TestCaseVo):void
        {

            cursorUpScrollingTest(13, 645, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_cursorDownScrollingTest(testCaseVo:TestCaseVo):void
        {

            cursorDownScrollingTest(13, 5, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_dragUpScrollingTest(testCaseVo:TestCaseVo):void
        {

            dragUpScrollingTest(12, 645, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_dragDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragDownScrollingTest(12, 5, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_characterEntryEndOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            characterEntryEndOfTextScrollingTest(647, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_spaceEntryMiddleOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            spaceEntryMiddleOfTextScrollingTest(5, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_deleteScrollingTest(testCaseVo:TestCaseVo):void
        {
            deleteScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_backspaceScrollingTest(testCaseVo:TestCaseVo):void
        {
            backspaceScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_pageUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageUpScrollingTest(229, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_pageDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageDownScrollingTest(417, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_mousewheelUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingTest(587, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_mousewheelUpScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingNoInteractionTest(587, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_mousewheelDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingTest(60, testCaseVo);
        }

        [Test(dataProvider=HORTLTestDp)]
        public function HORTL_mousewheelDownScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingNoInteractionTest(60, testCaseVo);
        }

        // Vertical Orientation Left To Right Direction Scrolling Tests.
        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_endKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            endKeyScrollingTest(1094, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_homeKeyScrollingTest(testCaseVo:TestCaseVo):void
        {
            homeKeyScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_cursorUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorUpScrollingTest(24, 1059, testCaseVo);
        }

        public function VORTL_cursorDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            cursorDownScrollingTest(24, 35, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_dragUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragUpScrollingTest(23, 1059, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_dragDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            dragDownScrollingTest(23, 35, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_characterEntryEndOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            characterEntryEndOfTextScrollingTest(1094, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_spaceEntryMiddleOfTextScrollingTest(testCaseVo:TestCaseVo):void
        {
            spaceEntryMiddleOfTextScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_deleteScrollingTest(testCaseVo:TestCaseVo):void
        {
            deleteScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_backspaceScrollingTest(testCaseVo:TestCaseVo):void
        {
            backspaceScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_pageUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageUpScrollingTest(0, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_pageDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            pageDownScrollingTest(722, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_mousewheelUpScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingTest(1034, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_mousewheelUpScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelUpScrollingNoInteractionTest(1034, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_mousewheelDownScrollingTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingTest(60, testCaseVo);
        }

        [Test(dataProvider=VORTLTestDp)]
        public function VORTL_mousewheelDownScrollingNoInteractionTest(testCaseVo:TestCaseVo):void
        {
            mousewheelDownScrollingNoInteractionTest(60, testCaseVo);
        }

        /**
         * Send a keyboard gesture using values listed above
         * Code folding extremely recommended here
         * @param type
         */
        private function sendKeyboardGesture(type:int):void
        {
            var charCode:int;
            var keyCode:int;
            var ctrlDown:Boolean = false;
            var shiftDown:Boolean = false;
            var altDown:Boolean = false;

            var leftCode:int = 37;
            var rightCode:int = 39;
            var upCode:int = 38;
            var downCode:int = 40;

            // Arrow keys behave differently on Right to Left Blockprogression
            // For the sake of test simplicity, I am translating the directions here
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.RL)
            {
                leftCode = 38;
                rightCode = 40;
                upCode = 39;
                downCode = 37;
            }
            switch (type)
            {
                case CTRL_BACKSPACE:
                    charCode = 8;
                    keyCode = 8;
                    ctrlDown = true;
                    break;
                case CTRL_DELETE:
                    charCode = 127;
                    keyCode = 46;
                    ctrlDown = true;
                    break;
                case OPT_BACKSPACE:
                    charCode = 8;
                    keyCode = 8;
                    altDown = true;
                    break;
                case OPT_DELETE:
                    charCode = 127;
                    keyCode = 46;
                    altDown = true;
                    break;
                case CTRL_LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    ctrlDown = true;
                    break;
                case CTRL_RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    ctrlDown = true;
                    break;
                case CTRL_UP:
                    charCode = 0;
                    keyCode = upCode;
                    ctrlDown = true;
                    break;
                case CTRL_DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    ctrlDown = true;
                    break;
                case OPT_LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    altDown = true;
                    break;
                case OPT_RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    altDown = true;
                    break;
                case OPT_UP:
                    charCode = 0;
                    keyCode = upCode;
                    altDown = true;
                    break;
                case OPT_DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    altDown = true;
                    break;
                case SHIFT_LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    ctrlDown = false;
                    shiftDown = true;
                    break;
                case SHIFT_RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    ctrlDown = false;
                    shiftDown = true;
                    break;
                case SHIFT_UP:
                    charCode = 0;
                    keyCode = upCode;
                    ctrlDown = false;
                    shiftDown = true;
                    break;
                case SHIFT_DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    ctrlDown = false;
                    shiftDown = true;
                    break;
                case SHIFT_CTRL_LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_CTRL_RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_CTRL_UP:
                    charCode = 0;
                    keyCode = upCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_CTRL_DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_OPT_LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_OPT_RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_OPT_UP:
                    charCode = 0;
                    keyCode = upCode;
                    ctrlDown = true;
                    shiftDown = true;
                    break;
                case SHIFT_OPT_DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    altDown = true;
                    shiftDown = true;
                    break;
                case HOME:
                    charCode = 0;
                    keyCode = 36;
                    break;
                case END:
                    charCode = 0;
                    keyCode = 35;
                    break;
                case SHIFT_HOME:
                    charCode = 0;
                    keyCode = 36;
                    shiftDown = true;
                    break;
                case SHIFT_END:
                    charCode = 0;
                    keyCode = 35;
                    shiftDown = true;
                    break;
                case CTRL_HOME:
                    charCode = 0;
                    keyCode = 36;
                    ctrlDown = true;
                    break;
                case CTRL_END:
                    charCode = 0;
                    keyCode = 35;
                    ctrlDown = true;
                    break;
                case SHIFT_CTRL_HOME:
                    charCode = 0;
                    keyCode = 36;
                    shiftDown = true;
                    ctrlDown = true;
                    break;
                case SHIFT_CTRL_END:
                    charCode = 0;
                    keyCode = 35;
                    shiftDown = true;
                    ctrlDown = true;
                    break;
                case PG_UP:
                    charCode = 0;
                    keyCode = 33;
                    break;
                case PG_DOWN:
                    charCode = 0;
                    keyCode = 34;
                    break;
                case SHIFT_PG_UP:
                    charCode = 0;
                    keyCode = 33;
                    shiftDown = true;
                    break;
                case SHIFT_PG_DOWN:
                    charCode = 0;
                    keyCode = 34;
                    shiftDown = true;
                    break;
                case UP:
                    charCode = 0;
                    keyCode = upCode;
                    break;
                case DOWN:
                    charCode = 0;
                    keyCode = downCode;
                    break;
                case LEFT:
                    charCode = 0;
                    keyCode = leftCode;
                    break;
                case RIGHT:
                    charCode = 0;
                    keyCode = rightCode;
                    break;
                default:
                    return;
            }

            var kEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN,
                    true, false, charCode, keyCode, KeyLocation.STANDARD, ctrlDown, altDown, shiftDown);
            TestFrame.container["dispatchEvent"](kEvent);
        }

        public function endKeyScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the CTRL + Home key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Hit the CTRL + End key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_END);
            // Check to make sure that it scrolled.
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("endKeyScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("endKeyScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("EndKey Scrolling Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("EndKey Scrolling Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function homeKeyScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the CTRL + End key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_END);
            // Hit the CTRL + Home key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_HOME);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("homeKeyScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("homeKeyScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("HomeKey Scrolling Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("HomeKey Scrolling Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function cursorUpScrollingTest(lines:Number, scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the End key to scroll to the end of the text.
            sendKeyboardGesture(CTRL_END);
            // Move the cursor over to the right.
            for (var i:Number = 0; i < lines; i++)
            {
                sendKeyboardGesture(UP);
            }
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("cursorUpScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("cursorUpScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("cursorUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("cursorUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }

        }

        public function cursorDownScrollingTest(lines:Number, scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the CTRL + HOME key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Move the cursor over to the right.
            for (var i:Number = 0; i < lines; i++)
            {
                sendKeyboardGesture(DOWN);
            }
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("cursorDownScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("cursorDownScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("cursorDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("cursorDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function dragUpScrollingTest(lines:Number, scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the End key to scroll to the end of the text.
            sendKeyboardGesture(CTRL_END);
            // Move the cursor over to the right.
            for (var i:Number = 0; i < lines; i++)
            {
                sendKeyboardGesture(UP);
            }
            sendKeyboardGesture(SHIFT_UP);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("dragUpScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("dragUpScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("dragUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("dragUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }

        }

        public function dragDownScrollingTest(lines:Number, scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the CTRL + HOME key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Move the cursor over to the right.
            for (var i:Number = 0; i < lines; i++)
            {
                sendKeyboardGesture(DOWN);
            }
            sendKeyboardGesture(SHIFT_DOWN);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("dragDownScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("dragDownScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("dragDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("dragDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function characterEntryEndOfTextScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the End key to scroll to the end of the first line.
            sendKeyboardGesture(CTRL_END);
            // Type in ABC and confirm that it scrolls.
            SelManager.insertText(" It was the best of times, it was the worst of times. I hope this thing scrolls like I expect it to scroll or this test will fail. ;)");
            //SelManager.flushPendingOperations();
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("characterEntryEndOfTextScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("characterEntryEndOfTextScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("characterEntryEndOfTextScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("characterEntryEndOfTextScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function spaceEntryMiddleOfTextScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Hit the CTRL + HOME key to scroll to the beginning of the text.
            sendKeyboardGesture(CTRL_HOME);
            // Move down to the middle of the text.
            for (var i:Number = 0; i < 13; i++)
            {
                sendKeyboardGesture(DOWN);
            }
            sendKeyboardGesture(END);
            // Type in ABC and confirm that it scrolls.
            SelManager.insertText("                                                                                       ");
            //SelManager.flushPendingOperations();
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("spaceEntryMiddleOfTextScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("spaceEntryMiddleOfTextScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("spaceEntryMiddleOfTextScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("spaceEntryMiddleOfTextScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function deleteScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Delete to force it to scroll up.
            for (var i:int = 0; i < 60; i++)
            {
                SelManager.deleteNextCharacter();
            }
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("deleteScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("deleteScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("deleteScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("deleteScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function backspaceScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Move to the second line.
            sendKeyboardGesture(DOWN);
            // Hit the End key to scroll to the end of the second line.
            sendKeyboardGesture(END);
            // Backspace to force it to scroll up.
            for (var i:int = 0; i < 60; i++)
            {
                SelManager.deletePreviousCharacter();
            }
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("backspaceScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("backspaceScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("backspaceScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("backspaceScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function pageUpScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_END);
            // Do a page up.
            sendKeyboardGesture(PG_UP);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("pageUpScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("pageUpScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("pageUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("pageUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function pageDownScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Do a page down.
            sendKeyboardGesture(PG_DOWN);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("pageDownScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("pageDownScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("pageDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("pageDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function mousewheelUpScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_END);
            // Do a mousewheel up.
            var mEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false, 3);
            TestFrame.container["dispatchEvent"](mEvent);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("mousewheelUpScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("mousewheelUpScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("mousewheelUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("mousewheelUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function mousewheelUpScrollingNoInteractionTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_END);
            var textFlow:TextFlow = SelManager.textFlow;		// save it for later
            SelManager.textFlow.interactionManager = null;		// turn off editing

            // Do a mousewheel up.
            var mEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false, 3);
            TestFrame.container["dispatchEvent"](mEvent);

            textFlow.interactionManager = SelManager;

            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("mousewheelUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("mousewheelUpScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }

            //to avoid tear down assertion
            SelManager.selectRange(0, 0);
        }

        public function mousewheelDownScrollingTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Do a mousewheel down.
            var mEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false, -3);
            TestFrame.container["dispatchEvent"](mEvent);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("mousewheelDownScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("mousewheelDownScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("mousewheelDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("mousewheelDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function mousewheelDownScrollingNoInteractionTest(scrollPos:Number, testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the start of the first line.
            sendKeyboardGesture(CTRL_HOME);
            // Do a mousewheel down.
            var textFlow:TextFlow = SelManager.textFlow;		// save it for later
            SelManager.textFlow.interactionManager = null;		// turn off editing
            var mEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false, -3);
            TestFrame.container["dispatchEvent"](mEvent);

            textFlow.interactionManager = SelManager;

            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));

            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("mousewheelDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("mousewheelDownScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }

            //to avoid tear down assertion
            SelManager.selectRange(0, 0);
        }

        public function autoScrollVisibleScrollingTest(scrollPos:Number):void
        {
            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the end of the text.
            sendKeyboardGesture(CTRL_END);
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            tmpContainerController.verticalScrollPolicy = "auto";
            // Type in enough text to make the scroll bars appear.
            SelManager.insertText(" It was the best of times, it was the worst of times.");
            //var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("autoScrollVisibleScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("autoScrollVisibleScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("autoScrollVisibleScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("autoScrollVisibleScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }

        public function autoScrollHideScrollingTest(scrollPos:Number):void
        {
            // Success or failure will be determined by the bitmap snapshot.
            // Move the cursor to the beginning of the first line.
            SelManager.selectRange(0, 0);
            // Make sure we are at the end of the text.
            sendKeyboardGesture(CTRL_END);
            // Delete enough characters so scroll bars disappear.
            for (var i:int = 0; i < 60; i++)
            {
                SelManager.deletePreviousCharacter();
            }
            var tmpContainerController:ContainerController = ContainerController(SelManager.textFlow.flowComposer.getControllerAt(0));
            //	trace("autoScrollHideScrollingTestHP=" + tmpContainerController.horizontalScrollPosition);
            //	trace("autoScrollHideScrollingTestVP=" + tmpContainerController.verticalScrollPosition);
            if (SelManager.textFlow.computedFormat.blockProgression == BlockProgression.TB)
            {
                assertTrue("autoScrollHideScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.verticalScrollPosition) < (scrollPos + 1)) == true);
            }
            else
            {
                assertTrue("autoScrollHideScrollingTest Test Failed.", (scrollPos < Math.abs(tmpContainerController.horizontalScrollPosition) < (scrollPos + 1)) == true);
            }
        }
    }
}

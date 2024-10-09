/*
 * Project: Xtronic Dev Tools
 * File Name: app_strings.dart
 * File Created: Monday, 15th January 2024 4:49:05 pm
 * Author: Omegaki113r (omegaki113r@gmail.com)
 * -----
 * Last Modified: Tuesday, 27th February 2024 9:29:31 pm
 * Modified By: Omegaki113r (omegaki113r@gmail.com>)
 * -----
 * Copyright 2024 - 2024 0m3g4ki113r, Xtronic
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	---------------------------------------------------------
 */

const String appName = "Xtronic DevTools";
const String developerPrefix = "Developed By: ";
const String versionPrefix = "Version: ";
const String developer = "0m3g4ki113r";
const String version = "0.0.10-alpha";

const String lblConnect = "Connect";
const String lblDisconnect = "Disconnect";

const String lblBitwiseCalculator = "Bitwise Calculator";
const String lblDecimal = "Decimal";
const String lbl2sCompliment = "2's Compliment";
const String lblBinary = "Binary";
const String lblOctal = "Octal";
const String lblHex = "Hex";
const String lblAscii = "ASCII";
const String lblExpressionResult = "Result";

const String lblDataStreamer = "Data Streamer";
const String lblAutoScroll = "AutoScroll";

const String lblSerial = "Serial";
const String lblWebSocket = "Web Socket";
const String lblMQTT = "MQTT";

const String lblJSONConfigurator = "JSON Configurator";
const String lblJSONString = "JSON String";
const String lblCJSONString = "JSON C String";

const String lblLoad = "Load";
const String lblCopy = "Copy";
const String lblCopiedToClipboard = "Copied to Clipboard!";
const String lblFloatingPointsNotYetSupported =
    "Floating point number conversion not yet supported!";

const String lblAbout = "About";
const String lblLabelNotProvided = "LABEL NOT PROVIDED";

const String lblNotSupportedYet = "NOT SUPPORTED YET!";
const String lblWEBAPINotice =
    "Web API for Serial Communication SUCKS!!!.. I am not happy with the results. Therefore this feature flagged as UNFINISHED!!.. ";

const String lblNoCOMPORT = "No COM Port";
const String lblPort = "Port";
const String lblBaud = "Baud";
const String lblDataBits = "Data Bits";
const String lblStopBits = "Stop Bits";
const String lblParity = "Parity";
const String lblCTSFlowControl = "CTS Flow Control";
const String msgCannotChangeConfigAfterConnect =
    "Web doesn't support configuration change after connection is established. Please disconnect from serial port, change the configuration and reconnect";
const String lblConfiguration = "Configuration";
const String lblTX = "TX";
const String lblRX = "RX";
const String lblSendOnEnter = "Send On Enter";
const String lblReceived = "Received";
const String lblReset = "Reset";
const String lblClearData = "Clear Data";
const String lblReceivedData = "Received Data";
const String lblTransmitted = "Transmitted";
const String lblTransmittedData = "Transmitted Data";

const String lblJSONRoot = " { } ";
const String lblData = "data";
const String lblName = "Name";
const String lblType = "Type";
const String lblString = "String";
const String lblNumber = "Number";
const String lblBoolean = "Boolean";
const String lblObject = "Object";
const String lblArray = "Array";
const String lblJSONSeperator = " : ";

// const String regExDecimal = r'^\d+(\.\d*)?';
const String regExDecimal = r'[\d+\-*/() <<>> &| ]';
const String regExBinary = r'[01+\-*/() <<>> &| ]';
const String regExOctal = r'[0-7+\-*/() <<>> &| ]';
const String regExHex = r'[0-9A-Fa-f+\-*/() <<>> &| ]';

const String msgLoadJSONFromFile = "Load JSON from file";
const String msgCopyToClipboard = "Copy the string to clipboard";
const String msgAddChildNode = "Add JSON child";
const String msgExpandCollapseNode = "Expand/Collapse";
const String msgDeleteChildNode = "Delete JSON child and it's contents";

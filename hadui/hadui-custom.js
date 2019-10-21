/**
 * hadui-custom.js
 */

import WSC from "/wsc.js";

export const HaduiDefaultStmt =
  // the statement shown initially
  `
do
  uiClearLog -- clear front UI log box

  uiLog $ TextMsg "This is a simple message."
  uiLog $ DetailedMsg "This message conveys following details:" 
                      "the message details ..."

  uiLog $ ErrorMsg "This is an error message."
  uiLog $ DetailedErrorMsg
            "This error message conveys following details:" 
            "the error details ..."

  print "This log msg should appear on front UI."
  logInfo "This log msg should appear on backend."
`.trim();

export class HaduiWSC extends WSC {
  // implement ws methods here
}

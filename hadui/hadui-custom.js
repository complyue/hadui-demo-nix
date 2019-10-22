/**
 * hadui-custom.js
 */

import WSC from "/wsc.js";

export const HaduiDefaultStmt =
  // the statement shown initially
  `do -- the statement here run in the 'UIO' monad
  -- uiXXX and print output to the log box in frontend
  uiClearLog -- clear front UI log box

  print "Hello, web front!"

  uiLog $ TextMsg "This is a simple message."
  uiLog $ DetailedMsg "This message conveys following details:" 
                      "the message details ..."

  uiLog $ ErrorMsg "This is an error message."
  uiLog $ DetailedErrorMsg
            "This error message conveys following details:" 
            "the error details ..."

{- note:
a hadui aware stack project can define various html pages for
frontend UI, there can be no log box in some page, uiLog/print
will appear in the browser's developer console on such pages -}

  -- monad 'UIO' implements 'HasLogFunc', so you have logXXX
  logInfo "This log msg should appear on backend."

  -- control front UI from Haskell
  showRatingPage "_blank"
`;

export class HaduiWSC extends WSC {
  // implement ws methods here

  // called by backend to update the rank shown on UI
  updateRank(newRank) {
    $("#rank").text("" + newRank);
  }
}

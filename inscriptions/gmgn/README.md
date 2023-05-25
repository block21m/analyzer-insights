This (download link)[] (??GB) contains all tapscripts for all (and only) script-path P2TR inputs for the confirmed transactions in the block range `779832` to `??`.

The file format is:

`bl <block number> cum_spam_fee <cumulative transaction fee for inscriptions containing PubKey 117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e> tx "<txid>" inp <input number> asm <tapscript>`.

The tapscripts can be checked for example at [scriptpath.info](https://scriptpath.info/tx/142614adfb5855703f76a7de1aa7598f1154fc905f66d5b238ef2ced88e7bdec).

Here are some awk commands to analyze this file:

    #number of "normal" (ord-wallet produced) Inscriptions per block
    awk '/bl.+asm OP_PUSHBYTES_32 [a-f0-9]{64} OP_CHECKSIG OP_0 OP_IF OP_PUSHBYTES_3 6f7264 OP_PUSHBYTES_1 01/{print $2}' filename.log  | sort | uniq -c
    #number of Inscriptions per block with PubKey 117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e and OP_DROP
    awk '/bl.+asm OP_PUSHBYTES_32 117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e OP_CHECKSIG OP_PUSHBYTES_6 [a-f0-9]{12} OP_DROP OP_0 OP_IF OP_PUSHBYTES_3 6f7264 OP_PUSHBYTES_1 01/{print $2}' filename.log | sort | uniq -c
    #number of non-standard Inscriptions per block OP_DROP and any PubKey (not produced by the standard ord wallet
    awk '/bl.+asm OP_PUSHBYTES_32 [a-f0-9]{64} OP_CHECKSIG OP_PUSHBYTES_6 [a-f0-9]{12} OP_DROP OP_0 OP_IF OP_PUSHBYTES_3 6f7264 OP_PUSHBYTES_1 01/{print $2}' filename.log | sort | uniq -c






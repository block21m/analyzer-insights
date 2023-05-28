This (GDrive download link)[] (??GB) contains a gzipped file `tapscript-779832-791373-fees.log.gz` with all tapscripts for all (and only) script-path P2TR inputs for the confirmed transactions in the block range `779832` to `791373`.

The file format is:

`bl <block number> cum_spam_fee <cumulative transaction fee for inscriptions containing PubKey 117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e> tx "<txid>" inp <input number> asm <tapscript>`.

The tapscripts can be checked for example at [scriptpath.info](https://scriptpath.info/tx/142614adfb5855703f76a7de1aa7598f1154fc905f66d5b238ef2ced88e7bdec).

The file `tapscript-779832-791373-fees.log` can be processed using `awk -f stats.awk tapscript-779832-791373-fees.log > blk_stats-779832-791373.log` with the [`stats.awk`](https://github.com/block21m/analyzer-insights/blob/main/inscriptions/gmgn/stats.awk) from this repository. 
The overall stats are in the end of `blk_stats-779832-791373.log`. The CSV part of `blk_stats-779832-791373.log` can be visualized in the [`blk_stats-779832-791373.xlsx `](https://github.com/block21m/analyzer-insights/blob/main/inscriptions/gmgn/blk_stats-779832-791373.xlsx).





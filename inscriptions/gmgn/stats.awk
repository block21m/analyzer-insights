#!/usr/bin/awk -f
BEGIN {
  printf "blk,total_since_first_brc20,gmgn,gmgn_pct,not_gmgn,not_gmgn_pct,ordi,ordi_pct\n";
}
/bl.+asm OP_PUSHBYTES_32 [a-f0-9]{64} OP_CHECKSIG (OP_PUSHBYTES_6 [a-f0-9]{12} OP_DROP )?OP_0 OP_IF OP_PUSHBYTES_3 6f7264 OP_PUSHBYTES_1 01/ {
    bl = $2;
    if (prev_bl && prev_bl != bl) {
        printf "%d,%d,%d,%.2f,%d,%.2f,%d,%.2f\n", prev_bl, total_bl, gmgn_bl, gmgn_bl / total_bl * 100, total_bl - gmgn_bl, 100 - gmgn_bl / total_bl * 100, ordi_bl, ordi_bl / total_bl * 100;
        for (i = prev_bl + 1; i < bl; i++) {
            printf "%d,0,0,0,0,0,0,0\n", i;
        }
        total_bl = 0;
        gmgn_bl = 0;
        ordi_bl = 0;
    }
    total_since_first_brc20++;
    total_bl++;
    if ($0 ~ /117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e/) {
        gmgn++;
        gmgn_bl++;
    }
    if ($0 ~ /e8fa1365a752f83c2af2295c86992fb88ba82aaf53ded9b9e2345e93acacda3a/) {
        ordi++;
        ordi_bl++;
    }
    if (gmgn > 0) {
        total_since_first_gmgn++
    }
    if (ordi > 0) {
        total_since_first_ordi++
    }
    prev_bl = bl;
}

END {
    printf "\n---Final Stats---\n"
    printf "inscr since BRC-20 %d, gmgn %d (%.2f%%), ordi %d (%.2f%%)\n", total_since_first_brc20, gmgn, gmgn / total_since_first_brc20 * 100, ordi, ordi / total_since_first_brc20 * 100;
    printf "inscr since first gmgn %d, gmgn %d (%.2f%%)\n", total_since_first_gmgn, gmgn, gmgn / total_since_first_gmgn * 100;
    printf "inscr since first ordi %d, ordi %d (%.2f%%)\n", total_since_first_ordi, ordi, ordi / total_since_first_ordi * 100;
}

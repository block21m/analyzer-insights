#!/usr/bin/awk -f
BEGIN {
  printf "blk,total_since_first_brc20,pk117_23e,pk117_23e_pct,not_pk117_23e,not_pk117_23e_pct,pke8f_a3a,pke8f_a3a_pct\n";
}
/bl.+asm OP_PUSHBYTES_32 [a-f0-9]{64} OP_CHECKSIG (OP_PUSHBYTES_6 [a-f0-9]{12} OP_DROP )?OP_0 OP_IF OP_PUSHBYTES_3 6f7264 OP_PUSHBYTES_1 01/ {
    bl = $2;
    if (prev_bl && prev_bl != bl) {
        printf "%d,%d,%d,%.2f,%d,%.2f,%d,%.2f\n", prev_bl, total_bl, pk117_23e_bl, pk117_23e_bl / total_bl * 100, total_bl - pk117_23e_bl, 100 - pk117_23e_bl / total_bl * 100, pke8f_a3a_bl, pke8f_a3a_bl / total_bl * 100;
        for (i = prev_bl + 1; i < bl; i++) {
            printf "%d,0,0,0,0,0,0,0\n", i;
        }
        total_bl = 0;
        pk117_23e_bl = 0;
        pke8f_a3a_bl = 0;
    }
    total_since_first_brc20++;
    total_bl++;
    if ($0 ~ /117f692257b2331233b5705ce9c682be8719ff1b2b64cbca290bd6faeb54423e/) {
        pk117_23e++;
        pk117_23e_bl++;
    }
    if ($0 ~ /e8fa1365a752f83c2af2295c86992fb88ba82aaf53ded9b9e2345e93acacda3a/) {
        pke8f_a3a++;
        pke8f_a3a_bl++;
    }
    if (pk117_23e > 0) {
        total_since_first_pk117_23e++
    }
    if (pke8f_a3a > 0) {
        total_since_first_pke8f_a3a++
    }
    prev_bl = bl;
}

END {
    printf "\n---Final Stats---\n"
    printf "inscr since BRC-20 %d, pk117_23e %d (%.2f%%), pke8f_a3a %d (%.2f%%)\n", total_since_first_brc20, pk117_23e, pk117_23e / total_since_first_brc20 * 100, pke8f_a3a, pke8f_a3a / total_since_first_brc20 * 100;
    printf "inscr since first pk117_23e %d, pk117_23e %d (%.2f%%)\n", total_since_first_pk117_23e, pk117_23e, pk117_23e / total_since_first_pk117_23e * 100;
    printf "inscr since first pke8f_a3a %d, pke8f_a3a %d (%.2f%%)\n", total_since_first_pke8f_a3a, pke8f_a3a, pke8f_a3a / total_since_first_pke8f_a3a * 100;
}

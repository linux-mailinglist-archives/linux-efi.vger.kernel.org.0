Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE930525C72
	for <lists+linux-efi@lfdr.de>; Fri, 13 May 2022 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377821AbiEMHmc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 May 2022 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiEMHmb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 May 2022 03:42:31 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77586AA44
        for <linux-efi@vger.kernel.org>; Fri, 13 May 2022 00:42:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k184-20020a6bbac1000000b0065aeedd4ba8so4367950iof.20
        for <linux-efi@vger.kernel.org>; Fri, 13 May 2022 00:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Gn+fz0Waz2RVUfgIrDWbZMgTEoVlXBuD6vpvtSt5yaI=;
        b=bRdE1v+JeW7XhJDci7A0Pn+63PdoEmxVRZ1bQbXN9TJr8lSgRNTfX/rb8FYGz2cnrS
         1BhPMneqAUcF3Nmbp8x7C/2D3okE10SlEtWYeHzbmxBTalUCUxDzKKe6VthJwvYYfXSA
         n298g8KrZnNTRg1sgOyxNXmdlcc/gVsy9ufquGHBtvoHmg9x9/tKMtzrzud2zpQtTYBB
         2gM5STUaPuoYY651Txp2U3iZJFpur5OO+t/oFqWnEOKb9S+io37/Dfq2rgZbci7W1qJO
         I4NQvc0hCIOGQDkSsWqtK0DqB2vWcEoRauMcavZP4lzRRX2sLXlXKr943gYtp3BnT43f
         g6TQ==
X-Gm-Message-State: AOAM532SLaF+X6KaoVYy7mJLsxmJdgbQmdrczUhJ9eCy9sSxsI5L/ym7
        G1E295/X/j1omlc3fN95+STrkXjE1ef8Z0+jXGsC1WgJDgqR
X-Google-Smtp-Source: ABdhPJy+mKCBnLubH9TOMT11RlSSppsrrsFyleuBrVBnM4gzsk9VxaZXEwdW4GRPYBSfejgnXTeGsY3APeHUJJkEwd3tekvvKOkk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a4:b0:32b:e72f:8f8f with SMTP id
 t36-20020a05663834a400b0032be72f8f8fmr1809781jal.202.1652427749290; Fri, 13
 May 2022 00:42:29 -0700 (PDT)
Date:   Fri, 13 May 2022 00:42:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003785905dedfd18b@google.com>
Subject: [syzbot] KASAN: use-after-free Read in anon_vma_interval_tree_remove
From:   syzbot <syzbot+dae32a647a56f4d153da@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        ardb@kernel.org, arnd@arndb.de, bp@alien8.de, ccross@google.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hpa@zytor.com, liam.howlett@oracle.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, ning.sun@intel.com,
        syzkaller-bugs@googlegroups.com, tboot-devel@lists.sourceforge.net,
        tglx@linutronix.de, vbabka@suse.cz, willy@infradead.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    187b9ac8c348 Add linux-next specific files for 20220512
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1299ce1af00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dcd4f4a77ca98a9
dashboard link: https://syzkaller.appspot.com/bug?extid=dae32a647a56f4d153da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1748d2c9f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130db7faf00000

The issue was bisected to:

commit ff59d518bcac98f97fb365666eb3649320a3af93
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Thu May 12 01:12:46 2022 +0000

    mm: remove rb tree.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10abf0aef00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12abf0aef00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14abf0aef00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dae32a647a56f4d153da@syzkaller.appspotmail.com
Fixes: ff59d518bcac ("mm: remove rb tree.")

==================================================================
==================================================================
BUG: KASAN: use-after-free in vma_last_pgoff mm/interval_tree.c:20 [inline]
BUG: KASAN: use-after-free in avc_last_pgoff mm/interval_tree.c:68 [inline]
BUG: KASAN: use-after-free in __anon_vma_interval_tree_augment_compute_max mm/interval_tree.c:71 [inline]
BUG: KASAN: use-after-free in __anon_vma_interval_tree_augment_propagate mm/interval_tree.c:71 [inline]
BUG: KASAN: use-after-free in __rb_erase_augmented include/linux/rbtree_augmented.h:295 [inline]
BUG: KASAN: use-after-free in rb_erase_augmented include/linux/rbtree_augmented.h:303 [inline]
BUG: KASAN: use-after-free in rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline]
BUG: KASAN: use-after-free in __anon_vma_interval_tree_remove mm/interval_tree.c:71 [inline]
BUG: KASAN: use-after-free in anon_vma_interval_tree_remove+0xc7d/0xf30 mm/interval_tree.c:88
Read of size 8 at addr ffff8880237dbb60 by task syz-executor150/3681

CPU: 1 PID: 3681 Comm: syz-executor150 Not tainted 5.18.0-rc6-next-20220512-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 vma_last_pgoff mm/interval_tree.c:20 [inline]
 avc_last_pgoff mm/interval_tree.c:68 [inline]
 __anon_vma_interval_tree_augment_compute_max mm/interval_tree.c:71 [inline]
 __anon_vma_interval_tree_augment_propagate mm/interval_tree.c:71 [inline]
 __rb_erase_augmented include/linux/rbtree_augmented.h:295 [inline]
 rb_erase_augmented include/linux/rbtree_augmented.h:303 [inline]
 rb_erase_augmented_cached include/linux/rbtree_augmented.h:314 [inline]
 __anon_vma_interval_tree_remove mm/interval_tree.c:71 [inline]
 anon_vma_interval_tree_remove+0xc7d/0xf30 mm/interval_tree.c:88
 unlink_anon_vmas+0x218/0x840 mm/rmap.c:406
 free_pgtables+0x24d/0x420 mm/memory.c:439
 exit_mmap+0x1ff/0x740 mm/mmap.c:3217
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa18/0x2a00 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9b5c196129
Code: Unable to access opcode bytes at RIP 0x7f9b5c1960ff.
RSP: 002b:00007fffb9cf1b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9b5c2023d0 RCX: 00007f9b5c196129
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 00007f9b5c003031
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f9b5c2023d0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3681:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3239
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 copy_vma+0x36f/0x890 mm/mmap.c:3332
 move_vma+0x449/0xf60 mm/mremap.c:624
 mremap_to mm/mremap.c:859 [inline]
 __do_sys_mremap+0xe68/0x1540 mm/mremap.c:970
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3681:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3524
 copy_vma+0x6ac/0x890 mm/mmap.c:3359
 move_vma+0x449/0xf60 mm/mremap.c:624
 mremap_to mm/mremap.c:859 [inline]
 __do_sys_mremap+0xe68/0x1540 mm/mremap.c:970
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff8880237dbaf8
 which belongs to the cache vm_area_struct of size 152
The buggy address is located 104 bytes inside of
 152-byte region [ffff8880237dbaf8, ffff8880237dbb90)

The buggy address belongs to the physical page:
page:ffffea00008df6c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x237db
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888140006b40
raw: 0000000000000000 0000000080120012 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3388, tgid 3388 (cmp), ts 30666718744, free_ts 30663321169
 prep_new_page mm/page_alloc.c:2431 [inline]
 get_page_from_freelist+0x129e/0x3dd0 mm/page_alloc.c:4176
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5396
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3239
 vm_area_dup+0x81/0x380 kernel/fork.c:466
 __split_vma+0x9f/0x530 mm/mmap.c:2283
 do_mas_align_munmap+0x553/0xed0 mm/mmap.c:2430
 do_mas_munmap+0x202/0x2c0 mm/mmap.c:2564
 mmap_region+0x219/0x1bf0 mm/mmap.c:2612
 do_mmap+0x825/0xf60 mm/mmap.c:1493
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:488
 ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1539
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1396
 free_unref_page_prepare mm/page_alloc.c:3318 [inline]
 free_unref_page_list+0x16f/0xf80 mm/page_alloc.c:3450
 release_pages+0xff1/0x2290 mm/swap.c:980
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:58
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu mm/mmu_gather.c:262 [inline]
 tlb_finish_mmu+0x147/0x7e0 mm/mmu_gather.c:353
 exit_mmap+0x211/0x740 mm/mmap.c:3218
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exec_mmap fs/exec.c:1038 [inline]
 begin_new_exec+0xfbd/0x2e50 fs/exec.c:1297
 load_elf_binary+0x15a3/0x4ec0 fs/binfmt_elf.c:1002
 search_binary_handler fs/exec.c:1728 [inline]
 exec_binprm fs/exec.c:1769 [inline]
 bprm_execve fs/exec.c:1838 [inline]
 bprm_execve+0x7ef/0x1970 fs/exec.c:1800
 do_execveat_common+0x727/0x890 fs/exec.c:1943
 do_execve fs/exec.c:2017 [inline]
 __do_sys_execve fs/exec.c:2093 [inline]
 __se_sys_execve fs/exec.c:2088 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2088
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff8880237dba00: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880237dba80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa
>ffff8880237dbb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880237dbb80: fb fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb
 ffff8880237dbc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

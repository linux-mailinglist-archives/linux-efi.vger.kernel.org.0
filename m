Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33C5A26A4
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbiHZLKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 07:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiHZLKb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 07:10:31 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD76E2C3
        for <linux-efi@vger.kernel.org>; Fri, 26 Aug 2022 04:10:30 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id o10-20020a6b5a0a000000b0068aba769d73so734223iob.4
        for <linux-efi@vger.kernel.org>; Fri, 26 Aug 2022 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ykKB6JtFGZwxwwDMGZo2OlEfzOvWnacKSlhlwZsEhWI=;
        b=cmZs0BnTF/xcFj9FKOasHjTzvnT+i+CTeXlZG6rZAW6y9OV3RWshVOMUkoqit5hV03
         lKtyRnjNYsmEUwsYgrLsrB6Jre/GcufWaS4jqg2qvPhHpam76VBEVK7pGCT7yU998ecM
         SV6GlbTmCH+9udaIYJnAU8S6myexpH7/IYceBUnI8Tqbc62P4Z4AWFFYwAGf7qlX9XGj
         SZbDUU3Q5JV4EN9AIW5/dChY1/YxAkKBc0AviLNbeJaqHmmWg33+sjhp1H7+W3CRmRvN
         SdnGskVQJRxzFNuK4myQOH/md3wC5hUuuBo9ODDSG0RDQe0DhBsq5OYB7ArdsXTJvMEP
         pmMA==
X-Gm-Message-State: ACgBeo0vVp9o1vckhx3up+RQQ+GdQDXO1z+CbFrrP+9ypJzCMrvRvyA1
        LbAsVkGzz2oGjeHrcUaJ83Pamv0xG4NkNfUWc6j4OZO65NIc
X-Google-Smtp-Source: AA6agR7RWmam6Y6fNRRsH/Zisn7THQXfY3C9pomIW+kormK2wpFFUV/pv1idIbJ20RVF12wJKUsHt3obfzuMPy5VSv7Kt3U4BYAg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:2ea:373a:cbe4 with SMTP id
 x13-20020a056e02194d00b002ea373acbe4mr3766138ilu.127.1661512229703; Fri, 26
 Aug 2022 04:10:29 -0700 (PDT)
Date:   Fri, 26 Aug 2022 04:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dd70305e722f605@google.com>
Subject: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff0000c74fd828, but was ffff80000d5c37a0. (prev=ffff80000d5c37a0)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3019 Comm: syz-executor150 Not tainted 5.19.0-rc8-syzkaller-01618-g680fb5b009e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0x94/0xa8 lib/list_debug.c:51
lr : __list_del_entry_valid+0x94/0xa8 lib/list_debug.c:51
sp : ffff80001317bc40
x29: ffff80001317bc40 x28: ffff0000c65f0000 x27: 0000000000000000
x26: 00000000000000c0 x25: ffff0000cae01828 x24: ffff0000c74fd000
x23: ffff80000d309368 x22: ffff8000093f7a24 x21: ffff80000d5c37a0
x20: 0000000000000000 x19: ffff0000c74fd000 x18: 0000000000000265
x17: ffff80000bfed6bc x16: ffff80000db3b658 x15: ffff0000c65f0000
x14: 0000000000000021 x13: 00000000ffffffff x12: ffff0000c65f0000
x11: ff808000081bf324 x10: 0000000000000000 x9 : bdc8aea51905dc00
x8 : bdc8aea51905dc00 x7 : ffff800008160c98 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000000 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0x94/0xa8 lib/list_debug.c:51
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 efivar_entry_remove+0x4c/0xa4 drivers/firmware/efi/vars.c:539
 efivarfs_destroy+0x20/0x5c fs/efivarfs/super.c:185
 __efivar_entry_iter+0x94/0x100 drivers/firmware/efi/vars.c:1089
 efivarfs_kill_sb+0x3c/0x4c fs/efivarfs/super.c:249
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1a4/0x1e0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1117
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x14c arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 9001b300 912e7000 aa0803e3 94a6ef81 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

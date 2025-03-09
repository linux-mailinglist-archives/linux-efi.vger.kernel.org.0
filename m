Return-Path: <linux-efi+bounces-2943-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE13EA5805E
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 03:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA2A3AE2E5
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCB35964;
	Sun,  9 Mar 2025 02:52:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12826ACC
	for <linux-efi@vger.kernel.org>; Sun,  9 Mar 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741488760; cv=none; b=NehiWwjWz8/nbtRNO9mXXbWRrCrH/I07GaqWZ/yKDYygXNOwED3AjwZiPLa/1l030QzWXwM9WS1KmRXPPlItiZ6KMh7ziodKR9X+2i8fYfF8EI9xoVHofnMhBpo4SdK28g8MXOPRdrxir0Veg2aOBCvWWhUeasM5auexUCbIOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741488760; c=relaxed/simple;
	bh=IAF6tIlCZ771DQ7D/fW4IofhwRm1wGqrFwMlnS/Mw5w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dDIf8X31IxW3xnS6o5nWMEUB6vBBESCoqOYwBCIMpEX/2tQ0kseG1GN/toagvbabb2jHE6RNiiCjqvjSUvsFkmSOGWp0YLjGPhWSiq16IR4nPudSVg+6TB6TOZOMjI8QEU5NfsVODOpeKNmDQwBTyzbJ1ArHLh98fbIGj4aDarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso31229845ab.3
        for <linux-efi@vger.kernel.org>; Sat, 08 Mar 2025 18:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741488758; x=1742093558;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoNwlPHGgWrJYVppCXZabpLb34WQ3gVLmP7cpmCDknI=;
        b=G+HccsgjNhcr5YABSTdJ2UnDAYHek5uWZpjIZOBTDyr340/M9ldS9WkRS55mgF4+eK
         cAAyTcc+aDzvOhxHe35nUnofkJeUManXvRfq32k3ETW/q65MVJ1G6pEKuB24B2BhVgpI
         ysiCKRCKMG+tQFiLODhl2qi6fDka3/WBS4BuXniVEI90GTWaqLpIcy45Tif3qrSpB9O7
         +rh6HhFZfLGbOIc7jFk9Z/zbeoVTE1yw3xyWQlVDA9NgG7/IoFesiIAuk52vmg+xfFSU
         qxQ2OhYSIHrmgakYkrLzFR+gxeKLva2tx5pb79R2SEfzw1sUxtdmcHKBKjsF0RZ00H7g
         xNeg==
X-Forwarded-Encrypted: i=1; AJvYcCXVWN/P+QpPf8+ylO2YyAQunkCpWsVR9/nepNc/GeGKSYyQ7bwYTfdpFVI+5XO1l17T4fuq+PU3Enk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3bWXZvkftVfZf+HU4pJ7/ty8hyeHJ88V3qtkLtj0VEkRZhdY
	4azcyzz4ypCF96PWVS4wOyYIvS6QEao5g9POgC0orVk0j8IR0u0mAvAh/ZHjsNrMkKEBc0OorSa
	Emes14E2CYTlUACsh+i/ZktszPbRzV8x5AaqOxUmaFUUTZPjCuY9u8hg=
X-Google-Smtp-Source: AGHT+IFr9O8/YhatesoKbYIzMB5FoK9myw8WHXXuTPRkLDN4JKxY6KI/JsGeB9U353W2PzTRCca6QV81t/45BQoYLxUpP90o/vRD
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3d4:4134:521a with SMTP id
 e9e14a558f8ab-3d441990392mr118888325ab.12.1741488758297; Sat, 08 Mar 2025
 18:52:38 -0800 (PST)
Date: Sat, 08 Mar 2025 18:52:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd0276.050a0220.14db68.006c.GAE@google.com>
Subject: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
From: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14ce9c64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=019072ad24ab1d948228
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111ed7a0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b97c64580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com

efivarfs: resyncing variable state
============================================
WARNING: possible recursive locking detected
6.14.0-rc4-syzkaller-ge056da87c780 #0 Not tainted
--------------------------------------------
syz-executor772/6443 is trying to acquire lock:
ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: efivarfs_actor+0x1b8/0x2b8 fs/efivarfs/super.c:422

but task is already holding lock:
ffff0000c6c7a558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4 fs/readdir.c:101

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sb->s_type->i_mutex_key#16);
  lock(&sb->s_type->i_mutex_key#16);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor772/6443:
 #0: ffff80008fc57208 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x68/0xc0 kernel/power/main.c:56
 #1: ffff80008fc75d70 ((pm_chain_head).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0 kernel/notifier.c:379
 #2: ffff0000c6c7a558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4 fs/readdir.c:101

stack backtrace:
CPU: 0 UID: 0 PID: 6443 Comm: syz-executor772 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_deadlock_bug+0x4e8/0x668 kernel/locking/lockdep.c:3039
 check_deadlock kernel/locking/lockdep.c:3091 [inline]
 validate_chain kernel/locking/lockdep.c:3893 [inline]
 __lock_acquire+0x6240/0x7904 kernel/locking/lockdep.c:5228
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5851
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:877 [inline]
 efivarfs_actor+0x1b8/0x2b8 fs/efivarfs/super.c:422
 dir_emit include/linux/fs.h:3849 [inline]
 dcache_readdir+0x2dc/0x4e8 fs/libfs.c:209
 iterate_dir+0x46c/0x5f4 fs/readdir.c:108
 efivarfs_pm_notify+0x2f4/0x350 fs/efivarfs/super.c:517
 notifier_call_chain+0x1c4/0x550 kernel/notifier.c:85
 blocking_notifier_call_chain+0x70/0xa0 kernel/notifier.c:380
 pm_notifier_call_chain+0x2c/0x3c kernel/power/main.c:109
 snapshot_release+0x128/0x1b8 kernel/power/user.c:125
 __fput+0x340/0x760 fs/file_table.c:464
 ____fput+0x20/0x30 fs/file_table.c:492
 task_work_run+0x230/0x2e0 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:745
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


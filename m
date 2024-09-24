Return-Path: <linux-efi+bounces-1795-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0659842D5
	for <lists+linux-efi@lfdr.de>; Tue, 24 Sep 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1961C22DDE
	for <lists+linux-efi@lfdr.de>; Tue, 24 Sep 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62421714B3;
	Tue, 24 Sep 2024 10:00:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFB161302
	for <linux-efi@vger.kernel.org>; Tue, 24 Sep 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172029; cv=none; b=PfwEVgkWFMIqI2/aAHpRA9rSJjXTN3V2yGl68fiXP810G6t8JSUYQQS/YDdRre6H++aVDc7s0duim13uyfXQ6pah+xF2v5ndaNbtekh4qbt7qvjAWQDw2xyY8O4/QNKejrLbgxOpNaT3F8oEjHrjizmPMxA+C/IcXYQXafg/X+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172029; c=relaxed/simple;
	bh=MW7uAMBxOxYvLczeiayMBeBe4tJ6ZSEA1YN1+9gK99E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s0jwRdqSZcD7nAhuHmiKz1OnFUUsD1svQn54B/nwNVkZN8qb0SPax4JXxGG1SrQcmIbAsy4ydlXvxbyEvrO3QTxsejmvWSSHUB7pBja+gTBWRaAoX+p543ZyI9vHA0ehZb3nmomYeyzcI3Aha6dLNQsEO6bohodNiqeobLjfqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce92f8779so510691039f.3
        for <linux-efi@vger.kernel.org>; Tue, 24 Sep 2024 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727172027; x=1727776827;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a01in42YpZacjQNq2gwoU1Xzi0dMyhrMcy5fwZ6YU+0=;
        b=dFFXkZdRMjnOIdG6gWUktdftPCWnzvopRrEYNyKXXvlv66nox5omV5emRTFRKxFem0
         Dav/bGovpVXWEILtuvE21Ze21Dw7uwXqI4jPPsfmcXe1ggbiZx/XiYmBbgPyhkVrbTZu
         K80MHL0+KgFuysGvpoLjbDkLq5xM/Z5Ycn05yTv0ctJNtojCw+ZirrTJ880SNPLrLAbU
         jDRqBvnILytb6c7VAdJJ5HgSaDch7PygEcUA3MfVFt1AEPwECfwz9Utws4CoU8QbXn0K
         VCGjl/iCosdpvtZltOROYD0Z+tu8vNjP0iOf3UEJC8ZSJs39X+zcJtyPvbN6rZZGQBki
         uY4w==
X-Forwarded-Encrypted: i=1; AJvYcCU/ksimgLT1jsysaZy7ursimYdazTeeK51PbymozTaPra0GDWtprNOAfqcONCnMPJDLRpVlDpp75QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsnVCrPZpPEOeu7jQlSUrIPhneOVj1/UnELKQEwZ/aioYAlUE
	BMCVgwqhBEb+XF6kwrlA/T355bzLXpCmdZ7TWjCu8nkc6Y6ICDPgS3gIe2t8f0gqKnCa6V7B3rD
	vRHyzqarwyXLIC9zT9Xpf7AUpBbuCTtp6wL5gr7xJAPUO96ISLv7GISs=
X-Google-Smtp-Source: AGHT+IFEyPIqDOU0BgXapvNJ0AprH4g0Xhtxo+g/M18pZBOlY2RfqAs7/63imA7TvnWzXPr2FXqpLW98eVcT5vclBsQfy1g3Zgnj
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a0:bc39:2d8c with SMTP id
 e9e14a558f8ab-3a0c8d2e653mr99327325ab.25.1727172027017; Tue, 24 Sep 2024
 03:00:27 -0700 (PDT)
Date: Tue, 24 Sep 2024 03:00:26 -0700
In-Reply-To: <0000000000005b6b0e0622220846@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f28dba.050a0220.3eed3.0028.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: corrupted stack end in
 kernel_init (2)
From: syzbot <syzbot+ec17b78de14721dd3bdc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	ardb@kernel.org, linux-block@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1298499f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=ec17b78de14721dd3bdc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11323107980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/33ba6e22aaa5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec17b78de14721dd3bdc@syzkaller.appspotmail.com

x8 : 8f1719b15e27f800 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000008 x3 : 0000000000000000
x2 : ffff0000d7975ac0 x1 : 0000000000000000 x0 : ffff800080872848
Kernel panic - not syncing: kernel stack overflow
CPU: 1 UID: 0 PID: 16523 Comm: syz.3.4916 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 panic+0x300/0x884 kernel/panic.c:354
 nmi_panic+0x11c/0x23c kernel/panic.c:205
 panic_bad_stack+0x200/0x28c arch/arm64/kernel/traps.c:917
 enter_from_kernel_mode+0x0/0x74 arch/arm64/kernel/entry-common.c:928
 __bad_stack+0x78/0x7c arch/arm64/kernel/entry.S:566
 el1h_64_sync+0x0/0x68 arch/arm64/kernel/entry.S:591
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x10,00000207,00200128,42017203
Memory Limit: none

================================
WARNING: inconsistent lock state
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
syz.3.4916/16523 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff800091c892b8 ((efivars_lock).lock){....}-{2:2}, at: down_trylock+0x28/0xd8 kernel/locking/semaphore.c:139
{INITIAL USE} state was registered at:
  lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
  down_interruptible+0x3c/0xfc kernel/locking/semaphore.c:83
  efivars_register+0x2c/0x10c drivers/firmware/efi/vars.c:68
  generic_ops_register drivers/firmware/efi/efi.c:229 [inline]
  efisubsys_init+0x414/0x5f8 drivers/firmware/efi/efi.c:433
  do_one_initcall+0x24c/0x9c0 init/main.c:1267
  do_initcall_level+0x154/0x214 init/main.c:1329
  do_initcalls+0x58/0xac init/main.c:1345
  do_basic_setup+0x8c/0xa0 init/main.c:1364
  kernel_init_freeable+0x324/0x478 init/main.c:1578
  kernel_init+0x24/0x2a0 init/main.c:1467
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 10106
hardirqs last  enabled at (10105): [<ffff80008b3388f8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (10105): [<ffff80008b3388f8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (10106): [<ffff80008b42e1b4>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (10106): [<ffff80008b42e1b4>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
softirqs last  enabled at (8930): [<ffff8000800307f8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (8928): [<ffff8000800307c4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((efivars_lock).lock);
  <Interrupt>
    lock((efivars_lock).lock);

 *** DEADLOCK ***

1 lock held by syz.3.4916/16523:
 #0: ffff0000ef1b60e0 (&type->s_umount_key#52/1){+.+.}-{3:3}, at: alloc_super+0x1b0/0x83c fs/super.c:344

stack backtrace:
CPU: 1 UID: 0 PID: 16523 Comm: syz.3.4916 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_usage_bug+0x698/0x9ac kernel/locking/lockdep.c:4000
 verify_lock_unused+0xc0/0x114 kernel/locking/lockdep.c:5691
 lock_acquire+0x3b0/0x728 kernel/locking/lockdep.c:5750
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 down_trylock+0x28/0xd8 kernel/locking/semaphore.c:139
 efivar_trylock+0x20/0xa0 drivers/firmware/efi/vars.c:160
 efi_pstore_write+0x21c/0x63c drivers/firmware/efi/efi-pstore.c:223
 pstore_dump+0x764/0xad0 fs/pstore/platform.c:354
 kmsg_dump+0x17c/0x274 kernel/printk/printk.c:4214
 panic+0x34c/0x884 kernel/panic.c:385
 nmi_panic+0x11c/0x23c kernel/panic.c:205
 panic_bad_stack+0x200/0x28c arch/arm64/kernel/traps.c:917
 enter_from_kernel_mode+0x0/0x74 arch/arm64/kernel/entry-common.c:928
 __bad_stack+0x78/0x7c arch/arm64/kernel/entry.S:566
 el1h_64_sync+0x0/0x68 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


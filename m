Return-Path: <linux-efi+bounces-4381-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C903DB074F1
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABB858105F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE41B4F1F;
	Wed, 16 Jul 2025 11:45:36 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B482AD0C;
	Wed, 16 Jul 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666336; cv=none; b=lpf/dZq7lumNxEw51AqYKxDjO+Yca2v65eIFVxXwK82D5FVWegN+s8JufwWzMYuQvIevVpW4TVYz/7kMZZle4jCGrJoi0sk1UQ6pkmmGEnkSt7GWpH16ZSalGDK45Xu6s/iGETRg0IDZZdrk4nc0CSxi4J4+M7K+hdNF88ep+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666336; c=relaxed/simple;
	bh=aVJTXeLXUzFe2M0Su/uG7LjgiS7IfDlKHcqWYH7dbSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2+zQ/xxtDNNs/W3/fdLYK/JrD07C5eiIc7g30bQCtWz2hs6nAqYBKKgkz4c/wMp4Qz4Wz0TxmpZtIJu1pqVYWsSALzD3I57F0NNEywHf6TtQv28XlucJjTPfVRkAPdTRUawgP/Qxri7QOFUVRB9dYFkLn+zGMVMTbLC+W2JChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1208613666b.0;
        Wed, 16 Jul 2025 04:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666332; x=1753271132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PkJosHLXzR/ZNrp/FdDYNqWbZ74MF07pYmKN25GJuU=;
        b=xQxYIB4JdkUWTaQ2A69gl3MfAvIJB0xpVL/bMtPTh3bwAhKG2Q0EkLXScjzGOS/Vmt
         dmMni1gZH/AzpIQId6iMBmyKDgOmN+FoPxuOY3VfxU0+IfYWozoztiSIuDq4G9mFgtTy
         8hIc0drFjHXP+5++APwK8jBJQPY6tEPQZAybbAagN1qXwo9g/3Bwo3JBXmSV27ZUTPCF
         ml+/+RM4JothiFfYrmeVhS3xqKlCmmDnoGEEGD8Rrosz+8aP9CwIA89rC5HW2G9kCgL/
         3ClSkVeSzBUZafgoTnJIEtwpTeVSvU3MKt+jsdNg/SBz3l5NUatvb9FSA/Nd39/2/ERl
         Y5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOUAe1MijFfh6uMrMjrWeAvdWrIQcvT7avXemR8lTk8verxnqAIxWe2OLQoOJIPCEB9F6djfm4saJDRfQM@vger.kernel.org, AJvYcCWYh3HBFm+WvqXWrugJM9VRJwikTnFXACPWMEHf25HxIvStSekbKMdX7wHk/S+XT+2C7CBbD8XjGsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNgmmXYa2zCgsFW9B/bcp0iGyHboUTIPpdhJknxZDOTA3LCum
	E6wXx+F1ozUUMTQtwNft8w1nZpbEE76XV6GJ36jY/Ud/LoqhikOxwgQD
X-Gm-Gg: ASbGncuvfGHrebL9Cyi5yG7mfko1Cj1VxIScgvESexs7ij2wvlnmjIvBb7n25wKoWmi
	LKJlriwjIHx7wHJveEn55Ivx13i8JbMvHeIz9Yd7hzzja2ugxo+z+1JYWBQebuiN1/ME1teRe4e
	nF0KAhD6Nn5fkl7NH1EDDtVxsOHLAiKIWufFF/M9eAmRsWVh8Felet29/JMolFI0nfe98Y9Y+W5
	XQFm54DNcjoAjfaGixAyhow2FnUe9jH12GBBGtfWnI8Db7PZQy+4bZljZ4YBLg304e4SCTDj9aC
	FlF2vlDwreSXn8mbPVgpdWfAZcj9cHm8W+wZDZc2yrV1A89jyjPA1+r2lxFGJpbd2fNgMvO6Rmn
	xdG+cUR0Z+NETvuRamMmyvzF6
X-Google-Smtp-Source: AGHT+IHg6jyOncfFaYdix74XGVWjs9rrefix6hx4VL/1FqdxocFwOW6S2Gm0fVT7KJQmjrXYSaZQFg==
X-Received: by 2002:a17:907:f1dd:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-ae9c9b96a77mr294693766b.54.1752666331935;
        Wed, 16 Jul 2025 04:45:31 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee44d4sm1186652266b.39.2025.07.16.04.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:45:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:45:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] efivarfs: Suppress false-positive kmemleak warning for
 sfi
Message-ID: <rvlw467lzx5yx3sl56u3xcc2hhhn3vj2fu7msg3e5o4giwtkcb@oomdafhhnqcv>
References: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
 <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>

Hello Ard,

On Wed, Jul 16, 2025 at 10:41:24AM +1000, Ard Biesheuvel wrote:
> On Tue, 15 Jul 2025 at 19:31, Breno Leitao <leitao@debian.org> wrote:
> >
> > When kmemleak is enabled, it incorrectly reports the sfi structure
> > allocated during efivarfs_init_fs_context() as leaked:
> >
> >     unreferenced object 0xffff888146250b80 (size 64):
> >     __kmalloc_cache_noprof
> >     efivarfs_init_fs_context
> >     ...
> >
> > On module unload, this object is freed in efivarfs_kill_sb(), confirming
> > no actual leak. Also, kfree(sfi) is called at efivarfs_kill_sb(). I am
> > not able to explain why kmemleak detected it as a leak. To silence this
> > false-positive, mark the sfi allocation as ignored by kmemleak right
> > after allocation.
> >
> > This ensures clearer leak diagnostics for this allocation path.
> >
> 
> Can you provide a reproducer? x86 defconfig with kmemleak enabled does
> not show this behavior.

I see this problem all the time when mounting efivars. This is the
config I am using: https://pastebin.com/i21Yv0jt

Looking further at this problem, I am running this patch to get more
information:

	diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
	index c900d98bf4945..b93ddd5b5cc0d 100644
	--- a/fs/efivarfs/super.c
	+++ b/fs/efivarfs/super.c
	@@ -497,10 +497,13 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
		sfi = kzalloc(sizeof(*sfi), GFP_KERNEL);
		if (!sfi)
			return -ENOMEM;
	+       printk("sfi: Allocated sfi  at %p\n", sfi);
	+       dump_stack();

		sfi->mount_opts.uid = GLOBAL_ROOT_UID;
		sfi->mount_opts.gid = GLOBAL_ROOT_GID;

	+       printk("sfi: previous address %p and new %p\n", fc->s_fs_info, sfi);
		fc->s_fs_info = sfi;
		fc->ops = &efivarfs_context_ops;

	@@ -514,6 +517,8 @@ static void efivarfs_kill_sb(struct super_block *sb)
		blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
		kill_litter_super(sb);

	+       printk("sfi: Freeing sfi at %p\n", sfi);
	+       dump_stack();
		kfree(sfi);
	}

The logs are interesting:

Machine has just booted and:

	# mount | grep efivar
	efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,noatime)

	# dmesg | grep sfi
	[  147.705760] sfi: Allocated sfi  at 00000000fab3df14
	[  148.012125] sfi: previous address 0000000000000000 and new 00000000fab3df14
	[  196.942547] sfi: Allocated sfi  at 00000000f7561519
	[  196.952762] sfi: previous address 0000000000000000 and new 00000000f7561519

	# cat /sys/kernel/debug/kmemleak
	unreferenced object 0xffff88810a1de380 (size 64):
	comm "mount", pid 818, jiffies 4294850435
	hex dump (first 32 bytes):
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	backtrace (crc 0):
	__kmalloc_cache_noprof+0x407/0x4f0
	efivarfs_init_fs_context+0x4e/0x1a0 [efivarfs]
	alloc_fs_context+0x4b6/0x860
	path_mount+0x80d/0x1c00
	__x64_sys_mount+0x202/0x270
	do_syscall_64+0x6e/0x390
	entry_SYSCALL_64_after_hwframe+0x4b/0x53

	# sudo umount /sys/firmware/efi/efivars
	# dmesg | grep -i sfi
	[  147.705760] sfi: Allocated sfi  at 00000000fab3df14
	[  148.012125] sfi: previous address 0000000000000000 and new 00000000fab3df14
	[  196.942547] sfi: Allocated sfi  at 00000000f7561519
	[  196.952762] sfi: previous address 0000000000000000 and new 00000000f7561519
	[  366.097658] sfi: Freeing sfi at 00000000fab3df14

	# sudo rmmod efivarfs
	# dmesg | grep -i sfi
	[  147.705760] sfi: Allocated sfi  at 00000000fab3df14
	[  148.012125] sfi: previous address 0000000000000000 and new 00000000fab3df14
	[  196.942547] sfi: Allocated sfi  at 00000000f7561519
	[  196.952762] sfi: previous address 0000000000000000 and new 00000000f7561519
	[  366.097658] sfi: Freeing sfi at 00000000fab3df14

	# cat /sys/kernel/debug/kmemleak
	unreferenced object 0xffff88810a1de380 (size 64):
	comm "mount", pid 818, jiffies 4294850435
	hex dump (first 32 bytes):
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	backtrace (crc 0):
	__kmalloc_cache_noprof+0x407/0x4f0
	0xffffffffa0411d9e
	alloc_fs_context+0x4b6/0x860
	path_mount+0x80d/0x1c00
	__x64_sys_mount+0x202/0x270
	do_syscall_64+0x6e/0x390
	entry_SYSCALL_64_after_hwframe+0x4b/0x53


So, are we somehow leaking memory?!

Here is the stacks, in case you want to see them:

	# dmesg | grep -i sfi -A 30
	[  147.705760] sfi: Allocated sfi  at 00000000fab3df14
	[  147.715844] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[  147.715847] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	[  147.715850] Call Trace:
	[  147.715854]  <TASK>
	[  147.715858]  dump_stack_lvl+0xa8/0xc0
	[  147.715872]  efivarfs_init_fs_context+0x6e/0x1a0 [efivarfs]
	[  147.715887]  alloc_fs_context+0x4b6/0x860
	[  147.715904]  path_mount+0x920/0x1c00
	[  147.715922]  ? finish_automount+0x5b0/0x5b0
	[  147.715930]  ? kmem_cache_free+0x318/0x560
	[  147.715938]  ? user_path_at+0x4f/0x60
	[  147.715962]  __x64_sys_mount+0x202/0x270
	[  147.715973]  ? path_mount+0x1c00/0x1c00
	[  147.715997]  do_syscall_64+0x6e/0x390
	[  147.716009]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
	[  147.716015] RIP: 0033:0x7f480bbe794e
	[  147.716022] Code: 48 8b 0d cd 94 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a 94 0e 00 f7 d8 64 89 01 48
	[  147.716027] RSP: 002b:00007ffd89a74a28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
	[  147.716034] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f480bbe794e
	[  147.716038] RDX: 00007f480c0903a7 RSI: 00007ffd89a74a30 RDI: 00007f480c0903a7
	[  147.716042] RBP: 0000000000000004 R08: 0000000000000000 R09: 00007ffd89a748b0
	[  147.716045] R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
	[  147.716048] R13: 00007f480c0903a7 R14: 000000000000000e R15: 00007ffd89a74a30
	[  147.716076]  </TASK>
	[  148.012125] sfi: previous address 0000000000000000 and new 00000000fab3df14
	--
	[  196.942547] sfi: Allocated sfi  at 00000000f7561519
	[  196.952507] CPU: 34 UID: 0 PID: 818 Comm: mount Tainted: G S          E       6.16.0-rc6upstream-00004-g9ed31e914181-dirty #77 PREEMPT(none)
	[  196.952520] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[  196.952523] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	[  196.952526] Call Trace:
	[  196.952530]  <TASK>
	[  196.952534]  dump_stack_lvl+0xa8/0xc0
	[  196.952547]  efivarfs_init_fs_context+0x6e/0x1a0 [efivarfs]
	[  196.952563]  alloc_fs_context+0x4b6/0x860
	[  196.952581]  path_mount+0x80d/0x1c00
	[  196.952598]  ? finish_automount+0x5b0/0x5b0
	[  196.952606]  ? kmem_cache_free+0x318/0x560
	[  196.952615]  ? user_path_at+0x4f/0x60
	[  196.952638]  __x64_sys_mount+0x202/0x270
	[  196.952650]  ? path_mount+0x1c00/0x1c00
	[  196.952659]  ? getname_flags.part.0+0xfd/0x490
	[  196.952678]  do_syscall_64+0x6e/0x390
	[  196.952690]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
	[  196.952696] RIP: 0033:0x7fdabdd0f94e
	[  196.952705] Code: 48 8b 0d cd 94 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9a 94 0e 00 f7 d8 64 89 01 48
	[  196.952710] RSP: 002b:00007fff7b4e25a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
	[  196.952717] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdabdd0f94e
	[  196.952721] RDX: 0000563cef4deef0 RSI: 0000563cef4deec0 RDI: 0000563cef4e0ef0
	[  196.952725] RBP: 0000563cef4dea00 R08: 0000000000000000 R09: 0000000000000000
	[  196.952728] R10: 000000000000042f R11: 0000000000000246 R12: 0000000000000000
	[  196.952731] R13: 0000563cef4deef0 R14: 0000563cef4e0ef0 R15: 0000563cef4dea00
	[  196.952759]  </TASK>
	[  196.952762] sfi: previous address 0000000000000000 and new 00000000f7561519
	--
	[  366.097658] sfi: Freeing sfi at 00000000fab3df14
	[  366.106994] CPU: 25 UID: 0 PID: 11734 Comm: umount Kdump: loaded Tainted: G S          E       6.16.0-rc6upstream-00004-g9ed31e914181-dirty #77 PREEMPT(none)
	[  366.107005] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
	[  366.107008] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
	[  366.107011] Call Trace:
	[  366.107014]  <TASK>
	[  366.107018]  dump_stack_lvl+0xa8/0xc0
	[  366.107031]  efivarfs_kill_sb+0x5d/0x70 [efivarfs]
	[  366.107046]  deactivate_locked_super+0xa2/0x160
	[  366.107058]  cleanup_mnt+0x282/0x3c0
	[  366.107066]  ? trace_irq_enable.constprop.0+0x146/0x1b0
	[  366.107076]  task_work_run+0x12a/0x210
	[  366.107087]  ? task_work_cancel+0x20/0x20
	[  366.107093]  ? __x64_sys_umount+0xfe/0x120
	[  366.107099]  ? rcu_is_watching+0xe/0xb0
	[  366.107110]  exit_to_user_mode_loop+0xff/0x110
	[  366.107117]  do_syscall_64+0x2f0/0x390
	[  366.107125]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
	[  366.107130] RIP: 0033:0x7fd66a10e87b
	[  366.107143] Code: a3 a5 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 69 a5 0e 00 f7 d8
	[  366.107147] RSP: 002b:00007ffec5df41b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
	[  366.107152] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd66a10e87b
	[  366.107155] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b1db334d40
	[  366.107157] RBP: 000055b1db334b10 R08: 0000000000000000 R09: 00007ffec5df2f40
	[  366.107159] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
	[  366.107161] R13: 000055b1db334d40 R14: 000055b1db334c20 R15: 000055b1db334b10
	[  366.107175]  </TASK>


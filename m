Return-Path: <linux-efi+bounces-3599-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E2AA9848
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF133A89CE
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAE25D21A;
	Mon,  5 May 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AXDwvafm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1551487C3;
	Mon,  5 May 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461063; cv=none; b=pT/OJG+YufCYR2oMq425wGQQAR4a9gR50ODx10Oyu/QgZJg74xYWuYm46UoHrLINcKq7qMpVeQQAgDnXRynDofU294CZtZk4ysCIcYMltxFX5ePdDz4K2YOsXvsPKaG9tgHOpzD48ezKF+dUrdGag8kEtWgnHHrhpjAVhnx+jFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461063; c=relaxed/simple;
	bh=wjHjAl6gK0zoew3zDb5vbq6k2Lubi+YiIwuifw1qFE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHTI20aOS0K7agbPWnpTwLTDLJa8TMRrEHOeyM6EV7vNNlmimuJ5+6y4Sa2fiDYjDMhR/kiJwCPudPRMyxbjed8B4xL/h0qVzRNcqEYk8ZLD0UhQXUqliFBgU27lTL4Rwn4fhJ23bH02KTypfgAeCXkMtGssMaBnB2kxs5qpW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AXDwvafm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2F22B40E0196;
	Mon,  5 May 2025 16:04:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uvjKqAb2xMf3; Mon,  5 May 2025 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746461048; bh=eOdR04Av+2p2q0BfKNb9pAObXvs8afM3+NDxhb3Wysg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXDwvafm5GhPNDRFMYfOCSTnnMUlXbQFulg9OyLgTHPKH+ObCQFNJ8Q2hLW7cAHSK
	 bXmUxbotjcN98Y9G2Mb/AbtGY/tpUtNZbMr8irF66lf5LNEUQVGp8tmVfYlQqCF6EV
	 CK676oGgxDIAW9Bq3v5iG9QJ+df9KdSn+1iLX4PY+faBVVqaDuPokPOhgaZxy2hajM
	 UO6hu69XosxEj1quI4cKa+XMnrTOpYB5rHLxTgOXVpK1toomkz942650gLG6R6meTh
	 y4xJafQyVwVaMLxmrxYRK+dMY4ei6VfvneCZ3C/3VoGhuIurhVfcCfC20gvq4gLUMI
	 eXhpPyXZfgDw1/7NnHvb4U5Rzy+qhGON4YGtqNl8ikTaEdT1b7ctbifEuVrrVFSa48
	 iDyznIZpiOITeQUJw2KqJXSEuEB78O5zrqHwFYZzy2mZJ9sYaN7UYkNu9LJ7ctJcsF
	 3JtNJqrfM0C5Kv9uepA+3dU+ZE44CjqCOIxHdtQxajF//1BOVFfS8ZNjR3pqLJmBwF
	 /lN98JDmcgxDB+0SBl1jKsV6G/vOMP5q7i9l/JG/aNf4vGbr9ETmont6EsVln4QZOi
	 jNpfu2ccpMesGJxVmdsx2oytTDBQMainm9V8/ZLcgWpO+EfsXBYSZpG4d05jw6CAJT
	 rJ+95viGb0/UNU0v958HWa9c=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12E2840E0222;
	Mon,  5 May 2025 16:03:52 +0000 (UTC)
Date: Mon, 5 May 2025 18:03:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Len Brown <len.brown@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Provide __pti_set_user_pgtbl() to
 startup code
Message-ID: <20250505160346.GJaBjhYp09sLZ5AyyJ@fat_crate.local>
References: <20250504095230.2932860-40-ardb+git@google.com>
 <174636840512.22196.14007684119604658714.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174636840512.22196.14007684119604658714.tip-bot2@tip-bot2>

On Sun, May 04, 2025 at 02:20:04PM -0000, tip-bot2 for Ard Biesheuvel wrote:
> The following commit has been merged into the x86/boot branch of tip:
> 
> Commit-ID:     5297886f0cc45db5f4a804caf359e6e7874ee864
> Gitweb:        https://git.kernel.org/tip/5297886f0cc45db5f4a804caf359e6e7874ee864
> Author:        Ard Biesheuvel <ardb@kernel.org>
> AuthorDate:    Sun, 04 May 2025 11:52:45 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sun, 04 May 2025 15:59:43 +02:00
> 
> x86/boot: Provide __pti_set_user_pgtbl() to startup code
> 
> The SME encryption startup code populates page tables using the ordinary
> set_pXX() helpers, and in a PTI build, these will call out to
> __pti_set_user_pgtbl() to manipulate the shadow copy of the page tables
> for user space.
> 
> This is unneeded for the startup code, which only manipulates the
> swapper page tables, and so this call could be avoided in this
> particular case. So instead of exposing the ordinary
> __pti_set_user_pgtblt() to the startup code after its gets confined into
> its own symbol space, provide an alternative which just returns pgd,
> which is always correct in the startup context.
> 
> Annotate it as __weak for now, this will be dropped in a subsequent
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: linux-efi@vger.kernel.org
> Link: https://lore.kernel.org/r/20250504095230.2932860-40-ardb+git@google.com
> ---
>  arch/x86/boot/startup/sme.c |  9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> index 5738b31..753cd20 100644
> --- a/arch/x86/boot/startup/sme.c
> +++ b/arch/x86/boot/startup/sme.c
> @@ -564,3 +564,12 @@ void __head sme_enable(struct boot_params *bp)
>  	cc_vendor	= CC_VENDOR_AMD;
>  	cc_set_mask(me_mask);
>  }
> +
> +#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
> +/* Local version for startup code, which never operates on user page tables */
> +__weak
> +pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
> +{
> +	return pgd;
> +}
> +#endif

[    1.227968] smp: Brought up 1 node, 32 CPUs
[    1.231576] smpboot: Total of 32 processors activated (191999.61 BogoMIPS)
[    1.247644] ------------[ cut here ]------------
[    1.248697] WARNING: CPU: 17 PID: 104 at kernel/jump_label.c:276 __static_key_slow_dec_cpuslocked+0x2a/0x80
[    1.251592] Modules linked in:
[    1.252370] CPU: 17 UID: 0 PID: 104 Comm: kworker/17:0 Not tainted 6.15.0-rc4+ #2 PREEMPT(voluntary) 
[    1.253173] node 0 deferred pages initialised in 12ms
[    1.254539] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[    1.257490] Workqueue: events unaccepted_cleanup_work
[    1.258698] RIP: 0010:__static_key_slow_dec_cpuslocked+0x2a/0x80
[    1.259574] Code: 0f 1f 44 00 00 53 48 89 fb e8 82 66 e5 ff 8b 03 85 c0 78 16 74 54 83 f8 01 74 11 8d 50 ff f0 0f b1 13 75 ec 5b e9 66 bf 8c 00 <0f> 0b 48 c7 c7 00 44 54 82 e8 a8 5f 8c 00 8b 03 83 f8 ff 74 33 85
[    1.266446] Memory: 7574396K/8381588K available (13737K kernel code, 2487K rwdata, 6056K rodata, 3916K init, 3592K bss, 791248K reserved, 0K cma-reserved)
[    1.263574] RSP: 0018:ffffc9000048fe40 EFLAGS: 00010286
[    1.267573] RAX: 00000000ffffffff RBX: ffffffff82f10d00 RCX: 0000000000000000
[    1.269388] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff82f10d00
[    1.275578] RBP: ffff88827b7d4d98 R08: 8080808080808080 R09: ffff888100b59100
[    1.277441] R10: ffff888100050cc0 R11: fefefefefefefeff R12: ffff88827326e300
[    1.279574] R13: ffff888100bc1940 R14: ffff8881000e2405 R15: ffff8881000e2400
[    1.281460] FS:  0000000000000000(0000) GS:ffff8882f0400000(0000) knlGS:0000000000000000
[    1.281460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.281460] CR2: 0000000000000000 CR3: 0008000002c22000 CR4: 00000000003506f0
[    1.287576] Call Trace:
[    1.288381]  <TASK>
[    1.289015]  static_key_slow_dec+0x1f/0x40
[    1.289980]  process_one_work+0x171/0x330
[    1.290988]  worker_thread+0x247/0x390
[    1.291576]  ? __pfx_worker_thread+0x10/0x10
[    1.292773]  kthread+0x107/0x240
[    1.293536]  ? __pfx_kthread+0x10/0x10
[    1.295573]  ret_from_fork+0x30/0x50
[    1.295575]  ? __pfx_kthread+0x10/0x10
[    1.296580]  ret_from_fork_asm+0x1a/0x30
[    1.297507]  </TASK>
[    1.298085] ---[ end trace 0000000000000000 ]---

mingo simply doesn't want to listen and stop queueing untested patches.

So lemme whack this one.

My SNP guest had CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y leading to the
above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-efi+bounces-3601-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C6AA99AC
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD83188B78A
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2A26B94F;
	Mon,  5 May 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CeeK4OFO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D826B2B3;
	Mon,  5 May 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463713; cv=none; b=SrkHOIEB3Ot7PoutE1Qj2VxId4aJzBpOiw93P9IyWDiQRKm4cjvp6Mw9R581MESjvsmJ+Zlg10oVgq8HYgFe31Pvms3OffL4gW6VQLGmknXnttnp1WT0FHiU+Mpkj8a99rhtimURzK5kfqJsAbdX+hH3phiczivpc8uMV54W9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463713; c=relaxed/simple;
	bh=C01nA5O+mLAiMonn6J6BABuNOVIjZa6tsn0yxFC2RGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg1BnKShQA7nGRxf7gWkjP0c6TizimHsO3Cg62cV/MDC8mrb6iH6gzzXh3uJZO5ZWc7rAXqRh5AHDDhmv6OGb+PZQQAfqMjVrgh8+jGHKhjtXBWBIeJnXdg3bIRlL2IlM4nd6TYKvcaWZ13TviWbUsi3oytPGie639JMoj9BJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CeeK4OFO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C31CA40E0173;
	Mon,  5 May 2025 16:48:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AzBYAK1vnQVS; Mon,  5 May 2025 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746463703; bh=EJEF51VWcEDI3LL6qft8RIIp1wktw3QhPsx0cJZ+hYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeeK4OFOWs3dtFI/N52HRV+9ukuAQTwFH4sZVPgR9o2L/5VgGiTK6nRvWpjO1P06o
	 Ir6Iz4AHCtnfP8bBe0MEKtUe0E7EAuKdda9oPkrwWpsZ+gglGElwRYWB+CbT0vH5iL
	 OOcus6GumonVt8gS8iDHHmcZ6BfazWjCUmcWHWeiA5RE1UqYzp4rgN6GLrjxrm9k/5
	 NUoKdKg5y9WbCXq54OuaYLACfMVVr5sjdcOaoa1Wfq1ga7uJ8GskTNndzxwEHNPh2e
	 910GbvdgBBnIOCxSJr93YI3L5o/fEPv4S1RK3LpVMQrYYloud9QDdP6O20Pg39xYGE
	 RJjqpjh4MQrWHd0cxQ1f7SGGm2nDExYWID5sG5raCtefI5ePWw5BQWXO1Lg+6LI/zD
	 /phR+ikyzXpxCgiizOm0lvP0hVE9FUi6+G+O4cAIA2/nZcDZ+n9dpjIHEc+IYEoGIX
	 Fb+vT+1qXDtXDP9DuT01o0Z5opGyUO1z7eQ42Ot8NbwdcCbpefIu0W0QS9erL2RGfg
	 rZ33RoNMnGGU3Z4vgM7skpOMBvb8oH10BXMiXlAKQA4NxfmfZiSTJbzeSvt1I6+A+n
	 ZRKUfDht0QyTaXh9gvdMHLUWQfSXE0kFH6oCM2sn11HNROeFTL4vGgbjvz+Phbe3/x
	 gYh0dxJCmibYGYzBr/HzyW/4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4ABC40E0239;
	Mon,  5 May 2025 16:48:06 +0000 (UTC)
Date: Mon, 5 May 2025 18:47:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
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
Message-ID: <20250505164759.GKaBjrv5SI4MX_NiX-@fat_crate.local>
References: <20250504095230.2932860-40-ardb+git@google.com>
 <174636840512.22196.14007684119604658714.tip-bot2@tip-bot2>
 <20250505160346.GJaBjhYp09sLZ5AyyJ@fat_crate.local>
 <CAMj1kXGY6GTmm1PCVwyaCieVDDLWF_wEfRGbGooCnVf+o-Pupw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGY6GTmm1PCVwyaCieVDDLWF_wEfRGbGooCnVf+o-Pupw@mail.gmail.com>

On Mon, May 05, 2025 at 06:19:49PM +0200, Ard Biesheuvel wrote:
> This patch by itself does nothing. The symbol is __weak for the time
> being, and given that this code does not have its __pi_ prefixes yet,
> this function will be superseded by the existing one. (If you remove
> the __weak you will get a linker error)
> 
> Are you sure this patch is causing the issue?

My by-foot bisection of x86/boot is below.

I don't know if this patch uncovers something or maybe changes placement...

Tom also pointed to

4067196a5227 ("mm/page_alloc: fix deadlock on cpu_hotplug_lock in __accept_page()")

as potentially related.

And now I went and tried to reproduce the warning and it fired ontop of:

419cbaf6a56a ("x86/boot: Add a bunch of PIC aliases")

which is the previous patch.

Ufff, this is one of those which don't reproduce reliably because it was fine
on that commit in the previous run. Nasty.

Lemme go dig more.

---

ed4d95d033e3 (HEAD, refs/remotes/tip/x86/boot) x86/sev: Disentangle #VC handling code from startup code

<--- NOT

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

5297886f0cc4 x86/boot: Provide __pti_set_user_pgtbl() to startup code

<--- OK

419cbaf6a56a x86/boot: Add a bunch of PIC aliases
f932adcc8650 x86/linkage: Add SYM_PIC_ALIAS() macro helper to emit symbol aliases

<--- OK

ae862964cbc5 x86/sev: Move instruction decoder into separate source file
fae89bbfdd9d x86/sev: Make sev_snp_enabled() a static function
b3464a36f7f2 x86/boot: Disregard __supported_pte_mask in __startup_64()
bd4a58beaaf1 x86/boot: Move early_setup_gdt() back into head64.c

<--- OK


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


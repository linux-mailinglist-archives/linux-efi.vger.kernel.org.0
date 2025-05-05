Return-Path: <linux-efi+bounces-3600-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA8AA98A7
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF0717CD4E
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B62676EB;
	Mon,  5 May 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnjc1Qb7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB181F2BAB;
	Mon,  5 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462003; cv=none; b=JNC79U+KpEMX6EmDyGdfwWv4XQPUK9X5hRYO768XaSJfEd2YcRtj6T9ouQegsJGxEPDYIWyPJFrtaso35mpKvyCD8xyVXbJPS4GUfL2TOaWSEe2t8L1Fj2hHH2qvFuvOSgBc3ytO7fn3dr7O7IPpHMWHDLY7RYYopK02pSbdvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462003; c=relaxed/simple;
	bh=Ql4yD29k+8oXcu+cIJZRrfwbR6JjoLPyA0cvnmWQ3QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLuRC8Xna/8ZLeugS9BEpX/Imz1uGD0Wl6luZFFElL2d33lA+yFzlzQDnj5zHstUrtcmc6TzF8w+jXN8cTyrtoUkRyinKJDoKzhpDH+ELAAE0LIGI57w30mQyAlSzwR4a9vNvCA2tXp+2AOq274V4S5TnrjkUfZu5RScWHZwxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnjc1Qb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C81C4AF0B;
	Mon,  5 May 2025 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746462002;
	bh=Ql4yD29k+8oXcu+cIJZRrfwbR6JjoLPyA0cvnmWQ3QE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bnjc1Qb7XIPGmCE5rtGoYx1qmyMGN/HIbaDxIeow12fQpdQScZYy703jTnzR3w6xA
	 AAcGfCxR2m3CWIXPNCTQXFE1fkv+z37sWKRTu429LR+x0/4YF5cRko8vXSTtI/ZNZ6
	 YI1lS0PeH/GesEN/aHDoPUc/8hyqL2grE6dk+Kr+JThHtoyWsXE/X+gpY0FF+COMSs
	 NLPNisDUuvkzk1CoOYhqDWEjFqybImbAB8L3noyJvuqdM9DiKBDgUiKVv6OTXSzfmu
	 qqIe9onn3Bhh16m30YpsDB3UHsBpxaC+V1RA2ulU7QTJv1+Qurihs9nsCSdSU2VIgy
	 8aACccnnXRCtQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b10956398so5402544e87.0;
        Mon, 05 May 2025 09:20:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjmfh+GN+j3ynfrX56Oqhc36zMdEYb8+G7PHuYHJNWtVAIeSsMAKsyzlzuF3BqmeBVSPUT7oDQg9Pn6jGznAYNrkU=@vger.kernel.org, AJvYcCXWffxZN5J0OHdV6CEl6fqux9UFmjI4yVtmaThj+09Z9+EsW5Afbt15Fz5ZtOcQ8LZOJthHuVdnU8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1uW8RHCxbLNjHMQ0KwqOz+l7/HtjZw4IM5g2q5e8y3QprHDy
	6upfDRdtQ53sk5EIhdxOVij7CBru2SB4+VseZyuBa2mvaSOC9FQc0lwB/kBXvg5OPbjRAz5LSaA
	msdvg9sbdKvAVb2gWJcwrFx4w6nk=
X-Google-Smtp-Source: AGHT+IG1PE+h0rYJrR1ass5g/WorMDdPRSIGKJqTv/YLy0WxYgzj/G6JJk8e4XkI5UsirR/+jqlEmroeoDXlbrmtg4I=
X-Received: by 2002:a05:6512:1154:b0:54d:69fd:3598 with SMTP id
 2adb3069b0e04-54fb466e115mr17931e87.18.1746462001120; Mon, 05 May 2025
 09:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504095230.2932860-40-ardb+git@google.com>
 <174636840512.22196.14007684119604658714.tip-bot2@tip-bot2> <20250505160346.GJaBjhYp09sLZ5AyyJ@fat_crate.local>
In-Reply-To: <20250505160346.GJaBjhYp09sLZ5AyyJ@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 5 May 2025 18:19:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGY6GTmm1PCVwyaCieVDDLWF_wEfRGbGooCnVf+o-Pupw@mail.gmail.com>
X-Gm-Features: ATxdqUEOCtDh3gYdIpeAuxrTyvND72fOX1YKtXJglSxflP9NiayJSv0rjKr4FBg
Message-ID: <CAMj1kXGY6GTmm1PCVwyaCieVDDLWF_wEfRGbGooCnVf+o-Pupw@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Provide __pti_set_user_pgtbl() to
 startup code
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Kees Cook <keescook@chromium.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 18:04, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, May 04, 2025 at 02:20:04PM -0000, tip-bot2 for Ard Biesheuvel wrote:
> > The following commit has been merged into the x86/boot branch of tip:
> >
> > Commit-ID:     5297886f0cc45db5f4a804caf359e6e7874ee864
> > Gitweb:        https://git.kernel.org/tip/5297886f0cc45db5f4a804caf359e6e7874ee864
> > Author:        Ard Biesheuvel <ardb@kernel.org>
> > AuthorDate:    Sun, 04 May 2025 11:52:45 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Sun, 04 May 2025 15:59:43 +02:00
> >
> > x86/boot: Provide __pti_set_user_pgtbl() to startup code
> >
> > The SME encryption startup code populates page tables using the ordinary
> > set_pXX() helpers, and in a PTI build, these will call out to
> > __pti_set_user_pgtbl() to manipulate the shadow copy of the page tables
> > for user space.
> >
> > This is unneeded for the startup code, which only manipulates the
> > swapper page tables, and so this call could be avoided in this
> > particular case. So instead of exposing the ordinary
> > __pti_set_user_pgtblt() to the startup code after its gets confined into
> > its own symbol space, provide an alternative which just returns pgd,
> > which is always correct in the startup context.
> >
> > Annotate it as __weak for now, this will be dropped in a subsequent
> > patch.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Kevin Loughlin <kevinloughlin@google.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: linux-efi@vger.kernel.org
> > Link: https://lore.kernel.org/r/20250504095230.2932860-40-ardb+git@google.com
> > ---
> >  arch/x86/boot/startup/sme.c |  9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> > index 5738b31..753cd20 100644
> > --- a/arch/x86/boot/startup/sme.c
> > +++ b/arch/x86/boot/startup/sme.c
> > @@ -564,3 +564,12 @@ void __head sme_enable(struct boot_params *bp)
> >       cc_vendor       = CC_VENDOR_AMD;
> >       cc_set_mask(me_mask);
> >  }
> > +
> > +#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
> > +/* Local version for startup code, which never operates on user page tables */
> > +__weak
> > +pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
> > +{
> > +     return pgd;
> > +}
> > +#endif
>
> [    1.227968] smp: Brought up 1 node, 32 CPUs
> [    1.231576] smpboot: Total of 32 processors activated (191999.61 BogoMIPS)
> [    1.247644] ------------[ cut here ]------------
> [    1.248697] WARNING: CPU: 17 PID: 104 at kernel/jump_label.c:276 __static_key_slow_dec_cpuslocked+0x2a/0x80
> [    1.251592] Modules linked in:
> [    1.252370] CPU: 17 UID: 0 PID: 104 Comm: kworker/17:0 Not tainted 6.15.0-rc4+ #2 PREEMPT(voluntary)
> [    1.253173] node 0 deferred pages initialised in 12ms
> [    1.254539] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [    1.257490] Workqueue: events unaccepted_cleanup_work
> [    1.258698] RIP: 0010:__static_key_slow_dec_cpuslocked+0x2a/0x80
> [    1.259574] Code: 0f 1f 44 00 00 53 48 89 fb e8 82 66 e5 ff 8b 03 85 c0 78 16 74 54 83 f8 01 74 11 8d 50 ff f0 0f b1 13 75 ec 5b e9 66 bf 8c 00 <0f> 0b 48 c7 c7 00 44 54 82 e8 a8 5f 8c 00 8b 03 83 f8 ff 74 33 85
> [    1.266446] Memory: 7574396K/8381588K available (13737K kernel code, 2487K rwdata, 6056K rodata, 3916K init, 3592K bss, 791248K reserved, 0K cma-reserved)
> [    1.263574] RSP: 0018:ffffc9000048fe40 EFLAGS: 00010286
> [    1.267573] RAX: 00000000ffffffff RBX: ffffffff82f10d00 RCX: 0000000000000000
> [    1.269388] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff82f10d00
> [    1.275578] RBP: ffff88827b7d4d98 R08: 8080808080808080 R09: ffff888100b59100
> [    1.277441] R10: ffff888100050cc0 R11: fefefefefefefeff R12: ffff88827326e300
> [    1.279574] R13: ffff888100bc1940 R14: ffff8881000e2405 R15: ffff8881000e2400
> [    1.281460] FS:  0000000000000000(0000) GS:ffff8882f0400000(0000) knlGS:0000000000000000
> [    1.281460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.281460] CR2: 0000000000000000 CR3: 0008000002c22000 CR4: 00000000003506f0
> [    1.287576] Call Trace:
> [    1.288381]  <TASK>
> [    1.289015]  static_key_slow_dec+0x1f/0x40
> [    1.289980]  process_one_work+0x171/0x330
> [    1.290988]  worker_thread+0x247/0x390
> [    1.291576]  ? __pfx_worker_thread+0x10/0x10
> [    1.292773]  kthread+0x107/0x240
> [    1.293536]  ? __pfx_kthread+0x10/0x10
> [    1.295573]  ret_from_fork+0x30/0x50
> [    1.295575]  ? __pfx_kthread+0x10/0x10
> [    1.296580]  ret_from_fork_asm+0x1a/0x30
> [    1.297507]  </TASK>
> [    1.298085] ---[ end trace 0000000000000000 ]---
>
> mingo simply doesn't want to listen and stop queueing untested patches.
>
> So lemme whack this one.
>
> My SNP guest had CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y leading to the
> above.
>

This patch by itself does nothing. The symbol is __weak for the time
being, and given that this code does not have its __pi_ prefixes yet,
this function will be superseded by the existing one. (If you remove
the __weak you will get a linker error)

Are you sure this patch is causing the issue?


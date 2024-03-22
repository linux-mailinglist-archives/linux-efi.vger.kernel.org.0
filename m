Return-Path: <linux-efi+bounces-848-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84770886C62
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16643B22040
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EA144C89;
	Fri, 22 Mar 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTFNuXN7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964E446D6;
	Fri, 22 Mar 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111939; cv=none; b=foHxbauHmWTYRuFsvvZovapcDmUYn150uehdc8QpZeggyZs3O2QnjfPmtEJKriPxawz8M2dFjx1YagqzsT8ejgjacytrUsnebfee09AzldxsopEG77ULC2Sk2ZkzXU5td20Vyf8zoldbbPT09YgdHXxEp/5Ot1l1yR7HoY1hv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111939; c=relaxed/simple;
	bh=mKpFVELhqQO/MJQzF7MS3ARP49TrE+jyDb5kEDSxe4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlNvxECo9O2J4NGpSB89Cc6IO9Zbq9fLa2/uVZw6ALOdAZRN11CNi+qE0wdlon99BsRCOn7QEeD2/Sgy/K1aBb6LhMZ2PnaxmbwYdFEouNxlMaQZ/p7nG1zahhysV3eHImkN5yz7nSz/FA5TZHPFuKFGDA+0jWkZGpBiqcWjBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTFNuXN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D9C43330;
	Fri, 22 Mar 2024 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711111938;
	bh=mKpFVELhqQO/MJQzF7MS3ARP49TrE+jyDb5kEDSxe4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rTFNuXN7JV4H1M8lLXRl6mOJlWMr4A6pU8HEO6y7MijPx4W9rSw9Pyvr5Bwq3IIk0
	 LNaObKIDTjch5G9YXExNvq07vTwioeOu/P6r/BVYcpOVGcVE3LtmIwm8gkKIC9GEH7
	 nSTDeHx5fGMFmjMU7Ckckq6suE2n6mscUs65BXjt+wapmqXn1HmHkyiEdIPqs+VYAv
	 2l3afxG3UidmbmwbsX6Rr2NGI0bZhSNOEJocVQAt+IRBliuVwXHZ6uSzSedUQPGjIj
	 nX6vYYO8H8uF1LzTAoOBAiKgEnESFNZs+WhCvGd8dBDEXOg4JnxiK1QiL6OwAyTx+o
	 M9wOrlCgMnvMA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513c8b72b24so2360902e87.3;
        Fri, 22 Mar 2024 05:52:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+TnPsCLhITkXCghIEtP2s1vst4qGSF6KaeTRrAuJTj2AgVVQB2oIxzxTHuzsGfpV51WRMTSfpHWiLiYDH82QkTbH2oe4BlfuxPonIRGgztcvB6MU/N8yRBf+ImfpNRk1wpSVi31Ln
X-Gm-Message-State: AOJu0Yw1N2azeuQPiBnjyphJxMkzG3zEGGpT8Vcrdkc72eyxFb3OAL8c
	uoyLwA+p3ANp/wILUqtV5Z0k5uvFJYAG3ClQXR3Z/XA8v6zZ8BMeIIrZFuMJYWLCIOHlBqp41DM
	EVT2FTIAZdNSDuR5Bts4+olv+MoY=
X-Google-Smtp-Source: AGHT+IHklJRW3LUltX6SoxEccs31USx3zcS1zXoGK6HTBbqRH+NoHQwA+Fh/DI4NCb7BYfEXe3bp6gH48jeuRVFqdw8=
X-Received: by 2002:a19:9157:0:b0:513:d1b6:6f0e with SMTP id
 y23-20020a199157000000b00513d1b66f0emr1553664lfj.36.1711111937220; Fri, 22
 Mar 2024 05:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net>
In-Reply-To: <20240321170641.GK8211@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 13:52:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
Message-ID: <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 01:06, Clayton Craft <clayton@craftyguy.net> wrote:
>
> On Thu, 21 Mar 2024 23:48:09 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > v6.8 fails for me, and presumably so does everything back to v6.2. v6.1 is able
> > > to boot OK on these platforms with mixed mode, and it looks like there are a lot
> > > of changes from 6.1..6.2 for EFI/mixed mode booting.
> >
> > v6.1 just received some EFI related backports, so please check the
> > latest v6.1.y as well.
>
> I just gave v6.1.82 a try, and it fails to boot for me. That seems to be a
> regression from the 6.1.0 that I tested previously.
>
> > I usually test on 32-bit OVMF built with LOAD_X64_ON_IA32_ENABLE,
> > which allows the use of the compat entry point. This is different from
> > the EFI handover protocol, and I am not sure which one you are using.
>
> I should have mentioned this previously, here's the EFI-related kconfig that I
> am using. If there's anything missing then please let me know:
>
>         CONFIG_EFI=y
>         CONFIG_EFI_EARLYCON=y
>         CONFIG_EFI_ESRT=y
>         # CONFIG_EFI_HANDOVER_PROTOCOL is not set
>         CONFIG_EFI_MIXED=y
>         CONFIG_EFI_RUNTIME_WRAPPERS=y
>         CONFIG_EFI_STUB=y
>         CONFIG_EFI_VARS_PSTORE=m
>         CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
>
> Note that the EFI handover protocol support is disabled, I was under the
> impression that it's not required for mixed mode.
>

That depends on the bootloader. One of the changes around that time is
the introduction of this Kconfig symbol: before that, the EFI handover
protocol was always supported but now it can be compiled out. So the
safe choice is to enable it.

However, while looking more deeply into this, I noticed that we are
running quite low own stack space. Mixed mode is different because it
calls into the boot services using the decompressor's boot stack,
rather than using the one that was provided by firmware at entry.
(Note that the UEFI spec mandates 128k of stack space)

In my case, I bisected the regression to

commit 5c4feadb0011983bbc4587bc61056c7b379d9969 (HEAD)
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Mon Aug 7 18:27:16 2023 +0200

    x86/decompressor: Move global symbol references to C code

which moves the boot stack into a different memory region. Formerly,
we'd end up at the far end of the heap when overrunning the stack but
now, we end up crashing. Of course, overwriting the heap can cause
problems of its own, so we'll need to bump this in any case.

Could you give this a try please?


--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -38,7 +38,7 @@
 #endif

 #ifdef CONFIG_X86_64
-# define BOOT_STACK_SIZE       0x4000
+# define BOOT_STACK_SIZE       0x10000

 /*
  * Used by decompressor's startup_32() to allocate page tables for identity


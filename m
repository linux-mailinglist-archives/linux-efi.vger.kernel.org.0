Return-Path: <linux-efi+bounces-2576-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C648A09897
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037B4188F1AB
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA1212B17;
	Fri, 10 Jan 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8xJR0kI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124D2F3E;
	Fri, 10 Jan 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530421; cv=none; b=tYYiVX54aKQJjdFaJpo9YxUySdWFhxvG6HH3hfKZqtCMciMwr4LTd10ZWphqpmazZeKEFgDS1JVHRM/LlSHoRm4tYDV4GG0eh+OzYoLVdJeKXogQ1TP+Il+9mx4AZ6rvqW50LRKJ+8vCGTyHYk1fxqzwAlEV7asFOAfRv07qu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530421; c=relaxed/simple;
	bh=2LgNlM5UDL6ChRle2mp0Np/L6evW51T2Zb82b3nCV2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kgg38nkONkQxgZK0L7vQ7urG7I5JNP5sWVaOg8n1/b/kwkVUByatHkU4IeYhsy0t1eW5LLocsNIQ+4tjqZfWzBEImXIrVu8AcX7it4VnmOrn3Gmi5sFBGSqajmyfZj9uOZFXHlnSAU/btGl1CRp/U3QgCBAdQ9oVKknCmsSx0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8xJR0kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80103C4CED6;
	Fri, 10 Jan 2025 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530420;
	bh=2LgNlM5UDL6ChRle2mp0Np/L6evW51T2Zb82b3nCV2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j8xJR0kIkN4IsONbSKw4WLRCqit1GiDdwWWEqOgpHFI7p0Dx2/Gs7+CQMNpDpiCKW
	 XL4grZ2YsobUcMRGAYh4Yo0fwW3Vsjuqs14GlMtc8B7ITUcP2trVwBDqz6JfFY/WUp
	 7gZtdcuEj0nff2KmH4741MJj+fslpo2joPvL7AwgB6aR9I4vBgpwzYK0ZsgiwLun2H
	 Mkj2bDezF9nLGPevq/hZeqfcC0CRe2vfSeoWiJTvrolC39IZVNMXrSnICGaKyzknWH
	 27Tc058QMe3oKoK70u9ZEG2nE9nrZGE7IbZZcjq/YvyMBUQnorl2ntq7AYBW3xmggV
	 hi5Qk1ubs4MYQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso26294811fa.1;
        Fri, 10 Jan 2025 09:33:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt/GJsIJHuo7QaMBwFNOTMhU6h9nmN0wvnhNH1hcS+prk5KbSHvl1GGbBVJIa2pTIKtIAaxrlwHHM=@vger.kernel.org, AJvYcCWvSpNz5nTsgMLzNzeKJcaV4pHILOPjo/uXFYNEDe/Z3NBf0Greik4VJ7Mdya1R3CPz64etPvLFTvvZxjuE@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyif7i6TtGvSUmfGPYDoJxkm61Fg5ETJRxoc14DRJhbsdP0zS
	YMy6m9qkysSH9Rwv6KixVkGwbuI74hkg7UujnTYzM5xJ75+HPPhKMEdGlAYYP3XplsMacPqVj59
	AnTRVN7AzyzOGLIfvkHqj04eRneg=
X-Google-Smtp-Source: AGHT+IEuxGh8/T/s4PRuzCDPZjJ30Nh6MVT+V5a4g3NgK4duCm/rvIxWbI/taLS4BGyAZZsJuYhCJRUHs5tmVT5suFI=
X-Received: by 2002:a05:6512:3f12:b0:542:6366:762a with SMTP id
 2adb3069b0e04-54284545e1bmr3182431e87.25.1736530418923; Fri, 10 Jan 2025
 09:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com> <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
 <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
In-Reply-To: <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 18:33:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFjJZKGS1VDcUw3Uw9xB0R5+Q3q-21hojw4NMbr__XmgA@mail.gmail.com>
X-Gm-Features: AbW1kvZLYSGGczVN_3S8j4nI__QcdSl-X1qZVWuLdX8pTn1lTfcnMroSAbHPcAM
Message-ID: <CAMj1kXFjJZKGS1VDcUw3Uw9xB0R5+Q3q-21hojw4NMbr__XmgA@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 12:36, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Fri, Jan 10, 2025 at 08:32:08AM +0100, Ard Biesheuvel wrote:
> > On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>
> > > I think in the end whoevers' responsibility it is, the easiest path forward
> > > seems to be in kernel? (and not firmware or libstub)
> > >
> >
> > Agreed. But as I pointed out in the other thread, the memory
> > attributes table only augments the memory map with permission
> > information, and can be disregarded, and given how badly we mangle the
> > memory map on x86, maybe this is the right choice here.
>
> If this augmented memory is not preserved accross kexec, then the next
> kexec'ed kernel will be able to find the original table?
>
> I understand that the memattr region(s) need to be always (in each kexec
> instances) `memblocked_reserved` to protect it from being used as a
> System RAM, right?
>
> Thus, if it is not passed throught e820, kexec'ed kernel needs to fetch
> it again from original EFI table at kexec/boot time.
>

Not sure what 'fetching' means here.

> This brings me another question.
>
> If the kexec'ed kernel sees the original memory, why can't it
> augment/update the RX permissions *again*, instead of passing the
> previous augmented version from previous kernel in this crazy dance.
>

I don't understand what original memory means. I think we're talking
past each other tbh.

> > This is a kexec problem (on x86 only) so let's fix it there.
>
> Would you mind explaining what kexec needs to be done differently?
> Should it preserve the augmented memattr table independently if it is
> mapped in e820?
>

I don't know what 'mapped in e820' means.

Let's forget about what the memory attributes table actually contains,
and just assume we can live without it, ok?

So when booting x86 via kexec (which is already detected in
arch/x86/platform/efi/efi.c), the kernel should pretend that the table
does not exist.


Return-Path: <linux-efi+bounces-856-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C692B887141
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8141F22E73
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252C5FB91;
	Fri, 22 Mar 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxlmZODE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C525FB86;
	Fri, 22 Mar 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126319; cv=none; b=D7kIaEeCpyePlpejLxo3xXIXXgVTqwJnNYi8rOfL1V+L1GZCvrL+/PDAwOVOnKniOTahppl+V/w14DjEZLg4KoQ/KabIwuPTlwAAZ4FVHY3yPwhRnQCuYECW46zlEtlpcDDUHEBTroH/cz9ML36H0pB4ozPhl4ogDw3sjUsmLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126319; c=relaxed/simple;
	bh=lE+j9KmSnjltzBjQCfhK7TmKOK+5AHSKNREDslpxLpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZV4nkhVeVMThkGm0HCdJ/mHb7gBN9N+iOkZIWWVjltE1I9MAFaE+zw8gAXxrL3EOLFIP/kJP8LtxaHXIHvcjDwR1+Id/wo81GTccV4Ql7GT2NHu3iozbCnS/FXsvWIVC3fjsHMj9q49y+2g359S/tYVYBkKKb/nhck0IVjh9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxlmZODE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B04AC433B1;
	Fri, 22 Mar 2024 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711126319;
	bh=lE+j9KmSnjltzBjQCfhK7TmKOK+5AHSKNREDslpxLpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NxlmZODEEA0ISb7ievayKFW0t96UaeZconP+faJmHR9A0TeQjfHBdohc5UI5rtjW8
	 87eAbnW8X+9elu9p+o/j/Og0NeeqdBEJuc8ijaWzoXAvKGqy9MlMpUeHTg8dMVQH+p
	 wod7/zlDWxJEBNLVgYjMoMGbHHyKY1DBX3H+HveCzZ7q8JOiIf8bW+7EvOSMwfLdg+
	 lPz+LesocOyBQPZhrlV2tXvwc4jeUHlZkhC7QB6S3ujQQVz/jhzoVcEkFFVCLPR+nC
	 wagd+8ZW6e1RNcvf4WFOe0C1uzf7cQPUUDSn8BOxwkgf6asx7/XL22YDjfVczey5Zf
	 BOaXs+/pdcZGg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51588f70d2dso2725202e87.3;
        Fri, 22 Mar 2024 09:51:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUv9d60lO/+jsoYDCXMutjYw7vKmbNcZlkG6Mg+gAtA89CbYYjohXbK659WnbG0m11uWfHRx7qAT+PL+2UPjdcErfNn2m5DR13//Ev6k/KTIrAIVG2ghaEFXuEe1K1Lz8FjlKy2B/x
X-Gm-Message-State: AOJu0Yx4xoTmEHndvEfRJaPEg8aLaIGMTZ9+oSYIHgSPx0Svc1Edz434
	9ATxAnUIqYcbEIdrRNhVl9jWqBoyQM6Z4lZflMW48TzGs4O1hVackySYrv4H5F6ZPuoiPSX3CA6
	jnx31KtmXdwv7YuG37kzLFhrbwzY=
X-Google-Smtp-Source: AGHT+IEZsoLGEBUw8HqAozJH8a40krnMcztaIt8FfqJgaMyd5W2p+IJDw4vv0XGWJS29LGQ4L0XJs/l7n89iFIg5d+8=
X-Received: by 2002:ac2:5bc5:0:b0:513:c28e:8215 with SMTP id
 u5-20020ac25bc5000000b00513c28e8215mr1985077lfn.64.1711126317477; Fri, 22 Mar
 2024 09:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net> <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net>
In-Reply-To: <20240322091857.GM8211@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 18:51:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
Message-ID: <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 18:19, Clayton Craft <clayton@craftyguy.net> wrote:
>
> On Fri, 22 Mar 2024 13:52:05 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > That depends on the bootloader. One of the changes around that time is
> > the introduction of this Kconfig symbol: before that, the EFI handover
> > protocol was always supported but now it can be compiled out. So the
> > safe choice is to enable it.
>
> I am using systemd-boot, and based on my understanding of its source it seems to
> only use handover on old kernels that don't support LINUX_INITRD_MEDIA_GUID.

That does ring a bell. So that means you must be using the .compat
entry point, which is what 32-bit OVMF uses too.

> >
> > However, while looking more deeply into this, I noticed that we are
> > running quite low own stack space. Mixed mode is different because it
> > calls into the boot services using the decompressor's boot stack,
> > rather than using the one that was provided by firmware at entry.
> > (Note that the UEFI spec mandates 128k of stack space)
> >
> > In my case, I bisected the regression to
> >
> > commit 5c4feadb0011983bbc4587bc61056c7b379d9969 (HEAD)
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Mon Aug 7 18:27:16 2023 +0200
> >
> >     x86/decompressor: Move global symbol references to C code
> >
> > which moves the boot stack into a different memory region. Formerly,
> > we'd end up at the far end of the heap when overrunning the stack but
> > now, we end up crashing. Of course, overwriting the heap can cause
> > problems of its own, so we'll need to bump this in any case.
> >
> > Could you give this a try please?
> >
> >
> > --- a/arch/x86/include/asm/boot.h
> > +++ b/arch/x86/include/asm/boot.h
> > @@ -38,7 +38,7 @@
> >  #endif
> >
> >  #ifdef CONFIG_X86_64
> > -# define BOOT_STACK_SIZE       0x4000
> > +# define BOOT_STACK_SIZE       0x10000
> >
> >  /*
> >   * Used by decompressor's startup_32() to allocate page tables for identity
>
> Just gave this a try, on 6.1.82, and the system still reboots after selecting
> the kernel in the bootloader. So it seems like my problem is different.
>

Yeah, it was a long shot.

> As I mentioned initially, I bisected my failure to e2ab9eab32. Does that give
> any hint about what might be the problem?
>

Not at all, unfortunately. What we might try is to back out the
changes step by step. I can prepare a branch for you if you like.


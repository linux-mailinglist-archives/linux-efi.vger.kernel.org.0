Return-Path: <linux-efi+bounces-3482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35500AA081F
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B0C188F752
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239912BEC2B;
	Tue, 29 Apr 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of8JiTE1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF02BEC27;
	Tue, 29 Apr 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921335; cv=none; b=DixPh9gMWx5WMo08HLI2VTTdOfSbNhfih83ipzClAwpcGVrrq/KCw/UhRXCNkizoYvdyo9KOo5F+rd8ptPTruSlOotvjUcHTdZXYJaUpxyW6o+mWLrAE/ruIyA21rySl7FBk02Pfoq75mw1Xh1H7NwOlyfMOFzKWsPjfOaK0nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921335; c=relaxed/simple;
	bh=8eQHhZvKJeBbQJb/Z+PDZwKqqPQyu1KFMmO63/+jE7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKFZuALtrJp4LJ93sdTD9EiYkKBmr3z2yke8R8Ehspp7e1bHHIn1GujUow+Zyttm1ZMWR+/SRM6CoGV7zrVnvDXd71Jq2XX8CAdv74o0F0rx27+7F3rq9QIXLboBeDSeeZ0C0QnD7zPTZhFGdWQSeHqckPNskkwJiSZyYoBtSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of8JiTE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDB7C4AF09;
	Tue, 29 Apr 2025 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921334;
	bh=8eQHhZvKJeBbQJb/Z+PDZwKqqPQyu1KFMmO63/+jE7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=of8JiTE1AjntJD1Zf3F7H/Utb/lNpVyhJzneIrl/XzCAzR/BewTjGxaszvjBJN8Vd
	 9P376c8jZSuVW0IazNF62E5qx/H4unik8ws5wmirjEevdmmZ4HIGN31ZNYIfh+0JGm
	 nWcfaQw6msRpvtvEVp3yk1BUS3OEh7D3URm8cQXSpCFOuBHPn2+wxK3V2LXQkaGHf4
	 95CPWlbnKcZBYLHs3cuJHa1LphWfHLnsjgkTMb93KHzYXa7RWZ4S7a+BU8s6hgS7wX
	 hN5MAcBETLE7ugGOzwyfPFpaFI80D3Vft4Rh0i7j5zt+JYYKzdBEVqEZOZFpO4TgBP
	 R+bCcbl+sTRKg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso7057927e87.3;
        Tue, 29 Apr 2025 03:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgRaOCE2EElcFE1MAz/M+4Crt/PEAnZBkfYdjjxdgd0U/OmXcvM0I2K1uAmT6OK7DZ5PV1qAcaC1A=@vger.kernel.org, AJvYcCWrqOXx2Op0cPxZv5gPIqK8qaNBTJWdZF7pSzWMuMsQdcpJHg2hmoMxrYYpVB4vo1inbKclGzN6wzqCw9/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H/3/tXpT1FVpWNi57epBA922sw4gPjHGthF4iEvCrgF/teo2
	5HJWbwhL0vA49MPNuRmqa5fqZbCeT59U2dA+gxiKnGBkXhDPvdY+tn4ehlxWXgjlswe69NKRk5/
	dv569sJ/aat3V2S/jB6ZiGDkOIww=
X-Google-Smtp-Source: AGHT+IFHOjwc+z3+q19o9cvStKVDDWxFOIkGItGTtAfcqINGWAbgiIfiJ5ivvwYeafOBzOcAJAI6k78w03WoGwkqazs=
X-Received: by 2002:a05:6512:15a5:b0:54a:f6e9:2c04 with SMTP id
 2adb3069b0e04-54e9e543a79mr502083e87.26.1745921333244; Tue, 29 Apr 2025
 03:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com> <87ikmn9tri.fsf@redhat.com>
In-Reply-To: <87ikmn9tri.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 29 Apr 2025 12:08:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHTtGP-UcJLut7OVUuULzg59npyoQhb+kuCZO5x-2NYWA@mail.gmail.com>
X-Gm-Features: ATxdqUFuqvkbKjuCCg2UD1PYDObWWJcxc5jqND0lrnoRL8XTShRPlINKCfO5fDU
Message-ID: <CAMj1kXHTtGP-UcJLut7OVUuULzg59npyoQhb+kuCZO5x-2NYWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Apr 2025 at 11:55, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> ...
>
> >> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> >> index fdbce022db55..b9b80eccdc02 100644
> >> --- a/arch/x86/boot/compressed/Makefile
> >> +++ b/arch/x86/boot/compressed/Makefile
> >> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
> >>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
> >>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> >>
> >> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
> >> +
> >
> > Please drop this, and put the .incbin directly into header.S
> >
>
> I'm sorry I'm probably missing something important but my understanding
> is that that header.S is compiled into setup.elf:
>
>  ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments  -m elf_i386 -z
>  noexecstack -T arch/x86/boot/setup.ld  ... arch/x86/boot/header.o ...  -o arch/x86/boot/setup.elf
>
> and then the result gets concatenated with vmlinux.bin to get bzImage:
>
>  objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
>  cp arch/x86/boot/setup.bin arch/x86/boot/bzImage; truncate -s %4K arch/x86/boot/bzImage; cat arch/x86/boot/vmlinux.bin >>arch/x86/boot/bzImage
>
> so if we want to have SBAT at the very end of bzImage without dirty
> tricks it must be at the very end of vmlinux.bin, not setup.bin. I can,
> of course, use some existing compilation unit but to be honest I can't
> find anything suitable.
>

Yeah, you're right. I keep forgetting the insane way the bzImage is
put together.

So you'll need to incorporate $(CONFIG_EFI_SBAT_FILE) into
arch/x86/boot/vmlinux. But that does not mean it needs to be
constructed under drivers/firmware/efi/libstub, and it also doesn't
mean you need filechk and a separate .o file, right?


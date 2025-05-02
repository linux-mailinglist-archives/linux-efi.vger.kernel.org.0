Return-Path: <linux-efi+bounces-3533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CBAA72C5
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CB01B63C19
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39297404E;
	Fri,  2 May 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/8cW97i"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE842049;
	Fri,  2 May 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190899; cv=none; b=ue5kzNaS0CHImdfBBciP29T2GbpGKkN6Oaupbp13lARupnX8isKxCwyH7p5POWTppNTLOvBaS1d7U0W5GzmFv7HMgYFnlPB5oG6vxj9N/dT5AXRHUx0jOaVSh1T9DhvnTIfxp4DrDuFrDf2+vT8fsO7i2+B/YRzwPIym1b8PTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190899; c=relaxed/simple;
	bh=dMQRuuNDPo6UB5iEmIqTKZGQgECmuzmTPgEY/2ndJx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdMftpRPw1wjTorkdo8Gytx+EsVEcuiHhQtOMzVeIzipTtw36Bm1GfR/FnGDII2CkJABU0FiIwfT6UZ8wsgzjMG6Mtsqsjqbbs7uxSnOkSAHC+2+UCRWgcKYLwZErbcJbZdSeqsobhD9yH8f3E4TO9biucjWlvwsiSJXX3IAEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/8cW97i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B3C4CEEB;
	Fri,  2 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746190899;
	bh=dMQRuuNDPo6UB5iEmIqTKZGQgECmuzmTPgEY/2ndJx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g/8cW97ifPJ5oIRMGfXy5zxvylC1XHkhb/p1gWvPVy2iXR7mJNCGMKQyjsWG/FMfC
	 bG04ILg6eNnBgb4Zqe9lKHHV4DDios+SlJtWffQymUyjckv6NPhWj6aiN9ReSyTbQ2
	 zGm69Y2HC3wR6nA5umAHD05gTjZk3B7ZwWbOE0e19ToC8NC5kOaNgxoxkbPNhb2Iif
	 HA0HsBqkhi8pA+pn6buNpDHvjdr6lSok2jEFyQzdpvKLfarEUikDwxjt6GCszZyM9t
	 sQkawU1Il76QBZcmL/N3D3gC6ViqliiAn57cHWbU/G6D9ZcNpUDcIFOjWfrFoxfOMx
	 SXUrBkqrj5O1w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso17947211fa.3;
        Fri, 02 May 2025 06:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAmWXOmDEiammz6LDSxYXUs2EZbMaal+nQNJr1Aj+r6ARwQDjZu490RtK9WD0c/qtjzfluCYBWkhXFNt10@vger.kernel.org, AJvYcCXnt8QBUCTBLkZ8Ouj11br1a1SciY0GBvWPp6A6PmKBTUezk/k1VBrgUrBp0p8CiDNZVMH9tKjYvnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WxIvBJk+E+jAjCVwyq9bZP+CfYs9uzYuqWWnIW0z7BkkKQsx
	7whjfmjgCyauGAuYqMZA5lcwvn+y6PHMQHTC4Hh5oZS8WiZCCvMXDj5bYF17Thw1/eiFa/JBxnM
	MhDxmng+17WpADihfCY9FhdhpXuo=
X-Google-Smtp-Source: AGHT+IFP2K1rVw27ZyLOosH08KKIQzCBLDHk9BWOU30jtDuPDDbzP6LOh48YChtZ0T4xHjqDNJTeyg60xD8QdUr+fuA=
X-Received: by 2002:a05:651c:50a:b0:30c:50ff:1a4e with SMTP id
 38308e7fff4ca-320c44e5ef9mr6919641fa.18.1746190897850; Fri, 02 May 2025
 06:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
 <87ldrka6w6.fsf@redhat.com> <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
 <87a57v9pt4.fsf@redhat.com>
In-Reply-To: <87a57v9pt4.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 May 2025 15:01:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkFCOqU2jvG_o97DzrhpXKyUd=WxPhHFA-_0ddPSvs0g@mail.gmail.com>
X-Gm-Features: ATxdqUGjrWPLVf8RNWg3y0yNbuxamdltX9gNRtUdxjVBvn7ezePbPeljUcggMvc
Message-ID: <CAMj1kXFkFCOqU2jvG_o97DzrhpXKyUd=WxPhHFA-_0ddPSvs0g@mail.gmail.com>
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

On Fri, 2 May 2025 at 14:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Mon, 28 Apr 2025 at 12:59, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> Ard Biesheuvel <ardb@kernel.org> writes:
> >>
> >> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> ...
>
> >> >>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
> >> >>         $(call if_changed,ld)
> >> >>
> >> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> index 3b2bc61c9408..d0a27905de90 100644
> >> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> @@ -49,9 +49,22 @@ SECTIONS
> >> >>                 *(.data.*)
> >> >>
> >> >>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
> >> >> +#ifndef CONFIG_EFI_SBAT
> >> >>                 . = ALIGN(. + 4, 0x200);
> >> >> +#else
> >> >> +               /* Avoid gap between '.data' and '.sbat' */
> >> >> +               . = ALIGN(. + 4, 0x1000);
> >> >> +#endif
> >> >>                 _edata = . ;
> >> >>         }
> >> >> +#ifdef CONFIG_EFI_SBAT
> >> >> +       .sbat : ALIGN(0x1000) {
> >> >> +               _sbat = . ;
> >> >> +               *(.sbat)
> >> >> +               _esbat = ALIGN(0x200);
> >> >> +               . = _esbat;
> >> >> +       }
> >> >> +#endif
> >> >>         . = ALIGN(L1_CACHE_BYTES);
> >> >>         .bss : {
> >> >>                 _bss = . ;
> >> >
> >> > This looks a bit odd - see below
> >> >
> >> >> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> >> >> index b5c79f43359b..ab851490ef74 100644
> >> >> --- a/arch/x86/boot/header.S
> >> >> +++ b/arch/x86/boot/header.S
> >> >> @@ -207,6 +207,19 @@ pecompat_fstart:
> >> >>                 IMAGE_SCN_MEM_READ              | \
> >> >>                 IMAGE_SCN_MEM_WRITE             # Characteristics
> >> >>
> >> >> +#ifdef CONFIG_EFI_SBAT
> >> >> +       .ascii ".sbat\0\0\0"
> >> >> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
> >> >> +       .long   setup_size + ZO__sbat           # VirtualAddress
> >> >> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> >> >> +       .long   setup_size + ZO__sbat           # PointerToRawData
> >> >> +
> >> >> +       .long   0, 0, 0
> >> >> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> >> >> +               IMAGE_SCN_MEM_READ              | \
> >> >> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
> >> >> +#endif
> >> >> +
> >> >
> >> > This puts the .sbat section at the very end of the file. However, the
> >> > virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
> >> > ZO__data', and so the .sbat section will overlap with .bss in the
> >> > memory view of the image.
> >>
> >> Missed that, will fix, thanks! A stupid question though: does this
> >> matter in practice for SBAT? I don't think anyone needs SBAT data after
> >> kernel starts booting so we can consider it 'discarded'. BSS data can
> >> then do whatever it wants.
> >>
> >
> > It violates the PE/COFF spec, and some PE loaders and signing tools
> > are very pedantic about the layout.
>
> Turns out it the problem is slightly harder to address then I initially
> thought.

Yeah I was afraid this was going to be tricky.

...

> The problem is similar for zboot.

How so?

> I have two ideas:
> 1) Get back to the idea of putting '.sbat' between '.text' and '.data'
> (was in my RFC).
>

This is what zboot does, no?

> 2) Introduce a separate '.bss' section to the PE binary, basically:
>

I'd like .sbat to be as unintrusive as we can make it, so this is my
least preferred option.


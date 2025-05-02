Return-Path: <linux-efi+bounces-3536-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECEAA744E
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5FA9C523D
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FB2561D1;
	Fri,  2 May 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+G+d2AF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C7255F25;
	Fri,  2 May 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194394; cv=none; b=DloQe+kDThNjVnnhY/CC39RbT7Brnebd86LdmytddXfooqnT+FHlq38ajyoWLpE2nBTJYL1ZoHWNaCn+QHuhbtTMj/tl1yqsa0gYJux1SVQ8XAInLf76RETDU+60aEaYkQ+8lf04R/Op3oJA55V4FF8d4gYWc3Ob1fu1xLx437s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194394; c=relaxed/simple;
	bh=88NFVXZUaDaRJYWPhXI1WcMj18KEdbphqFNzYdApJss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoXP6Hy9J30ntua0dL2iNNjdZLrfr3PXepVyCFk1SHjq99OMRYh/fek9rp0XTqil6FqrnAeOa2BAmqltMuBz6VROLRDD12ElshU9NL9jYG9hWJ26bI1BT+3lyyRxAgy1BZqnTgI25+31zNCrf9uwM+2C/23kq+lYGQfhbh9HTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+G+d2AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01393C4CEF7;
	Fri,  2 May 2025 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746194394;
	bh=88NFVXZUaDaRJYWPhXI1WcMj18KEdbphqFNzYdApJss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q+G+d2AFwxPqZ1IbpSQtcKHBOzh4UNnex+XQiq6pey/o04QI/GbkT8coaMy7npKwh
	 4WNzhwxDUp/NwasAuvuJv4qgyiqrvOHRvrdz88cfY3YLRELKQgHwOzWPMeof7K8xX5
	 TgjiLeAsrtFaOvsPUzOZapPRuJKhw2kmGwguLtTkXIG/rs/oyw3Dj/MU/RvHFPwIpc
	 SniKzQoGE956mklUPyZFfLBYr5MkNpYE/Jt9ryjYAQHBm1c/rjSu56XtrjnUeMKD6M
	 san9fjYMy7gYRW5Z5EHoNCL4NGdvQFB4XsGXPyAmZhIU/as8R6LDdWXxw+Q/sv8Uea
	 GqmFQuJ/LNEhw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so2404420e87.2;
        Fri, 02 May 2025 06:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBM1aPMbyljPXMdX3nI6Q+D5d35wUbvWL5OjkpiuU3bB217Wxw6OsgGSsD5prpPh3y457ZrGV1+NwVn/Yy@vger.kernel.org, AJvYcCVsgVHfiXa9dEgijEAntrHIAxW3Y5S51P9uIhSPLpDTyWuZizg25iSxQ9ObfggLy0y8l2jWqBctH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaducT3UFmyhaP4yHphr/EuCRbLw/wO8S8tySeffQwed9hYLtq
	8iWplPEjS7rgM8jaI0r4fWBT4FPlIyXHlB2ySTOktIp6JcAVOHzr48VGX/c9ML6fBXz5kZtC8fw
	GlCrymEaXZO7EGo1LpF4aZJQb7Kk=
X-Google-Smtp-Source: AGHT+IGr5b1a1gQxlQm0D4LZ5TZhA73SmaQyU2KyUmenM1TrcRCJnJx7hdIKg/Xc3Nyl46yYwNTsjCSg6z9AKg81Lv0=
X-Received: by 2002:a05:6512:3d94:b0:545:6fa:bf60 with SMTP id
 2adb3069b0e04-54eac20b3cbmr882115e87.19.1746194392276; Fri, 02 May 2025
 06:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080950.289864-1-vkuznets@redhat.com> <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
 <87ldrka6w6.fsf@redhat.com> <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
 <87a57v9pt4.fsf@redhat.com> <CAMj1kXFkFCOqU2jvG_o97DzrhpXKyUd=WxPhHFA-_0ddPSvs0g@mail.gmail.com>
 <877c2z9lbw.fsf@redhat.com>
In-Reply-To: <877c2z9lbw.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 May 2025 15:59:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH00miQoZcPygSz+C5dWN0U2AhjTn+HfRki2smfMwjWEQ@mail.gmail.com>
X-Gm-Features: ATxdqUGExM_e4qzwbqX3tr9hmm5GsxfyeFI24AH5nF7tC6nIL9PhK0VQ65QSApg
Message-ID: <CAMj1kXH00miQoZcPygSz+C5dWN0U2AhjTn+HfRki2smfMwjWEQ@mail.gmail.com>
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

On Fri, 2 May 2025 at 15:46, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Fri, 2 May 2025 at 14:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> Ard Biesheuvel <ardb@kernel.org> writes:
> >>
> >> > On Mon, 28 Apr 2025 at 12:59, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >> >>
> >> >> Ard Biesheuvel <ardb@kernel.org> writes:
> >> >>
> >> >> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> ...
> >>
> >> >> >>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
> >> >> >>         $(call if_changed,ld)
> >> >> >>
> >> >> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> >> index 3b2bc61c9408..d0a27905de90 100644
> >> >> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> >> >> >> @@ -49,9 +49,22 @@ SECTIONS
> >> >> >>                 *(.data.*)
> >> >> >>
> >> >> >>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
> >> >> >> +#ifndef CONFIG_EFI_SBAT
> >> >> >>                 . = ALIGN(. + 4, 0x200);
> >> >> >> +#else
> >> >> >> +               /* Avoid gap between '.data' and '.sbat' */
> >> >> >> +               . = ALIGN(. + 4, 0x1000);
> >> >> >> +#endif
> >> >> >>                 _edata = . ;
> >> >> >>         }
> >> >> >> +#ifdef CONFIG_EFI_SBAT
> >> >> >> +       .sbat : ALIGN(0x1000) {
> >> >> >> +               _sbat = . ;
> >> >> >> +               *(.sbat)
> >> >> >> +               _esbat = ALIGN(0x200);
> >> >> >> +               . = _esbat;
> >> >> >> +       }
> >> >> >> +#endif
> >> >> >>         . = ALIGN(L1_CACHE_BYTES);
> >> >> >>         .bss : {
> >> >> >>                 _bss = . ;
> >> >> >
> >> >> > This looks a bit odd - see below
> >> >> >
> >> >> >> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> >> >> >> index b5c79f43359b..ab851490ef74 100644
> >> >> >> --- a/arch/x86/boot/header.S
> >> >> >> +++ b/arch/x86/boot/header.S
> >> >> >> @@ -207,6 +207,19 @@ pecompat_fstart:
> >> >> >>                 IMAGE_SCN_MEM_READ              | \
> >> >> >>                 IMAGE_SCN_MEM_WRITE             # Characteristics
> >> >> >>
> >> >> >> +#ifdef CONFIG_EFI_SBAT
> >> >> >> +       .ascii ".sbat\0\0\0"
> >> >> >> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
> >> >> >> +       .long   setup_size + ZO__sbat           # VirtualAddress
> >> >> >> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> >> >> >> +       .long   setup_size + ZO__sbat           # PointerToRawData
> >> >> >> +
> >> >> >> +       .long   0, 0, 0
> >> >> >> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
> >> >> >> +               IMAGE_SCN_MEM_READ              | \
> >> >> >> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
> >> >> >> +#endif
> >> >> >> +
> >> >> >
> >> >> > This puts the .sbat section at the very end of the file. However, the
> >> >> > virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
> >> >> > ZO__data', and so the .sbat section will overlap with .bss in the
> >> >> > memory view of the image.
> >> >>
> >> >> Missed that, will fix, thanks! A stupid question though: does this
> >> >> matter in practice for SBAT? I don't think anyone needs SBAT data after
> >> >> kernel starts booting so we can consider it 'discarded'. BSS data can
> >> >> then do whatever it wants.
> >> >>
> >> >
> >> > It violates the PE/COFF spec, and some PE loaders and signing tools
> >> > are very pedantic about the layout.
> >>
> >> Turns out it the problem is slightly harder to address then I initially
> >> thought.
> >
> > Yeah I was afraid this was going to be tricky.
> >
> > ...
> >
> >> The problem is similar for zboot.
> >
> > How so?
> >
>
> zboot-header.S has:
>
>     .ascii          ".data\0\0\0"
>     .long           __data_size
>     .long           _etext - .Ldoshdr
>     .long           __data_rawsize
>     .long           _etext - .Ldoshdr
>
> where the difference between '__data_rawsize' and '__data_size' is:
>
>  PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
>  PROVIDE(__data_size = ABSOLUTE(_end - _etext));
>
> and "_end" is the end of BSS. So if we put '.sbat' right after '.data'
> then '.data' will cover it too (so we will get an overlap). If we put
> if after '.bss' then we're going to get a hole (size of '.bss') upon
> (aarch64 example):
>
>  objcopy  -O binary arch/arm64/boot/vmlinuz.efi.elf arch/arm64/boot/vmlinuz.efi
>
> as AFAIU it won't be able to squeeze the binary, it only truncates the
> tail throwing away secions without content (in particular, '.sbat').
>

Ah I misread your patch - I thought .sbat was between .text and .data,
which arguably makes more sense.


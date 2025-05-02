Return-Path: <linux-efi+bounces-3535-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C452DAA741C
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C589A8178
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFF225779;
	Fri,  2 May 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvKoG7zH"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADA22094
	for <linux-efi@vger.kernel.org>; Fri,  2 May 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193610; cv=none; b=jGr7jZSQaDsZxN+dawcukqwwSwdn4wzeUh/W3UyOMWueVJopQ3KT2Hj+kYsd3hB7y+gmXHUJwQy02IT6vxm7wHngSutNhfcvfjKsXS1ccfbnUcd8m0p9MMePIDjjCQ9yBBpwSzFqz/wujGS/xBgFLlYGbfn/sdLVYBCfLpJnEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193610; c=relaxed/simple;
	bh=bLnKoNftABG2OB4Q01vU3eb9fNvmmUVBrHvWNLMKcXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhIrrilCxS0CeexFE1I6NIIwBgS54s6gznsFEWOf8hSVMs6zC37IIpPvmnbiACOgrjVK+UOuOfzQ6gI5ENH8QkOs0HAtpyCnJfg3KS4Np/k0HU+blIndALU+PgM8FhrMsExgM8Yz/kLMCPi32ZNrOwt7zaucC8XetnBp9G30v7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvKoG7zH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746193607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t26WFBHi08pW7euHNG026rO+y6++jNdV0Wnu59PtcDI=;
	b=PvKoG7zH5mWdvt1kglKm0mzgIA4E/kLKRr72PZlbMjDRJGRKUloqlp8He9Jm6dDzK5vtED
	4ohZU4taPtYpFqsqR/xSAh9hPHKdrpvU1SHOzNy3xXEGlPpJHhSZ6IqXIJPQVyG3vzi/kk
	X9rZ3Q6EPJ6TTbCsiaG49zsD16McBJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-HXE_riAvPx2aW2w_AP3v6w-1; Fri, 02 May 2025 09:46:46 -0400
X-MC-Unique: HXE_riAvPx2aW2w_AP3v6w-1
X-Mimecast-MFC-AGG-ID: HXE_riAvPx2aW2w_AP3v6w_1746193605
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39130f02631so567271f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 02 May 2025 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746193605; x=1746798405;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t26WFBHi08pW7euHNG026rO+y6++jNdV0Wnu59PtcDI=;
        b=iluR+Gk6+6PrWwJAvJbUbjDt0BZJt2Tf1EdqsAzpn/Dp3SkMSBMWkduvw+HYHi6YEt
         +fvvQWzIrLwJOTcjzieB8RWIe1oSRuB421V7e69IhxMQsxioyHAk/Z2S9vGRvZDXnmMy
         9vr9X8iDfZLbipiAtA4iRa8Z5uKzV0wbIdo9dEh99//5asM3quv8psNZLTAIYFw70dHG
         Caztv8cZq9hUwNtiJnkauKUxaKxxBSof0MtCJd+yqJHZJK+fqL6rEndE5Kuve6OXIGF9
         DpbQD3gHE0gxv1fJJ7hg9sEQUWNzuLnOXC5VqQsI/0plp3g1pEZYmQrqCWAI5PtQZVDn
         9aEw==
X-Forwarded-Encrypted: i=1; AJvYcCVa2I6ZvPN7cXYMrROAOLv2nx99+xVmSU4frgPJ8H8GJRaI6SUu8wNonIEGPnY0tkfpPOISWBnk7/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4uIWehGWyldUcchHE0XL/c5IbyBez8kn9VZ/Ib/rWBKYUh2w
	6lcXZx24mr9ALkFy6Pc7OU7wscysNob2Yx4okZJ3XW4aVEeX5A5avLxDGn5gOaOTOsTZaFhE4lT
	xE6F3pM6SkEYdCEjFb6C9+FxSBu0KZTUWAtuuA4nM2Ls1Pw87hlsLEevfwA==
X-Gm-Gg: ASbGncsVzUGo8fAQJky7zTCPCgJXurx4crYfpEzviVM6Y3rRBTQVShkvddSC4GP8JUI
	sKe2jSWriSl1g8+oihUh3R7TMzdcsM2bQRS8dMrg32gxx4B9tErDKhs+Uk4Qx++C4Oq5bIbW8Ta
	RjreBQVTgabeJZsAD+4dPThSONEHTKSsp+1edPbqyvnL/1uIWHZ2DLy00NUQ98N1QQQjlEmdEA0
	dc7AM9Olh/4HAla4W6ZPh6CqLRpOVUvpQ3ljBqGEo6kM69IjMSt704HLbAMYLgKZiwTYav6KjJm
	eVredbk=
X-Received: by 2002:a5d:588b:0:b0:3a0:8442:2c48 with SMTP id ffacd0b85a97d-3a099ae9222mr2602342f8f.44.1746193605160;
        Fri, 02 May 2025 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGs1GZuij98mNUcVZcrNsFGm1V35jGUDgdtybLeV9BC/KcmWiOtMwk4H8uBWA4raSVAiEO2w==
X-Received: by 2002:a5d:588b:0:b0:3a0:8442:2c48 with SMTP id ffacd0b85a97d-3a099ae9222mr2602322f8f.44.1746193604732;
        Fri, 02 May 2025 06:46:44 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20c3fsm91680295e9.28.2025.05.02.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:46:44 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, Emanuele
 Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi
 <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, Matthew Garrett
 <mjg59@srcf.ucam.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
In-Reply-To: <CAMj1kXFkFCOqU2jvG_o97DzrhpXKyUd=WxPhHFA-_0ddPSvs0g@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
 <87ldrka6w6.fsf@redhat.com>
 <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
 <87a57v9pt4.fsf@redhat.com>
 <CAMj1kXFkFCOqU2jvG_o97DzrhpXKyUd=WxPhHFA-_0ddPSvs0g@mail.gmail.com>
Date: Fri, 02 May 2025 15:46:43 +0200
Message-ID: <877c2z9lbw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Fri, 2 May 2025 at 14:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Mon, 28 Apr 2025 at 12:59, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >>
>> >> Ard Biesheuvel <ardb@kernel.org> writes:
>> >>
>> >> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> ...
>>
>> >> >>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>> >> >>         $(call if_changed,ld)
>> >> >>
>> >> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> >> index 3b2bc61c9408..d0a27905de90 100644
>> >> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> >> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> >> @@ -49,9 +49,22 @@ SECTIONS
>> >> >>                 *(.data.*)
>> >> >>
>> >> >>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
>> >> >> +#ifndef CONFIG_EFI_SBAT
>> >> >>                 . = ALIGN(. + 4, 0x200);
>> >> >> +#else
>> >> >> +               /* Avoid gap between '.data' and '.sbat' */
>> >> >> +               . = ALIGN(. + 4, 0x1000);
>> >> >> +#endif
>> >> >>                 _edata = . ;
>> >> >>         }
>> >> >> +#ifdef CONFIG_EFI_SBAT
>> >> >> +       .sbat : ALIGN(0x1000) {
>> >> >> +               _sbat = . ;
>> >> >> +               *(.sbat)
>> >> >> +               _esbat = ALIGN(0x200);
>> >> >> +               . = _esbat;
>> >> >> +       }
>> >> >> +#endif
>> >> >>         . = ALIGN(L1_CACHE_BYTES);
>> >> >>         .bss : {
>> >> >>                 _bss = . ;
>> >> >
>> >> > This looks a bit odd - see below
>> >> >
>> >> >> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> >> >> index b5c79f43359b..ab851490ef74 100644
>> >> >> --- a/arch/x86/boot/header.S
>> >> >> +++ b/arch/x86/boot/header.S
>> >> >> @@ -207,6 +207,19 @@ pecompat_fstart:
>> >> >>                 IMAGE_SCN_MEM_READ              | \
>> >> >>                 IMAGE_SCN_MEM_WRITE             # Characteristics
>> >> >>
>> >> >> +#ifdef CONFIG_EFI_SBAT
>> >> >> +       .ascii ".sbat\0\0\0"
>> >> >> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
>> >> >> +       .long   setup_size + ZO__sbat           # VirtualAddress
>> >> >> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
>> >> >> +       .long   setup_size + ZO__sbat           # PointerToRawData
>> >> >> +
>> >> >> +       .long   0, 0, 0
>> >> >> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> >> >> +               IMAGE_SCN_MEM_READ              | \
>> >> >> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
>> >> >> +#endif
>> >> >> +
>> >> >
>> >> > This puts the .sbat section at the very end of the file. However, the
>> >> > virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
>> >> > ZO__data', and so the .sbat section will overlap with .bss in the
>> >> > memory view of the image.
>> >>
>> >> Missed that, will fix, thanks! A stupid question though: does this
>> >> matter in practice for SBAT? I don't think anyone needs SBAT data after
>> >> kernel starts booting so we can consider it 'discarded'. BSS data can
>> >> then do whatever it wants.
>> >>
>> >
>> > It violates the PE/COFF spec, and some PE loaders and signing tools
>> > are very pedantic about the layout.
>>
>> Turns out it the problem is slightly harder to address then I initially
>> thought.
>
> Yeah I was afraid this was going to be tricky.
>
> ...
>
>> The problem is similar for zboot.
>
> How so?
>

zboot-header.S has:

    .ascii          ".data\0\0\0"
    .long           __data_size
    .long           _etext - .Ldoshdr
    .long           __data_rawsize
    .long           _etext - .Ldoshdr

where the difference between '__data_rawsize' and '__data_size' is:

 PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
 PROVIDE(__data_size = ABSOLUTE(_end - _etext));

and "_end" is the end of BSS. So if we put '.sbat' right after '.data'
then '.data' will cover it too (so we will get an overlap). If we put
if after '.bss' then we're going to get a hole (size of '.bss') upon
(aarch64 example):

 objcopy  -O binary arch/arm64/boot/vmlinuz.efi.elf arch/arm64/boot/vmlinuz.efi

as AFAIU it won't be able to squeeze the binary, it only truncates the
tail throwing away secions without content (in particular, '.sbat').

>> I have two ideas:
>> 1) Get back to the idea of putting '.sbat' between '.text' and '.data'
>> (was in my RFC).
>>
>
> This is what zboot does, no?
>

In v1 I put '.sbat' right after '.data' and before '.bss' but I didn't
think about the memory overlap problem.

>> 2) Introduce a separate '.bss' section to the PE binary, basically:
>>
>
> I'd like .sbat to be as unintrusive as we can make it, so this is my
> least preferred option.
>

This is very reasonable -- unless for some reason we belive that
separating '.bss' into its own PE section is a good idea on its own.

-- 
Vitaly



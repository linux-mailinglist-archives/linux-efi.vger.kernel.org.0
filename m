Return-Path: <linux-efi+bounces-3472-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA0A9EE7A
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 12:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0D7ACFCC
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0848262FD9;
	Mon, 28 Apr 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwbR9m2L"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69925F96D
	for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837985; cv=none; b=hLuTuGhTzkl9nq/TnkJ67egPBOO0dE6/n9Yu8qmeqm/bxxwnCZ0smTQ0oHjIJNmXfjki5XcudR3D4YOZ9Q8PbtLQZ5GV8s5RaJlj68umGLwErA/ianCg7MOKJiQt0tuSveYHBWvu9S5ewMLYjzGtRFmwO4F1mBZMVfujK1rfb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837985; c=relaxed/simple;
	bh=qcq79qRePDaFRa38AzdyI92iXEXV7YAprKycHB4l2IQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOnAkgaOqwE1xYDXPLABegARfKpquLv5qb619kQU35mcEPnnO4Vt6cjEuak7HAF8GCtNYIAAm7eL9mPJS6PeA/M7qh0NDL0+ruPYDbpRcoJxEDfTmkELI1GnvyUeGQxe4aOMD5qALSkDOz/zdKjTH0voSE3+6Fp9sG/H5VYptsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwbR9m2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745837982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1S1GQtMqLXYO4RQQUYg3g09QNCmMVEz/isjWKDgecM=;
	b=cwbR9m2Lu8Bg/38NlWOh7Wu7OiGORJdyBS5MC3BtyQEPaOsoeWS34obmNZNlhXoobqwGhg
	DQQ8px+UYZAQht7efuKV0vQkw2m0qZSQluEBCEPDra5r6TL5l4lUye2XuvVowGy1tgV47e
	FrrFanEUba7RK2yB8wBTImtTnEH1kVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Z4rx5cD4PRKbC1KOldRKrA-1; Mon, 28 Apr 2025 06:59:40 -0400
X-MC-Unique: Z4rx5cD4PRKbC1KOldRKrA-1
X-Mimecast-MFC-AGG-ID: Z4rx5cD4PRKbC1KOldRKrA_1745837979
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so23989075e9.3
        for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837979; x=1746442779;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1S1GQtMqLXYO4RQQUYg3g09QNCmMVEz/isjWKDgecM=;
        b=tNtKLhnThXKeBmywJF3pWc9MhUk7ie6aL0kBuoov4V8kvfRYoprq62t1M/RLxoRLVU
         vWTRWJsnNLdZ/v9wpkWapTw/6GSq3OKTRRW3FYxBV2/t8l2Cog/c7XMQnWChr+6UjPQn
         Ew3TtSDPiKU4vhImm39sC35vH/1LmLB0zf3ol7TeD4Ad0DFlR6PbcPXMvnqq8+Jxui/z
         Yw17f1EaTSYDRRIZbwz9yAEeBySlNfvUlfxF8Vi2XnqKd0DhqoMqhRUydWmd/dWx8f+C
         2F+eQgQXLcKReVHgK1BKQVTBnfBFNtRCI/GkZOhKMqnEA6PbeWDtZZaIiq7xnvh3N7ru
         OqKg==
X-Forwarded-Encrypted: i=1; AJvYcCUYgs3YNODglvpdqpuwogT68UFLW1upG/gfG2XsO5W5KQNSiULV5gSQNBM2RVFswnzS7ivAaDq0n/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPXai0eI733DisZcBR+zAaZXSh+NduJdR523omALhxuKzbPFQ
	5rbEgR6qObAaBWq0zzVma3l2rYpAhIVawl9TT7x3W6xhkYuIb5zA44VmiXi4C/a3OnZobXz0hmL
	Bq1JDivrL1UBr1H5epq0TRiO0Ogaws6l1g0oY27IitXgoCnLrZSsj7Uzmog==
X-Gm-Gg: ASbGncv9pBaFG70a8k3XK8LpCsvYh46ZwcBjXvacHDYdcNKXqLpJ3tQCmjqpn9cl3WP
	bgmI0y08dag4CH1YSjbwiBHnfrTyvQqobeCBY+y2T4j2JPUR3ClprIwh8m2dmnrjmU8mNSV5i1r
	DDRCWYWF46MFt52BkiseCcIey6NrQpqGV0S8XTM2/NZVYT8RfyzVgLAMK/DWAtSEfLo8yTJJVYU
	2ioI+pF/0c+Aweajq+PXqmt07514AbVaJ+Y5j3mwTd9RcGCoU+8fWQYGt35frD9VRfF9IF0i3kF
	UjI+Gd0=
X-Received: by 2002:a05:600c:138c:b0:43d:23fe:e8a6 with SMTP id 5b1f17b1804b1-440ab76a962mr68871395e9.5.1745837979452;
        Mon, 28 Apr 2025 03:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3yhCzFV9b07iIXPnMiZwoDz9SPGqteJaLn0qdABKCE9uf+MOeasr/lE8Q+wKF9OZr7Up4LQ==
X-Received: by 2002:a05:600c:138c:b0:43d:23fe:e8a6 with SMTP id 5b1f17b1804b1-440ab76a962mr68871015e9.5.1745837978978;
        Mon, 28 Apr 2025 03:59:38 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408c8b0ea0sm102888495e9.2.2025.04.28.03.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:59:38 -0700 (PDT)
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
In-Reply-To: <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
Date: Mon, 28 Apr 2025 12:59:37 +0200
Message-ID: <87ldrka6w6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Similar to zboot architectures, implement support for embedding SBAT data
>> for x86. Put '.sbat' section to the very end of the binary.
>>
>> Note, the obsolete CRC-32 checksum (see commit 9c54baab4401 ("x86/boot:
>> Drop CRC-32 checksum and the build tool that generates it")) is gone and
>> while it would've been possible to reserve the last 4 bytes in '.sbat'
>> section too (like it's done today in '.data'), it seems to be a pointless
>> exercise: SBAT makes zero sense without a signature on the EFI binary so
>> '.sbat' won't be at the very end of the file anyway. Any tool which uses
>> the last 4 bytes of the file as a checksum is broken with signed EFI
>> binaries already.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/boot/Makefile                 |  2 +-
>>  arch/x86/boot/compressed/Makefile      |  2 ++
>>  arch/x86/boot/compressed/vmlinux.lds.S | 13 +++++++++++++
>>  arch/x86/boot/header.S                 | 13 +++++++++++++
>>  drivers/firmware/efi/Kconfig           |  2 +-
>>  5 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>> index 81f55da81967..5f7b52f0e7f5 100644
>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>> @@ -71,7 +71,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>>
>>  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
>>
>> -sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>> +sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>>
>>  quiet_cmd_zoffset = ZOFFSET $@
>>        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index fdbce022db55..b9b80eccdc02 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -107,6 +107,8 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>
>> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(objtree)/drivers/firmware/efi/libstub/sbat.o
>> +
>
> Please drop this, and put the .incbin directly into header.S
>

Sure, but as I also commented on zboot patch, we need a logic to track
possible sbat data changes and rebuild when needed. 'sbat.o' was
convenient because we can have this tracking logic in one place (zboot)
and make will do the rest. If we are to drop 'sbat.o', we will need the
tracking logic both in zboot and x86.

>>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>>         $(call if_changed,ld)
>>
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 3b2bc61c9408..d0a27905de90 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -49,9 +49,22 @@ SECTIONS
>>                 *(.data.*)
>>
>>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
>> +#ifndef CONFIG_EFI_SBAT
>>                 . = ALIGN(. + 4, 0x200);
>> +#else
>> +               /* Avoid gap between '.data' and '.sbat' */
>> +               . = ALIGN(. + 4, 0x1000);
>> +#endif
>>                 _edata = . ;
>>         }
>> +#ifdef CONFIG_EFI_SBAT
>> +       .sbat : ALIGN(0x1000) {
>> +               _sbat = . ;
>> +               *(.sbat)
>> +               _esbat = ALIGN(0x200);
>> +               . = _esbat;
>> +       }
>> +#endif
>>         . = ALIGN(L1_CACHE_BYTES);
>>         .bss : {
>>                 _bss = . ;
>
> This looks a bit odd - see below
>
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index b5c79f43359b..ab851490ef74 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -207,6 +207,19 @@ pecompat_fstart:
>>                 IMAGE_SCN_MEM_READ              | \
>>                 IMAGE_SCN_MEM_WRITE             # Characteristics
>>
>> +#ifdef CONFIG_EFI_SBAT
>> +       .ascii ".sbat\0\0\0"
>> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
>> +       .long   setup_size + ZO__sbat           # VirtualAddress
>> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
>> +       .long   setup_size + ZO__sbat           # PointerToRawData
>> +
>> +       .long   0, 0, 0
>> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> +               IMAGE_SCN_MEM_READ              | \
>> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
>> +#endif
>> +
>
> This puts the .sbat section at the very end of the file. However, the
> virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
> ZO__data', and so the .sbat section will overlap with .bss in the
> memory view of the image.

Missed that, will fix, thanks! A stupid question though: does this
matter in practice for SBAT? I don't think anyone needs SBAT data after
kernel starts booting so we can consider it 'discarded'. BSS data can
then do whatever it wants.

>
>
>>         .set    section_count, (. - section_table) / 40
>>  #endif /* CONFIG_EFI_STUB */
>>
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index 2edb0167ba49..5022a378fec1 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -283,7 +283,7 @@ config EFI_EMBEDDED_FIRMWARE
>>
>>  config EFI_SBAT
>>         bool "Embed SBAT section in the kernel"
>> -       depends on EFI_ZBOOT
>> +       depends on EFI_ZBOOT || (EFI_STUB && X86)
>>         help
>>           SBAT section provides a way to improve SecureBoot revocations of UEFI
>>           binaries by introducing a generation-based mechanism. With SBAT, older
>> --
>> 2.49.0
>>
>>
>

-- 
Vitaly



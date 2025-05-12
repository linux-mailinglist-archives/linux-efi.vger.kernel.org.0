Return-Path: <linux-efi+bounces-3654-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E296AB3B95
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D037B16E5A2
	for <lists+linux-efi@lfdr.de>; Mon, 12 May 2025 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F7215773;
	Mon, 12 May 2025 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTxuFs5q"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AF4C80
	for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062154; cv=none; b=MccgwjxVpTPmUru6MiN69Z38Y9mo1bGuG1JF4wVtj5/iLc05nhuQJAbSewP7c6whFS/BkAB9UDWVH9alJ/rYggioU/QyCcX9OMh5+XQWgYCK4/DzGJ/OZxHf8+53OZ7z5eVgehxMPH26zZH/Y4Tl6UmkexqjwS4gdNQLIXvGcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062154; c=relaxed/simple;
	bh=JBmAM9H5JX6TW3sbNChQ2DMktHIFyE/nMpfZxooDixQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YwfG8YC14+9xkg/1kJR+z0375IT911yeunC8ehQH81JFVqSdcVnEJWA3qyXzMrDVnbI9hAy7fIJz5X4EUHNIqKBnGAHWQEdQO6PKqCKAmhpaNskDcoedTseuPSFlZsfZQlGSSfy5qvnGB/bQlHKdwCTiy29XwvF1zKjHAqWid6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTxuFs5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747062151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+aiFA56058+FsYxyTgCmKmCwSIpkx/e3xhnhpzVDs5s=;
	b=FTxuFs5qeb5GZTXOAdARbZ95nUQ//rm8bXlFQiY4pJpkKXNrM4YrYKIb+czDik6wdgRIEJ
	Ss3+hIKQoTxY1naqLCzYYjk4VnsFThnjTuNvqH/OWApL3UyEtY/7G/8Jf5/0/3z8QhFCxa
	Bav5BV8N6rOsiMsoaS4WW2xa7HDDsoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Qfgiv4zdM36egRnlJChdsQ-1; Mon, 12 May 2025 11:02:29 -0400
X-MC-Unique: Qfgiv4zdM36egRnlJChdsQ-1
X-Mimecast-MFC-AGG-ID: Qfgiv4zdM36egRnlJChdsQ_1747062148
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so32475895e9.1
        for <linux-efi@vger.kernel.org>; Mon, 12 May 2025 08:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062148; x=1747666948;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aiFA56058+FsYxyTgCmKmCwSIpkx/e3xhnhpzVDs5s=;
        b=tFbzytmIh2uXZg8boCHPLYTMSOavqJw/wokRmuEGNglSbRiu9I+ZFkmBaJV0zB5ym7
         xVE50XH75a7uGHLeQz+JUvfIdcr3sX+bBzO+CF3OVzEOReyopQNt5cs++OF11rkeUAMS
         ++NGH3z4XgTIas1WzyfF/+xgRm6NKw1NRUzNRs9PupRp9vo4KhqE81kFYxepGMm63BX6
         zfM/SQx5dVPs7DcTJO7fLNiJYn0bBZZ7Erp4QW3CG2r4L/gjARRoV0ws9DxBqHEcjRoN
         jYM1VCqMHRyMDmH660VnMl083RtVn6wozFNJ2OqjcLmgKlvVAZkZgBwbiYF1gcd5k/O+
         1IAw==
X-Forwarded-Encrypted: i=1; AJvYcCWOMJeKpTO4QsJq2XEy8xgTn+nM7pqD0CUKHuoT1fR+PaG1UaQXlPJI39aiWlTMlLbzmtYREUYhNb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+2TsJwQOwIuDoZkOYyHNLUFaGS4iZPDzjqlY1rx9RDaJP8Rz
	ai09byjFmQg9u2e9sJ5C/+n0QmvXQGnxBhKe58JZI839eGBd2q5mHW8bctKINWIAU+ZEk5Za8yL
	l34eukci8rTqHuX+L3VvOK0KO+8YqXaW1+awOYO3dKaZ+wCA1yU2MOpQKdw==
X-Gm-Gg: ASbGncujBTxCzrBO0qIfSwdUuY9jaiNBTTerCHXdGTpvWGaXiDjp7e9PHprrmoh/CTO
	GHZQNpTnwHxDhUxgVwgz9NBJAbt7QL6TBIKioUmhcBxRm3pW/tL8M2LvWZYXPf19a6gi4FhEZqb
	bzREilHX+Wm+WjQo116h/NvC2ADVv9nIQl7N+RwfXeGht8asW5Pa64wDIV4fLqFbO3diCWelXvg
	Q2RP3zIL1suzqe+dKUj+q0/G/U0Yt6uW+/8Cm6/bkAt4h7Ctyas2+2nR+xj4IzsjEcQfgSPXnXm
	OavCFcU=
X-Received: by 2002:a05:600c:c0c3:20b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-442e0e003famr39057015e9.29.1747062147418;
        Mon, 12 May 2025 08:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNCRsWpjjm70p7pA66zqim2XKAcn+cYHPKtWmq9XcV7Ie5htKeoPZ2dXj5fYwpZgFkNrN4gQ==
X-Received: by 2002:a05:600c:c0c3:20b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-442e0e003famr39056145e9.29.1747062146172;
        Mon, 12 May 2025 08:02:26 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd328f0fsm176545865e9.7.2025.05.12.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 08:02:25 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>, Daniel Berrange
 <berrange@redhat.com>, Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luca Boccassi <bluca@debian.org>,
 Matthew Garrett <mjg59@srcf.ucam.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Implement support for embedding SBAT
 data for x86
In-Reply-To: <CAMj1kXE5iVsKSEcEPqJs4bZpB03FYR9OcstDVUKNax=2y8nsAg@mail.gmail.com>
References: <20250505154523.231233-1-vkuznets@redhat.com>
 <20250505154523.231233-3-vkuznets@redhat.com>
 <CAMj1kXE5iVsKSEcEPqJs4bZpB03FYR9OcstDVUKNax=2y8nsAg@mail.gmail.com>
Date: Mon, 12 May 2025 17:02:24 +0200
Message-ID: <8734d9oosf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Mon, 5 May 2025 at 17:46, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Similar to zboot architectures, implement support for embedding SBAT data
>> for x86. Put '.sbat' section in between '.data' and '.text' as the former
>> also covers '.bss' and '.pgtable' and thus must be the last one in the
>> file.
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
>
> Is this last paragraph still relevant? If not, please drop it.
>

Ceratinly not relevant anymore, will drop.

>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/boot/Makefile                 |  2 +-
>>  arch/x86/boot/compressed/Makefile      |  5 ++++
>>  arch/x86/boot/compressed/sbat.S        |  7 ++++++
>>  arch/x86/boot/compressed/vmlinux.lds.S |  8 +++++++
>>  arch/x86/boot/header.S                 | 33 +++++++++++++++++++-------
>>  drivers/firmware/efi/Kconfig           |  2 +-
>>  6 files changed, 46 insertions(+), 11 deletions(-)
>>  create mode 100644 arch/x86/boot/compressed/sbat.S
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
>> index fdbce022db55..1441435869cc 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -106,6 +106,11 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>>
>>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>  vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>> +vmlinux-objs-$(CONFIG_EFI_SBAT) += $(obj)/sbat.o
>> +
>> +ifdef CONFIG_EFI_SBAT
>> +$(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
>> +endif
>>
>>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>>         $(call if_changed,ld)
>> diff --git a/arch/x86/boot/compressed/sbat.S b/arch/x86/boot/compressed/sbat.S
>> new file mode 100644
>> index 000000000000..838f70a997dd
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/sbat.S
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Embed SBAT data in the kernel.
>> + */
>> +       .pushsection ".sbat", "a", @progbits
>> +       .incbin CONFIG_EFI_SBAT_FILE
>> +       .popsection
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 3b2bc61c9408..587ce3e7c504 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -43,6 +43,14 @@ SECTIONS
>>                 *(.rodata.*)
>>                 _erodata = . ;
>>         }
>> +#ifdef CONFIG_EFI_SBAT
>> +       .sbat : ALIGN(0x1000) {
>> +               _sbat = . ;
>> +               *(.sbat)
>> +               _esbat = ALIGN(0x1000);
>> +               . = _esbat;
>> +       }
>> +#endif
>>         .data : ALIGN(0x1000) {
>>                 _data = . ;
>>                 *(.data)
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index b5c79f43359b..91964818bf50 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -179,15 +179,17 @@ pecompat_fstart:
>>  #else
>>         .set    pecompat_fstart, setup_size
>>  #endif
>> -       .ascii  ".text"
>> -       .byte   0
>> -       .byte   0
>> -       .byte   0
>> -       .long   ZO__data
>> -       .long   setup_size
>> -       .long   ZO__data                        # Size of initialized data
>> -                                               # on disk
>> -       .long   setup_size
>> +       .ascii  ".text\0\0\0"
>> +#ifdef CONFIG_EFI_SBAT
>> +       .long   ZO__sbat                        # VirtualSize
>> +       .long   setup_size                      # VirtualAddress
>> +       .long   ZO__sbat                        # SizeOfRawData
>> +#else
>> +       .long   ZO__data                        # VirtualSize
>> +       .long   setup_size                      # VirtualAddress
>> +       .long   ZO__data                        # SizeOfRawData
>> +#endif
>> +       .long   setup_size                      # PointerToRawData
>
> Would it work if we do the following here
>
> #ifdef CONFIG_EFI_SBAT
>   .set .Ltextsize, ZO__sbat
> #else
>   .set .Ltextsize, ZO__data
> #endif
>
> and keep a single section definition for .text
>
>   .ascii  ".text\0\0\0"
>   .long   .Ltextsize                  # VirtualSize
>   .long   setup_size                  # VirtualAddress
>   .long   .Ltextsize                  # SizeOfRawData
>   .long   setup_size                  # PointerToRawData
>

As we already have '#ifdef CONFIG_EFI_SBAT' below I'd suggest we set
textsize there, basically:

@@ -199,16 +194,20 @@ pecompat_fstart:
                IMAGE_SCN_MEM_EXECUTE           # Characteristics
 
 #ifdef CONFIG_EFI_SBAT
-       .ascii ".sbat\0\0\0"
-       .long   ZO__esbat - ZO__sbat            # VirtualSize
-       .long   setup_size + ZO__sbat           # VirtualAddress
-       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
-       .long   setup_size + ZO__sbat           # PointerToRawData
+       .ascii  ".sbat\0\0\0"
+       .long   ZO__esbat - ZO__sbat            # VirtualSize
+       .long   setup_size + ZO__sbat           # VirtualAddress
+       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
+       .long   setup_size + ZO__sbat           # PointerToRawData
 
        .long   0, 0, 0
        .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
                IMAGE_SCN_MEM_READ              | \
                IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
+
+       .set textsize, ZO__sbat
+#else
+       .set textsize, ZO__data
 #endif
 
        .ascii  ".data\0\0\0"

and nobody seems to care that we use it first and define/set it later.

BTW, does '.L' prefix you suggest has a meaning here? I see we don't use
it for e.g. 'pecompat_fstart', 'section_count'.

>
>>         .long   0                               # PointerToRelocations
>>         .long   0                               # PointerToLineNumbers
>>         .word   0                               # NumberOfRelocations
>> @@ -196,6 +198,19 @@ pecompat_fstart:
>>                 IMAGE_SCN_MEM_READ              | \
>>                 IMAGE_SCN_MEM_EXECUTE           # Characteristics
>>
>> +#ifdef CONFIG_EFI_SBAT
>> +       .ascii ".sbat\0\0\0"
>
> Inconsistent indentation? ^^^
>

Yep, fixing.

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
>>         .ascii  ".data\0\0\0"
>>         .long   ZO__end - ZO__data              # VirtualSize
>>         .long   setup_size + ZO__data           # VirtualAddress
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index db8c5c03d3a2..16baa038d412 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -286,7 +286,7 @@ config EFI_SBAT
>>
>>  config EFI_SBAT_FILE
>>         string "Embedded SBAT section file path"
>> -       depends on EFI_ZBOOT
>> +       depends on EFI_ZBOOT || (EFI_STUB && X86)
>>         help
>>           SBAT section provides a way to improve SecureBoot revocations of UEFI
>>           binaries by introducing a generation-based mechanism. With SBAT, older
>> --
>> 2.49.0
>>
>
> Modulo the nits, I think this patch looks fine, but it will need to go
> through the -tip tree.
>
> So with the changes,
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for the review!

>
> Ingo, Boris, given that this depends on the previous patch, mind
> taking both via the -tip tree? I can take them too, but it doesn't
> make sense splitting them up.
>

-- 
Vitaly



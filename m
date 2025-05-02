Return-Path: <linux-efi+bounces-3532-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E85AA7143
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 14:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56411BC3FC9
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ABE248F55;
	Fri,  2 May 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2qGErEV"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FE20C488
	for <linux-efi@vger.kernel.org>; Fri,  2 May 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187807; cv=none; b=UPM8kIJE4ywgBhk305qxaU5smmJGlNnkxZX4+WQ6h6HngXcLcmfgULV4w2D4Wy1rr0lCpeALd9/XwRMbQU61B+EEQScj36/rD1YWQArDZSE6+wK4pJO/reMkyT7D5qebqWOf4p3blFvd/aAzkB7nbQSV9FLhgltSaAy95kzZXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187807; c=relaxed/simple;
	bh=pOpOvjck0Gt5C7hmD9HobhQXttro+pD0I2xh7VVgCXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMmBnavYllPcWOebHTC0mChBEdWkTXfZSPhkb8allToI6PgHOx0OORdTig1IAVttHGLQKpOkpCqWLE/AJVrjk27uT4LqaCWOC4A/LuLDnB7M+UWJflyCXpkhkpoj9Wo+J2uSPQDnf/oU6RBXPs5jAcfSxJme4IeNVuAkKKcgvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2qGErEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746187804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+x86lQ3eEa6wGjIIl/uJ+Xr71OZD/OsawvdSadvihw=;
	b=O2qGErEVq0AXq9QZRzWoPcJW67lOj20GS/9wNm5VGA/wYhNpomjohT3yCWGZ7rPRtsDzt3
	SicoJowuuwcShfCfoCAEkYZXOL/yqlbQdGWl6mDZ+MN+P4+2gHdYLq3BihPWG5RUSkVJ54
	7V7WcewVnRUzlSRwm1vRNL+7tZpUUmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-0SXlAn5qM26av8dskAYrrg-1; Fri, 02 May 2025 08:10:02 -0400
X-MC-Unique: 0SXlAn5qM26av8dskAYrrg-1
X-Mimecast-MFC-AGG-ID: 0SXlAn5qM26av8dskAYrrg_1746187802
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso8338295e9.3
        for <linux-efi@vger.kernel.org>; Fri, 02 May 2025 05:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746187802; x=1746792602;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+x86lQ3eEa6wGjIIl/uJ+Xr71OZD/OsawvdSadvihw=;
        b=ZDUte8W38NPH3Opfw9ihFD8zk9gbe2KwbTPOM6UrSsqBLW6L7tTFyve7KJoY5hV2Au
         Hc+9h9TmIRBvkcERmCJ0KswP67uKNyxymPEkqjeEHXtBBDI0lHntZpTfUnKXB9TTpFPR
         +nKPwB+0nhE2JRGowt8hkvvFnaVoL2LfRnMahzOi7o0jsgWgcTkgR8PSA4nZNGaoW1Fn
         VcTnwEv7Vhws5itm/bxJsCmMKwDV6PKlskZ3PcXWNq9mG949fEYxa+xnljr5HzeHeWoQ
         7fjnNpHnkOt9x1d0CLplj6HVr0kvSAcqQSq4ZGjL0jOI+ks2ef6oobozoZjsdZVLVYXr
         2biQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0X18FJnTJNjoT12euIKIEtTOhokREH63IegeMRbSot0xbaMrFUSqe0M5xQC5hhtEDh7M/+NQn/nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhXaOUqY4VPGiX1f7qs6RekVigGXhHiygDJvWQSzfmYAmx7hN
	rYTuWQxc233LlNT6O9ZVLst+ygdIQIQq7Pt3K2bnXLaNA5YGqdl/yREgYxCyeYpdaW7bEglzSlX
	CO2dHElLmHIr1QF6AU1rBNxEGcYhNw3FE14vaSN5VrposRDOPaLVH9Inq2g==
X-Gm-Gg: ASbGnctQ7wqtZB4AmD8SxgIoP0q5DfM3LThMcgRRXzFIDWaFcl5w0KD3jZS70E6xcac
	20YLqcUi1DhHd/Z1t678tN3XaVLERKsQtWvfimqz3qw+LpqjvLzq4XVqIRx/hJUbSxgKZewZP7q
	0jhAan2ypFsqXs4aPfMMeXkT54vELmr6hYZ9D8gLZ0TkgN7nhEw9AyX2DMvCpSfLl18QyTJN5tC
	QrI6E8mDWUWBs/m7YhMPBR5LVuM8/YM0Ft4FZjQ9ICXvFm28+IWX17K+vquphYhURlD1C30/0GZ
	+e9b4PE=
X-Received: by 2002:a05:600c:6612:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-441bbe25490mr23119535e9.0.1746187801759;
        Fri, 02 May 2025 05:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9Keejkp+a+4rvlg26rBiOVIXrfRiZtb/w3Nvum12Eyzo9hqF3GutGJC1S6pljMkzwZdEAA==
X-Received: by 2002:a05:600c:6612:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-441bbe25490mr23119155e9.0.1746187801359;
        Fri, 02 May 2025 05:10:01 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecc89sm88150895e9.9.2025.05.02.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 05:10:00 -0700 (PDT)
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
In-Reply-To: <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-3-vkuznets@redhat.com>
 <CAMj1kXFMmhROmaDZ0gsw+ozG5iSkMvSXb15qexToUSAFyBn5hQ@mail.gmail.com>
 <87ldrka6w6.fsf@redhat.com>
 <CAMj1kXE0WcenLEB+60=+oc+aKfbqZkwYZf-TrOyDY=ShXQ2pYw@mail.gmail.com>
Date: Fri, 02 May 2025 14:09:59 +0200
Message-ID: <87a57v9pt4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Mon, 28 Apr 2025 at 12:59, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Ard Biesheuvel <ardb@kernel.org> writes:
>>
>> > On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

...

>> >>  $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
>> >>         $(call if_changed,ld)
>> >>
>> >> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> index 3b2bc61c9408..d0a27905de90 100644
>> >> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> >> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> >> @@ -49,9 +49,22 @@ SECTIONS
>> >>                 *(.data.*)
>> >>
>> >>                 /* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
>> >> +#ifndef CONFIG_EFI_SBAT
>> >>                 . = ALIGN(. + 4, 0x200);
>> >> +#else
>> >> +               /* Avoid gap between '.data' and '.sbat' */
>> >> +               . = ALIGN(. + 4, 0x1000);
>> >> +#endif
>> >>                 _edata = . ;
>> >>         }
>> >> +#ifdef CONFIG_EFI_SBAT
>> >> +       .sbat : ALIGN(0x1000) {
>> >> +               _sbat = . ;
>> >> +               *(.sbat)
>> >> +               _esbat = ALIGN(0x200);
>> >> +               . = _esbat;
>> >> +       }
>> >> +#endif
>> >>         . = ALIGN(L1_CACHE_BYTES);
>> >>         .bss : {
>> >>                 _bss = . ;
>> >
>> > This looks a bit odd - see below
>> >
>> >> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> >> index b5c79f43359b..ab851490ef74 100644
>> >> --- a/arch/x86/boot/header.S
>> >> +++ b/arch/x86/boot/header.S
>> >> @@ -207,6 +207,19 @@ pecompat_fstart:
>> >>                 IMAGE_SCN_MEM_READ              | \
>> >>                 IMAGE_SCN_MEM_WRITE             # Characteristics
>> >>
>> >> +#ifdef CONFIG_EFI_SBAT
>> >> +       .ascii ".sbat\0\0\0"
>> >> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
>> >> +       .long   setup_size + ZO__sbat           # VirtualAddress
>> >> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
>> >> +       .long   setup_size + ZO__sbat           # PointerToRawData
>> >> +
>> >> +       .long   0, 0, 0
>> >> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> >> +               IMAGE_SCN_MEM_READ              | \
>> >> +               IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
>> >> +#endif
>> >> +
>> >
>> > This puts the .sbat section at the very end of the file. However, the
>> > virtual size of .data is 'ZO__end - ZO__data' not 'ZO__edata -
>> > ZO__data', and so the .sbat section will overlap with .bss in the
>> > memory view of the image.
>>
>> Missed that, will fix, thanks! A stupid question though: does this
>> matter in practice for SBAT? I don't think anyone needs SBAT data after
>> kernel starts booting so we can consider it 'discarded'. BSS data can
>> then do whatever it wants.
>>
>
> It violates the PE/COFF spec, and some PE loaders and signing tools
> are very pedantic about the layout.

Turns out it the problem is slightly harder to address then I initially
thought. On x86, arch/x86/boot/bzImage is composed of setup.bin and
vmlinux.bin and the later is produced from vmlinux with

 objcopy -O binary -R .note -R .comment -S arch/x86/boot/compressed/vmlinux arch/x86/boot/vmlinux.bin

"objcopy -O binary" basically dumps memory representation of vmlinux. In
case we put '.sbat' before '.bss' we get:

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
...
  4 .data         00002000  0000000000aef000  0000000000aef000  00af0000  2**12
                  CONTENTS, ALLOC, LOAD, DATA
  5 .sbat         00001000  0000000000af1000  0000000000af1000  00af2000  2**12
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .bss          00023078  0000000000af2000  0000000000af2000  00af3000  2**12
                  ALLOC
  7 .pgtable      00021000  0000000000b16000  0000000000b16000  00af3000  2**12
                  ALLOC
...

so we can't have a single '.data' section in PE covering both '.data'
and '.bss'/'.pgtable' as '.sbat' is in the middle and we want it to be a
separate section. If we try putting '.sbat' after '.bss' we are going to
get a hole size of '.bss' + '.pgtable' in arch/x86/boot/vmlinux.bin
because 'objcopy -O binary' is not going to squeeze anything (and it has
no idea what '.sbat' is and if it can be moved).

The problem is similar for zboot. I have two ideas:
1) Get back to the idea of putting '.sbat' between '.text' and '.data'
(was in my RFC). 

2) Introduce a separate '.bss' section to the PE binary, basically:

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..dae8202705c4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -197,7 +197,7 @@ pecompat_fstart:
                IMAGE_SCN_MEM_EXECUTE           # Characteristics
 
        .ascii  ".data\0\0\0"
-       .long   ZO__end - ZO__data              # VirtualSize
+       .long   ZO__edata - ZO__data            # VirtualSize
        .long   setup_size + ZO__data           # VirtualAddress
        .long   ZO__edata - ZO__data            # SizeOfRawData
        .long   setup_size + ZO__data           # PointerToRawData
@@ -207,6 +207,17 @@ pecompat_fstart:
                IMAGE_SCN_MEM_READ              | \
                IMAGE_SCN_MEM_WRITE             # Characteristics
 
+       .ascii  ".bss\0\0\0\0"
+       .long   ZO__end - ZO__edata             # VirtualSize
+       .long   setup_size + ZO__edata          # VirtualAddress
+       .long   0                               # SizeOfRawData
+       .long   0                               # PointerToRawData
+
+       .long   0, 0, 0
+       .long   IMAGE_SCN_CNT_UNINITIALIZED_DATA| \
+               IMAGE_SCN_MEM_READ              | \
+               IMAGE_SCN_MEM_WRITE             # Characteristics
+
        .set    section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */

This way '.data' doesn't need to be the last meaninful section in
'vmlinux' and we can then pub '.sbat' right after it. I'm going to give
it a try but also I'm wondering why do we have '.data' covering '.bss'
and '.pgtable' in the first place.

-- 
Vitaly



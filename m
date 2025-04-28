Return-Path: <linux-efi+bounces-3471-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BBA9EE6D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513F17AB423
	for <lists+linux-efi@lfdr.de>; Mon, 28 Apr 2025 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE58262FF8;
	Mon, 28 Apr 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLCyO42O"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6826280C
	for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837679; cv=none; b=NIuEKBeRThaolm9nmAVh9qmGUA3sDDWCtfCdBid2ShJ84TBuROV38SK1FSE88mK2gXyEGeHKO8xvLqA1dhEWV6GhZgKFqrVtmXATlxhtNGivXpwUiDC2FxWYWrQx8ZiUbkTacqjReu+Vh75uRzc+/NJKyj0jFfpWSjSHChCg1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837679; c=relaxed/simple;
	bh=Ecq6K4BNTHLRWyjIObZfoy2w/9GkEyRpkKtINHJ2CFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ucw1QQTUnw2d4hRyrgbeT4wY1dHzcPiRIdcxbfkZSu0PNEX14Gj2t1U1l5/2Zki33TVRVn2IGpdptTASo2s+I0pnbhels0SrfGgp2btBg9akIm6NJLaZObhMIossvwYUU8YbjP2dy7X2s4aOW01V9Fd6I31YCtDF/fzvtO0xz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLCyO42O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745837675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IEU2LSwAWutexi29Aw4e1+MJAP+WX/OVNnsZGRxNDw=;
	b=YLCyO42O+QmUNS/Nk6hei+HiVJRAVSBxQd5lVkypLDgqDf1JZwsf7MYy4RUBXkYKXt6Ia1
	Eq0zjcmnq8kXAsbJGAWy7RsMpJI0nyOoXTqaWVshvVkCHFqTtDpS0TRTkm9XBhgG0lzsff
	tf4F6ndiaCafutthWjwS5wg+kDVfMrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-JXJDcbS6MwSxBBS865g2gQ-1; Mon, 28 Apr 2025 06:54:31 -0400
X-MC-Unique: JXJDcbS6MwSxBBS865g2gQ-1
X-Mimecast-MFC-AGG-ID: JXJDcbS6MwSxBBS865g2gQ_1745837670
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so23959145e9.3
        for <linux-efi@vger.kernel.org>; Mon, 28 Apr 2025 03:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837670; x=1746442470;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IEU2LSwAWutexi29Aw4e1+MJAP+WX/OVNnsZGRxNDw=;
        b=SRE8oif5US0cw5dQblJ4voJoT5mZXfl8YG3vgHcrMJFR3W1Omow5w6LOfYClMLNZT1
         Tz/ILW26Wh+zr37UL13+URr8f6p8NfNCDhsDB+0unC24ICI0YYlT+E/sCYiQaj9wkgs6
         A7h50IwPBlquJRWByuX0br1ZDqvpBvU6sAAD69daZ2RC+XrK+CZYl6+RRLhCPUyzp3Xh
         8Av5xAQWYCRS+13Tb2i4i9kOXKsGuG5Pbnm22MejgOpI/wUdqSED6P8JXOBcVMLwvzk8
         uKFckJFHnzoqW36vKI3lN31DtLCudIrOb0VWRGNjUu16PkAle0opBaup9W5PIHScX3Uk
         ++ig==
X-Forwarded-Encrypted: i=1; AJvYcCVFFXG3vaZoEtEdbqTiqJ0bdZrKwxK6RUPYULZZBmKyQQflTVP80rvNXTSCt9zFTD9nCdTrknhAGVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhoznrc+qmAC/TUNMnEXzRAekLJjCCROjVXj6IjoUjMMJ/mpX7
	R8XCJEb2A0edyLpySsfgK6zklep48bJWrSD6JpIb9bOhLpTSB7DtebJNGzReFQKl6AcdUsyvNBS
	6daBVGqe/SU/91V8Z1xAVofbJWd8Kk/wEzq1fsYtLoxx1FQ1mmhzoMw4Kqg==
X-Gm-Gg: ASbGncteryTLMTPk4lV0VTP9SkU8Zak6zFOMz35DoQnOLVXSu9ITQsNlGmn7HnKnVIr
	hXtFEDrgS4dhwCr2JWJZ2HphYITaRqozixpTxOshhFnaY5mfGFrXdf9t7M/iB2UJEDrJ2frX3VB
	Iarb9Ntiqb20Vk9CnmcJRoENgmnfENac6EzwsJlqrpGOSiyqtpP7YjsDTJcdm4I58v4c9jMezK1
	4Pspqyhn2oVtCIDmc6AlMcxrzv1wHBDf3U8Zv2lE9TVjIWKI6ban5i4I0ASAZCbSyUnABMsS1BM
	8VS/a0k=
X-Received: by 2002:a05:600c:4e51:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-440ab79f582mr90565295e9.10.1745837670326;
        Mon, 28 Apr 2025 03:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWN38u2JhWDwqPy6JXuY84JTovfHFRGLcF3m5SfbosWG675z9E1F2DXDYB5118UF5AWfcjaA==
X-Received: by 2002:a05:600c:4e51:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-440ab79f582mr90565035e9.10.1745837669916;
        Mon, 28 Apr 2025 03:54:29 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46454sm10839008f8f.78.2025.04.28.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:54:29 -0700 (PDT)
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
Subject: Re: [PATCH 1/2] efi/libstub: zboot specific mechanism for embedding
 SBAT section
In-Reply-To: <CAMj1kXHqmOiNX_DH+8uSsTROzR+hgvZ5DyE=3wVE7-dQ+2BW=Q@mail.gmail.com>
References: <20250424080950.289864-1-vkuznets@redhat.com>
 <20250424080950.289864-2-vkuznets@redhat.com>
 <CAMj1kXHqmOiNX_DH+8uSsTROzR+hgvZ5DyE=3wVE7-dQ+2BW=Q@mail.gmail.com>
Date: Mon, 28 Apr 2025 12:54:27 +0200
Message-ID: <87o6wga74s.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> Hi Vitaly,
>

Ard, thanks for the review!

> On Thu, 24 Apr 2025 at 10:10, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
>> by introducing a generation-based technique. Compromised or vulnerable UEFI
>> binaries can be prevented from booting by bumping the minimal required
>> generation for the specific component in the bootloader. More information
>> on the SBAT can be obtained here:
>>
>> https://github.com/rhboot/shim/blob/main/SBAT.md
>>
>> Upstream Linux kernel does not currently participate in any way in SBAT as
>> there's no existing policy in how SBAT generation number should be
>> defined. Keep the status quo and provide a mechanism for distro vendors and
>> anyone else who signs their kernel for SecureBoot to include their own SBAT
>> data. This leaves the decision on the policy to the vendor. Basically, each
>> distro implementing SecureBoot today, will have an option to inject their
>> own SBAT data during kernel build and before it gets signed by their
>> SecureBoot CA. Different distro do not need to agree on the common SBAT
>> component names or generation numbers as each distro ships its own 'shim'
>> with their own 'vendor_cert'/'vendor_db'
>>
>> Implement support for embedding SBAT data for architectures using
>> zboot (arm64, loongarch, riscv). Build '.sbat' section along with libstub
>> so it can be reused by x86 implementation later.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/firmware/efi/Kconfig                | 25 +++++++++++++++++++++
>>  drivers/firmware/efi/libstub/Makefile       |  7 ++++++
>>  drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
>>  drivers/firmware/efi/libstub/sbat.S         |  7 ++++++
>>  drivers/firmware/efi/libstub/zboot-header.S | 14 ++++++++++++
>>  drivers/firmware/efi/libstub/zboot.lds      | 17 ++++++++++++++
>>  6 files changed, 72 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/firmware/efi/libstub/sbat.S
>>
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index 5fe61b9ab5f9..2edb0167ba49 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -281,6 +281,31 @@ config EFI_EMBEDDED_FIRMWARE
>>         bool
>>         select CRYPTO_LIB_SHA256
>>
>> +config EFI_SBAT
>> +       bool "Embed SBAT section in the kernel"
>> +       depends on EFI_ZBOOT
>> +       help
>> +         SBAT section provides a way to improve SecureBoot revocations of UEFI
>> +         binaries by introducing a generation-based mechanism. With SBAT, older
>> +         UEFI binaries can be prevented from booting by bumping the minimal
>> +         required generation for the specific component in the bootloader.
>> +
>> +         Note: SBAT information is distribution specific, i.e. the owner of the
>> +         signing SecureBoot certificate must define the SBAT policy. Linux
>> +         kernel upstream does not define SBAT components and their generations.
>> +
>> +         See https://github.com/rhboot/shim/blob/main/SBAT.md for the additional
>> +         details.
>> +
>> +         If unsure, say N.
>> +
>> +config EFI_SBAT_FILE
>> +       string "Embedded SBAT section file path"
>> +       depends on EFI_SBAT
>> +       help
>> +         Specify a file with SBAT data which is going to be embedded as '.sbat'
>> +         section into the kernel.
>> +
>
> Can we simplify this? CONFIG_EFI_SBAT makes no sense if
> CONFIG_EFI_SBAT_FILE is left empty. If you really need both symbols,
> set EFI_SBAT automatically based on whether EFI_SBAT_FILE is
> non-empty.

Sure, but FWIW, I modelled this after MODULE_SIG/MODULE_SIG_KEY and
BOOT_CONFIG_EMBED/BOOT_CONFIG_EMBED_FILE where the selection is also
2-step -- do you think EFI_SBAT/EFI_SBAT_FILE case is different?

>
>>  endmenu
>>
>>  config UEFI_CPER
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index d23a1b9fed75..5113cbdadf9a 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -105,6 +105,13 @@ lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
>>  extra-y                                := $(lib-y)
>>  lib-y                          := $(patsubst %.o,%.stub.o,$(lib-y))
>>
>> +extra-$(CONFIG_EFI_SBAT)       += sbat.o
>> +$(obj)/sbat.o: $(obj)/sbat.bin
>> +targets += sbat.bin
>> +filechk_sbat.bin = cat $(or $(real-prereqs), /dev/null)
>> +$(obj)/sbat.bin: $(CONFIG_EFI_SBAT_FILE) FORCE
>> +       $(call filechk,sbat.bin)
>> +
>
> Please get rid of all of this, and move the .incbin into
> zboot-header.S

The main prupose of this logic is to track possible sbat data
changes. E.g. if the file with SBAT data has changed, then we need to
rebuild the kernel binary. If we just use a raw 'incbin' somewhere and
don't add a specific Makefile dependency, then the logic will be lost.

I think I can drop the dedicated 'sbat.S' and use zboot-header.S but I'd
like to keep at least the 'filechk' part: we compare what's in
EFI_SBAT_FILE with 'sbat.bin' copy and, if things have changed, rebuild.

>
>
>>  # Even when -mbranch-protection=none is set, Clang will generate a
>>  # .note.gnu.property for code-less object files (like lib/ctype.c),
>>  # so work around this by explicitly removing the unwanted section.
>> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
>> index 48842b5c106b..3d2d0b326f7c 100644
>> --- a/drivers/firmware/efi/libstub/Makefile.zboot
>> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
>> @@ -44,7 +44,8 @@ AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE
>>  $(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
>>         $(call if_changed_rule,as_o_S)
>>
>> -ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
>> +ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a \
>> +          $(if $(CONFIG_EFI_SBAT),$(objtree)/drivers/firmware/efi/libstub/sbat.o)
>>
>
> Drop this too
>
>>  LDFLAGS_vmlinuz.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
>>  $(obj)/vmlinuz.efi.elf: $(obj)/vmlinuz.o $(ZBOOT_DEPS) FORCE
>> diff --git a/drivers/firmware/efi/libstub/sbat.S b/drivers/firmware/efi/libstub/sbat.S
>> new file mode 100644
>> index 000000000000..4e99a1bac794
>> --- /dev/null
>> +++ b/drivers/firmware/efi/libstub/sbat.S
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Embed SBAT data in the kernel.
>> + */
>> +       .pushsection ".sbat","a",@progbits
>> +       .incbin "drivers/firmware/efi/libstub/sbat.bin"
>> +       .popsection
>> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
>> index fb676ded47fa..f2df24504fc5 100644
>> --- a/drivers/firmware/efi/libstub/zboot-header.S
>> +++ b/drivers/firmware/efi/libstub/zboot-header.S
>> @@ -135,6 +135,20 @@ __efistub_efi_zboot_header:
>>                         IMAGE_SCN_MEM_READ | \
>>                         IMAGE_SCN_MEM_WRITE
>>
>> +#ifdef CONFIG_EFI_SBAT
>> +       .ascii          ".sbat\0\0\0"
>> +       .long           __sbat_size
>> +       .long           _edata - .Ldoshdr
>> +       .long           __sbat_size
>> +       .long           _edata - .Ldoshdr
>> +
>> +       .long           0, 0
>> +       .short          0, 0
>> +       .long           IMAGE_SCN_CNT_INITIALIZED_DATA | \
>> +                       IMAGE_SCN_MEM_READ | \
>> +                       IMAGE_SCN_MEM_DISCARDABLE
>
> You can put the pushsection/popsection right here.
>

Ok (but see my comment about Makefile magic above.


>> +#endif
>> +
>>         .set            .Lsection_count, (. - .Lsection_table) / 40
>>
>>  #ifdef PE_DLL_CHAR_EX
>> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
>> index 9ecc57ff5b45..2cd5015c70ce 100644
>> --- a/drivers/firmware/efi/libstub/zboot.lds
>> +++ b/drivers/firmware/efi/libstub/zboot.lds
>> @@ -31,10 +31,24 @@ SECTIONS
>>
>>         .data : ALIGN(4096) {
>>                 *(.data* .init.data*)
>> +#ifndef CONFIG_EFI_SBAT
>>                 _edata = ALIGN(512);
>> +#else
>> +               /* Avoid gap between '.data' and '.sbat' */
>> +               _edata = ALIGN(4096);
>> +#endif
>
> Just use 4096 in all cases.
>

Ok.

>>                 . = _edata;
>>         }
>>
>> +#ifdef CONFIG_EFI_SBAT
>> +        .sbat : ALIGN(4096) {
>> +               _sbat = . ;
>> +               *(.sbat)
>> +               _esbat = ALIGN(512);
>> +               . = _esbat;
>> +       }
>> +#endif
>> +
>>         .bss : {
>>                 *(.bss* .init.bss*)
>>                 _end = ALIGN(512);
>> @@ -52,3 +66,6 @@ PROVIDE(__efistub__gzdata_size =
>>
>>  PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
>>  PROVIDE(__data_size = ABSOLUTE(_end - _etext));
>> +#ifdef CONFIG_EFI_SBAT
>> +PROVIDE(__sbat_size = ABSOLUTE(_esbat - _sbat));
>> +#endif
>
> This can be unconditional - it is only evaluated when a reference to it exists.
>

Yes, it compiles well, I put #ifdef here mostly for documentational
purposes. Will drop.

>> --
>> 2.49.0
>>
>

-- 
Vitaly



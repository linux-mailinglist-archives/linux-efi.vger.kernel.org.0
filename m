Return-Path: <linux-efi+bounces-2569-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EDBA0937B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5161116628E
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DD210F7F;
	Fri, 10 Jan 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEBpeRUO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5538DD6;
	Fri, 10 Jan 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519479; cv=none; b=rPN/5XJOowV+doy/NYaVnEpYVQm3ZwIWwoBfgiLtj4471QUMxLICYlHGYb5oHgOv69YA0zr8CFTOyOgx1OLTF8PnMGnKiuFN/U/nYo/tDnY51R7mP7KAjc8m0X9vV9vjt8ZtAURY4X67KcFElHMLpzzRAb1CKpV7FRQ1EC55iRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519479; c=relaxed/simple;
	bh=VqYImBBiq5oIxryEvt1lWdvM1W93LUkvWVOgxPmsPh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjrpoOXLCbhQCp3VwZtrshTSX7xsy5KkLRhZuaR9WvLQFP9FkgPR0v92tWQjyR6aznd2iZ49L5CK6KfjSeG1st5p105r/O93wyHiFotXm8Cd4cXE0zivca1gYFBP8zC4UXh39tXO4K7++p0VumTmeVRgoa5zpPY2dPhvypecZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEBpeRUO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so21249305e9.1;
        Fri, 10 Jan 2025 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736519476; x=1737124276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjnAZo6ruk1OKuFWATcJolJe2qu441fKWg1k8R351yw=;
        b=EEBpeRUORn9bDFjYGL0G1MN2Re0aWv4q9Qtdmorofi0IEzgEbiRdKiY4g6rEszfLY5
         zNwwrzLuZPl9wOOkzTUUtGOHIz7XKz7hZh2L/8Bgme3GkCTeWSJTAwNxuUMmk8gUlxpR
         jZAJcu8uvGlikgWrvlLsz2u6WME1ZQwFCpny5ZzWzaKlsUnz4kAaWZSDTih74TXPDmmm
         T6K/aVIrnXh2l4mg/E1+mg8B2yBEvclhJMeP2LevTO6sGaxFhjGM3v1mIuTV+yzVUL3K
         QDyEo05fVrLCUH8BL/GGxWnF53XwbwpUr7tujjF75pVJT8EI71xlzKEg9rPDHajXJTrU
         P2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519476; x=1737124276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjnAZo6ruk1OKuFWATcJolJe2qu441fKWg1k8R351yw=;
        b=G9J+7fQbDHPzsWGGMSZreujEe0mrt8w5LCEKOhrGvb8WsN0lId3N7fgMlvEv4PeMmj
         xSA4S+9i3a9o4T7ClPHFKwfPO/tj3YBrM4IZ9V7r87k4KwXb0q9/I+f6p6JzGj+wp4AM
         v1UkvrQck8LThBmT5O8l3bLQ1176MnzkKNkmTErkV8XPtNO0aJWf8mQMDL350GfR+vbJ
         FkDqXOgjvjGBA4UMZu/qx5Jb4cXhwQzQAfbxOptSaz/odta5T3oOxQ/bdq4BVR9zmbbC
         wWIKX0jZofPnSJfgG2sI2IcZqACKUyV2sxsDw87AvK4JvfAjzHx39m/zjOQ65I4cXMUQ
         dx9A==
X-Forwarded-Encrypted: i=1; AJvYcCVOxdIbyslanVyE9Tpi0yvGnuxBW286oW1UN3t95rIZO/eBqYDtn+457Cm6n3gZJhhbz5qXpOBqGtG62Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aLDzUS6/Ph2EUAe+SXTKNgR7bbekwiSQxtlr8TbLOG1icAMq
	xakC5uOkcZ9ugsLQ3HsEv8QOMbe5J3r8lV3Mj2x38p/QsemnyIzO
X-Gm-Gg: ASbGncsOzFJrFj/Os+QtZtyJ+roiJSIls329gEjZyq+Wb7tml/9BHXwv6vlUCgITebm
	m40A2yrB9qvau0HISo50SJ+icuLccA4okE6X5kzFUbsz4SZx/LV/LkrjNdzIcPXdSvRCVtF6dql
	NFDHg3X0SgC7rQAfTK0cl3Ch6eiLNov+fhKY2EkYvcYxe/6ONukhHrNprZZt+QnMPd5iebGfL0i
	WhCd/s50+IOU5cCjH2d+H5WaczCuhyrAcuF2hI1gzEwMFQCwgfrV0aLNWf14rPbkISODlfQVJGx
	alDOjVtANeKDfQpVnojRZKmYgSc9chXToxqdanNRbGPs5XI3oA==
X-Google-Smtp-Source: AGHT+IGq00rhLc0Ylg2NuJdsWT9ahGisN7BbjecTv7ITNG64U9Bb1M/Ufx7fRwM6+4l70m96C3vDSA==
X-Received: by 2002:a05:600c:3551:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-436e26c3c34mr99055335e9.8.1736519475604;
        Fri, 10 Jan 2025 06:31:15 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc860bsm54386535e9.9.2025.01.10.06.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 06:31:15 -0800 (PST)
Message-ID: <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Date: Fri, 10 Jan 2025 14:31:14 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
 <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/01/2025 07:32, Ard Biesheuvel wrote:
> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 09/01/2025 16:15, Ard Biesheuvel wrote:

>> I think in the end whoevers' responsibility it is, the easiest path forward
>> seems to be in kernel? (and not firmware or libstub)
>>
> 
> Agreed. But as I pointed out in the other thread, the memory
> attributes table only augments the memory map with permission
> information, and can be disregarded, and given how badly we mangle the
> memory map on x86, maybe this is the right choice here.
> 
>>>
>>>> The next ideal place would be in libstub. However, it looks like
>>>> InstallMemoryAttributesTable [2] is not available as a boot service
>>>> call option [3], [4], and install_configuration_table does not
>>>> seem to work as a valid substitute.
>>>>
>>>
>>> To do what, exactly?
>>>
>>
>> To change the memory type from System RAM to either reserved or
>> something more appropriate, i.e. any type that is not touched by
>> kexec or any other userspace.
>>
>> Basically the example code I attached at the end of the cover letter in
>> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
>> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
>> touched by kexec.
>>
> 
> This is a kexec problem (on x86 only) so let's fix it there.


I don't believe we can accurately tell if we are booting from a cold boot or kexec.
There is bootloader_type available for x86, but not sure if we should rely on
that. I think a way forward would be to move it behind a Kconfig option, something like
below, which defaults to n for x86. Anyone who needs it can enable it. What do you think?


diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index aa95f77d7a30..31deb0a5371e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -83,7 +83,9 @@ static const unsigned long * const efi_tables[] = {
        &efi_config_table,
        &efi.esrt,
        &prop_phys,
+#ifdef CONFIG_EFI_MEMATTR
        &efi_mem_attr_table,
+#endif
 #ifdef CONFIG_EFI_RCI2_TABLE
        &rci2_table_phys,
 #endif
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 72f2537d90ca..b8ecb318768c 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -287,6 +287,13 @@ config EFI_EMBEDDED_FIRMWARE
        bool
        select CRYPTO_LIB_SHA256
 
+config EFI_MEMATTR
+       bool "EFI Memory attributes table"
+       default n if X86_64
+       help
+          EFI Memory Attributes table describes memory protections that may
+          be applied to the EFI Runtime code and data regions by the kernel.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0..c593ec0d9940 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -11,7 +11,9 @@
 KASAN_SANITIZE_runtime-wrappers.o      := n
 
 obj-$(CONFIG_ACPI_BGRT)                += efi-bgrt.o
-obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o memattr.o tpm.o
+obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o tpm.o
+obj-$(CONFIG_EFI_MEMATTR)              += memattr.o
+
 obj-$(CONFIG_EFI)                      += memmap.o
 ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)                      += capsule.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdf07dd6f459..f359179083d5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -596,7 +596,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
        {SMBIOS_TABLE_GUID,                     &efi.smbios,            "SMBIOS"        },
        {SMBIOS3_TABLE_GUID,                    &efi.smbios3,           "SMBIOS 3.0"    },
        {EFI_SYSTEM_RESOURCE_TABLE_GUID,        &efi.esrt,              "ESRT"          },
+#ifdef CONFIG_EFI_MEMATTR
        {EFI_MEMORY_ATTRIBUTES_TABLE_GUID,      &efi_mem_attr_table,    "MEMATTR"       },
+#endif
        {LINUX_EFI_RANDOM_SEED_TABLE_GUID,      &efi_rng_seed,          "RNG"           },
        {LINUX_EFI_TPM_EVENT_LOG_GUID,          &efi.tpm_log,           "TPMEventLog"   },
        {EFI_TCG2_FINAL_EVENTS_TABLE_GUID,      &efi.tpm_final_log,     "TPMFinalLog"   },
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9c239cdff771..4cf5ebe014e2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -783,9 +783,21 @@ extern unsigned long efi_mem_attr_table;
  */
 typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
+#ifdef CONFIG_EFI_MEMATTR
 extern int efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
                                         efi_memattr_perm_setter fn);
+#else
+static inline int efi_memattr_init(void)
+{
+       return 0;
+}
+static inline int efi_memattr_apply_permissions(struct mm_struct *mm,
+                                        efi_memattr_perm_setter fn)
+{
+       return 0;
+}
+#endif
 
 /*
  * efi_memdesc_ptr - get the n-th EFI memmap descriptor


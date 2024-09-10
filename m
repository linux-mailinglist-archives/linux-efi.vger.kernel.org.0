Return-Path: <linux-efi+bounces-1694-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B403973CA0
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0A52832BF
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7622AE69;
	Tue, 10 Sep 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6mRjreM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D118EFE2
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983181; cv=none; b=m43WNmhCUOmAwgvLKt/b8pZjFIw0Jm3m9vIE4XBMIfHPSuma35FJZ1ssC/2TXWUCH6hxyNEiTK/+gi4VnPPx8fG5gLX/fI2u2wpnPXmLmcN3NzlgaJwa19nPfx68/4DgHzy7XwXehhtu2p6pHwV1PsJIoGhN2XvvwwXi0C8yYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983181; c=relaxed/simple;
	bh=Lm1J0jBmzxpiMr4BGogglqDpUPxkyIWoY72JU4lUZX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5DgLLDQ9/IZ6GzcEVgIov9RPLqNelBk5Hlj1+TmFLomKgC1p3lny+dGjLrimi28KrVr5Ni5PswigKQhQPgezWoe4cG6uH7ejW7gqVvHnV+nj7Zs35mgb4D4tlKfXLlwlY+mpDqCr5We1FIymlt6Qu9y6FmwWQPteC3iJYRw2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6mRjreM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so6279864a12.2
        for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725983177; x=1726587977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5hE1fXxYGteGDXTL1cL2butIFPQq/2aSEB57x6JcN4=;
        b=T6mRjreMZ3Ctr9Q1xjTo+CNHimsfzZZ7haUXcmh0L3m9S/VNwOerrMryXY3UxznjUq
         z6nunDRw99lJN2tQPUXYH6t8GjvT7AuDaU9ULzTLKkqdvseB0HkBIMDK7haiDoeOIATg
         mPceCvuMl0NIAx2tAIhy1vvZltHkc0eDodob3gbDyaIs/8imfhSDEqFkQZnVp7KygMZb
         zYFM7X9ElEIAEJ1iyJNpqcj8O0wRPm1iei6k1fGn7df1GI3xO3RkgyuGI6Sw7jXfUFoG
         K95vtV/A3NVA83ZUL8dOq1TfE8XceXHiuazE2IukU0qPUgHGpUAbaLV0qti4aJWtonqC
         DfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983177; x=1726587977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5hE1fXxYGteGDXTL1cL2butIFPQq/2aSEB57x6JcN4=;
        b=JlEJJg0tqH4T0t0oZVN/IXRtfm9CL4i63TQ7XMPaA1EZM6qq0NU4u78Nky4AoUdoSo
         fzZVYe3SbCqfNlfxVKr5E+Tj+VrySAf0MdR0F9zcdOZybA38d5Sa0zVghkr+0Q8v1Yjv
         AkLzI4WV2jnsulImnhosrSxiMewmBYM6h4Ds6aaBSmvVvDUaQY28nhHFBeElISLgFyez
         jZAf/udLoCBrwqu6wMv+ECVt7Emm4m7qePg96ez+MJPO6F17JqGnlIdriBVIzcmXtMJw
         sc1XLlQgWG/mwT0RPft3hGrw51pE6nn+4/vTN9xn3GxjHmHeVNNco8z2gogBLjvneRoV
         Rw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxBx65WoNGvovXmhQ1s4dsr48Z7EC4Im+pas16HVPVPRwD88sXKW8kdl0NdgxOGSX/KxggPOzC8BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVpaZWnWkMF+I0A7gJpKUCNzA0DqL3JlEhatA50Ce9Unk8SyQ
	3nYL2pby7zmxfyo71LFS56rj41afMetZYQESik3VmZSflrivjlx6
X-Google-Smtp-Source: AGHT+IFMQLfuXiiliWsCtziJxd30hsALblQ4GT8eOdoksyoOUVS3BwT/NFM4Vc0jDrzrMCc3oZ9Mpw==
X-Received: by 2002:a05:6402:5203:b0:5c2:6e51:9d22 with SMTP id 4fb4d7f45d1cf-5c3dc7bd575mr10172025a12.25.1725983176535;
        Tue, 10 Sep 2024 08:46:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61d8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41cd7sm4422605a12.3.2024.09.10.08.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 08:46:16 -0700 (PDT)
Message-ID: <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
Date: Tue, 10 Sep 2024 16:46:15 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFI table being corrupted during Kexec
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Breno Leitao <leitao@debian.org>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io, rppt@kernel.org,
 gourry@gourry.net, rmikey@meta.com, tglx@linutronix.de
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/09/2024 15:26, Eric W. Biederman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> We've seen a problem in upstream kernel kexec, where a EFI TPM log event table
>> is being overwritten.  This problem happen on real machine, as well as in a
>> recent EDK2 qemu VM.
>>
>> Digging deep, the table is being overwritten during kexec, more precisely when
>> relocating kernel (relocate_kernel() function).
>>
>> I've also found that the table is being properly reserved using
>> memblock_reserve() early in the boot, and that range gets overwritten later in
>> by relocate_kernel(). In other words, kexec is overwriting a memory that was
>> previously reserved (as memblock_reserve()).
>>
>> Usama found that kexec only honours memory reservations from /sys/firmware/memmap
>> which comes from e820_table_firmware table.
>>
>> Looking at the TPM spec, I found the following part:
>>
>> 	If the ACPI TPM2 table contains the address and size of the Platform Firmware TCG log,
>> 	firmware “pins” the memory associated with the Platform Firmware TCG log, and reports
>> 	this memory as “Reserved” memory via the INT 15h/E820 interface.
>>
>>
>> From: https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>>
>> I am wondering if that memory region/range should be part of e820 table that is
>> passed by EFI firmware to kernel, and if it is not passed (as it is not being
>> passed today), then the kernel doesn't need to respect it, and it is free to
>> overwrite (as it does today). In other words, this is a firmware bug and not a
>> kernel bug.
>>
>> Am I missing something?
> 
> I agree that this appears to be a firmware bug.  This memory is reserved
> in one location and not in another location.
> 
> That said that doesn't mean we can't deal with it in the kernel.
> acpi_table_upgrade seems to have hit a similar issue issue and calls
> arch_reserve_mem_area to reserve the area in the e820tables.
> 
> 
> The last time I looked the e820 tables (in the kernel) are used to store
> the efi memory map when available and only use the true e820 data on
> older systems.
> 
> Which is a long way of say that the e820 table in the kernel last I
> looked was the master table, of how the firmware views the memory.
> 
> 
> As I recall the memblock allocator is the bootstrap memory allocator
> used when bringing up the kernel.  So I don't see reserving something
> in the memblock allocator as being authoritative as to how the firmware
> has setup memory.
> 
> 
m> 
> I would suggest writing a patch to update whatever is calling
> memblock_reserve to also, or perhaps in preference to update the e820
> map.  If the code is not x86 specific I would suggest using ACPI's
> arch_reserve_mem_area call.
> 

So I believe arch_reserve_mem_area is unfortunately not enough. It updates
e820_table, but kexec seems to use e820_table_firmware. I believe the proper
fix should be in efi firmware, which might be a bit difficult to get through. 

But with the below secondary fix in kernel, the corruption is gone, it would be
good to have efi, tpm and kexec experts to look at this and tell if it makes sense?

Thanks!
Usama


From cd8a9a8b5903fa86f4f76a250fd48bc2abfb13d6 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Tue, 10 Sep 2024 16:14:38 +0100
Subject: [PATCH] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Looking at the TPM spec [1]

If the ACPI TPM2 table contains the address and size of the Platform
Firmware TCG log, firmware “pins” the memory associated with the
Platform FirmwareTCG log, and reports this memory as “Reserved” memory
via the INT 15h/E820 interface.

It looks like the firmware should pass this as reserved in e820 memory
map. However, it doesn't seem to. The firmware being tested on is:
dmidecode -s bios-version
edk2-20240214-2.el9

When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where efi.tpm_log
is and overwrite it and relocate_kernel.

Having a fix in firmware can be difficult to get through. As a secondary fix,
this patch marks that region as reserved in e820_table_firmware so that
kexec doesn't use it for kernel segments.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/e820.c          | 6 ++++++
 arch/x86/platform/efi/efi.c     | 6 ++++++
 drivers/firmware/efi/tpm.c      | 5 +++--
 include/linux/efi.h             | 7 +++++++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..4e9aa24f03bd 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+					enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..912400161623 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
 	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
+u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
+}
+
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 88a96816de9a..644c5da8fb39 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -171,6 +171,12 @@ static void __init do_add_efi_memmap(void)
 	e820__update_table(e820_table);
 }
 
+void arch_update_firmware_area(u64 addr, u64 size)
+{
+	e820__range_update_firmware(efi.tpm_log, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+	e820__update_table(e820_table_firmware);
+}
+
 /*
  * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3..787c5a206010 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -60,7 +60,9 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
+	if (!memblock_reserve(efi.tpm_log, tbl_size)) {
+		arch_update_firmware_area(efi.tpm_log, tbl_size);
+	}
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
@@ -107,4 +109,3 @@ int __init efi_tpm_eventlog_init(void)
 	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return ret;
 }
-
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6bf3c4fe8511..9c239cdff771 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1371,4 +1371,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
+#ifdef CONFIG_X86_64
+void __init arch_update_firmware_area(u64 addr, u64 size);
+#else
+static inline void __init arch_update_firmware_area(u64 addr, u64 size)
+{
+}
+#endif
 #endif /* _LINUX_EFI_H */
-- 
2.43.5





Return-Path: <linux-efi+bounces-1704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A79766A7
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285F81C2305C
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E619EEA1;
	Thu, 12 Sep 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5jTyvct"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7D19E96F;
	Thu, 12 Sep 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136636; cv=none; b=IVEogKfFsbDhU6Jb/AE7vibYWWaeIVPl8Xs/whKXB36NBLf4Z64kB0taUc7sQyIFTuITslWVLees2+ISqenRshseQAkbP9XkZlVCWzADo+FKTvJmNJdozKgHj1CuAaJu5NGCmBpesQJZg6mxu0CHjPZgzjOkdDycAXj41nKL8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136636; c=relaxed/simple;
	bh=emKy+x/LCTxK24M5T1QegNnB9ZmFdnwXpAtqtoQHiEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWLlmLlzLZMZMImpG7ZZKxu4ulLkb+kaIv/BpWrKbqF212eG+7d9xcS4AlCBLu02qDDZd+0/O2ranao9WQxnbstaRVhv9xIjZffYErMQpKAMDmrhF/C6iBpX3XaidbAaOxSMI0HwHYUbI8vVYuYh0UUpEa4TPOvJJomwG4n9+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5jTyvct; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so898749e87.3;
        Thu, 12 Sep 2024 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726136633; x=1726741433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FN9wRqtITC+cR2Xh4csoxXgF4O10cCi7vtuSZOuSwSE=;
        b=C5jTyvctYxzMnf/uPtv6B67jejm/wlVL6luuCHVEW8ctIwDkwMLYTe+iKpWC1RaEGV
         ru9CsR2St3EZDoNipInoT1qe3pM45igy8QNCpQH+BrPR1CmOlnQZtcGobvHqqPvEWUzJ
         Pu2C8D9UhspuXYo6kJAbOXnkQop1Z+dXxUdzq1Z350Yez+/4nXbdL/sHxcW3CUc/odnE
         JVhWpzVK50RSTmbwy3mdKEsdjI5leYGrhojBFI1JmvHASpoZV8odtuHJ9QDNCVjqy2Kv
         bHQOsvTngs66AiFc69m+Ma3XAoCLFa2mGCQzXZmVyDwb7JMRYo3ntaaePmWeovQGGQwv
         k5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136633; x=1726741433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FN9wRqtITC+cR2Xh4csoxXgF4O10cCi7vtuSZOuSwSE=;
        b=WOn/HGfQfAjLZgVsJV5HnRoGOQQvwsKbTkSC3PTH7CnEZMCOk7sFfqBmukpc4NSO3M
         Kb/iTXHqahZVsB9wId7vn0Vy7+km6ajQAFomv0LvlTRDudOwQ1KDla7qSLzSjdepODfb
         grkt/q2gXGqELlPtM3tOzB4L6qIAWWDnm1c05KWgv2mt5VcKsCBDDPucKOTrXTKlxMvu
         zPDVYg191lSps3EJ3lvtCc/UBz/8kz8oYflPmEBdBJkbVBjmVoVgWlbgFYEx+uHhnYmH
         JFwx8phYHk9ucsjz0aMlJkuOtUOODf7OiTC58f74M8/Mr2ixbWRtmE5fRqkWAzKt7/bJ
         As5w==
X-Forwarded-Encrypted: i=1; AJvYcCV2QAlc9hT0bTlNpx0r0JyMFYM1W/Zdy70y8xjOQPLHFkht8H/EA8lEBJ+b8T0Oe1lsdX0OncmrGG7H+1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGueOq1HbErL0I92jnutIMEKtoS3mXTFZMgSPEhR0tOydZD8E
	t83cV4qvgWg9OAa1A3hrqzSkX3F8gOpFpErPKdJ1uAW/4ya67fdz
X-Google-Smtp-Source: AGHT+IFa35XUhJrsBIbKs/6bDUMZLDX4vSRLwnoncaj96m4x4j01vqAUVJlH4IxnJhx8zNcUrZa2ug==
X-Received: by 2002:a05:6512:4017:b0:52e:be50:9c66 with SMTP id 2adb3069b0e04-53678ff5e62mr1284185e87.53.1726136631811;
        Thu, 12 Sep 2024 03:23:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258339dasm730477266b.38.2024.09.12.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:23:51 -0700 (PDT)
Message-ID: <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
Date: Thu, 12 Sep 2024 11:23:50 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 rmikey@meta.com, gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/09/2024 12:51, Ard Biesheuvel wrote:
> On Wed, 11 Sept 2024 at 12:41, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> Looking at the TPM spec [1]
>>
>> If the ACPI TPM2 table contains the address and size of the Platform
>> Firmware TCG log, firmware “pins” the memory associated with the
>> Platform FirmwareTCG log, and reports this memory as “Reserved” memory
>> via the INT 15h/E820 interface.
>>
>> It looks like the firmware should pass this as reserved in e820 memory
>> map. However, it doesn't seem to. The firmware being tested on is:
>> dmidecode -s bios-version
>> edk2-20240214-2.el9
>>
>> When this area is not reserved, it comes up as usable in
>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>> to find usable memory regions, can select the region where efi.tpm_log
>> is and overwrite it and relocate_kernel.
>>
>> Having a fix in firmware can be difficult to get through. As a secondary
>> fix, this patch marks that region as reserved in e820_table_firmware if it
>> is currently E820_TYPE_RAM so that kexec doesn't use it for kernel segments.
>>
>> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> 
> I would expect the EFI memory map to E820 conversion implemented in
> the EFI stub to take care of this.
> 

So I have been making a prototype with EFI stub, and the unfinished version is looking like a
horrible hack.

The only way to do this in libstub is to pass log_tbl all the way from efi_retrieve_tcg2_eventlog
to efi_stub_entry and from there to setup_e820.
While going through the efi memory map and converting it to e820 table in setup_e820, you have to check
if log_tbl falls in any of the ranges and if the range is E820_TYPE_RAM. If that condition is satisfied,
then you have to split that range into 3. i.e. the E820_TYPE_RAM range before tpm_log, the tpm_log 
E820_TYPE_RESERVED range, and the E820_TYPE_RAM range after. There are no helper functions, so this
splitting involves playing with a lot of pointers, and it looks quite ugly. I believe doing this
way is more likely to introduce bugs.

If we are having to compensate for an EFI bug, would it make sense to do it in the way done
in RFC and do it in kernel rather than libstub? It is simple and very likely to be bug free.

Thanks,
Usama

> If you are not booting via the EFI stub, the bootloader is performing
> this conversion, and so it should be done there instead.
> 
> 
>> ---
>>  arch/x86/include/asm/e820/api.h | 2 ++
>>  arch/x86/kernel/e820.c          | 6 ++++++
>>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>>  drivers/firmware/efi/tpm.c      | 2 +-
>>  include/linux/efi.h             | 7 +++++++
>>  5 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
>> index 2e74a7f0e935..4e9aa24f03bd 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>>
>>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                       enum e820_type new_type);
>>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 4893d30ce438..912400161623 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
>>         return __e820__range_update(t, start, size, old_type, new_type);
>>  }
>>
>> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
>> +                                      enum e820_type new_type)
>> +{
>> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
>> +}
>> +
>>  /* Remove a range of memory from the E820 table: */
>>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>>  {
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index 88a96816de9a..aa95f77d7a30 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -171,6 +171,15 @@ static void __init do_add_efi_memmap(void)
>>         e820__update_table(e820_table);
>>  }
>>
>> +/* Reserve firmware area if it was marked as RAM */
>> +void arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
>> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
>> +               e820__update_table(e820_table_firmware);
>> +       }
>> +}
>> +
>>  /*
>>   * Given add_efi_memmap defaults to 0 and there is no alternative
>>   * e820 mechanism for soft-reserved memory, import the full EFI memory
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index e8d69bd548f3..8e6e7131d718 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -60,6 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>>         }
>>
>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
>> +       arch_update_firmware_area(efi.tpm_log, tbl_size);
>>         memblock_reserve(efi.tpm_log, tbl_size);
>>
>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>> @@ -107,4 +108,3 @@ int __init efi_tpm_eventlog_init(void)
>>         early_memunmap(log_tbl, sizeof(*log_tbl));
>>         return ret;
>>  }
>> -
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index 6bf3c4fe8511..9c239cdff771 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -1371,4 +1371,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
>>  void efivars_generic_ops_register(void);
>>  void efivars_generic_ops_unregister(void);
>>
>> +#ifdef CONFIG_X86_64
>> +void __init arch_update_firmware_area(u64 addr, u64 size);
>> +#else
>> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
>> +{
>> +}
>> +#endif
>>  #endif /* _LINUX_EFI_H */
>> --
>> 2.43.5
>>



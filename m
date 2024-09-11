Return-Path: <linux-efi+bounces-1703-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26097558E
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C0A1C239AC
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1361A2C04;
	Wed, 11 Sep 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBv4niLt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4891E480;
	Wed, 11 Sep 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065261; cv=none; b=HOSyf8csK4ZcZktNPMxO73Uu7wkVopPrTIaJOIIOG4k2hUG3USKoo+w5NaI6Q0viXBvODt3MLi1Ebhe1f5OYUJht940V9Au2iUEETIx8n3nWTX1XRPwJBTD6/tb8HVcMyAjrxp4TFDvK/Sp3IR+JbgzW6Bb0Qen7CyrhJ9FH7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065261; c=relaxed/simple;
	bh=xh4N9tjYPgEuL0hGhP9iu7zhPjV6H+Rgo4J2fq1SfcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns99MZhAdvp7jgjenNZxlO163F9O1hRY7JIO4ztvwWaRLpgYZW3flWbdYL0Wp4qQVjTQl63MYVDHoiXRwYWacUVgOEVlLf1bzpdqFGvYrt7lMPBBL5zdkWktuzqYjbrDYa59TXKfAUzZorhZn4THOa4qBsSA18S82FwbUncTuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBv4niLt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so196402066b.1;
        Wed, 11 Sep 2024 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726065258; x=1726670058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVTuE5Ad6zPah/b8EIl3uFAmdBpE4CYkodOUlKK/R9c=;
        b=iBv4niLt/9xwAWU7+fWwQQdanaB9OBhFOrwbrl5rvaMMYxDZqX9slPCBDG5hLPExYp
         Kzjj8sM0Hn9ChWpmtOyrByrPSEXn0fnfCZ/OZMMUfVyeTBdBjraBW8uLpX5z+6zW8jcb
         hw8oQxkbkqOHoFGwnEeE8EKf1qO9KNad+gEFmW40b2/f8a0W7qMY6RC2Y1PEDZGJ/Fvo
         DYiaJxXLdykQGHnP3MNtm5pMYG3Pce7f0v1EI04LogIlB44kfHdJYNBJFQdtSs5WIm2a
         9lSnFxYpD9FW+m8dd/9MO+f9gk8AAhPHbotSiSn99UHDxYaq0NHnVuwJa8Mgh8TqzQk+
         3neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065258; x=1726670058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVTuE5Ad6zPah/b8EIl3uFAmdBpE4CYkodOUlKK/R9c=;
        b=iKpEnvi72yNNUBZeEpdTPYaPRQi1q3AGxt2i8KYKMorNzomV/Jk/catabxzB3Iznku
         2/S7GkpV+wAzl9T+R04rAP+3maWdq4Hf3Po3P+TJ3DfFYssa08HvH+E0+2MV9dBkkzH6
         /Y8cktNE08iYmBXeSbiIuOnbCgBB3gaJKNNteiMWEqT9bp3E2NUN7z6WCPFPK19Mld6X
         1nXiQPgB+uR1ppOxjGKnBdEvw1UE7q+BUvsomLmT9FXuEjibdDyIaoZlMmewK2FfJTlM
         IxxEGMWGFHC9lu11I0GibvVHDcmEI+dXT4waTmpmwJyN5K+bVomKCb2b6zyzrLtuF0jr
         P0yA==
X-Forwarded-Encrypted: i=1; AJvYcCWNrUf0Eg//6Kb2Pd3o3KjA/YmyublOSNbJfwLzej7bdAPqnC5e1+oNsGS1E3y0g9coG6T5LMCvxubXpp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwa08sxpquD4SjF8Z2wtehreox68E36b8qq7bZ7bFYp1i0Oxy
	lh6d4YQ5xjhjkvL18jwnnd7zpPAeW+mCVr3l504YGvXzkUCOZdOj
X-Google-Smtp-Source: AGHT+IFWvH0mfTXi2x5OaLKLnSmNiGDqfGOGOCka3ud/AYA498nx/U9l4CG0TQPaUla3tH3QYSfjGQ==
X-Received: by 2002:a17:906:4fce:b0:a8d:6a35:5091 with SMTP id a640c23a62f3a-a8ffaac0a52mr483464966b.1.1726065256856;
        Wed, 11 Sep 2024 07:34:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:aa41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c7286esm613294166b.138.2024.09.11.07.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 07:34:16 -0700 (PDT)
Message-ID: <c80603d1-4604-486c-bd18-ccd4afaba57e@gmail.com>
Date: Wed, 11 Sep 2024 15:34:15 +0100
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
Forgot to add:

Reported-by: Breno Leitao <leitao@debian.org>

> 
> I would expect the EFI memory map to E820 conversion implemented in
> the EFI stub to take care of this.
> 
> If you are not booting via the EFI stub, the bootloader is performing
> this conversion, and so it should be done there instead.
> 
I will look into this and report back.
Thanks

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



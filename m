Return-Path: <linux-efi+bounces-2332-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD19E9C76
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98A9167CB0
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27451150980;
	Mon,  9 Dec 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JKoKI8Xk"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA8314F9F8;
	Mon,  9 Dec 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763753; cv=none; b=tAMCC9xAw7krQUWWTdkFhPfaWcuNrX4M1a6AghhkHncL9Ya1nd1qo7+SLBrGXi6L8MqYgxLY1XnIeH8CkKh5cxkcu+HbLvscBGahG1/9llTwCbidt64MPWOOLYULO4qRbMpQNlyIn6Pwy0sdrFMt+ejJUZEcIE5lWkVBkKa83Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763753; c=relaxed/simple;
	bh=TgECz1ImA/rmKbcmW5GPn4At4ClQAqIrMHIpuT+dGaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERpQf8dD6uGDAUGYvP308/meD6Kwe9NjnsaBmLKPSIyS1JcXnvQc93X2h7f+Db4whoqjtkVD2Lur9EBIxdimeRUMf52iedzh2oDuj7XhHBUbNSxThzOY26xCAAaJgBZs8WHTN8eHsHFWRNBz+zvaf5eblYSw9KlIapJgHLy04Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JKoKI8Xk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.2.246] (unknown [70.49.166.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76CBF20ACD6A;
	Mon,  9 Dec 2024 09:02:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76CBF20ACD6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733763745;
	bh=1BVACcjTRKyUgpLPUdy/K7pIzmBSCoBv7TYoN90iukg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JKoKI8XkKzqZ/roYeTuGzSk9glgde3ri7vboDZbRFtqKy1un6mkxlsuU1STk8uiW1
	 axyqTaZgaBcgszLuuKH4W54jvSYh6UB4icrKmtXT0gIGNBcXfcDUsp9+ubCrgUuxpg
	 6HPAb9+A2nYqqe8fB1o0PyN6QCG5K76p/JfYa3PY=
Message-ID: <380bbf4b-0828-444e-9b93-fa639cc23a1a@linux.microsoft.com>
Date: Mon, 9 Dec 2024 12:02:13 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: make the min and max mmap slack slots configurable
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, stable@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Brian Nguyen <nguyenbrian@microsoft.com>,
 Jacob Pan <panj@microsoft.com>, Allen Pais <apais@microsoft.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>,
 Kees Cook <kees@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Yuntao Wang <ytcoode@gmail.com>, Aditya Garg <gargaditya08@live.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241209162449.48390-1-hamzamahfooz@linux.microsoft.com>
 <CAMj1kXF=f-QAhXJA=U=jbn++Vyzf+e2k+cCS+Jk4Om4p0puD5Q@mail.gmail.com>
Content-Language: en-US
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
In-Reply-To: <CAMj1kXF=f-QAhXJA=U=jbn++Vyzf+e2k+cCS+Jk4Om4p0puD5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ard,

On 12/9/24 11:40, Ard Biesheuvel wrote:
> Hello Hamza,
> 
> Thanks for the patch.
> 
> On Mon, 9 Dec 2024 at 17:25, Hamza Mahfooz
> <hamzamahfooz@linux.microsoft.com> wrote:
>>
>> Recent platforms
> 
> Which platforms are you referring to here?

Grace Blackwell 200 in particular.

> 
>> require more slack slots than the current value of
>> EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. So, introduce
>> EFI_MIN_NR_MMAP_SLACK_SLOTS and EFI_MAX_NR_MMAP_SLACK_SLOTS
>> and use them to determine a number of slots that the platform
>> is willing to accept.
>>
> 
> What does 'acceptance' mean in this case?

Not having allocate_pool() return EFI_BUFFER_TOO_SMALL.

> 
>> Cc: stable@vger.kernel.org
>> Cc: Tyler Hicks <code@tyhicks.com>
>> Tested-by: Brian Nguyen <nguyenbrian@microsoft.com>
>> Tested-by: Jacob Pan <panj@microsoft.com>
>> Reviewed-by: Allen Pais <apais@microsoft.com>
> 
> I appreciate the effort of your colleagues, but if these
> tested/reviewed-bys were not given on an open list, they are
> meaningless, and I am going to drop them unless the people in question
> reply to this thread.
> 
>> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>> ---
>>  drivers/firmware/efi/Kconfig                  | 23 +++++++++++++++++
>>  .../firmware/efi/libstub/efi-stub-helper.c    |  2 +-
>>  drivers/firmware/efi/libstub/efistub.h        | 15 +----------
>>  drivers/firmware/efi/libstub/kaslr.c          |  2 +-
>>  drivers/firmware/efi/libstub/mem.c            | 25 +++++++++++++++----
>>  drivers/firmware/efi/libstub/randomalloc.c    |  2 +-
>>  drivers/firmware/efi/libstub/relocate.c       |  2 +-
>>  drivers/firmware/efi/libstub/x86-stub.c       |  8 +++---
>>  8 files changed, 52 insertions(+), 27 deletions(-)
>>
> 
> This looks rather intrusive for a patch that is intended as cc:stable.
> 
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index e312d731f4a3..7fedc271d543 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -155,6 +155,29 @@ config EFI_TEST
>>           Say Y here to enable the runtime services support via /dev/efi_test.
>>           If unsure, say N.
>>
>> +#
>> +# An efi_boot_memmap is used by efi_get_memory_map() to return the
>> +# EFI memory map in a dynamically allocated buffer.
>> +#
>> +# The buffer allocated for the EFI memory map includes extra room for
>> +# a range of [EFI_MIN_NR_MMAP_SLACK_SLOTS, EFI_MAX_NR_MMAP_SLACK_SLOTS]
>> +# additional EFI memory descriptors. This facilitates the reuse of the
>> +# EFI memory map buffer when a second call to ExitBootServices() is
>> +# needed because of intervening changes to the EFI memory map. Other
>> +# related structures, e.g. x86 e820ext, need to factor in this headroom
>> +# requirement as well.
>> +#
>> +
>> +config EFI_MIN_NR_MMAP_SLACK_SLOTS
>> +       int
>> +       depends on EFI
>> +       default 8
>> +
>> +config EFI_MAX_NR_MMAP_SLACK_SLOTS
>> +       int
>> +       depends on EFI
>> +       default 64
>> +
> 
> What would be the reason for not always bumping this to 64?

I personally don't mind always bumping it up, but it seemed to
me like it might regress existing platforms if we did that.

> 
>>  config EFI_DEV_PATH_PARSER
>>         bool
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> index c0c81ca4237e..adf2b0c0dd34 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> @@ -432,7 +432,7 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
>>         if (efi_disable_pci_dma)
>>                 efi_pci_disable_bridge_busmaster();
>>
>> -       status = efi_get_memory_map(&map, true);
>> +       status = efi_get_memory_map(&map, true, NULL);
>>         if (status != EFI_SUCCESS)
>>                 return status;
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index 76e44c185f29..d86c6e13de5f 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -160,19 +160,6 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>>   */
>>  #define EFI_100NSEC_PER_USEC   ((u64)10)
>>
>> -/*
>> - * An efi_boot_memmap is used by efi_get_memory_map() to return the
>> - * EFI memory map in a dynamically allocated buffer.
>> - *
>> - * The buffer allocated for the EFI memory map includes extra room for
>> - * a minimum of EFI_MMAP_NR_SLACK_SLOTS additional EFI memory descriptors.
>> - * This facilitates the reuse of the EFI memory map buffer when a second
>> - * call to ExitBootServices() is needed because of intervening changes to
>> - * the EFI memory map. Other related structures, e.g. x86 e820ext, need
>> - * to factor in this headroom requirement as well.
>> - */
>> -#define EFI_MMAP_NR_SLACK_SLOTS        8
>> -
>>  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
>>
>>  union efi_device_path_to_text_protocol {
>> @@ -1059,7 +1046,7 @@ void efi_apply_loadoptions_quirk(const void **load_options, u32 *load_options_si
>>  char *efi_convert_cmdline(efi_loaded_image_t *image);
>>
>>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
>> -                               bool install_cfg_tbl);
>> +                               bool install_cfg_tbl, unsigned int *n);
>>
>>  efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
>>                                 unsigned long max);
>> diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
>> index 6318c40bda38..06e7a1ef34ab 100644
>> --- a/drivers/firmware/efi/libstub/kaslr.c
>> +++ b/drivers/firmware/efi/libstub/kaslr.c
>> @@ -62,7 +62,7 @@ static bool check_image_region(u64 base, u64 size)
>>         bool ret = false;
>>         int map_offset;
>>
>> -       status = efi_get_memory_map(&map, false);
>> +       status = efi_get_memory_map(&map, false, NULL);
>>         if (status != EFI_SUCCESS)
>>                 return false;
>>
>> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
>> index 4f1fa302234d..cab25183b790 100644
>> --- a/drivers/firmware/efi/libstub/mem.c
>> +++ b/drivers/firmware/efi/libstub/mem.c
>> @@ -13,32 +13,47 @@
>>   *                     configuration table
>>   *
>>   * Retrieve the UEFI memory map. The allocated memory leaves room for
>> - * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
>> + * up to CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS additional memory map entries.
>>   *
>>   * Return:     status code
>>   */
>>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
>> -                               bool install_cfg_tbl)
>> +                               bool install_cfg_tbl,
>> +                               unsigned int *n)
> 
> What is the purpose of 'n'? Having single letter names for function
> parameters is not great for legibility.
> 
>>  {
>>         int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
>>                                       : EFI_LOADER_DATA;
>>         efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
>> +       unsigned int nr = CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS;
>>         struct efi_boot_memmap *m, tmp;
>>         efi_status_t status;
>>         unsigned long size;
>>
>> +       BUILD_BUG_ON(!is_power_of_2(CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS) ||
>> +                    !is_power_of_2(CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS) ||
>> +                    CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS >=
>> +                    CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
>> +
>>         tmp.map_size = 0;
>>         status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
>>                              &tmp.desc_size, &tmp.desc_ver);
>>         if (status != EFI_BUFFER_TOO_SMALL)
>>                 return EFI_LOAD_ERROR;
>>
>> -       size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
>> -       status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
>> -                            (void **)&m);
>> +       do {
>> +               size = tmp.map_size + tmp.desc_size * nr;
>> +               status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
>> +                                    (void **)&m);
>> +               nr <<= 1;
>> +       } while (status == EFI_BUFFER_TOO_SMALL &&
>> +                nr <= CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
>> +
> 
> Under what circumstances would you expect AllocatePool() to return
> EFI_BUFFER_TOO_SMALL? What is the purpose of this loop?

We have observed that allocate_pool() will return EFI_BUFFER_TOO_SMALL
if EFI_MMAP_NR_SLACK_SLOTS is less than 32. The loop is there so only
the minimum number of extra slots are allocated.

> 
> How did you test this code?

I was able to successfully boot the platform with this patch applied,
without it we need to append `efi=disable_early_pci_dma` to the kernel's
cmdline be able to boot the system.


> 
>>         if (status != EFI_SUCCESS)
>>                 return status;
>>
>> +       if (n)
>> +               *n = nr;
>> +
>>         if (install_cfg_tbl) {
>>                 /*
>>                  * Installing a configuration table might allocate memory, and
>> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
>> index c41e7b2091cd..e80a65e7b87a 100644
>> --- a/drivers/firmware/efi/libstub/randomalloc.c
>> +++ b/drivers/firmware/efi/libstub/randomalloc.c
>> @@ -65,7 +65,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>>         efi_status_t status;
>>         int map_offset;
>>
>> -       status = efi_get_memory_map(&map, false);
>> +       status = efi_get_memory_map(&map, false, NULL);
>>         if (status != EFI_SUCCESS)
>>                 return status;
>>
>> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
>> index d694bcfa1074..b7b0aad95ba4 100644
>> --- a/drivers/firmware/efi/libstub/relocate.c
>> +++ b/drivers/firmware/efi/libstub/relocate.c
>> @@ -28,7 +28,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>>         unsigned long nr_pages;
>>         int i;
>>
>> -       status = efi_get_memory_map(&map, false);
>> +       status = efi_get_memory_map(&map, false, NULL);
>>         if (status != EFI_SUCCESS)
>>                 goto fail;
>>
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index 188c8000d245..cb14f0d2a3d9 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -740,15 +740,15 @@ static efi_status_t allocate_e820(struct boot_params *params,
>>         struct efi_boot_memmap *map;
>>         efi_status_t status;
>>         __u32 nr_desc;
>> +       __u32 nr;
>>
>> -       status = efi_get_memory_map(&map, false);
>> +       status = efi_get_memory_map(&map, false, &nr);
>>         if (status != EFI_SUCCESS)
>>                 return status;
>>
>>         nr_desc = map->map_size / map->desc_size;
>> -       if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
>> -               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
>> -                                EFI_MMAP_NR_SLACK_SLOTS;
>> +       if (nr_desc > ARRAY_SIZE(params->e820_table) - nr) {
>> +               u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) + nr;
>>
>>                 status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>>         }
>> --
>> 2.47.1
>>



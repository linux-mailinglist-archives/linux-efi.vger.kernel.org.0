Return-Path: <linux-efi+bounces-2335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E99E9DCB
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 19:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AB7282506
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B21422D8;
	Mon,  9 Dec 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IPuKYZXv"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1581F5F6;
	Mon,  9 Dec 2024 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767443; cv=none; b=IuFP27v7wM2wohKJI7BLxdYFFm83qBr6s15iU9Apr08xUouxPp66+4PfS7ATZn8Y/0lTosW/U5kzEr+pxnEAjaCqnDt5qdrk5kBhRSFS1XAsQSIL579A3JJtOXPoOC+rBeliMLPEYQ5M38lz0FD/9h27kVcQyLIXEOaOjZPZVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767443; c=relaxed/simple;
	bh=GnZHONchw2Uieb2JZkJ/5ZqeDPUlH0nixwbk6z1QYLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBKbt2ODhbu0mP5jRyag4n3BB7dOADUDuzbllUKHNtPU/J9OWrSF0Udx9dKY0dfOV5vUruvz7HSuflTCUP93qGh+wV/fjhOKwSJ5nUEvMLsopJvpQ3qy6sVbOJm6tn2H6M6NV23xZplBfAFSWNoCi/OzrKiHyazRBWGXg3X/vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IPuKYZXv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.2.246] (bras-base-toroon4332w-grc-63-70-49-166-4.dsl.bell.ca [70.49.166.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 031B420BCAFE;
	Mon,  9 Dec 2024 10:03:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 031B420BCAFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733767441;
	bh=WABAMkncnfO0e2Iha+P2koPHNAKGwrkqWDBUajnKbAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IPuKYZXv1z6rhjNi07HlD+lzjfwsMpFsCNecTfuvcZVpWnjYB7VD3FwZwNwjwJenp
	 38LLWVBczetqxa4Gsr1/rrvYh9VNNlzdzvyIPwGlZC+DmS3E7KfWbQJPim690+4P7p
	 lnWCr5vIqxMNEH99VRvb74a0xEGNWemAHOoVmSdY=
Message-ID: <d08a70a6-89d3-4f65-9625-841d616ac5ed@linux.microsoft.com>
Date: Mon, 9 Dec 2024 13:03:59 -0500
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
 <380bbf4b-0828-444e-9b93-fa639cc23a1a@linux.microsoft.com>
 <CAMj1kXFAbycLk5fLtyDXw2ApPp2ztJ0J7B-De5=eXKtUjvyAfw@mail.gmail.com>
Content-Language: en-US
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
In-Reply-To: <CAMj1kXFAbycLk5fLtyDXw2ApPp2ztJ0J7B-De5=eXKtUjvyAfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 13:00, Ard Biesheuvel wrote:
> On Mon, 9 Dec 2024 at 18:02, Hamza Mahfooz
> <hamzamahfooz@linux.microsoft.com> wrote:
>>
>> Hi Ard,
>>
>> On 12/9/24 11:40, Ard Biesheuvel wrote:
>>> Hello Hamza,
>>>
>>> Thanks for the patch.
>>>
>>> On Mon, 9 Dec 2024 at 17:25, Hamza Mahfooz
>>> <hamzamahfooz@linux.microsoft.com> wrote:
>>>>
>>>> Recent platforms
>>>
>>> Which platforms are you referring to here?
>>
>> Grace Blackwell 200 in particular.
>>
> 
> Those are arm64 systems, right?

Yup.

> 
>>>
>>>> require more slack slots than the current value of
>>>> EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. So, introduce
>>>> EFI_MIN_NR_MMAP_SLACK_SLOTS and EFI_MAX_NR_MMAP_SLACK_SLOTS
>>>> and use them to determine a number of slots that the platform
>>>> is willing to accept.
>>>>
>>>
>>> What does 'acceptance' mean in this case?
>>
>> Not having allocate_pool() return EFI_BUFFER_TOO_SMALL.
>>
> 
> I think you may have gotten confused here - see below
> 
>>>
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Tyler Hicks <code@tyhicks.com>
>>>> Tested-by: Brian Nguyen <nguyenbrian@microsoft.com>
>>>> Tested-by: Jacob Pan <panj@microsoft.com>
>>>> Reviewed-by: Allen Pais <apais@microsoft.com>
>>>
>>> I appreciate the effort of your colleagues, but if these
>>> tested/reviewed-bys were not given on an open list, they are
>>> meaningless, and I am going to drop them unless the people in question
>>> reply to this thread.
>>>
>>>> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>>>> ---
> ...
>>>> diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
>>>> index 4f1fa302234d..cab25183b790 100644
>>>> --- a/drivers/firmware/efi/libstub/mem.c
>>>> +++ b/drivers/firmware/efi/libstub/mem.c
>>>> @@ -13,32 +13,47 @@
>>>>   *                     configuration table
>>>>   *
>>>>   * Retrieve the UEFI memory map. The allocated memory leaves room for
>>>> - * up to EFI_MMAP_NR_SLACK_SLOTS additional memory map entries.
>>>> + * up to CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS additional memory map entries.
>>>>   *
>>>>   * Return:     status code
>>>>   */
>>>>  efi_status_t efi_get_memory_map(struct efi_boot_memmap **map,
>>>> -                               bool install_cfg_tbl)
>>>> +                               bool install_cfg_tbl,
>>>> +                               unsigned int *n)
>>>
>>> What is the purpose of 'n'? Having single letter names for function
>>> parameters is not great for legibility.
>>>
>>>>  {
>>>>         int memtype = install_cfg_tbl ? EFI_ACPI_RECLAIM_MEMORY
>>>>                                       : EFI_LOADER_DATA;
>>>>         efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
>>>> +       unsigned int nr = CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS;
>>>>         struct efi_boot_memmap *m, tmp;
>>>>         efi_status_t status;
>>>>         unsigned long size;
>>>>
>>>> +       BUILD_BUG_ON(!is_power_of_2(CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS) ||
>>>> +                    !is_power_of_2(CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS) ||
>>>> +                    CONFIG_EFI_MIN_NR_MMAP_SLACK_SLOTS >=
>>>> +                    CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
>>>> +
>>>>         tmp.map_size = 0;
>>>>         status = efi_bs_call(get_memory_map, &tmp.map_size, NULL, &tmp.map_key,
>>>>                              &tmp.desc_size, &tmp.desc_ver);
>>>>         if (status != EFI_BUFFER_TOO_SMALL)
>>>>                 return EFI_LOAD_ERROR;
>>>>
>>>> -       size = tmp.map_size + tmp.desc_size * EFI_MMAP_NR_SLACK_SLOTS;
>>>> -       status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
>>>> -                            (void **)&m);
>>>> +       do {
>>>> +               size = tmp.map_size + tmp.desc_size * nr;
>>>> +               status = efi_bs_call(allocate_pool, memtype, sizeof(*m) + size,
>>>> +                                    (void **)&m);
>>>> +               nr <<= 1;
>>>> +       } while (status == EFI_BUFFER_TOO_SMALL &&
>>>> +                nr <= CONFIG_EFI_MAX_NR_MMAP_SLACK_SLOTS);
>>>> +
>>>
>>> Under what circumstances would you expect AllocatePool() to return
>>> EFI_BUFFER_TOO_SMALL? What is the purpose of this loop?
>>
>> We have observed that allocate_pool() will return EFI_BUFFER_TOO_SMALL
>> if EFI_MMAP_NR_SLACK_SLOTS is less than 32. The loop is there so only
>> the minimum number of extra slots are allocated.
>>
> 
> But allocate_pool() *never* returns EFI_BUFFER_TOO_SMALL. It is
> get_memory_map() that may return EFI_BUFFER_TOO_SMALL if the memory
> map is larger than the provided buffer. In this case, allocate_pool()
> needs to be called again to allocate a buffer of the appropriate size.
> 
> So the loop needs to call get_memory_map() again, but given that the
> size is returned directly when the first call fails, this iterative
> logic seems misguided.
> 
> I also think you might be misunderstanding the purpose of the slack
> slots. They exist to reduce the likelihood that the memory map grows
> more entries than can be accommodated in the buffer in cases where the
> first call to ExitBootServices() fails, and GetMemoryMap() needs to be
> called again; at that point, memory allocations are no longer possible
> (although the UEFI spec was relaxed in this regard between 2.6 and
> 2.10).
> 
> 
>>>
>>> How did you test this code?
>>
>> I was able to successfully boot the platform with this patch applied,
>> without it we need to append `efi=disable_early_pci_dma` to the kernel's
>> cmdline be able to boot the system.
>>
> 
> allocate_pool() never returns EFI_BUFFER_TOO_SMALL, and so your loop
> executes only once. I cannot explain how this happens to fix the boot
> for you, but your patch as presented is deeply flawed.
> 
> If bumping the number of slots to 32 also solves the problem, I'd
> happily consider that instead,

Ya, lets go with that, in that case.

> 
> 
>>
>>>
>>>>         if (status != EFI_SUCCESS)
>>>>                 return status;
>>>>
>>>> +       if (n)
>>>> +               *n = nr;
>>>> +
> 
> It seems to me that at this point, nr has been doubled after it was
> used to perform the allocation, so you are returning a wrong value
> here.



Return-Path: <linux-efi+bounces-1883-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF1F98E1BB
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79F31C23121
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2EB1D172F;
	Wed,  2 Oct 2024 17:38:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F71CFEA3;
	Wed,  2 Oct 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890736; cv=none; b=MssA455TgFjGt71XWRX3gbInzmGWR3N8TMLGHkUvVn8jwDhDcWfkS1S7/HZR+LeIotRdCZvbwUtUaY4+J2JZ6TJvNXUK5vGoL0E8RHSpmtYheLyvLwQwG0GSnRnJqSGN3rciIfSp0TuK4LASHbJwVVWX06rYpU65xFskuMgf5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890736; c=relaxed/simple;
	bh=Rnlfoy9t01pWKbEP6U97WcKgYooNcGbQxl9bQLj/Q+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLv2iJ98M5xL5ZBy2aqtF3CPOwpEi9BmEkpdNfUu0RaKlYUALGNYDVzVW1NL1BlceHogCdVFr+Rt/nQfPrqbXoGr4hfq6lxaFPjzL89Xbm1FjPWwOXJn2msG6751HkR5/PXwHOgoh2F2rmUs5+3R2Q1UVAlS7n5dileoS7BFqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19FBC339;
	Wed,  2 Oct 2024 10:39:23 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66EE43F64C;
	Wed,  2 Oct 2024 10:38:51 -0700 (PDT)
Message-ID: <c0121455-6c46-468e-a386-6be2180dd7a3@arm.com>
Date: Wed, 2 Oct 2024 12:38:49 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 bp@alien8.de, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
 <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com>
 <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Ilias,

On 10/2/24 11:35 AM, Ilias Apalodimas wrote:
> Hi Jeremy,
> 
> On Wed, 2 Oct 2024 at 18:37, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Hi,
>>
>> On 10/1/24 2:19 AM, Ilias Apalodimas wrote:
>>> Thanks, Ard
>>>
>>> On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> (cc Ilias)
>>>>
>>>> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>>>
>>>>> Currently the initrd is only measured if it can be loaded using the
>>>>> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
>>>>> command line it is never measured. Lets move the check down a couple
>>>>> lines so the measurement happens independent of the source.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>    drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
>>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>> index de659f6a815f..555f84287f0b 100644
>>>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>>> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>>>>>           status = efi_load_initrd_dev_path(&initrd, hard_limit);
>>>>>           if (status == EFI_SUCCESS) {
>>>>>                   efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
>>>>> -               if (initrd.size > 0 &&
>>>>> -                   efi_measure_tagged_event(initrd.base, initrd.size,
>>>>> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
>>>>> -                       efi_info("Measured initrd data into PCR 9\n");
>>>>>           } else if (status == EFI_NOT_FOUND) {
>>>>>                   status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
>>>>>                                                    hard_limit);
>>>>> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>>>>>           if (status != EFI_SUCCESS)
>>>>>                   goto failed;
>>>>>
>>>>> +       if (initrd.size > 0 &&
>>>>> +           efi_measure_tagged_event(initrd.base, initrd.size,
>>>>> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
>>>>> +               efi_info("Measured initrd data into PCR 9\n");
>>>
>>> Back when we added this we intentionally left loading an initramfs
>>> loaded via the command line out.
>>> We wanted people to start using the LoadFile2 protocol instead of the
>>> command line option, which suffered from various issues  -- e.g could
>>> only be loaded if it resided in the same filesystem as the kernel and
>>> the bootloader had to reason about the kernel memory layout.
>>> I don't think measuring the command line option as well is going to
>>> cause any problems, but isn't it a step backward?
>>
>> Thanks for looking at this. Since no one else seems to have commented, I
>> will just express IMHO, that both methods are useful in differing
>> circumstances.
>>
>> For a heavyweight Linux aware bootloader like grub/sd-boot the
>> INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
>> out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
>> shell),
> 
> I am not sure I am following on the EfiShell. It has to run from an
> EFI firmware somehow. The two open-source options I am aware of are
> U-Boot and EDK2.
> U-Boot has full support for the LoadFile2 protocol (and the
> INITRD_MEDIA_GUID). In fact, you can add the initramfs/dtb/kernel
> triplets as your boot options, supported by the EfiBoot manager and
> you don't need grub/systemd boot etc.
> 
> I don't think you can do that from EDK2 -- encode the initrd in a boot
> option, but you can configure the initramfs to be loaded via LoadFile2
> in OMVF via the 'initrd' shell command.

Oh, I guess the shell is a bad example because I was unaware that there 
was a initrd option in it now. I'm buying into the boot loader/boot 
manager distinction, where the manager is largely unaware of the target 
OS's specific needs (in this case, having the initrd GUID set).


> 
>> the commandline based initrd loader is a useful function.
>> Because, the kernel stub should continue to serve as a complete, if
>> minimal implementation for booting Linux out of a pure UEFI environment
>> without additional support infrastructure (shim/grub/etc). So, it seems
>> that unless there is a reason for divergent behavior it shouldn't exist.
>> And at the moment, the two primary linux bootloaders grub2 and sdboot
>> are both using the INITRD_MEDIA_GUID. Given the battering ram has been
>> successful, it isn't a step backward.
> 
> I am not saying we shouldn't. As I said I don't think this patch
> breaks anything. I am just wondering if enhancing EDK2 to load the
> initramfs via LoadFile2 for more than OVMF is a better option.

There is a separation of concerns argument here. People regularly 
complain about firmware implementations tuned for windows, but making 
the FW aware of this GUID is doing the same thing for Linux. So, IMHO 
that should be avoided, rather assuring the firmware is made as OS 
agnostic as possible, and the OS specifics are moved into the OS boot 
loader, one of which is this stub. It would make more logical sense to 
have the stub set the GUID from built in command line defaults. To be 
clear, i'm not suggesting that.






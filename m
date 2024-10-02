Return-Path: <linux-efi+bounces-1879-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17798DF62
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 17:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AA282995
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7827A1D0B86;
	Wed,  2 Oct 2024 15:37:28 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9711D0BA5;
	Wed,  2 Oct 2024 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883448; cv=none; b=RkdRn8vQCglTDEWFSayIDtqXRn4ACMcl7pnPrEgWl8mjpzpj25wHIhBBPHGywT6ojzvp1lCGoDzk4fgAdCK5fHI/hIVRyvr/FDxwdxdspkzBUAy4GCm/fd5lIYkSR89mADINYoGnIZjsGxBtx4iaNhv4xHQhCsHDj51KIVTSlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883448; c=relaxed/simple;
	bh=pLb/moY3kS1040DesOQTSP2llEiE2lmADZSKlbnphrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJnD3TkJAqBO2nz4rN19Uur7URCZUXxL5Y9P+4OI8C15ZiLeerrnbPStogEFdM3Asu4oIrB6N+7SNFjek83h7tXJLKzK7fb2B58V/HKxs4li+u7MyFy3VM3hZbd6+5TsTnTCNa7M3G7gUIoPXoA4IQQg4Pjaof35Nkg3RlIXfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D69339;
	Wed,  2 Oct 2024 08:37:54 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E5483F58B;
	Wed,  2 Oct 2024 08:37:23 -0700 (PDT)
Message-ID: <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com>
Date: Wed, 2 Oct 2024 10:37:21 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, bp@alien8.de,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/1/24 2:19 AM, Ilias Apalodimas wrote:
> Thanks, Ard
> 
> On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> (cc Ilias)
>>
>> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>> Currently the initrd is only measured if it can be loaded using the
>>> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
>>> command line it is never measured. Lets move the check down a couple
>>> lines so the measurement happens independent of the source.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> index de659f6a815f..555f84287f0b 100644
>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>>>          status = efi_load_initrd_dev_path(&initrd, hard_limit);
>>>          if (status == EFI_SUCCESS) {
>>>                  efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
>>> -               if (initrd.size > 0 &&
>>> -                   efi_measure_tagged_event(initrd.base, initrd.size,
>>> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
>>> -                       efi_info("Measured initrd data into PCR 9\n");
>>>          } else if (status == EFI_NOT_FOUND) {
>>>                  status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
>>>                                                   hard_limit);
>>> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>>>          if (status != EFI_SUCCESS)
>>>                  goto failed;
>>>
>>> +       if (initrd.size > 0 &&
>>> +           efi_measure_tagged_event(initrd.base, initrd.size,
>>> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
>>> +               efi_info("Measured initrd data into PCR 9\n");
> 
> Back when we added this we intentionally left loading an initramfs
> loaded via the command line out.
> We wanted people to start using the LoadFile2 protocol instead of the
> command line option, which suffered from various issues  -- e.g could
> only be loaded if it resided in the same filesystem as the kernel and
> the bootloader had to reason about the kernel memory layout.
> I don't think measuring the command line option as well is going to
> cause any problems, but isn't it a step backward?

Thanks for looking at this. Since no one else seems to have commented, I 
will just express IMHO, that both methods are useful in differing 
circumstances.

For a heavyweight Linux aware bootloader like grub/sd-boot the 
INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out 
out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI 
shell), the commandline based initrd loader is a useful function. 
Because, the kernel stub should continue to serve as a complete, if 
minimal implementation for booting Linux out of a pure UEFI environment 
without additional support infrastructure (shim/grub/etc). So, it seems 
that unless there is a reason for divergent behavior it shouldn't exist. 
And at the moment, the two primary linux bootloaders grub2 and sdboot 
are both using the INITRD_MEDIA_GUID. Given the battering ram has been 
successful, it isn't a step backward.

> 
> Thanks
> /Ilias
>>> +
>>>          status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
>>>                               (void **)&tbl);
>>>          if (status != EFI_SUCCESS)
>>> --
>>> 2.46.1
>>>



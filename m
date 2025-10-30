Return-Path: <linux-efi+bounces-5254-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0745C1FA13
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068EA1882F88
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821D2045B7;
	Thu, 30 Oct 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WciZT9NT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAD1CEADB;
	Thu, 30 Oct 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821191; cv=none; b=aCncksUXGO59g5NBrG3LlXtGWRES4qG/UzJCb/UI7ESfW0t3z8sRuTSWm4cP8ttURLzwc0D1A7BvDqjGhWufdLDAcOZcJ6VkAROpU4/Xa1FKheuvfHb+AY6ySHZq4HnE80LWqqLPIHz2eSd8Z62OP6RPytvaAG9Z77xpK+9qpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821191; c=relaxed/simple;
	bh=pAhi+umUxXwXGmw4zZlEHH9PM6bSxgE5mQz+r0jrM1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qi0pGm6z6YIaC7JbybUsze9IrJX6uoUqjrfEu06cdj57vXou4l6/+NtA6vVzvTWNwC0pvWeqREABK98obukmWGplgr0GSQ5U8bWP88ZJf2FSzqcoqiCc6U6NIhMEsKPR6nxJSqWG3XRmSzFSmBRhUSUbO65SKIFDb8Y/UpI3u/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WciZT9NT; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761821107;
	bh=MRXsreiGcYdw08vCAm+5uQvjPGAu2tcntKPNgaJ66zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WciZT9NTTavKJD4xEBfHtvqtfUTkDRYy1HaSt5lqdDanOLBS75+1ptFcKHykA6yPt
	 LSw99FeQ+yyzQ3gWAb/KsRUj42c/6oMAmlzVBojy6XUq547ooWaLAPWChewddJYneq
	 825uudRAS+ZACEd8gm8lpn8zhmwoPb+g8WQmuLN0=
X-QQ-mid: esmtpsz18t1761821100td57587fb
X-QQ-Originating-IP: UOM9KTHY+8oO5A1ca7+4BxY32mxy5LGe7L23reGSeDQ=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 18:44:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9726592726005352863
Message-ID: <006327B65B574934+440b408c-499d-4ec9-837e-703991ad51fc@uniontech.com>
Date: Thu, 30 Oct 2025 18:44:58 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251023082129.75612-1-maqianga@uniontech.com>
 <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
 <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
 <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
 <9F7F632B7963434F+abad2548-a90d-4448-ae79-dd4bf637ee6e@uniontech.com>
 <CAMj1kXHu5ABgxKsc_gg1j=pWMz6DbWoqv=qAAjx-5CiSF2PAiQ@mail.gmail.com>
 <BD93A8DBE27154B0+22bf4a83-a850-4f78-8e0d-84cc93fe2715@uniontech.com>
 <CAMj1kXFUUCoE=gZ0kTMKx87qnJMU9J9skT75STTKjjakXb8kmw@mail.gmail.com>
 <89364700AD0CD6E1+dd8d745f-5a72-4b0a-80db-eaa1d00c4e64@uniontech.com>
 <CAMj1kXHpJ3gz=+Keswx0MZ8v6YQENR2pjeS_CE6g4cXML2LQhA@mail.gmail.com>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <CAMj1kXHpJ3gz=+Keswx0MZ8v6YQENR2pjeS_CE6g4cXML2LQhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OBUAsW88a6arDPrmg2LFOEkCMx36cxdHU5WDQFVw6br3icDZtXGxdrYl
	XfJtZVIHhjIaMTrP5a8E/S+qyskYsGsYOUkn0N2GurLKaecxQTF8wVlCaSncR10cgsOE6MU
	YZJ62JWZjkdQ8mhfRr5HxiKHlswvvt3NuoEt2S/Zzw3TSJ/PXp2xBQ1OPm8UjNoG8ReVUAk
	3iAdOk0V9yE0OiGGyJW1pMhWQh7HJjPmNtHQsesWggWilLxc00DaMzWXKl/5NCBaex0vUsp
	H1+E2KXpeM/W/MWaa//csGPnv+sBJj3VN6aMXT21aQYLGekbu55WLI9zSSk5YmRB8szIViT
	6wa+NQRBIrABd6nAMAia8wTP8nHmRGjJbCjyTaKX11vxeKWJdKkjn9BRlWy2qULfqzK+VIE
	fAgAZeceiq3xU27ljqJlda+moFKqenhWz12O0DWecGHJpd+H7xfzx3iJuDnvfQ9DyqnWxcz
	paeulYyylUHDgyaf9sJM+59M3HKmNtsIAwYoArcH0mE3OVw+OC1FvPnRHku7EABx3xG5f5l
	1AKTOZDpm+k0rSoIXYeHXRdFKVRpax8IABQSfd7zxR+1Z5fqvqhYsZEMdf0+gdzQXpUdJzP
	tRnxCixOamV2G4PASSp86lz0U4SyypHNg7Ot+vamGP2PeOPSBIuA7c2qDuqNwj2aH+Kmx8o
	LNczh0k0/ZRq02KAiPzkiR+cr4KbDo6w/q256QXvPnLwqGhNx9adv8V4ZH3Kj9JFv79eKIU
	K/ACjzBVSE2ExcbSklfZESaZ+jAmJGJkOCFW6bkHq0YX7wmOGDw1D1GUqrw86Sda2fmcUpS
	o4HcyvgpOP+99ExvNwLe4jPGlHaYqdq/7K1WjnaSEBxsWoCux621U+l9bto2xGJjQ91w8UY
	kQk4mxEx5H00HzW7Xrjlc3XNr06qcMk2obLwaOysw6rWW9Qubc1AyUKMG46/kO+/ZyFt74D
	tdkSY7JxOs//+T7heip9pn89yw0pVlwj5LGOoNMw4Ed9dpEM5qBxBDZHXKfZDPHQ3Sb9VKH
	WZ6LsR/mf4uxRN0e9qWmEiUDlThKBODsrTKA5HGg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0


在 2025/10/30 18:36, Ard Biesheuvel 写道:
> On Thu, 30 Oct 2025 at 11:25, Qiang Ma <maqianga@uniontech.com> wrote:
>>
>> 在 2025/10/30 18:02, Ard Biesheuvel 写道:
>>> On Thu, 30 Oct 2025 at 08:37, Qiang Ma <maqianga@uniontech.com> wrote:
>>>> 在 2025/10/29 22:15, Ard Biesheuvel 写道:
>>>>> On Wed, 29 Oct 2025 at 10:55, Qiang Ma <maqianga@uniontech.com> wrote:
>>>>>> 在 2025/10/28 21:42, Ard Biesheuvel 写道:
>>>>>>> On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote:
>>>>>>>> 在 2025/10/23 16:30, Ard Biesheuvel 写道:
>>>>>>>>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
>>>>>>>>>> In the efi_virtmap_init(), permission settings have been applied:
>>>>>>>>>>
>>>>>>>>>> static bool __init efi_virtmap_init(void)
>>>>>>>>>> {
>>>>>>>>>>              ...
>>>>>>>>>>              for_each_efi_memory_desc(md)
>>>>>>>>>>                      ...
>>>>>>>>>>                      efi_create_mapping(&efi_mm, md);
>>>>>>>>>>              ...
>>>>>>>>>>              efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
>>>>>>>>>>              ...
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> Therefore, there is no need to apply it again in the efi_create_mapping().
>>>>>>>>>>
>>>>>>>>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>>>>>> No, efi_memattr_apply_permissions() uses the /optional/ memory
>>>>>>>>> attributes table, whereas efi_create_mapping() uses the permission
>>>>>>>>> attributes in the EFI memory map. The memory attributes table is
>>>>>>>>> optional, in which case any RO/XP attributes from the memory map
>>>>>>>>> should be used.
>>>>>>>>>
>>>>>>>> I see.
>>>>>>>>
>>>>>>>> Then, can it be modified like this?
>>>>>>> No
>>>>>>>
>>>>>>>> --- a/arch/arm/kernel/efi.c
>>>>>>>> +++ b/arch/arm/kernel/efi.c
>>>>>>>> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm,
>>>>>>>> efi_memory_desc_t *md)
>>>>>>>>                      desc.type = MT_MEMORY_RWX_NONCACHED;
>>>>>>>>              else if (md->attribute & EFI_MEMORY_WC)
>>>>>>>>                      desc.type = MT_DEVICE_WC;
>>>>>>>> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
>>>>>>> This will be true for RO, XP or RO+XP.
>>>>>>>
>>>>>>>> +               desc.type = MT_MEMORY_RO;
>>>>>>> This will apply RO permissions even to XP regions, which need to be writable.
>>>>>>>
>>>>>> Thanks for your review.
>>>>>> I see.
>>>>>>
>>>>>> I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
>>>>>> and then we can use the RO+XP attribute to implement memory mapping.
>>>>>>
>>>>> Why? The current code is working fine, no?
>>>>>
>>>> Yes, the current code is running normally.
>>>>
>>>> The reasons for the modification are as follows:
>>>> I noticed that the arm64/RISC-V efi_create_mapping() always return 0,
>>>> but in the code where efi_virtmap_init() calls it, it is as follows:
>>>>
>>>> ret = efi_create_mapping(&efi_mm, md);
>>>> if (ret) {
>>>>        pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
>>>>            &phys, ret);
>>>>        return false;
>>>> }
>>>>
>>>> This return error print is unnecessary, so I want to remove it.
>>> So what is preventing you from removing this from the RISC-V version?
>>>
>> The current idea is to first remove the unnecessary return print from
>> arm/arm64,
> Please leave the ARM code alone.
I see.
>> and then remove RISC-V later, as this RISC-V code is also adapted based
>> on arm64.
>>
> RISC-V copied the ARM code and used it as a starting point. That does
> not mean it has to remain that way.
I can propose a patch specifically for RISC-V.



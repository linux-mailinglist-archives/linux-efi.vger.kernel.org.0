Return-Path: <linux-efi+bounces-5252-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C584C1F8CC
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 11:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E1D1A21C9A
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F23587C0;
	Thu, 30 Oct 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oFN7PsxS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24863357716;
	Thu, 30 Oct 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819999; cv=none; b=QRJM2DdvzORMx7rMxY8371I2HWKzi5flQ/KPErD2yfepqvFRLtqOAQqPZVvoSJXOtSBJfnnJrtxQz1IjicoFxLDx/j/qSqA1aZbTxVa4gIhoyLZHTbOjE07U4LVY+pf8G3sBhGY5u6TTJbYeFf5empZ6M2Od48M5CQg49/sfNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819999; c=relaxed/simple;
	bh=vvZQPp6EYrtMWK7Xie71R/nS4riQmKtoLGLX9XgmSyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diWaRjVNZN7ZhcY1agPUvbWItY0nU0E2M7mDj3veRkWhwP+/x6dO0Z9QCcyaKKW7Y+00b31m4isOlUo4mWpWAtUTJ99+9pLOi5WZhjEVcFjssehMpiADqQXnLo6YSbYflp0VPsIN2Xy5GUKKUISIJxbii1LeRGpuyWY/aZ+G8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oFN7PsxS; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761819857;
	bh=cIY7WYUzuDGkFE+k2rXKzr0YSMDo3kE1Fa0cpFNPx+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oFN7PsxSJWikcUx0u2QyxVradtO/densF9NrZY9+bpF6uWoad2IQJ4Gr7XaG6y8xP
	 SNyKwdF+JkVG9gVUXdAFS7f0fOey9m8WLsKqLQQQegt5GOS3zogPR5C/qksj+iUUPu
	 ZZLtLZZw2benOmTuu2C5AM+M8Piag9q8Da91y8nk=
X-QQ-mid: esmtpsz17t1761819849t112d1f9c
X-QQ-Originating-IP: XVhXU0kHJRbd+UVQvK+5/J0kiHqJAAeeCHRDMvlf5xk=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 18:24:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2889926651659397346
Message-ID: <89364700AD0CD6E1+dd8d745f-5a72-4b0a-80db-eaa1d00c4e64@uniontech.com>
Date: Thu, 30 Oct 2025 18:24:08 +0800
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
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <CAMj1kXFUUCoE=gZ0kTMKx87qnJMU9J9skT75STTKjjakXb8kmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NBjdfkqVynM2LzNdcPHTpqy83qJFwYM2EghexspTMIyRZih0xJE/kUI6
	CU2n2Ez7r8E6wKPNXIOrfx07ea6c9br3UH1SvDIgpRF8wCvserHPG3pGEI8bcntmQXYs5Ha
	bMCF3VcxxzcrPZIaSA6/gBv8Rs06pgRf9jettx40PzlZB1O8a8KlOwVkY22nMiy9r1uUFbx
	368C10lpoNy3+Trhadg7eP70Vgkq3JBV2wdD9FVI8xgkax2keMmAoUwqyKFkGq9tR4nGNmZ
	5MZgMCV3kRkv6x4pHW0tNTlP7tcml2nfA1jRZKmQPmfF/1l3dNYwKt6/otaxYEJykHrsKP4
	8+LqQQ3pVUwtG7ahIt+emFNA5EcZXNqzv+NUhR6dMETU8nFh+OnwWRrcRM5usQNamtVRRCk
	7uFqgzcixtj2nYtxdfiHdO6hfHdzhUJFJZsqYFmp2llyJkjG7qDW3tu/2kAUW64FcPhNj0r
	u9wRhsWgUJIpzcozYMApuf0u8x5dQRWThnTKNAvlD0jfCHxt2gbZ61Jtsj07eXwJtpuknJe
	MitSMayueG15Xj+xsZmK+ZeCyDuNDig8ffxD84zny60ydHi6LVRd7LPLyGFSVK78DMwdIC+
	Kqwt9AF75omxruj81Py0uC3zH6rpUOv151MnZxB8cLz8W9DILYPG5QDwcwr/4bUCcpAcoi8
	DvPC8fxUjL8PU9lSxRBF4RfRevDF99mCBdoin24iEwxqb+cVzV9ZlZPb1m1EWVQfUg1NFUI
	q4FForLJTuNI7BrWi0WiJFYHRmDSlcNGdav3R+ukBqlu/UUufu1OplkqOp4a6wnGHjShZMj
	hWZFMm5d+8Gr8+kH2NZJZDK/ZBY42prIcOqrcc3nCZjkDwbEW6DfnO8aOKnPqFfK8iQtlXq
	UdgUso7wle6ET6pRFk9wm+W/basxqMzh35IZN7PNjqz+9r4EUb4gYFXLDK76jGOVvT7yfcE
	jdE09YNZgEYtnu2a0JvFoflolYeGtgSh0HztFnpf9ayiVqsoZ83pxBoU9Z5gTOL6F9OtTv7
	yuTqZQcnjvsbYJUOSmO1o+8uUhATw=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


在 2025/10/30 18:02, Ard Biesheuvel 写道:
> On Thu, 30 Oct 2025 at 08:37, Qiang Ma <maqianga@uniontech.com> wrote:
>>
>> 在 2025/10/29 22:15, Ard Biesheuvel 写道:
>>> On Wed, 29 Oct 2025 at 10:55, Qiang Ma <maqianga@uniontech.com> wrote:
>>>> 在 2025/10/28 21:42, Ard Biesheuvel 写道:
>>>>> On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote:
>>>>>> 在 2025/10/23 16:30, Ard Biesheuvel 写道:
>>>>>>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
>>>>>>>> In the efi_virtmap_init(), permission settings have been applied:
>>>>>>>>
>>>>>>>> static bool __init efi_virtmap_init(void)
>>>>>>>> {
>>>>>>>>             ...
>>>>>>>>             for_each_efi_memory_desc(md)
>>>>>>>>                     ...
>>>>>>>>                     efi_create_mapping(&efi_mm, md);
>>>>>>>>             ...
>>>>>>>>             efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
>>>>>>>>             ...
>>>>>>>> }
>>>>>>>>
>>>>>>>> Therefore, there is no need to apply it again in the efi_create_mapping().
>>>>>>>>
>>>>>>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")
>>>>>>>>
>>>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>>>> No, efi_memattr_apply_permissions() uses the /optional/ memory
>>>>>>> attributes table, whereas efi_create_mapping() uses the permission
>>>>>>> attributes in the EFI memory map. The memory attributes table is
>>>>>>> optional, in which case any RO/XP attributes from the memory map
>>>>>>> should be used.
>>>>>>>
>>>>>> I see.
>>>>>>
>>>>>> Then, can it be modified like this?
>>>>> No
>>>>>
>>>>>> --- a/arch/arm/kernel/efi.c
>>>>>> +++ b/arch/arm/kernel/efi.c
>>>>>> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm,
>>>>>> efi_memory_desc_t *md)
>>>>>>                     desc.type = MT_MEMORY_RWX_NONCACHED;
>>>>>>             else if (md->attribute & EFI_MEMORY_WC)
>>>>>>                     desc.type = MT_DEVICE_WC;
>>>>>> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
>>>>> This will be true for RO, XP or RO+XP.
>>>>>
>>>>>> +               desc.type = MT_MEMORY_RO;
>>>>> This will apply RO permissions even to XP regions, which need to be writable.
>>>>>
>>>> Thanks for your review.
>>>> I see.
>>>>
>>>> I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
>>>> and then we can use the RO+XP attribute to implement memory mapping.
>>>>
>>> Why? The current code is working fine, no?
>>>
>> Yes, the current code is running normally.
>>
>> The reasons for the modification are as follows:
>> I noticed that the arm64/RISC-V efi_create_mapping() always return 0,
>> but in the code where efi_virtmap_init() calls it, it is as follows:
>>
>> ret = efi_create_mapping(&efi_mm, md);
>> if (ret) {
>>       pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
>>           &phys, ret);
>>       return false;
>> }
>>
>> This return error print is unnecessary, so I want to remove it.
> So what is preventing you from removing this from the RISC-V version?
>
The current idea is to first remove the unnecessary return print from 
arm/arm64,
and then remove RISC-V later, as this RISC-V code is also adapted based 
on arm64.



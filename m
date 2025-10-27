Return-Path: <linux-efi+bounces-5131-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC06C0BC47
	for <lists+linux-efi@lfdr.de>; Mon, 27 Oct 2025 04:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB01734AC2D
	for <lists+linux-efi@lfdr.de>; Mon, 27 Oct 2025 03:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889F78F29;
	Mon, 27 Oct 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kE5CTSl9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DF2D47E2;
	Mon, 27 Oct 2025 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536852; cv=none; b=DeYToQDi/A5/sQFIk0NJm1omPnOp+hfRrj8PvDwv8a8UjT3TzCD+aUrfTZGz9Nj4D5cdQ96LSGNIPVe+slIga8DYii836FheOMTskhNUrpcktkOuTOIl1n+vNi2NHsd7pqupiNjvLcnNEUeZgE1FO/6P8r4erA3SEcN+bLBK2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536852; c=relaxed/simple;
	bh=CTxwTyAC6s0EAwA33SpwEti8j0LogCEECO/bQ3HrAd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ei78cO9YX9TXRd04pnvAAtzMlrGzadU6qUyftNymPIIcZHCN5bCXJOOXBUDgQ616o5+Je80EhJXtIAV+7syzrQHVXwQND87EPHQftACwLirCdeMqQS2kgkzWZG3P+Zp/5/gVnHW9wnWTS8YVFSQ5yt0dg1treHmw/YLT0F3VcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kE5CTSl9; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761536765;
	bh=GH1rp1IvB9GX2JiwW5ZpYAb3JZ2Tf3hU3x3vAETwZOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kE5CTSl9qHgVEE1xcvfg90p7ywuDJhzErjasbRGHBR27iY9HNQpQOQzkvduqlTnvV
	 Ov6w/Gx81jsqKprdhbEwxSUkwjE83bMt9F4r1WpLTDGoheKNjeYtdeGVjpeNzzt9tU
	 f7N0/qAPV1XG64bnSUe3kWbtlRdRPDAdyPqe50fA=
X-QQ-mid: zesmtpgz3t1761536758tae45e91c
X-QQ-Originating-IP: 5faAr8goJjyzbCyUMsccEbc0vjz64JAT+lkSY6B33kw=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:45:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4447698992672488604
Message-ID: <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
Date: Mon, 27 Oct 2025 11:45:56 +0800
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
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NvjhxCSDgXIC1vjyXzfCUUD28uX6thRu0yRvJdVZlrrhgKumJz5F8RCD
	+1RIhmVkvLiUIebNUcRcMyeNjNlTHQvdfOjvBN4tQWBGrbjr8Lv3OVqdQEUI4r3v/1qrNn3
	6R/Hs+UZp3htX1qOuQ9BiUIMwHx98AR1oqiBPZQaHuEVw9Sma/lY5uurqWGnUTqBLXghsLH
	gQA5zyrpr43pC7BZmt+FpwVbrhK6JZQPZRfYu3PlVoUvQrZ+s5Bl2JB2i20fdm+hsZA8ZSc
	+73p9TfOsZqRnEOSmj509SDP1zysl+m9DkHpatoRxUV1B5hok1X2KESX/Oo0ek/L6r81r/h
	IxcSGj+FIXxvRY2C2jmU+9im4+f28lkZludhTIkbsLMM/IG03hZFXUruoRUyIC4CY77RR5W
	pT4ob4Ocz8qQOu9HW9Z3oARfZ642ac+Dbd6rGKuCuBHcDnu7VmiWhCzI5y3H8wqPRtpXH88
	Or2JqnOUFVuwUgfbdBZM11ZDiZSM9NSsx0xCr0+ouzhGTxkuIfb5EJBHR227nMabOKQtN0e
	OUPjztFGc4Xvvcj5qwX4cX4kap6OLhXgEmpBbbmha477v0qnUgPPpQS1fyTpPp6nC2duinF
	2mSj2Jvyv0bpTVWqht+1kSxg73LQlah+Y4zovrTR9HUNKhhkRa/dqMrCS8TiQU/wFJMOU4g
	ZOHIzHgQ2IO5AD9MX7jykHdDmfnhh8OQEvWNzIgg2TMsdRLbHL8vr8PzwsSUixRk//8KOjJ
	dhA0ShnqdV5/MD3NrHwoz0OtCS/bb7jTmu9uo0seO5Ez8OR/ZbXL5sE0hlmzvaIWXq/bRfS
	c/gGtAGDVPUutjrETJVrCgkmqs0ctBmCDis8uSEU/J7hEbpKsO1Zu2SksgJIrm6ibc3/k2J
	XgfN1Pp26XxRfDoIIK3qRXdb7pPTOtxyQ2sm+LKeXzsISSY036sj5OKp4f3sC6In/SdlJKQ
	2tXBje6jxxmWxkg1/8TmKvntfxOGy4OYUdomK8VGEFk/fErNwBUNuaPhOmiZHi6YNfiqla9
	Tp0nrgBCoe7t4gHmXq
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


在 2025/10/23 16:30, Ard Biesheuvel 写道:
> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote:
>> In the efi_virtmap_init(), permission settings have been applied:
>>
>> static bool __init efi_virtmap_init(void)
>> {
>>          ...
>>          for_each_efi_memory_desc(md)
>>                  ...
>>                  efi_create_mapping(&efi_mm, md);
>>          ...
>>          efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_permissions);
>>          ...
>> }
>>
>> Therefore, there is no need to apply it again in the efi_create_mapping().
>>
>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Runtime Services regions")
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> No, efi_memattr_apply_permissions() uses the /optional/ memory
> attributes table, whereas efi_create_mapping() uses the permission
> attributes in the EFI memory map. The memory attributes table is
> optional, in which case any RO/XP attributes from the memory map
> should be used.
>
I see.

Then, can it be modified like this?
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm, 
efi_memory_desc_t *md)
                 desc.type = MT_MEMORY_RWX_NONCACHED;
         else if (md->attribute & EFI_MEMORY_WC)
                 desc.type = MT_DEVICE_WC;
+       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
+               desc.type = MT_MEMORY_RO;
         else
                 desc.type = MT_DEVICE;

         create_mapping_late(mm, &desc, true);

-       /*
-        * If stricter permissions were specified, apply them now.
-        */
-       if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
-               return efi_set_mapping_permissions(mm, md, false);
         return 0;
  }

The create_mapping_late() finds the corresponding page table attribute 
from mem_types through type.
Here it is MT_MEMORY_RO, and its corresponding prot_pte is:
       ...
         [MT_MEMORY_RO] = {
                 .prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
                              L_PTE_XN | L_PTE_RDONLY,
       ...

Finally, the page table is also set through the set_pte_ext().


Thanks.

>> ---
>>   arch/arm/kernel/efi.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
>> index 6f9ec7d28a71..d2fca20d912e 100644
>> --- a/arch/arm/kernel/efi.c
>> +++ b/arch/arm/kernel/efi.c
>> @@ -70,11 +70,6 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
>>
>>          create_mapping_late(mm, &desc, true);
>>
>> -       /*
>> -        * If stricter permissions were specified, apply them now.
>> -        */
>> -       if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
>> -               return efi_set_mapping_permissions(mm, md, false);
>>          return 0;
>>   }
>>
>> --
>> 2.20.1
>>



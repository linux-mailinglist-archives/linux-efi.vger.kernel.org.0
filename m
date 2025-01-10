Return-Path: <linux-efi+bounces-2568-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA5A08F9D
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C716A3A1FA1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269FC2080E9;
	Fri, 10 Jan 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFRRMdDy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484ED1714AC;
	Fri, 10 Jan 2025 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509333; cv=none; b=iA17TqvHTLh5OACcySdgCvRAAiJAuLuZe7Xy+bE+jaNfIiEgBXWgtQpRcEO+5v/+F4M2aRT5PNOquB2kyqZQ6SKjQVZS/V1LbmQIdcw/fE3QqhV9ZtsPJGEPRRrfLyZ/G+16pZkmhblcXwrcSdMsHZpq+LIESDcNQtbSSl+9tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509333; c=relaxed/simple;
	bh=z1WdnxjTLqfHXsuY27XFPLVnec3qNksu/nwU2Q+Vsmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRLt0kWPdnzslEwUXbzClOb2RO6nYhODzw1HDRFcOGl2bTyiVUVCS2gmIPtEtXkKQC9YqBBnLOtVki7ChAPOV64rt3qqbNYqapEUqLNtODmGqGQPuo1loDud16fZUmaYqnI2Wjl3Lra1bP6NzaXcX8Viad8J/aRWUCfituQShFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFRRMdDy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf60d85238so377648866b.0;
        Fri, 10 Jan 2025 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509329; x=1737114129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmbj6+bdcAEA/h03npvSWI55L56TERING6IBOmfVGT8=;
        b=jFRRMdDyNU326+hk7NTNlPynGCSOeJ3XTWwkoIoS+2Co3RgT+dRQEwGNyvRLQNEYta
         1DtlOh6/0d1/PXyhvn2GOsOBnsHcjJFSGuKSsRAAHLX+uAzfw4I9R7gtTIk12MD/iR9K
         hQW18/aBKmjSv79P8J19XCraK4B5hCqJGqWdp1znmYmeIMJKPmuEWaZZgz/abd1KXpZG
         sKTo+KjrS4wh5zpuz7NEQhSPmRtCdFQvOXYUjhE4WsFgj42XV1BOeg1eFa537svLgZAF
         Qq7J8eLkuwuecvK9aIdJSx145qcOMGmSOVS6BzY6lsnRevPtHHhVupyfVJkLA2VNrZcc
         JDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509329; x=1737114129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmbj6+bdcAEA/h03npvSWI55L56TERING6IBOmfVGT8=;
        b=cCJtg83nUkpwPg3Puv2sLHBw57JiQJQElm74s6G30b5tqddloBRNxzjVZFVZYPj9KY
         YFEf8Fde7CSpjlwIA0VkMPYQ59RuEPZS4CMYmHugFUCV/HYGV9/j1o3/FhJ3Kxt4rdQK
         nTEsyV2o/ltPtD8oRcplIKj2gtUDyYn6TuieK4sh2jC5DTbIUDQiBshDrz2/2BPm5DMl
         3BeI6emxTmhnRXVU0QerrMeA1Dueu19MAawSHtTdoW7hOMnLDqMrJc1cIZkI+3C/ntxv
         floioEWd9iceTQZWN09ZEw4HS4dgHXRF03aqTOJCEB8rgbUm4iPqqEZsaZ+mu8DOeMoC
         9Tcg==
X-Forwarded-Encrypted: i=1; AJvYcCWSJGChnxmED75MHedOX+dPXu7X6/yrPwLOyRvTc480hibB4t3GSPesCZRuwwqtXjuyltPiMI5A6qk29Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvfBdMKDAbD1RkcBp4QegHmMDYaOtujSnajx5sd5HLVnXgtZx
	kMVZNaAhKcdw/nHKZm7rC6/K4AMgs/7KbmPgWEN3RhUXp564liviHyHFvW1vVhf+8A==
X-Gm-Gg: ASbGncv1P6TbFsgJ70X87UwbolWCqmuz/IR/M1P9elmrwBZWTUwTRNm3YjBK/cQ+Qe8
	xy0kSmOjC5/hSUxyWxBKs/+ABxKNPwCuqLca/5INjJ4NYKOjzKW4vBVl3G7trZoRs8qOUOEFJtk
	IDNMXocT0TUdRuWLcQ0gaATY6mVMw5SmAXtI5+/Ron7EtqCJnDisYlPos/x+8NwZJrbLOL9qLMJ
	zZIpwGOnfmZulRwOM4IQ/TIW99qahujiX9zC80uyzk4uLYxyopPQtdd3/pAL5Uw9og6QimJnqaC
	Iwb0vJeWAAd+3aoh7uz3NDF0cyRN
X-Google-Smtp-Source: AGHT+IFqYTiXpAtyFHsSTe2ln++HKgU0ODNtcI+FY2vTwxc+2zrHSgT1LKHx/WkhY/e2BplHhyn4nA==
X-Received: by 2002:a17:906:f582:b0:aa6:7165:5044 with SMTP id a640c23a62f3a-ab2abc789c7mr828412766b.44.1736509329336;
        Fri, 10 Jan 2025 03:42:09 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c964992esm156460966b.185.2025.01.10.03.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:42:09 -0800 (PST)
Message-ID: <31ea58e9-147e-4c6d-861e-97f0cc7792bb@gmail.com>
Date: Fri, 10 Jan 2025 11:42:08 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, ardb@kernel.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
 <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
 <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/01/2025 11:20, Dave Young wrote:
> On Fri, 10 Jan 2025 at 19:18, Dave Young <dyoung@redhat.com> wrote:
>>
>> On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 10/01/2025 02:50, Dave Young wrote:
>>>> Hi Usama,
>>>>
>>>> On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>> When this area is not reserved, it comes up as usable in
>>>>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>>>>> to find usable memory regions, can select the region where
>>>>> efi_mem_attr_table is and overwrite it and relocate_kernel.
>>>>
>>>> Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
>>>> work for you?
>>>> Just refer to esrt.c.
>>>>
>>>
>>> Hi Dave,
>>>
>>> Its a bit difficult to reproduce the problem and therefore test the fix, but
>>> we are seeing it a lot in production. Ard proposed the same thing in
>>> https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
>>> but as I mentioned there, I dont think that efi_mem_reserve would help,
>>> as efi_mem_reserve changes e820_table, while kexec looks at
>>> /sys/firmware/memmap which uses e820_table_firmware.
>>
>> I sent a question to pm people, if the sysfs memmap comes from
>> e820_table then it will be fine. Let's see:
> s/e820_table/e820_table_kexec
> 

Do you mean change /sys/firmware/memmap to point to e820_table_kexec instead
of e820_table_firmware [1]? 
I thought of doing this when the first bug was encountered last year, but
didn't do it as I thought it would be frowned upon to change what sysfs file
exposes to userspace.

[1] https://elixir.bootlin.com/linux/v6.12.6/source/arch/x86/kernel/e820.c#L31


>> https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/
>>
>>>
>>> Thanks,
>>> Usama
>>>
>>>> Thanks
>>>> Dave
>>>>
>>>
> 



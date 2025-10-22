Return-Path: <linux-efi+bounces-5095-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC9BFE9B7
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 01:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EF31888986
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 23:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2F280332;
	Wed, 22 Oct 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI8gSQpa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EE21ABB1
	for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176971; cv=none; b=oUuSB3imX3XeE4bzLe8u1G0pDNI4EYgY3uFNt2D3L6hOT2oKFoSk+HAZWJsNRcIl3FcDMzcKkm557ONfJ46ed66SVwyznx9LCaItVFU3bRRNQT0L+m2w7MTHT6ZdDLrFaRIFPR1VcbpGHwtv/1tvgkn7QCtEIr7y7lCg7L8ly9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176971; c=relaxed/simple;
	bh=fqYMAKlqtZJtiuJ1ERUUL+oJvskTG+jxNptCeiCYtag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZgvuFxbJyV+8S4H5Xd8BWahX4fYs2b+pHul3jvj9htZWjzIMOSnjnD6pS2ZYttRTYO/5UlFyQTq8xe1vlnrA8LQB8tUnpymb+BpOiIdSJj9Hv8kOuqrTG0EuqPIg86XKnnL00pzTq4GZhg3E0lR/v+/qxy9A9n8b1B3ykM7Njs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI8gSQpa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so781375e9.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 16:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761176968; x=1761781768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iAsIQREh+zGURAyjuCvUwYmGkRo9NPMoW7K+cQ8Syg=;
        b=PI8gSQpaxmAxoUKAcxlaZycH694Z6BqI5eLDQSYD2or5t367pZWjvTvBG2x/MF6Z75
         tM1k3g/6GsQ4G26pgonIaBFT7xXT/dDQoC2UJIUMkjiUtA1iRyqpMBlSBGCAfpZIEiKq
         YHBJ6TZoUcFvwWrrCSVAw6LYlYvKlYk2jf0WpbjE4P3Mexs4Xr2CbtIPB9xlY+v5QmIM
         eCghWImf8I59o4DvwAe65W0Om+RJZ7c1jLIZ174WLfsuVNmJPKxqurp0L++2DaIaihNI
         G9nc0Ys1UTYDHsabsFVgs0ozLlN0qIfEbB0+G40kjVzvZAMAh5gvmtenui1mXtU0ptIz
         SR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176968; x=1761781768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iAsIQREh+zGURAyjuCvUwYmGkRo9NPMoW7K+cQ8Syg=;
        b=nnE0Sd9LhP089N6jwgnX5rgARwBYSW+LPnCCZXPGTjPforLXB4yw4sSUmCnwSEIsyj
         VHvXpR0noyT/ecLn/gjy5NxgApACVaAxdUJid3VX1VuEo0YBqCENLBsU0V2b2ZMZSFBt
         hHlCKL/A3X+bFZoE0d+kukYb1VAe+p/JoyAX42roHBanBz4EE3x8/0MOLBKybCCHEiqx
         bn8BsdNDOvCS1UoE33uUFCPbKKQIY/LII/DrlJR7RYWZm3GNEO3RvQ/vDcRxTmZCf5+8
         i6q/p0G8rk9OR+0mWgDxgLNmGsFxLa2fWwsXMkk361RYCKmI0yq6OSinmY+c9SRKr+md
         Fo8A==
X-Forwarded-Encrypted: i=1; AJvYcCVeNoqlDUdyeFWKjRXyPOiQJneguJtO6529eNdD1e9efnTnJc2zBKzdGIo1BgZVnAyCBMUql+ulwXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzfjveXfKiNpdC5NoDpzvyYyge2tBR6sdqeFx3UCgnv9FDFs7
	lYY/JdGVafstW7mSOFdoN2RbK2bJ3Kmi3Q4TlpObxCSTewm0xzX0l+we
X-Gm-Gg: ASbGncuUqwS9BIMyMweAng0IDCfj5rYj5bIBTD9fwPO0Bs1y38F3T4FC1Fc4Q3f4noh
	q49Z0RLvo46hL3xlAISPomgW2/GossvUEblJfW2uKVA1IOSXlvHsbsSY7jbJVrJdp2FHV3Vxo/Y
	jqmZ8/KUzNYptZ63333mQQml7aRz4jMM6t3s49Uc80aFFCZUJEap1Kp7F3sCV1EcTclUgnhwMWk
	DgQv6/0ka11Z9pQq/NyjPFmpi7B4biT5NpHVsymxHQJz2dHG+6xswYsRS2MBLDwD588e9ooeS7K
	m9Rft4iKNny9WhFOP5zT13GpfzDq74HsXi+a7T5Cie7sNAtybvi8KEiuRcJ3JKCf3POJmo44Fph
	6H2uJhllTdl+jiPatHY24McL6ovQYOF4QTi6oJ/HyZLIvHGcY5Jwqod02qNynC//Dbhti2uFlOC
	KgU4f96iUrEKH5ucTlMtNYJWO5r5tp6nGBrzZPYrA7cgJJmPK12EFjrwGJ/gY6kgu2VxffSv9+4
	Vb9XMjQJA==
X-Google-Smtp-Source: AGHT+IEnIvYXuGkCzSV8+nhk+aDTUal3owkvZ8NNI/eJ4nC+WbM60rYIhbD7kTnRmJpNaU5p4X+VNg==
X-Received: by 2002:a05:600c:8217:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-4711790c372mr174343665e9.22.1761176967548;
        Wed, 22 Oct 2025 16:49:27 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494a91c47sm49161355e9.1.2025.10.22.16.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 16:49:26 -0700 (PDT)
Message-ID: <1a7a28d2-5a49-4522-b6e6-a42a14397aa0@gmail.com>
Date: Thu, 23 Oct 2025 00:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/boot: Fix page table access in 5-level to 4-level
 paging transition
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>, dwmw@amazon.co.uk,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-2-usamaarif642@gmail.com>
 <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2025 00:16, Dave Hansen wrote:
> On 10/22/25 15:06, Usama Arif wrote:
>> +		pgdp = (pgd_t *)read_cr3_pa();
>> +		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
>> +		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
> 
> Heh, somebody like casting, I see!

haha yeah its a lot here.
> 
> But seriously, read_cr3_pa() should be returning a physical address. No?
> Today it does:
> 
> static inline unsigned long read_cr3_pa(void)
> {
>         return __read_cr3() & CR3_ADDR_MASK;
> }
> 
> So shouldn't CR3_ADDR_MASK be masking out any naughty non-address bits?
> Shouldn't we fix read_cr3_pa() and not do this in its caller?

So we need to mask 2 things here:
- cr3, which is done by read_cr3_pa using CR3_ADDR_MASK/(__sme_clr(PHYSICAL_PAGE_MASK))
  as you pointed out.
- pgdp[0] (the deferenced value), i.e. the p4d table pointer (This was previously
  *(unsigned long *)__native_read_cr3()). This needs to be masked by PTE_PFN_MASK and
  and not PAGE_MASK which was done previously in order to take care of _PAGE_BIT_NOPTISHADOW.





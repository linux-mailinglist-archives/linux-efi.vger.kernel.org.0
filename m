Return-Path: <linux-efi+bounces-5117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5DC03A6B
	for <lists+linux-efi@lfdr.de>; Fri, 24 Oct 2025 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3E23B6857
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42795299A8A;
	Thu, 23 Oct 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxMkMj1q"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71956287503
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257712; cv=none; b=jN3VbhDLHASfwSU9C3lOrq69IcLYBqMZBCluXmow4Cu6kahV2VhJJMuuempOB7vV8thpjTGJPugiaihlT1eqKFKpcM9dQYqCTN61iD5ZJmruTrY9V6PIGX2CuoHCj0fpBmyHuHZgbQSxNzeOYfNwLSk0nTbloC01gZDCnRBQ57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257712; c=relaxed/simple;
	bh=oMC6wy7M+wMo//fYy0JBO3dAoVtDmXvF979orUPQy2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NktRS3v8r638N4kcw8sF/0IYlgTP4RLzYYduMQAu5GR4zk5aBaJytNJ+p+/BpOs+CM7CAbGdaTG/GqG4IgNufE57Joi0ZzxQzpE9i2kP9sNpGBhvYruqFdFLL7InoJjsuEvJELbH4NsoA+N6u+4VAt+omI2ncv4AfmJOhcBjVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxMkMj1q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47106fc51faso17564645e9.0
        for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761257708; x=1761862508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1abuvR+39U4BCu0WtCZb5wERbUtkhCRp5Ltmqxnu5wU=;
        b=jxMkMj1qnVPOVHELxpQNQuZ57xzrFsX1ygqYr66Z+9Lp6pdXa/w6V2/BDJZCX+w63e
         3jFptB4QqpuCRfG36RlJkU+EwRmUbZCzYUmeWhe6cvcxDR9uXRz+AFLNr3/pOTIjyVaG
         3zSnMLfqg4iGK5hvWnT/6zHGEks5edxBwfnn++MuSqfZ1/UXQtLDfAl1r9yxIUVLD0yR
         XPjpqyhnRhC5/0Qb1Xc4Y738e93ce9h/E8o2yqUnZlLxQEM+pmgWlFvQTANzZCI1olew
         krAXtkjR3NrzaIkLU4B/KtTueE66dCxVAzAh5eJrne2IwbnbvXH/Q5+tNREffU6XdSRh
         K9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761257708; x=1761862508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1abuvR+39U4BCu0WtCZb5wERbUtkhCRp5Ltmqxnu5wU=;
        b=uRThZSKxPcV9tSFHKNiDe88BwG5l6MDko5hDkfnjLtgDnmHFRa6fev4XHhlpXsR3uD
         Sz1L2R/Sjtcw3wTb1Mu0aNnTvigKzHUlVSNXwA71TQqTAzsB/gYsQGNEKnq8eVE/ozFL
         A51bltp9fRrELbEcvV2Ch9FEmCvupiDn4Fh44Lh1ID9UB1hx0usJsiHOBIchnW58fg+k
         tPzCD0ORwWn0EHXeyDugjWPCIvkVLsMWrYlVSGRgQXArx3Qs2A+buMxVKsjKdBX/4ZDN
         eZRFI2XDXeuXDr5ckKhG9O8zX27yNPO8BwXEQVTsHCAizjMuB4r9uPjWjFNkAQvYhGaE
         YBvg==
X-Forwarded-Encrypted: i=1; AJvYcCUyODcHNLgmTfbPlb9dcqqPb5q6o1Q7WFuFHc3jCV3FxIbz5IZ3YDdzC5gMw/oMYjmEUFL43kLEDPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzseKRmtLO8WTf5atpKffl0qGB5fTVdSFQEc1lmmaL5ljIUwGFb
	GhdFKkmY66Da01Y/VBAzKfjLYV0Y7ekjKBhsP21k4BhOdajAB1FB8rse
X-Gm-Gg: ASbGnct9YIcvbVeo6k5Ox9Mbkypy0/mRlMjH+LWtJ/yYeXwu9T7Ftlo3fKeZbUQ99l4
	zBh+3s0mXILcbwJhCqGScOxWjv2ut4zKkRWf1wgQLfxPvyDs8lyjXr8illx8ltRW+Eaz/sjxOYf
	3m7WFNglE4x2CpAMAARUbv8/0t02rYeYBQHaz8K703lLLfg86QgLOyI7Dq8/J60fRSrIieH5daF
	SNFKWNX5t8sh0k0etRKL7rQmSZ9iYjrvjEQ66ZFnhz2gMbwsrGKfpfhzO6dmXtEDOYiokL6Cpof
	04S2RIojicqpm8YPr23wQOLiKLfpNao2TQoXFOa5ehL6/igzmQzMtQdD/5dDX/MOILV9tCnusSl
	UYfV9Vv2WCPdyX+cWKD0tZzPnNgzDOE9ozKXv7Bzw+f5qTt7DNk9BCq3yiQpcNf3zzFNH6kBh90
	CGMoLO8qXu8j9h8FMjcc48oTD/PdWVWHxJ+BrbJx+7vIYXZljB8N5Z/W7+lQBD11h7uNIpoXzbl
	uVMGW+bIbiogIDgvA==
X-Google-Smtp-Source: AGHT+IFS7PDCwmJhO3e+p4QIOGLQwGY2qQkayzEzWyhN9VeP5ssAW+SKTxC3iyMEa6P7uWMGnmHlhg==
X-Received: by 2002:a05:600c:871a:b0:471:14f5:124e with SMTP id 5b1f17b1804b1-4711791ef9bmr194221505e9.35.1761257707419;
        Thu, 23 Oct 2025 15:15:07 -0700 (PDT)
Received: from ?IPV6:2001:16a2:cca1:5f00:4fa:aca1:dd42:a7f1? ([2001:16a2:cca1:5f00:4fa:aca1:dd42:a7f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm55222625e9.17.2025.10.23.15.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 15:15:06 -0700 (PDT)
Message-ID: <b0c0cd4f-91c9-4bbd-a93f-34b8472c218b@gmail.com>
Date: Fri, 24 Oct 2025 01:15:03 +0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to bit
 9
Content-Language: en-GB
To: Dave Hansen <dave.hansen@intel.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com, x86@kernel.org,
 apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
 Tobias Fleig <tfleig@meta.com>, Breno Leitao <leitao@debian.org>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-4-usamaarif642@gmail.com>
 <98bc658f-2ec6-43f5-a7e1-e9424450a850@intel.com>
 <797c78f4-1a90-42da-9fed-e87682456a43@gmail.com>
 <90047889-3b90-4c6a-90ed-f155c92f7ce1@intel.com>
 <yv2sjut5urpzz426z4wmufshbron35ohwtqk6jzun46elbcqtf@3z54nh33yl4m>
 <49769803-ad4a-4e15-a691-fd512b667ade@intel.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <49769803-ad4a-4e15-a691-fd512b667ade@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2025 16:12, Dave Hansen wrote:
> On 10/23/25 07:24, Kiryl Shutsemau wrote:
>> The last patch allows us to only update the kernel that has 5-level
>> paging enabled, making it much easier logistically.
>>
>> The fix seems trivial, and I don't see any downsides.
> 
> What I'm hearing is: Please change mainline so $COMPANY can do fewer
> backports.
> 

Not at all! Very happy to do the backports (will probably end up doing anyways).
They apply very cleanly annd are easy to do.

The issue is trying to deploy a kernel with 5-level table. This problem would be encountered
by anyone that has a medium to large number of machines to manage. 
Kiryl made a good point about crash kernels, but also medium to large fleets are very
dynamic. Old kernels remain for some time for a variety of reasons. And once you have
to kexec into an older kernel that doesnt have patches 1 and 2, it just doesn't work.

The only reason I mentioned live-patch is because that is the only way I know that can
be used to fix a problem like this and not have patch 3. But even if they were live patchable
not every uses it.

It would be nice to have patch 3 in upstream, as I would imagine it would make
life easier for a lot of people when they upgrade their kernel past 6.15 (when the defconfig
option to switch to 4 level was removed). We know of the problem, so we can mitigate it,
but I would imagine a lot of people won't. The bug was found when we tried upgrading
to 6.16, and kexec was breaking when downgrading. It took quite a while to find the bug
as prints don't work in this part of the code, so I think this patch might just save others
the trouble of going through the whole debugging process. 

If there is a strong preference to drop patch 3, I will remove it in the next revision.


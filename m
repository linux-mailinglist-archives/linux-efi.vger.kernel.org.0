Return-Path: <linux-efi+bounces-5096-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16BABFE9F9
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 01:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96511A05961
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F612BDC01;
	Wed, 22 Oct 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOpmMQfY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81026F292
	for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177504; cv=none; b=kFDUNBUeFBxeKsd6wgm8wgAzi8FiKJ78SYBH6HZT7kc1uKmEOpj/fo/mUekjNKCSC+KKEBFIxeUA7qdUtKWNR31KJnQNRgsafZsibIrU346Ztqt09Shp6BRn9x7mv0dMJTbj2pUPLUe9j4uN07UO21ZwfXjaczW7Vp8Jxg7zuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177504; c=relaxed/simple;
	bh=69kLIv0wf/Ul4iCPcD9yN9pfEnI9UUhm+gSpzsbN5zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZRkEvMP4aYH1XKokljM1KuGU36UZO0Ir1NqThKvCeQL7J9oGkNwevyHdOpxHB4/qD3T+ipHTfZdagZhtn5mHQzikvzmnCIN73iOQTB3XLSG/eFmC1mCBZKPrLhrRVbjHL5mW/td+VkiMcxlV1FcPy8R1hZIj9/8gCRdd4mlzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOpmMQfY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711b95226dso1671935e9.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761177501; x=1761782301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXmSZAbNCQuKGvpBAJGAIpTehSDAI3bN+gV4VpD9+5A=;
        b=gOpmMQfYGBS5gBPa60AL6TfvgZ3OutGoB6dJcRWKsy+aZ00KVqUy6ZyQRqHiAR5HvC
         7Dc/AjUCCu2SXU9g9T8Idhjrs1j2IKdRQHyIxN9mnv95CCRW8SHccFtyEsMlZjVmkqN5
         IujIYFoFUSeul+zIYgzFBv6YnTP5drKy4OLEcMfm2cb8GS0UD4p8BZSHruYscDSjLVsh
         t10RQp9pYtP8IQZAKVCQr4y8jkEvzaIi+mH65TN5wY3OQ9Gh7IunF07fa7HY0XJLGSKd
         O7unvkeLpdyKNYdbfM7hYKUUsdDpCjVsydafMTS4VNSFtek3YdlSlNiQiX6IwsYX0AD6
         S4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177501; x=1761782301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXmSZAbNCQuKGvpBAJGAIpTehSDAI3bN+gV4VpD9+5A=;
        b=qL/0WHrMs9BLLJmcg52QrXA/00fVCM6sfbaVrwQ2hvlJZPTxxB9jnS8THwMeHNBGXQ
         VIVWifkzcqLV+YcDvYieRYkVQ22WBeK9rOjE8/Re7//zoxbgDCjakVZQNQzl0HMP9hGC
         OQVw4iDMt8tWOv/2gP4NdlvYgMEhENbxrMuq85slxzbNlCRHTxu7vTlwvOW5inplzOtb
         DpSXgKwWFzn6lXbOvwc6kgBV7ReutE/VR4L6aIvfo/3UtKYVn6U08NOmTffm4/y3pOvr
         gvUZiUOy29j1VDHOmKTfBxiWMH9BKLK/J3+u2cxQLZz5D/BkYaVXs0m9fiqsPaKNsuOm
         m/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmmgqj4q2GaDPpGFh1wOOjkDEKq56vG/COwFdr+ECcd3uP9Ktw+EPsm9DpilmN9BGv4lqvFn37dsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/lv2D73UMC4OiJhPqlbvMcLHvktvVvY+sL7l/rc31foPtPq+
	iM2Zzmytlo8XbFnVeffsyfzgh4PCaIndkTnD80jwD5M+Y9/h8h6TVsPD
X-Gm-Gg: ASbGnctiYhnN72yrn+TO9n68ZCnfCKPiBke4DSJBge3D2j/MC1qaREcq6xuQYhZM39j
	SQUntsrLjwj5CDSm2vokr7EW1GkEmfCPGaJLDHcM99Bqrg9i4g8EZsbDLDIRY15vxhwdYC4XPbz
	OpqM3eL48rpXam/EdmUh9V8kUquOGpapkzOdRf9lj1WXVc2FDEPE64oeAHHiW9C2W3B5Dz4Pv2l
	DKElAJIdBgXgSOk23vmDPKPvcmgXmE52olazpfpCS2phbD6txacDAeniKQucF71fZvzSPFtP3x0
	U/h2SsvTYdS8mXELYdwXP2W1PohuDLYOy1y0/I0aboBc7b0nl9wE9wf819l1SrW1E53NRe/GJYh
	+i+nkfrW+HHP3BO1IDwtrXHbDh72n+YQjr7S/ZvM5Bh40UL7vK8LDffCOztcmqnjwEjJH6DXPO4
	xzUgpIh0UusVDLkEgn8THSGgydlv8inqBQRRUXZ+VPox1oIUX9jQ0MquOiypoT9yYMRTN6aDo=
X-Google-Smtp-Source: AGHT+IH5JiGj/CNajuRvuvR8aKKLlzF81OHsZpCjsEZOUlytRCFZVIyJ04vJEtOMPUj6DaFVPcHRdw==
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id 5b1f17b1804b1-4711c487d74mr110956515e9.9.1761177500838;
        Wed, 22 Oct 2025 16:58:20 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e785asm900083f8f.3.2025.10.22.16.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 16:58:18 -0700 (PDT)
Message-ID: <797c78f4-1a90-42da-9fed-e87682456a43@gmail.com>
Date: Thu, 23 Oct 2025 00:58:15 +0100
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
To: Dave Hansen <dave.hansen@intel.com>, dwmw@amazon.co.uk,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
 <20251022220755.1026144-4-usamaarif642@gmail.com>
 <98bc658f-2ec6-43f5-a7e1-e9424450a850@intel.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <98bc658f-2ec6-43f5-a7e1-e9424450a850@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/2025 00:35, Dave Hansen wrote:
> On 10/22/25 15:06, Usama Arif wrote:
>> Instead, move _PAGE_BIT_NOPTISHADOW to use _PAGE_BIT_SOFTW1 (bit 9),
> 
> Wait a sec, though...
> 
> This isn't necessary once the previous 2 patches are applied, right?

In kexec if the target kernels have patch 1 and 2, then this patch
is not needed. Unfortunately, patches 1 and 2 are not livepatchable.
Also backporting patches 1 and 2 to all previous kernels running in
production in a large fleet is not very scalable.

So if we want to run a kernel with 5 level pagetable in production
(with the ability to kexec into a 4 level kernel that doesn't have the first
2 patches), then this patch would solve the problem. i.e. patches 1 and 2
solve the problem from the target kernels perspective, patch 3 solves
it from the source kernel (if the target kernel doesnt have patches 1
and 2 applied).
I mentioned this in the commit message as:

"
- The logistical challenge of patching all older kernels in production
- The patch not being applicable for live patching
"

I can try and make the commit message clearer in the next revision.
 


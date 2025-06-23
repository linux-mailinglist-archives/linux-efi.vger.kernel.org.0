Return-Path: <linux-efi+bounces-3916-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE6AE490D
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 17:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52517A71E4
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF728E579;
	Mon, 23 Jun 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rSe9u0vO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EE264A97
	for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693506; cv=none; b=AXEf11yEDPq/Yu0d0YI9Nru9yVUHJ0PWB6OF6OB76EZZonMCDYC1CCUyQKHj2/xTtv5uUWH980KtJBWBjzDfrwV/iaidY/oF+lvVP7aCnnx2KuqNIH1YzFcQgpXadg+AiuCL7e6L2htDz26Fs/nymtAMdxHzxdUkRJlIl7FCZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693506; c=relaxed/simple;
	bh=5PNEmnbjciG2Xuw+gQQ+guOQSMZOjAoOCyw8eUAileQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtZq0s1XwNgR6MZcak1B/LmOU9U/qkHZs/q9zqG54WZFYsI0knM+2IjSQxloKLSiFSpmowZMwFrmcVSk/70e62ozzJl8mzEXxjhYTYAS7A3NM0ah9hbiiQlfIJywrvYEYw5EzKxUpgHVNfZe3gFWmxP2tkth63fUK1YO6rNI25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rSe9u0vO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1664087f8f.2
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750693503; x=1751298303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uL0O45hMlPAbdxle62Dl9Ya0NwjEYAAouOVoiEETw7E=;
        b=rSe9u0vOUsEzsjbCAkbK7yiaG5+6MtZCUo9e4M9o0RXMU1+Bmqcy0ozQtPBGyF5EtL
         Qpaajke8WY3twhwYLqLj4GijH1Jkh+EC9pMTbo9cZZ7EBwytAv15NNZ4eTBrNXGCe+ZR
         mmpBl6rJuw9AWEZfIrSzN3RzUbnERanryuKss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693503; x=1751298303;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL0O45hMlPAbdxle62Dl9Ya0NwjEYAAouOVoiEETw7E=;
        b=mPoamQwZn3SLe9mC4TMWNhbGReH+uOSOdEyfdO5Bo7GlQ61ldrt6F43v4nC954LEix
         qc9mWcedZCuZ5xPJweQJka/i99/J3rGQzIasqukwfw5cd9+7G/K8LX5L8DENGh6pJFuo
         BnFLLNvZBtLbrO9KWh+UHM2VlVneWRFlw7oz+urkZygtrSLmhxuZIsK3Urh4YLebJv5X
         BP0m7HOXwHqmEr2V8rs4lj2SsVqjhHdfbdRsw0Ejhpxi+ZIgq2Nxm1gtia3LNwZidtB4
         wGOryK5BgwMXU0gfZx+FTAvemiC4Rk0LRnbqwpkDLzKvb9P95w+u62VHO/sOD8CV7A1Y
         YNlA==
X-Forwarded-Encrypted: i=1; AJvYcCWj7psSvGG5DAEfZjk2DBkzEjCP9MmCQqpBqpPAbFIqR0alYBb0ChIZwRESM/I5rXTCJZnN/zATMzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxlPmeUWYd1XGWq07e5YFbmBibyeKx0Z6z+U8TwmHyN+f1B4S
	qCKqQHgqa+vqpWZx72Kvsuw90ZK4dhqPrMli0j8z5+Ve+vjvKM/7z/fJxdrAnQERJSw=
X-Gm-Gg: ASbGncuYCONe7rloWmDIBBMRULkNEO0mVmbvY1XVON0vXLCMpdcBNQgawPilpFSky4D
	T0dq9k3iV/RiddsiY2jpatPi2Bxpj99O1IAiSke4iLjwFX+cNy39LQug3U3MpRNJflL4vj8Lnnp
	ysJyTYx665kOp1mMtN2Zmmn5qkQpWAL3Tf1vIZXy/qb7goCly77GEzjtSYeyUP5raXs+f7tauXF
	RSPrlw13jzXjpEW/Rf0RAhi952BuOVeJ4SgQRAVXa6h9RyljPbIGkW6YpiUFzT/0fpXZvNvZ7Za
	w3cqVMy9FvvolgtJyJqcA4ttcIuUL5gRtGndE36x2VySxzd+VaTKFX4G2V8Frg76QibzENypqWR
	VJPKNDNaG4/ln0xgIOprp+9Ag5EA=
X-Google-Smtp-Source: AGHT+IGJ+QVsjcPbF0c+9y4h5WCZmLSbsgH/DWi6LPZOcySwQ1t7xKBejzOH5X1Y8ebzu0LTpXrofA==
X-Received: by 2002:a05:6000:178a:b0:3a5:2cca:6054 with SMTP id ffacd0b85a97d-3a6d1193e06mr11205314f8f.4.1750693502940;
        Mon, 23 Jun 2025 08:45:02 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1815dsm9554055f8f.28.2025.06.23.08.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:45:02 -0700 (PDT)
Message-ID: <ddbb18e8-fc32-4a41-b23d-4b707890200d@citrix.com>
Date: Mon, 23 Jun 2025 16:45:00 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
 bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, corbet@lwn.net, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, ebiggers@google.com, geert+renesas@glider.be,
 houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com,
 jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org,
 leitao@debian.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@rasmusvillemoes.dk,
 luto@kernel.org, mcgrof@kernel.org, mhiramat@kernel.org,
 michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com,
 namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
 sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com,
 vegard.nossum@oracle.com, x86@kernel.org, xin3.li@intel.com,
 xiongwei.song@windriver.com, ytcoode@gmail.com
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
 <kthmv63jrvrr3shhzhhcib7qrjp7sjkah65kogbfphfr6wg6cb@z5zydz6ov7pv>
 <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/06/2025 4:32 pm, Dave Hansen wrote:
> On 6/23/25 05:41, Kirill A. Shutemov wrote:
>> So, IIUC, that's dependency of vsyscall PF on NX. Do we want to disable
>> vsyscall on boot if NX is not available?
> Well, vsyscall=none can break old userspace, so forcing it on old
> hardware doesn't seem like a great idea.
>
> But, either way, this doesn't really appear to be a LASS issue. This code:
>
>>         if (!(error_code & X86_PF_INSTR)) {
>>                 /* Failed vsyscall read */
>>                 if (vsyscall_mode == EMULATE)
>>                         return false;
> Is really asking the question:
>
> 	Is this #PF from an instruction fetch in the vsyscall page?
>
> That _should_ be able to be done by comparing CR2 and regs->rip. In
> fact, that's done just below anyway:
>
> 	WARN_ON_ONCE(address != regs->ip);
>
> So I think we can fix this up with something like the attached patch
> which just drives the if() from regs->rip and make the warning NX-only.

Yeah, that looks good.  Furthermore, it means that the LASS #GP path
(patch 9) will be consistent with this path.  (i.e. both doing a
regs->rip check.)

Patch Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com> if that
counts for anything.

~Andrew


Return-Path: <linux-efi+bounces-3893-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0843AE2679
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487515A0357
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A12417E6;
	Fri, 20 Jun 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rbnP/Ay8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF823E32D
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462185; cv=none; b=YRKxrpiIHbDTiGI9hljO6RHfpylbJrKFvTzYwUtIx3PwgjaQivdHqFh6+cg2Wqft2ZkEZ9wAeB0tp54NPTrAXcqLcmBg3kaaaQvwuFOzjpvNIhCdO1YfZraOjxZqKOwBvzCOMRN4z1OIwa9HSNGTG5zgAx0D43OXvQNWoMOVtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462185; c=relaxed/simple;
	bh=GyWk0qiWePCQwaKIBix6f2exrRagW+EzsOmbSS+oOcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoGJ1AUh2YQhbTn+4vpNkAHbJn65FEYh4RYF05c8CYHCAWslE6/4j4pIrJlgopvMDZykOVcv+udOAw4CAbW8Zojz7/Y9o3B+PT7GPy1Ni1GPT5Buw+Lbj4k1Lu/BjHCxbAi69vASFV1it5hYMErgG0cIjP5vYSY3dhpWXPoEaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rbnP/Ay8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so17342355e9.0
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750462183; x=1751066983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ2eaHvE+DUGUCT+tt8p22ZyvVmrf9rbNhrUi9BbtKM=;
        b=rbnP/Ay8412hKSszqdqn7vg96GpPoBzBxJgE40T5B/9OUbIUQyzFQlzqSvGQ3Y1bAk
         AjKeHzTD4ZtyJMgXXoS55qc27TeDttoA/7i/I2Tt4iC5TDQQNHm625evxhT1ONxBNtrT
         0I9fRP4RRNd1GWsezUtj7s9tbQGIF8Cafetwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750462183; x=1751066983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ2eaHvE+DUGUCT+tt8p22ZyvVmrf9rbNhrUi9BbtKM=;
        b=Qar8UosILYIU9iHRC4bCw5Xnxx66imijJ1tYZid29rz6PmCq0QzCLgQ3LP63CBur22
         1fjhRl4DdGBLct3ifZEOHR74CsTMvtDgksq05TfmMu3aJL1ymG54K8zF7ZmCxxyhDPRf
         VL9IV3hWtCqrqLr4pilBzilK/nOQUouL1AIEUFBKgtSGghn7Axd5T6EIcnM2fYcETWaX
         1II/gsjeIKlbBrrF9WrDpBJLP2WTZYqBLTXP7Uw5q+UsDsaZhYMXZK/B0NO2lCc3Gs5x
         2pJK/JqTm6LQ5yBWv+jluBcCP5CXp5NW1QFSPDGIPBtfySlY2GhRzWfOaSr0I1Lbe1GU
         UfoA==
X-Forwarded-Encrypted: i=1; AJvYcCXK4ZR1cAlBIx7+G76qEfE8K3UKiQi+2qeqrnVH42u7bgH41sT1UlNdMEeE8JaK8Ajjtc44gsOFpdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgiX+32UbNOdFdrZXm9keZj97RaZpn5lPJOZDXkT0M8ZY+2z1
	YxoTtzHBr83lXgHLwTZ0N5hAtRiGABpBSoHuNWnMKwWuJjPp1RrMmjMo7YflNpOW4rk=
X-Gm-Gg: ASbGnctjRhf2P8noEr+ylViG/Ez1ITggeQDr3sVwAmjtClaxYWeA6Nsmq/hQzq9zxuk
	PnDKxxWvoxzbQcOglpWLL2d1hcf4WnRWt93O0dyyYJNi1ZvrandExnjSr/vAj/nLvfpJQJfkOsW
	ekis0HN4Y1C3ZiXFPaLnVlsVZXBxBl1o1w2N6QiwjcSWcbqY3tW2ikG5SDAd1h/gESf+NuhxlhC
	YGpJ0LvUDa0+hgfVMeGvcF4Qf2qnCQbg8XiiEKNacbW9qB+TRW5k3vN8Iwxmrrn0NbXJy9CkDnd
	OH3y8VsiQElK3TEi4B7zUkyymzMec7thCMR3AmwARhioMBrdw8gBS91EL077uH28e95ENb+/DHD
	m6LVej/cC48MVMdAzhtKJJgVeGa4=
X-Google-Smtp-Source: AGHT+IGgRZHxkj2pQ+l7/rk0whCWEYGExTTse7TuxuHuH1Xq1Z0HqPD/2OxQrgjoH7P7iFf5EIxSVg==
X-Received: by 2002:a05:600c:154b:b0:43d:40b0:5b with SMTP id 5b1f17b1804b1-453659b885emr40942275e9.25.1750462182540;
        Fri, 20 Jun 2025 16:29:42 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d91bsm3142259f8f.42.2025.06.20.16.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 16:29:41 -0700 (PDT)
Message-ID: <83e4ffb4-26e9-4fc9-90ad-256a1613ba7d@citrix.com>
Date: Sat, 21 Jun 2025 00:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
To: Sohil Mehta <sohil.mehta@intel.com>, dave.hansen@intel.com
Cc: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
 alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
 bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
 christophe.leroy@csgroup.eu, corbet@lwn.net, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, ebiggers@google.com, geert+renesas@glider.be,
 houtao1@huawei.com, hpa@zytor.com, jgg@ziepe.ca, jgross@suse.com,
 jpoimboe@kernel.org, kai.huang@intel.com, kees@kernel.org,
 kirill.shutemov@linux.intel.com, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@rasmusvillemoes.dk,
 luto@kernel.org, mcgrof@kernel.org, mhiramat@kernel.org,
 michael.roth@amd.com, mingo@kernel.org, mingo@redhat.com,
 namhyung@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
 sandipan.das@amd.com, shijie@os.amperecomputing.com, tglx@linutronix.de,
 tj@kernel.org, tony.luck@intel.com, vegard.nossum@oracle.com,
 x86@kernel.org, xin3.li@intel.com, xiongwei.song@windriver.com,
 ytcoode@gmail.com
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
 <f6d73a46-7ca0-4898-bb23-9095be403ea9@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <f6d73a46-7ca0-4898-bb23-9095be403ea9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/06/2025 12:18 am, Sohil Mehta wrote:
> On 6/20/2025 4:08 PM, Andrew Cooper wrote:
>>> But, the resulting code is wonky. It needs to do something more like this:
>>>
>>> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>>> 		return false;
>>>
>>> 	if (error_code & X86_PF_INSTR))
>>> 		return __emulate_vsyscall(regs, address);
>> To do this, LASS needs a proper interlink against NX || SMEP.
>>
>> If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
>> meaning that fetches are reported as plain reads.
>>
>> This leads to some fun corner cases in SMAP and now LASS too for virt.
> Maybe I am missing something, but LASS works pre-paging so it wouldn't
> generate a PF, right?

Oh right, yes.  This is a preexisting bug in vsyscall #PF handling.

It simply became obvious with Dave's suggested rearrangement.

~Andrew


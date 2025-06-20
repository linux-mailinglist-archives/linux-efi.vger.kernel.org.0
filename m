Return-Path: <linux-efi+bounces-3885-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34767AE2494
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 00:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD137AB2E3
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769B2367B6;
	Fri, 20 Jun 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BXOOPKFp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAF30E842
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457099; cv=none; b=pfmyeD0GFPHW2BXyJDJEr3C4X0OLjY8Nzg1fmowaVou+NtHZ4/FzFNxJvxismpH/mKdBfslNyiExdCIRxHq/KnhL+5t7JJj5nVJxk3xs1D57u/5wqZCkUkWwmRannSwsMEfAxklwI/DsKTOI9SBZ7nPeHF+G+uKEuzl831iJ5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457099; c=relaxed/simple;
	bh=qKO47JUuOeYylxbkUaI8PyJvTVsk6wydJd+Heew7j0Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RTfg2F7qnveEpO3oAheQgn3ZEB9decAEN/WA8vCHOl+UbYKfbo8suGgLxoZMyddjNirpzr8LriVWfaGi6ykO2ozr8nZHIQLTVdqVU1BeSKM1uTKV/Rg0dNQIkCqmi/1hDFaqYQizskL2zsgz5QefQLpye6dUi/nbKnLCjNVzeTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BXOOPKFp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45363645a8eso11545115e9.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750457096; x=1751061896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8uvyBLImuMcilKTjMXqSxIOYKLWiCOZqiuUgZlbFHE=;
        b=BXOOPKFpNFXSAUqQwMDG3rStpim9bXseKStuhrEd5Epg6cwTX85D26Fbs3GMJ6lK2M
         0nIG8NqLx/stj5eazAxDpZyNXYy+ijZleS41xbnvblvh8DfRXQx+qkrZTZ9LVX/d0y7k
         uduOs8nIZda0jSjZ5hqWzF1uSuRgJWifzuRv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457096; x=1751061896;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8uvyBLImuMcilKTjMXqSxIOYKLWiCOZqiuUgZlbFHE=;
        b=BEUtEh++s244RvMxQN71N02iVIWd3UKsrHflO7MFGANc11coCv/yrjwyIYUfnaye4z
         gDdaq2mEyOg7vlK4iOZeUafmpWvoNp3QtFu2SE+NLLUhFQWZswMStzNEyOOl3yZKsl0F
         6afd/B2RbHnK/GkmSl/oc/g0+jT7s9iJenputMe7iWi7ru7IPqaFXms8Qm9aMA4WmWEF
         C05W5DKimyQ4tqoZ7RKi4uGjzC5Ur8EedWB9hKn+USjZZ1VWQvXe7GY8JxWm2BwDW/1K
         VD1SgKj2gQu60iSnW/14trVaGI4DLgJ9Z0Oy5gSs+VzyhNCfZClycxUSH2zu5/Uorvzv
         w5wg==
X-Forwarded-Encrypted: i=1; AJvYcCWqRyOS9LcPcMkMvlYeKfycaF1H0+uqcDlgeR9WoDh3QtJd5hf1jO6hCTRU1k2FBvTRLXAE6XR8n4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YysT1TMbGv8u8HW+T2+X0egACYZ3MNjuOK0e7v0vqrDopkj0dYB
	TLWj80MdgG1g18r/mJPE90Nu8v6Prh5LAD3JzYEBloRi2Kq1rAtrTcH+XJqku8jsaQc=
X-Gm-Gg: ASbGncteLu2trea9jhwmmwzF9zPvfTcnBNcWlpY9MpiW78cgcX9dnmRZtZt5V+xNfnT
	Wl6OCB6ViCVmMlyZa5l1f88lmuRJuS5qazWlCdmzdhZ/bSm8jHVJS8K88/nseLnGLruPblB5d2C
	GV03zwU4ahD9rqQf59QD26A6h+5oSp7Sgr95CX/LFw/RyvyaxRWRQw1KEHer452hFua0nTH37Wz
	+rlw+AfbXjXt0NBVt1C6/EOA+HPdyyEEDdnqocrIjhhZtDvMT+UHLKtW/Bx3gc4dfpcmN9P2j11
	GAMC4QrHZIlKVdg3scTl8pC+WgGc8U3QRG/1kQ25bwBTs3PZu7hUMhGitG7c0pWKg2setunRM9X
	zqa8xujGgSvGSbZzx32MQmdeXDF4=
X-Google-Smtp-Source: AGHT+IF6TPHwFiRLRjNFUMsfj1E0KbTbLeSrxFBj3Izkb3vF6rF/CpISXhdDyQjItHncOEQak6nvPw==
X-Received: by 2002:a05:600c:314f:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-453659ba5a3mr38824305e9.24.1750457095655;
        Fri, 20 Jun 2025 15:04:55 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1188247sm3046998f8f.76.2025.06.20.15.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 15:04:55 -0700 (PDT)
Message-ID: <1aa5fb31-ce23-4c9f-ba1b-d5dc93402209@citrix.com>
Date: Fri, 20 Jun 2025 23:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dave.hansen@intel.com
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
 sandipan.das@amd.com, shijie@os.amperecomputing.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tj@kernel.org, tony.luck@intel.com,
 vegard.nossum@oracle.com, x86@kernel.org, xin3.li@intel.com,
 xiongwei.song@windriver.com, ytcoode@gmail.com
References: <61af62d9-4cd0-485f-8f0c-2da981f52695@intel.com>
Subject: Re: [PATCHv6 00/16] x86: Enable Linear Address Space Separation
 support
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <61af62d9-4cd0-485f-8f0c-2da981f52695@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Most of the cover letter here reads like an Intel whitepaper. That's not
> the worst thing in the world, but I think it glosses over one very
> important point:
>
> 	Had it been available, LASS alone would have mitigated Meltdown.
>
> Could we say this up front in a prominent place, please?

I'm going to nitpick. :)

Yes, LASS would have made Meltdown a far less major problem than it was,
but I don't think that phrasing is fair.  As I recall, LASS was
literally invented as a "what would have been useful?" exercise in the
wake of Meltdown.

However, a less well known/researched area of Meltdown, which would not
be addressed by LASS, is the ability to pend stores to read-only memory
and proceed with the expectation that they'll success.

Other things which would have helped would have been PKS (and this *was*
asked for ahead of Skylake launching...)

The other important thing about LASS is that it does cut off a whole
class of sidechannels.  This halts definitely-rogue speculation, but is
useful for non-speculative security too.

~Andrew


Return-Path: <linux-efi+bounces-3889-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADCAE25E9
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E6118983B2
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4505B23F43C;
	Fri, 20 Jun 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RfxLm+7n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44022CBC0
	for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750460938; cv=none; b=Dbp8v4C6d5O117Crv/mRAsMoAeTZWmf1Zv2mkQo4moeniJIM1vXvKFWayDdLX40oQU91621Zn/UtxxMfRn/3zMAEBnK4KSWOsQ3W6eklbcj4XHwl+8ohbFTNdjFUBfw0P/Uza6+H86Hx6sPp2htErElSnjuHwqpH3Rp+I/7uAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750460938; c=relaxed/simple;
	bh=LrIKVw9uceU9PNljM3GXHP0UH4jzYFs66QOU9jwX1gg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RcwMRctatGpvuygN106vbYgrGMGSS6SjsdWTIcy/MofsQb8j0vVylS9bFwUFfzc2Nzc1dij7z+drwHGJzWzZQyru2L5ke4V5sKmtPPr3yPLMv7j10WGif572lLss9HJJ26mD3jOCQ/V9fIAmHd1DBkzu/rBr8lwQXGAfWMqQy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=RfxLm+7n; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1952135f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 20 Jun 2025 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1750460934; x=1751065734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8K7VF56cCSHOQmH4rrNXHm6nXu5zATs+oNyo/btQdw8=;
        b=RfxLm+7nWNiqEc3PgMtBbYTUw/L+T6OKwGYvm504npYhzBkVknFXzJVDY8JkvVhEUF
         QoK0dq0N+k3NMRe2mDFzZJ6DYCFbpYojE+x2t5fhmoNIrqDPr0CRKSURVARBuYPJzKNC
         0wVarOTZQKbBS45X6VNvSXDjbyUzFYTHwuGaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750460934; x=1751065734;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K7VF56cCSHOQmH4rrNXHm6nXu5zATs+oNyo/btQdw8=;
        b=SMAURj5ej9VQKB4abFjcKVekSdbubBZcBjp3wNDePURUDvcA8qpTeYFy3p1N/7JfaF
         eWQI1QA+s1fnsweo2lsM6tlR7RRPUA2D/kWkMzL8OqGuzAT2H3FeK2QIjZM9EjvsVrwY
         YQDPEHAj1/c4Gs2d+IQA9ZknviJEBJA2sDrH7trmcUkBsCyu8fhKFYvkyL/nQnCLAo99
         Fi/d5opPfUi7aPmx+Ikg1RB+8tSPKbrki4mSQ+akv3jNGVpXNeTSDNTR0NerwpZPRGtB
         kkPiWz1KQlrvX4aSObx1E/vq59HtQ+VfwyeSES87TwXQA+SiqBzkhnxXGhvhzwB3jPNX
         D4gg==
X-Forwarded-Encrypted: i=1; AJvYcCU0XSncAUo17hlGvjvS1FWfovSgDZS1Ad0QS0rXPsVV/Z1SWx5OBa4n3/tWukQP241OvJv7Rkun+mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34syWob5ss3+DHtTlP4Sj/1617PiuZRjnUi/RnoDT6AkA2xn0
	GN7HvvvXGV5MPSQJoluvsSBJr5Z3nWyJtS5OlryhgxAYubsViDNJSgVfm7NjUWTRxgA=
X-Gm-Gg: ASbGncvj2PK3HwvPdMKLWHc8Lmvb6RrCJXtbi8FZP+miHjxedkvzfxcoMBTN/HAryJ9
	4nF0c5fgB1YNtWjqoZ3T1Oro3JhN3IN6xAZ3eRRHgeykwelQFbV6Q+EeCuvi/xWaZNH4k7sB/hh
	uxmc3L80CH5Ln4Rtl9KZeZ5RpDotJOemR9mOeiBp+VifuFuGv9vZPcmeUZCHQq/m9/t2PqHXIio
	qrxdvwogXW1LOClhghv6JyUHd1sKTwjA+5RCXsiYA69TenftBLLQRJPQJ6BhEjgViexRw3/7W9i
	OPYl2DMaCMg4xevnZp9plZvji7pfOJbsqcqHOYuJJN+bgC7tymGcEE2DweLwbrIzJSHBAVQZvqZ
	S9Tp6I8x5NFcSttIwXXtLJVMGEuM=
X-Google-Smtp-Source: AGHT+IGGVYXzErXFXuqWdpZbidTRzHjqEaCE+CrUvxDikjsokKsYjhP3LOanuYExDelRYdFsSrdp9A==
X-Received: by 2002:a5d:5846:0:b0:3a5:2ec5:35a9 with SMTP id ffacd0b85a97d-3a6d12c45ccmr4299674f8f.3.1750460933871;
        Fri, 20 Jun 2025 16:08:53 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647f29bdsm36635735e9.18.2025.06.20.16.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 16:08:53 -0700 (PDT)
Message-ID: <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
Date: Sat, 21 Jun 2025 00:08:51 +0100
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
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> But, the resulting code is wonky. It needs to do something more like this:
>
> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
> 		return false;
>
> 	if (error_code & X86_PF_INSTR))
> 		return __emulate_vsyscall(regs, address);

To do this, LASS needs a proper interlink against NX || SMEP.

If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
meaning that fetches are reported as plain reads.

This leads to some fun corner cases in SMAP and now LASS too for virt.

~Andrew


Return-Path: <linux-efi+bounces-3896-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC604AE26C1
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C3173830
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F42C2F2;
	Sat, 21 Jun 2025 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VUIymHWY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22790539A;
	Sat, 21 Jun 2025 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750467084; cv=none; b=Yum+9aoCVrv4QnWgD5dHNHtwCiIxvCWygMTS6J2e2tjaVlJHPJ3OgiPk31AJ6onAlSwKsLHLXXm7ce9M/jI5hLgxlvcOs9Fx8g5qU9dXRIisNdz1AQS3SM3hpWyajraAQAD5vfB/pG6w7wFBnyYoerM8UUhumSelQmvX8by6WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750467084; c=relaxed/simple;
	bh=mjLyVxKI89fLVKvD5qEgpVUzw9+sz+xpPSc2trtuMUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eVqDUmZgJRC4ceBXf/1Dm+SQnT98/fopKlZ9VzgfHm8Sa3r1wVdTR6zWNTSf4uB2HO0WaXFj+eDg/0lIF9K4flZyDluuhTtD3DlYEM4f0y1Zmx0Jp/Y8BtiCDchzWH1VpnPDeI/9t24TG3SIHIVVjhZKAjz+ytnw899Ksoxb7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VUIymHWY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55L0oJpw005744
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 20 Jun 2025 17:50:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55L0oJpw005744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1750467022;
	bh=8mp4H2Dh4pCq+5wlyN9ZrtiHLJlnNsb33zOx+M9tfYo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VUIymHWYeg2zZU8ZTGE3x5uN5qQUav/L2hRU+ARb5VILrC1d2nyCWg38sm9PrcVDv
	 DZ+vl6tFy8/5wuWp/gjs+vImUdfo4F/ohy8Oe2dkKSj3wa41PPW+d9PizYJXnVo23E
	 bD6npqiarkKjTl+oukVEzViu/IgPtYs7w22RTch3mnxmfQsdVppzJgBJ1x3uRbaATa
	 Z9v/1UEif3rlIOJJ8ljoo/Q10T+YK2aWBRcxfyZGW4S0TgMJG9sIpYJyN+T4qyRfMA
	 SqGeVbbXhKQpOOSU4cST9tzdxKY6XmfWR7yOkw9ZVKBxxursV3ek3k3ve30+jA8Tck
	 dYRAvXaQg3t8g==
Message-ID: <f04936b7-e1e1-4a63-a907-33315af0dd8f@zytor.com>
Date: Fri, 20 Jun 2025 17:50:19 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com>
 <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn>
 <aa91aadb-758e-42db-86ab-451384e466ed@zytor.com>
 <D8783A84-119A-4981-9EB1-12C21BB34714@zytor.com>
Content-Language: en-US
In-Reply-To: <D8783A84-119A-4981-9EB1-12C21BB34714@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-20 17:45, H. Peter Anvin wrote:
>>
>> But I simply hate adding a disabled feature that depends on !X86_64;
>> x86_64 has a broad scope, and new CPU features are often intentionally
>> not enabled for 32-bit.
>>
>> (X86_DISABLED_FEATURE_PCID is the only one before LASS)
> 
> More importantly, it is wrong.
> 
> The 32-bit build can depend on this feature not existing, therefore it SHOULD be listed as a disabled feature.
> 

Ok, that was word salad. What I meant was that the original patch is 
correct, and we SHOULD have this as a disabled feature.

The reason is that it reduces the need to explicitly test for 32/64 bits 
for features that don't exist on 32 bits. When they are flagged as 
disabled, they get filtered out *at compile time*.

	-hpa



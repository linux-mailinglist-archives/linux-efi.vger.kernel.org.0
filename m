Return-Path: <linux-efi+bounces-3897-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14202AE273E
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 05:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3F21BC6544
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 03:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080713AA53;
	Sat, 21 Jun 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fg1Rl96B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011510E5;
	Sat, 21 Jun 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750477032; cv=none; b=MI1oY8u7DRJJKxQVDbgq5gW4sxlQ3ZJ4tZAPcx0vtR9d0k0b4TC136dcv4Nc21G0wFkQFO/1zpmC4JlwsBmqUVccc5h/4pgrLMsFwtm9K9QHDOsblPPLn6if4+VFflujSu3CjWYcPT7+mfjSk9eQoZN4omG7AgDSixSnTBHbD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750477032; c=relaxed/simple;
	bh=9H/qYeTAQ/zxcfO5P9LTtIB4ECRa8QU9rE7gTO2GCKE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p47URasjQ5qyfWVXnIkM9SJWMrl8oBCJRNSfw40C/5ur0hzWi8N5ZpYPGkDYr5cR2ucbRfEPP7DgXpPnpc4+y/AU5rj29n0GGaNlMOVsbBRMdlB6U6mJ6ZNK93WbRxZzkeciIOU3/X2rVI5LEEUk/6va8QpjHiqQ/KzS3iLGWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fg1Rl96B; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.59.160.63])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55L3ZpFw045279
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 20 Jun 2025 20:35:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55L3ZpFw045279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1750476959;
	bh=e8u5GdAoNmNNX+7s1We8IvN8ajhS7ttID7S5qCJy8UE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fg1Rl96BlDPtm6MboBx7fzOIQO56zmQRAwuRt6FlJ5Bapo9PGVzdpzLSAZ7ASFEqt
	 crVA+NGYkWM8aOcqXlpqzrou88mmD1SFu6F9BHL274OJAOuur9ixBDgdltznH6dZIN
	 +chniuJQEHRtEdALpdS2BYSxcF4ACV9O+nY66VgpTTY22vDrz95BqnQ4FfEdVo3mFl
	 IusBJiUv0S0TVZHL6KVEXvkZPywCUakX8e9TTo4aeDnU9pKw7AbsN8tkC8QDECWNU4
	 KjiJbxr4qL4CmijeMCqcaTL7z6U/F9Nl6/Q+DFkXCEaRC1qlc6HVuA5XygN3fnbJDO
	 U+mqPnogQOeIw==
Date: Fri, 20 Jun 2025 20:35:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
CC: acme@redhat.com, aik@amd.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, ardb@kernel.org, ast@kernel.org,
        bp@alien8.de, brijesh.singh@amd.com, changbin.du@huawei.com,
        christophe.leroy@csgroup.eu, corbet@lwn.net,
        daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com,
        ebiggers@google.com, geert+renesas@glider.be, houtao1@huawei.com,
        jgg@ziepe.ca, jgross@suse.com, jpoimboe@kernel.org,
        kai.huang@intel.com, kees@kernel.org, kirill.shutemov@linux.intel.com,
        leitao@debian.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@rasmusvillemoes.dk, luto@kernel.org,
        mcgrof@kernel.org, mhiramat@kernel.org, michael.roth@amd.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        peterz@infradead.org, rick.p.edgecombe@intel.com, rppt@kernel.org,
        sandipan.das@amd.com, shijie@os.amperecomputing.com,
        sohil.mehta@intel.com, tglx@linutronix.de, tj@kernel.org,
        tony.luck@intel.com, vegard.nossum@oracle.com, x86@kernel.org,
        xin3.li@intel.com, xiongwei.song@windriver.com, ytcoode@gmail.com
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
User-Agent: K-9 Mail for Android
In-Reply-To: <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com> <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com> <b6f8a90d-4309-45c5-84cd-32e281d076fb@intel.com>
Message-ID: <D5C8ABB5-5185-43EC-8C3E-106DBBEBF389@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 20, 2025 4:21:38 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>On 6/20/25 16:08, Andrew Cooper wrote:
>>> But, the resulting code is wonky=2E It needs to do something more like=
 this:
>>>
>>> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) !=3D X86_PF_USER)
>>> 		return false;
>>>
>>> 	if (error_code & X86_PF_INSTR))
>>> 		return __emulate_vsyscall(regs, address);
>> To do this, LASS needs a proper interlink against NX || SMEP=2E
>>=20
>> If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR=
,
>> meaning that fetches are reported as plain reads=2E
>Interesting point=2E
>
>I think the easiest way to do this is just make a cpuid_deps[] entry for
>LASS and NX=2E If there's a CPU where LASS is available but where NX isn'=
t
>available, we have much bigger problems on our hands=2E

Indeed=2E There is exactly zero reason to support this case=2E


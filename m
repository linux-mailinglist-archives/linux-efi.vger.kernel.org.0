Return-Path: <linux-efi+bounces-3948-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C75BAE5F34
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 10:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06657B15A4
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7E257AF8;
	Tue, 24 Jun 2025 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ntiLKVGj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E42571DD;
	Tue, 24 Jun 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753658; cv=none; b=f19qqcjhDp1opw2781nsVZ2oCqJdbSp90tLtCHPkQ5Ds2Ow9sprZPmnG2LDOn0PCSz+kmlCAN/hh40u05T7ZibWNWhwbKF9py0teLI4zTAiY62yGT751xlaEDZgX7HnqlI0le9aAaF7Qk6kjLGfNmdj4s1v6r0ZYtuFtp+TgN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753658; c=relaxed/simple;
	bh=H9y34vir+9nirPEjwoiMIfT3bIIQ67ZyNybg+nCN+Vs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FOnKJSRmCa1XRZoT9N6Yj9MU2phgh9D+B8tff0nfKJRSxcuTpYXonBCTuBq24kzSGetxDXlo50Lw4mlwaxH0foZhl5kXIWJZaBtj20FPCwElGAKEynYnzHVBdGVfOJI7+JOQNlIviN91WcvS56/lZGked53NT+RqBBb9w656w80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ntiLKVGj; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O8M1nR1268415
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 24 Jun 2025 01:22:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O8M1nR1268415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750753324;
	bh=/GcMmlSpVmJGdK70vVLdVq+WGghRjcWXQ50iTcyNOcA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ntiLKVGj72JidONcwsNyF7DiOUmQsTszeaPpNemwiXD6CPdpKiW9vohotZJ/Uypgh
	 1g5A/YBi/YEX1VbFBd5znZPwQ71z8MhTOIB9sgTundppHmWvz2rpdGfYCcZ8tJO9u+
	 OoIEreNgnqijK49eia3xSxorTmqUuEiQr65WeF+uVFzQmzEdrfC5ZDMACjjVumZyLS
	 dKFSVjbOay6ynxoXAyfVIUCOsknfeZJ4Qyr7DJ+7+5ZZy5uSJ2aUlTLPc/BCDyVwUs
	 ojq2ITfPl9h3690j9i1ylwg3seoaa3MSTMp99lLAi4NM34mJTXaK7RnV+YEBN6fACC
	 I5SNz2Sn1RArw==
Date: Tue, 24 Jun 2025 01:22:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Khalid Ali <khaliidcaliy@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, corbet@lwn.net
CC: luto@kernel.org, peterz@infradead.org, ardb@kernel.org,
        jan.kiszka@siemens.com, kbingham@kernel.org,
        kirill.shutemov@linux.intel.com, michael.roth@amd.com,
        rick.p.edgecombe@intel.com, brijesh.singh@amd.com,
        sandipan.das@amd.com, jgross@suse.com, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv2_0/3=5D_x86=3A_Make_5-level_p?=
 =?US-ASCII?Q?aging_support_unconditional_for_x86-64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250624081400.2284-1-khaliidcaliy@gmail.com>
References:  <20250624081400.2284-1-khaliidcaliy@gmail.com>
Message-ID: <3EB75889-2194-402F-AF85-2CC96DA5D8F2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 24, 2025 1:11:15 AM PDT, Khalid Ali <khaliidcaliy@gmail=2Ecom> wrot=
e:
>>Both Intel and AMD CPUs support 5-level paging, which is expected to
>>become more widely adopted in the future=2E
>>
>>Remove CONFIG_X86_5LEVEL=2E
>>
>>In preparation to that remove CONFIG_DYNAMIC_MEMORY_LAYOUT and make
>>SPARSEMEM_VMEMMAP the only memory model=2E
>>
>>v2:
>> - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
>>   #if CONFIG_PGTABLE_LEVELS > 4;
>> - Rebased onto current tip/master;
>>
>>Kirill A=2E Shutemov (3):
>>  x86/64/mm: Always use dynamic memory layout
>>  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
>>  x86/64/mm: Make 5-level paging support unconditional
>>
>> Documentation/arch/x86/cpuinfo=2Erst            |  8 ++---
>> =2E=2E=2E/arch/x86/x86_64/5level-paging=2Erst         |  9 ------
>> arch/x86/Kconfig                              | 32 ++-----------------
>> arch/x86/Kconfig=2Ecpufeatures                  |  4 ---
>> arch/x86/boot/compressed/pgtable_64=2Ec         | 11 ++-----
>> arch/x86/boot/header=2ES                        |  4 ---
>> arch/x86/boot/startup/map_kernel=2Ec            |  5 +--
>> arch/x86/include/asm/page_64=2Eh                |  2 --
>> arch/x86/include/asm/page_64_types=2Eh          | 11 -------
>> arch/x86/include/asm/pgtable_64_types=2Eh       | 24 --------------
>> arch/x86/kernel/alternative=2Ec                 |  2 +-
>> arch/x86/kernel/head64=2Ec                      |  4 ---
>> arch/x86/kernel/head_64=2ES                     |  2 --
>> arch/x86/mm/init=2Ec                            |  4 ---
>> arch/x86/mm/init_64=2Ec                         |  9 +-----
>> arch/x86/mm/pgtable=2Ec                         |  2 +-
>> drivers/firmware/efi/libstub/x86-5lvl=2Ec       |  2 +-
>> scripts/gdb/linux/pgtable=2Epy                  |  4 +--
>> 18 files changed, 13 insertions(+), 126 deletions(-)
>
>I think i am too late, however this is completely wrong=2E There are stil=
l processors that doesn't support
>5-level paging which is mordern=2E We may call those processors old, howe=
ver they are still common and used=2E
>
>So this patch seem too early for that=2E Some intel core-i5 and core-i7 d=
oesn't support 5-level paging at all=2E
>
>This will break x86_64 cpus that doesn't support 5-level paging=2E

Uh, no=2E Kernels compiled with 5-level support also support 4 levels=2E


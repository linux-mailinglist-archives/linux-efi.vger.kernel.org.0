Return-Path: <linux-efi+bounces-5129-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF21C0A075
	for <lists+linux-efi@lfdr.de>; Sat, 25 Oct 2025 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DEF1A66E2B
	for <lists+linux-efi@lfdr.de>; Sat, 25 Oct 2025 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A2283FEE;
	Sat, 25 Oct 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="M7IyTQoS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD42AD2F;
	Sat, 25 Oct 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761429057; cv=none; b=lbAH3EbDfOQJJ8ZrGUotgvUAmRBN/azD+/GeYWSk1q7Y99i13zcwvlGdL65Tz77gsQLuTfC1tyWSFCJWSMIEIROy6JQjj3EKsRMC5XNHSPDim5WXoasMr+fu4cfspHrIPJuzPAj4Jw4Q/e5VaCLu6ztMBedEm3hxVc8R/OeOynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761429057; c=relaxed/simple;
	bh=WV6sOsK95CL79pnSDWklrqcJbBh9kw7B+++33ob0zhE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VSI+ZqC95H+P+br+Nl9lg36rFKjAAJyfyyhtGB4C3fJox0bLmZNm6S1ujpOQ0kIs2zqqU/q36Y09SYR7WC8pvArQGHaqGB6uD+VZpuKHNJPBucIT0xSnMakFKOzKrW1D0IH69wrLqbRKFgxAp7spNJcf3nakFgF2YcAnjsxAY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=M7IyTQoS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net ([172.59.163.204])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59PLoG1S4179485
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 25 Oct 2025 14:50:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59PLoG1S4179485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1761429018;
	bh=eXQiaXQMBEkffKXwky4JNR+uRHh73bSTtxccDACEux4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=M7IyTQoSCYKp2vhd4FVMOvpoxDSprmjVQjBDad8TG0neqPd1dJLogdJmlkfwB0/zM
	 7ZdSbTD+ffmRhEB7hQk3DhSLOub/eX6QVXu9SbHz66XeQycmWFnyk8dLduDzmUYNdF
	 zA/OemUVELrulEMU1bz5Gq05QNoabeBE/CAKLReVVEV5Cya7JbXrH5LjCtvExcbePe
	 k+zqo09jA+W5Qubulr64zdW+GvUmwRt6g5LV7fq9vJDCl/tnArZKQgh20joJYfMIJW
	 B8W+clI9xeGbcPyn/JiKbJUzbczRW8Xs15EzsN7EMo3xcLuSxpnHbKLCOjpbO2JcJe
	 7DcBsl0zTsqQw==
Date: Sat, 25 Oct 2025 14:50:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Usama Arif <usamaarif642@gmail.com>,
        dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, ardb@kernel.org
CC: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com,
        kas@kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, kernel-team@meta.com,
        Michael van der Westhuizen <rmikey@meta.com>,
        Tobias Fleig <tfleig@meta.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_x86/boot=3A_Fix_page_table_ac?=
 =?US-ASCII?Q?cess_in_5-level_to_4-level_paging_transition?=
User-Agent: K-9 Mail for Android
In-Reply-To: <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com> <20251022220755.1026144-2-usamaarif642@gmail.com> <8283c1b6-1487-49e2-b220-7dbd043a2913@intel.com>
Message-ID: <7BB09BB9-7034-413B-9FA8-D3FC3EB352D7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 22, 2025 4:16:34 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 10/22/25 15:06, Usama Arif wrote:
>> +		pgdp =3D (pgd_t *)read_cr3_pa();
>> +		new_cr3 =3D (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
>> +		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
>
>Heh, somebody like casting, I see!
>
>But seriously, read_cr3_pa() should be returning a physical address=2E No=
?
>Today it does:
>
>static inline unsigned long read_cr3_pa(void)
>{
>        return __read_cr3() & CR3_ADDR_MASK;
>}
>
>So shouldn't CR3_ADDR_MASK be masking out any naughty non-address bits?
>Shouldn't we fix read_cr3_pa() and not do this in its caller?

Ah, the times when one can wish for C++=2E

Too bad they still haven't figured out tagged initializers=2E


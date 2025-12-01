Return-Path: <linux-efi+bounces-5740-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31431C98B8C
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22799343754
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149B21D3F4;
	Mon,  1 Dec 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdEAf+gF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9E211A09;
	Mon,  1 Dec 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613965; cv=none; b=EVd1N8Hl6s62Szvtx727xNJ50KXzv5pXE2nRFQH+3Okf4YVOR3HQaa4tVeyg6y8LmyCyV+afaZss/QEaXZ3NBAOM9gT4JUbcFmG9R+XaUmxPeYBZ7FBRGS+hNAfVZ9qOT6yM3OF4ocz08bNsZRZjNun0OvDPmWlaAB4wYF0qt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613965; c=relaxed/simple;
	bh=2IfzNXSfzN92nTYZTzGsXr1fBjpjDfpWrXwW0YZPKmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrIUN8VQD8ebyaVAeTlOS5vOPfU2nlmJby82CYC1e0ehacBzZl0lA04PzPrEdg8etHDur0Mc5rnTWfVm4sB4aL5LxodkTjy49KgpkvIhslqRQ/YXB+ob5Xr/ymaLEXccetwf05ps1wRcdYkGdRaWV8zcWvhgeg8ZnV+vaQPvVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdEAf+gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95955C4CEF1;
	Mon,  1 Dec 2025 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764613964;
	bh=2IfzNXSfzN92nTYZTzGsXr1fBjpjDfpWrXwW0YZPKmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bdEAf+gFID+PrIxA1/+WE4DYDfDJBXtzv1cVw+nJIpuZeM4V7UDOI6jNrBiUD+JiU
	 Do/ziqGJ20sAbyjbWPOYm7gpCJsOOaoO0oOY3Q/c/n2u2g3F3WkpuCK+tGySIpJ7/a
	 4bHtVR3xPkyARb5tRlMwGubNri7MqXAER1PYHxOrlxfT978nc0ysn8YYAyDp0R2UJa
	 ylvgL0h8z4rxROQi+p/OmfAf/EI5TUidCbLe8wG4JDv0gCn34+s5WqaQzw9lbi9t+0
	 YB+7uvR+JnDYAJVwUa/iKVshebyq9AUbnu27D3pI2QqNfHXVsrtP4EF6cRnIBRZw1w
	 svVlqTs6UAx3g==
Message-ID: <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
Date: Mon, 1 Dec 2025 19:32:38 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 12:12, Borislav Petkov wrote:
> On Mon, Dec 01, 2025 at 10:18:37AM +0100, David Hildenbrand (Red Hat) wrote:
>> Makes sense to me, especially for confidential VMs where we pass such
>> kernel-managed data from the old to the new kernel.
> 
> It shouldn't matter, right?
> 
> I think the question is whether the kernel should agree to the software
> contract (/eyeroll) to keep the kernel ABI compatible wrt kexec.
> 
> And I don't think we have agreed to that AFAIK.

I think we are in agreement: from what I recall, this software contract used to be
rather simple and stable.

Looking into the details, I guess it's all about

$ grep "define LINUX_EFI_" include/linux/efi.h
#define LINUX_EFI_CRASH_GUID                    EFI_GUID(0xcfc8fc79, 0xbe2e, 0x4ddc,  0x97, 0xf0, 0x9f, 0x98, 0xbf, 0xe2, 0x98, 0xa0)
#define LINUX_EFI_SCREEN_INFO_TABLE_GUID        EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
#define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID      EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
#define LINUX_EFI_LOADER_ENTRY_GUID             EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
#define LINUX_EFI_RANDOM_SEED_TABLE_GUID        EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
#define LINUX_EFI_TPM_EVENT_LOG_GUID            EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
#define LINUX_EFI_MEMRESERVE_TABLE_GUID         EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
#define LINUX_EFI_INITRD_MEDIA_GUID             EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
#define LINUX_EFI_MOK_VARIABLE_TABLE_GUID       EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
#define LINUX_EFI_COCO_SECRET_AREA_GUID         EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
#define LINUX_EFI_BOOT_MEMMAP_GUID              EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID     EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
#define LINUX_EFI_LOADED_IMAGE_FIXED_GUID       EFI_GUID(0xf5a37b6d, 0x3344, 0x42a5,  0xb6, 0xbb, 0x97, 0x86, 0x48, 0xc1, 0x89, 0x0a)

Likely the format of these section stayed unchanged over the years.

-- 
Cheers

David


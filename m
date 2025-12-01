Return-Path: <linux-efi+bounces-5724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D32C9659F
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 10:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 486F4341E78
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4812D1907;
	Mon,  1 Dec 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCLEM5LO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0021765B;
	Mon,  1 Dec 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580725; cv=none; b=Ci7UNPBGRfX3ZmpUDMkEth3XW0SIMXDFe7rq0grdr8rMrPLbkVcQjxZTX0ampw1ySmAYC1CYJwCjjTNCtchDUZEf2M0tqg7tu8uMkffA/mdpr7NFLO64uby1f/vxP7lg9qZfrJQTa9iU+k/MtQUHLgmHSlR5crdLftJ/O3G8lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580725; c=relaxed/simple;
	bh=qWp6QKEfPfpxLUmqgtn55SeILlnnhx0o/0HpFCZjylY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFVGtRb8ptsT4QcO6frkvFPxiyhzbvUJX948+CRIGc48d5v0yiE7dySwT9LwVgRLnpxNYnx8V6/YIA0O6qYP3AT66DFA9BntLNIKbdDjPRR5WStxCaVGRQF9EEWhsMLLazb8yv4bCIj/arfDqGQiLmW3VLa046CavI+uPqt3+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCLEM5LO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91652C4CEF1;
	Mon,  1 Dec 2025 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764580725;
	bh=qWp6QKEfPfpxLUmqgtn55SeILlnnhx0o/0HpFCZjylY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LCLEM5LOdK4VTSpDstiX63Jcdt88wt0TLg17IBcCaa43907suA29aPg/LYKHG0q9y
	 70BPoZAyi/0h0BWg9phe/Wx4nxITfIF+JH8jTzpmijHYnh7kZRMkXc5QmS+XrTY1Fp
	 SERtNsiEKqfUMDjpm90ZWmnJaja9csucNVSgviYi4L5UEipYBzxCU9GL1oeOmIRmbb
	 eK9j+iC7NmO3a8Ru205q3gCmqa1prsC9bd31ydK9UBwGwxr9tt+BnIYE6tnhRHi4Ik
	 97YkhkH06XH62JmMxo2htRq3qaWecptFQrE+Fdxi630V3F0kSCokiDvVYJlNhutqEM
	 EyuylCUql/yDA==
Message-ID: <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
Date: Mon, 1 Dec 2025 10:18:37 +0100
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/25 12:34, Borislav Petkov wrote:
> On Fri, Nov 28, 2025 at 10:30:15AM +0100, David Hildenbrand (Red Hat) wrote:
>> kexecing the same kernel is typically used for kdump purposes.
>>
>> kexecing different kernels is used for all sorts of things (live-upgrade,
>> grub-emu come to mind). It's quite common to kexec different kernels, or
>> maybe I misunderstood the question here?
> 
> And my question is: since when do we enforce no-ABI-changes between kernels so
> that we can kexec any kernel into any kernel?
> 
> By that logic I should be able to kexec 5.x into 6.x. I'll bet some money that
> it won't work.

I *think* ordinary kexec would likely work, as I recall that it doesn't 
need a lot of that special kexec ABI sauce like unaccepted memory uses.

Within confidential VMs (kexec ...) I am pretty sure that it's a 
different discussion.

> 
> So unless it is written down somewhere, I think we should probably talk first
> what we want to support and why...
> 
> Makes sense?

Makes sense to me, especially for confidential VMs where we pass such 
kernel-managed data from the old to the new kernel.

-- 
Cheers

David


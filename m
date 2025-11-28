Return-Path: <linux-efi+bounces-5715-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961A6C91725
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C863A64B5
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF7302CCA;
	Fri, 28 Nov 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd2NiCXu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35762302CDC;
	Fri, 28 Nov 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322222; cv=none; b=SS5Yh+3VpU3BYDyDnj6saVW+EKlkVSo9o28RnWeFZWD9kBhbW/1gWpvV1m2J9oauQriLW1YqB+6nPlj2lPQH6BAtDLM4qGsrZ9CJ5I1PrZRpz1NuMPwbVmCyW2d5Ek7oy7dmDjz97EloVLITsfuF4dJKNJw3Qv19FwtMXK19Vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322222; c=relaxed/simple;
	bh=c+ju217X/Iu2Eyrw3ITJ5fQi1c/hHwxKC7muOjOFeAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWjarYT8FAXTnuS1lqD1Vr2pUtDRCZdpSk43kR+8CcEYwUOCH9L2HdMQ/FQW07+wqLnHciKh833TjW5ZQRYR9wp7cZlv4CCML0Qzcf8rOWkxWAgnl7fYvORZz1bQPyeslfUuuu6CFn6QWHJQqtiYqSg8Ca5eG25LBKcSYZTNhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd2NiCXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA9C2BCB8;
	Fri, 28 Nov 2025 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764322221;
	bh=c+ju217X/Iu2Eyrw3ITJ5fQi1c/hHwxKC7muOjOFeAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qd2NiCXui9tsiwdCYok4UcUDQqTMMHZ6dOVLI2a8Xq54o7qj/gy6iWGAmfeyWL5FA
	 AsOozZOa2wastuPtMQVwdg+nw8TUIggbbXDbFvAXxxuRXII5OylWbCEY0d0IK7wAWz
	 YWD+EnnPEc5wBSsoeAdM35iCQM2bQmQXYCl83xolfiOZLxpllI6bTnSbqXqKeSPA6y
	 JNgKKja898564OBPnGHhqQ5sySb/JvG6rdgJsmNB+YH5OWCZYPmzzCKCsmOfzJvWh4
	 UO4uKNdhhtpsauOOAJQyf34Zczo24r/NZ29e9HNiu1foo4xfKEQQKStJKSQcPQGtua
	 Yv3nsgTV78cFQ==
Message-ID: <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
Date: Fri, 28 Nov 2025 10:30:15 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Borislav Petkov <bp@alien8.de>, Kiryl Shutsemau <kas@kernel.org>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org,
 osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/25 19:12, Borislav Petkov wrote:
> On Thu, Nov 27, 2025 at 05:35:57PM +0000, Kiryl Shutsemau wrote:
>>> ABI break for kexec? Is that a thing?
>>>
>>> Since when do we enforce ABI compatibility for kexec and where are we
>>> documenting that?
> 
> I'll take that as a "no".
> 
>> The whole purpose of kexec() is to switch between kernel versions. This
>> struct defines format we communicate information about unaccepted memory
>> between kernels. The mismatch will lead to boot failure.
>>
>> The structure is versioned. Ideally, we should know the format of the
>> structure the next kernel supports and act accordingly in the first
>> kernel. Like, we can accept all memory before kexec on mismatch.
> 
> None of that matters if you kexec the same kernels.
> 
> IOW, for some reason you want to be able to kexec different kernels. The
> question is why do we care?

kexecing the same kernel is typically used for kdump purposes.

kexecing different kernels is used for all sorts of things 
(live-upgrade, grub-emu come to mind). It's quite common to kexec 
different kernels, or maybe I misunderstood the question here?

-- 
Cheers

David


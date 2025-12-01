Return-Path: <linux-efi+bounces-5746-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF0C98F72
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 21:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AC345021
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 20:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109AC2571D7;
	Mon,  1 Dec 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1QVgUHM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3826248F57;
	Mon,  1 Dec 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619842; cv=none; b=VFlw0Xc+lfwG/GMod8ULVxUQ+f8Iuv7Khliy1Ic4nf7NOMbk2vOib/D1i0ja6tqNAxisBJWdmGDE7FTAPT/8eLCT69g99Ksl7DVkzoQy8qo5zbcp1BJ5yaos3DjTvlGXBT0WFT8KkpzOZgPAeOTXY05j9WfVyFFYw7stYsB7csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619842; c=relaxed/simple;
	bh=hoZr9ZDqrSasGQq9xDqBsQud6miZ87nkO1FhX8K27vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtZqg1AyvNZe3KGklOxqvWsPbzDP73WZ3lJnrilmghOsYr0jDjIhENHkhFcMpiVC1aC2++mERcggv+BMCKs9T58gQ4tnqkTPeCGUr9owgjzjnOiphu+GqR4C2XOtHKtNCvQo/jwikz8dd72JO0yu4CZ0bci9uPvIYyeYn7wgxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1QVgUHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A0DC4CEF1;
	Mon,  1 Dec 2025 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619842;
	bh=hoZr9ZDqrSasGQq9xDqBsQud6miZ87nkO1FhX8K27vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F1QVgUHMWRD99MrQdXIUYwpvo8wZMIhpPmXAQZoBiJfHgVYuQUXLMhLU17qdMQEi0
	 NZy1bOijLnnaFdsm89ArW2j4zCra6sxNc2nik11uGWKeTo5KwTxTnS+cOKXB3U2LR2
	 tjTfN/oHANb0DRigoVJ0hNLCEPkmaZbNDhagE+6nPnLByxcv/4jKfW56kF8ROYiTSP
	 1LEaYjIFbzKYK8LXluqCMvdB3x9GcCehti4X37rq2C1gF5ju2VYoqUuISlkOtO+1My
	 KWOEL2xibAh6obECR7KhRg2eNpGswQtmO2brUCDPs1BrVkqdWr7VUXa4LuSrEiQOOp
	 tZ+DtTsqQsv+w==
Message-ID: <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>
Date: Mon, 1 Dec 2025 21:10:26 +0100
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
References: <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
 <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 20:10, Borislav Petkov wrote:
> On Mon, Dec 01, 2025 at 07:32:38PM +0100, David Hildenbrand (Red Hat) wrote:
>> I think we are in agreement: from what I recall, this software contract used to be
>> rather simple and stable.
> 
> Ok, please point me to the *explicit* document in our tree which says: "we
> won't break the kernel and support kexec with any kernel version"?

Just to be clear, I don't think it exist and also I don't think that it 
should exist.

> 
> Something ala Documentation/process/stable-api-nonsense.rst
> 
> Which says things like:
> 
> "Assuming that we had a stable kernel source interface for the kernel,
> a binary interface would naturally happen too, right?  Wrong."
> 
> Which I read as a "no" to the kexec question too.
> 
> IOW, it is not about whether it works or not - it is about enforcing that.

Agreed.

-- 
Cheers

David


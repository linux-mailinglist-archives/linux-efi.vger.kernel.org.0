Return-Path: <linux-efi+bounces-5748-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4623C990C0
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6356D3A462E
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8725392C;
	Mon,  1 Dec 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi22TA//"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6936D50A;
	Mon,  1 Dec 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621427; cv=none; b=B41RYifdE2RNVXW5S65hZLBF8aOJ/H1FD0bgFLh5+gQx0Ki3mfOTNzlCC6VfiQeT9fMANzlJVfYYuY9D9kyfTbEnlc8iPEUocrv0qprGhkrmWMtK9VNFjGwJf8ZxDeAdRGWujD29bQ02vuYqxMtRIYQrd09hkb2DRJqUQqwgvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621427; c=relaxed/simple;
	bh=PmhAts491XzuroHVSlK8NY9S+n+kVfTtaW7AXN6Kq3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leqeop9LJysWcrz5aDSlZrU4EGe3Yw9LiCteUMnm9BAstiAzCuH5L+myH7yKH2TZokfCgwfpJmvvKULhjAknuT3ao+UdUitFa33bLIPB2VGMhN/Bg5kfbC12wFF5n/7KuKHx9ufGbrMkiab+VKK3Or595on84/DwtRsXKtECVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi22TA//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78BAC4CEF1;
	Mon,  1 Dec 2025 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764621425;
	bh=PmhAts491XzuroHVSlK8NY9S+n+kVfTtaW7AXN6Kq3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qi22TA//4UhyZnUo34ywTeiqH2Ar85pgmIalWuJljf3u48IW9oDXRE2Q08wJa6Y3a
	 hr5QsG3gO6KOGsUvXYO/Gpfv6whabj2O6vVdCEz2Xjx6pFPNKiG4BWIU27yJ7F6E/x
	 T5blgTqII3AsketDw1OXlnbit7qd4vhllSlE710rFR3uJqkpYrTFkVMyEfl8y81n4R
	 yG6Cyw98/yGe1Goo9VdcKeD2H1iKOIJKKLtsftzbCjn1p3RF1NXZVmFIhY6A1Y9N2c
	 FJVCQHiTYzWtqDZUdoxNk1/vw6S2ed72f3bOOIeYFerIlM/o/nCaoYu/DghBbByxD7
	 w06MmMmaqwXjg==
Message-ID: <420865fb-34cc-43a8-820c-b15b5f24a27c@kernel.org>
Date: Mon, 1 Dec 2025 21:36:58 +0100
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
References: <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
 <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
 <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>
 <20251201202507.GFaS35o7WtLJOM0_jh@fat_crate.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251201202507.GFaS35o7WtLJOM0_jh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 21:25, Borislav Petkov wrote:
> On Mon, Dec 01, 2025 at 09:10:26PM +0100, David Hildenbrand (Red Hat) wrote:
>> Just to be clear, I don't think it exist and also I don't think that it
>> should exist.
> 
> By that logic if it doesn't exist and someone sends a patch, I should simply
> ignore a review comment about that patch breaking some non-existent ABI and
> simply take it.

Well, we can always discuss and see if there is a way to not break a 
specific use case, independent of any ABI stability guarantees.

> 
> Well, it certainly works for me.
> 
> Unless you folks come-a-runnin' later screaming it broke some use case of
> yours. 

Heh, not me, but likely some of the CoCo folks regarding this specific 
use case (kexec in a confidential VM).

> And then we're back to what I've been preaching on this thread from the
> very beginning: having a common agreement on what ABI Linux enforces.

Right. Maybe Kiryl knows more about this specific case as he brought up that
these structures are versioned.

-- 
Cheers

David


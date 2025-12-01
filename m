Return-Path: <linux-efi+bounces-5749-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB1C99160
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 21:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FE4E2D8C
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F525F988;
	Mon,  1 Dec 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="hjzVlElH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC972080C8;
	Mon,  1 Dec 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622319; cv=none; b=sOGtMm5kdTmiasSo2EfhyKz4FYD57IeqzJrqTKvrOtSXkTNwuWcG/mGkTB/DhLLjQQf+VnNTpff4mFMkOBf0DsmomWdZEQlMSN2eY3jfH2WxkXybyOmVzD2+LWHBeJHHCbC54EI4/V2cQL4qs+OpOkJxhdyPR9rsAE4AF8FRRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622319; c=relaxed/simple;
	bh=D+KSoh6U6uQ9naSe9zJXIqMp501MOwXAvBYBsKvJ82M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTgRZn4g0nbXHdBiqhzAdTKEk/jnkdJQcbmJrxU03UrTZvtfNQ5Hkl5LQ23FnyHz503Rmk9p9Mm54K8eF0FPfO0wNX7S8VWjFkJZxjmFndGUyQ1n0twFubEG6txYDjKVCdmHIqYHEp4t5aH8J9bCDkHMhf3N5PoszcRL47zTZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=hjzVlElH; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4dKx0P1wFFz16Ps;
	Mon,  1 Dec 2025 15:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1764622309; bh=D+KSoh6U6uQ9naSe9zJXIqMp501MOwXAvBYBsKvJ82M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hjzVlElHok4mx2EA9fcENdLZ4mFjFFlxiD3JaM6tooDgOx1/KunOpvqr9GLMLqrso
	 M2HL3IW+5c48L+OqSuuWlMQrl59kYn4pTF7jNI8Jr1z+UycyYXyBUNv33YA9AD3V0w
	 tozbrwJgPLbqzql9/55rQinVUHSjMQU3Cwv5a5Os=
Message-ID: <628342c2-15c5-4890-84ae-dc29df2c5f16@panix.com>
Date: Mon, 1 Dec 2025 12:51:48 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops when returning from hibernation with changed thunderbolt
 status
To: Michael Guntsche <michael.guntsche@it-loops.com>
Cc: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-efi@vger.kernel.org,
 maarten.lankhorst@linux.intel.com
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com> <aSGTghJyX-u-leL6@wunner.de>
 <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
 <CALG0vJv7ZA8byAF25pKqh9fEBpfgbXk+cAE6s9K1N6ZvVRroUw@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CALG0vJv7ZA8byAF25pKqh9fEBpfgbXk+cAE6s9K1N6ZvVRroUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/1/25 11:09, Michael Guntsche wrote:

>> FWIW, this sounds really familiar (resume crashes if I changed TB docks
>> between suspend and resume) and was getting an OOPS there I'd bisected to:
>>
>> Resume OOPS from f6971d7427 ("drm/i915/mst: adapt
>> intel_dp_mtp_tu_compute_config() for 128b/132b SST") if MST displays
>> disconnected while suspended
>>
>> ... and this was fixed in 732b87a (Fix determining SST/MST mode during
>> MTP TU state computation) back in 6.15 (which IIRC, is when your crashes
>> started happening).
>>
>> I wonder if this is related? Maybe reach out to the i915 guys?
> 
> I tried this now with 6.18 and got the same issues, now it even fails
> for me  if I unplug the dock while hibernating.
> The last entry I see is the UBSAN message and an out of bounds index error.

I guess what I'm wondering is if the fix for me broke things for you ... 
can you revert that change in 6.15.1 and see if things unbreak for you?

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA



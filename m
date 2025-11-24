Return-Path: <linux-efi+bounces-5676-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55723C82016
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C81F3AC540
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B352BEC41;
	Mon, 24 Nov 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="uzT18HvT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC18316900;
	Mon, 24 Nov 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007336; cv=none; b=EWVf1dO5gc91FQ5FtYU6wWBvizwNlpEhT8bfYKTQL4ROb/5ClvD897RaR+MzJGNxCUa3ulaLZBs4EDSx4SVSgMTss30qJ7VrgrpnX6MUrssPlcj+RwYo7CCudUOhY7mXC2+dMYUIuQ7CzDTtElfqS8vmeK6UfPCcEhppExdFhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007336; c=relaxed/simple;
	bh=FhfVkAsfNdsFdhI8lvJ5LkMDe1YEZB4iPo9Utu9w2XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyPC9nq34X41ImKVsMTRIbqw2jvogpEykMvxUY2OouRrLfUvg0tKRhYre4oY9AArHudgQ/2JZC3+n6hUqyCvMtieUaLFBQa1PEQnIBq3RIhOhYycyNPL0TlzVlYtRy3qE3uTxp2P53UqfH3aBPpX0xZYFCag7t2o7H+tIHFk7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=uzT18HvT; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4dFYYn2cB4z4X2K;
	Mon, 24 Nov 2025 13:02:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1764007325; bh=FhfVkAsfNdsFdhI8lvJ5LkMDe1YEZB4iPo9Utu9w2XM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uzT18HvTQ/HnYY8yguVhBDIjNPYEl/qVzyx3Y+wkg34bbjsupfttDA0mT+D1l7W+a
	 a74QxUWLFQmCUVJUDvP6PCbrGaRZnr+wqxmkHn4zDHc3QrZ+Cb+nzwLgGggHOE7hIO
	 QMGpY3L4e6/I66firxyMYgxBTEKEeZ/R+3npupws=
Message-ID: <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
Date: Mon, 24 Nov 2025 10:02:04 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Oops when returning from hibernation with changed thunderbolt
 status
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Michael Guntsche <michael.guntsche@it-loops.com>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com> <aSGTghJyX-u-leL6@wunner.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <aSGTghJyX-u-leL6@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/25 02:42, Lukas Wunner wrote:

> Also the photo shows a UBSAN splat in drm/display/drm_mst_topology.c
> 220 msec before the oops, maybe it's related?

FWIW, this sounds really familiar (resume crashes if I changed TB docks 
between suspend and resume) and was getting an OOPS there I'd bisected to:

Resume OOPS from f6971d7427 ("drm/i915/mst: adapt 
intel_dp_mtp_tu_compute_config() for 128b/132b SST") if MST displays 
disconnected while suspended

... and this was fixed in 732b87a (Fix determining SST/MST mode during 
MTP TU state computation) back in 6.15 (which IIRC, is when your crashes 
started happening).

I wonder if this is related? Maybe reach out to the i915 guys?

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA



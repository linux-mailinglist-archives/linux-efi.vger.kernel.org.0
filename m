Return-Path: <linux-efi+bounces-3480-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0FA9FEA9
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 02:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614715A62C5
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342CC13B58B;
	Tue, 29 Apr 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lso/JJ5k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644A86338;
	Tue, 29 Apr 2025 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888203; cv=none; b=hTNqvaw4R5KRS4FcTE3ouP8C6niA/FrRYCr9tTmwVHLlzRVIDnu6fvHWiAFhZriD6J4+yG0P3HxPQ9Zol/JCkFNRhFstNkhG271Jm+xudBSnMO7chW0VFh7zsAykYoBHi/rYSwEV7rIgJ54l0f0zkAHB1/g8e+oDlONZF4EPs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888203; c=relaxed/simple;
	bh=BwErcrUVT5FMYq5kvaleY8ubULHmM0h7cgHWh+9nRh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjFPuiCzB0GbHgN5LLsD4m4MOAnQa5CnPoNPNZ8a1/0R82/mznuKdHRGbWFe3N3Jf7vLZVTcJIEiOTnDfB28knDn0n53KV2652GtHw3H1IFwivN5ebr1pYLy8sLVbCcgRAk/bSxQEqxPVd3naVWa+MYj109vuk1clOu996S8WdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lso/JJ5k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745888201; x=1777424201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BwErcrUVT5FMYq5kvaleY8ubULHmM0h7cgHWh+9nRh4=;
  b=Lso/JJ5kSA8r1lYCeWWJ/S6BQ3euh+RGfJPtsu/mzJvp4juLlutroM+x
   CGgXEgYHvY+VJhXkQwvdzQFUWtl+QiiZClxArFah8KBNAHcpw8Urz/ghq
   q/qiR40JH2YJj8hoN350rJQ6Y9V12jEhrjaUpLVSJXSFL0PGRfFYD0wDY
   twlvhAJUGVWzQ6cAzj5H+kgoaKTHcz7zfTBwGvtg+lgXTaQL0Nr9TFLZ5
   /T0fC/vWWjAauO+KpuupgfHLLHyVKmy41BmexQXXSGyfQDNF/FlY6yecr
   iGgWpMeDuRbH0P2VXOgPkfOw1h/kB09+GpbwKDHC2P86URrYXevgQB4Lm
   Q==;
X-CSE-ConnectionGUID: cGykmTdtQB6ZCEH0WRnpQw==
X-CSE-MsgGUID: kAloYNsmTGa9jg2vkUuwpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="65031994"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="65031994"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:56:40 -0700
X-CSE-ConnectionGUID: NsIFn/EMRPuSNGP1biZbdw==
X-CSE-MsgGUID: LNOqP8N1RTON31J+6EQWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="134189495"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.223.46]) ([10.124.223.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:56:38 -0700
Message-ID: <fbb23ee0-c0b4-4b0e-8861-940f8ceaf161@intel.com>
Date: Mon, 28 Apr 2025 17:56:36 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Rich Persaud <persaur@gmail.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com,
 Sergii Dmytruk <sergii.dmytruk@3mdeb.com>, openxt@googlegroups.com,
 "Mowka, Mateusz" <mateusz.mowka@intel.com>, Ning Sun <ning.sun@intel.com>,
 tboot-devel@lists.sourceforge.net
References: <18F9BD47-282D-4225-AB6B-FDA4AD52D7AE@gmail.com>
 <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com>
 <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 17:04, Daniel P. Smith wrote:
>> OK, but why do this in Linux as opposed to tboot? Right now, much of the
>> TXT magic is done outside of the kernel. Why do it *IN* the kernel?
> 
> There was a patch set submitted to tboot to add AMD support. It was
> rejected as tboot is solely focused on Intel TXT implementation.
> 
> This meant I either had to go the route of yet another standalone loader
> kernel or do it in the kernel. Doing it as an external loader would have
> required a new set of touchpoints, like the one you are highlighting. At
> which point, I am sure I would have gotten the question of why I didn't
> do it in the kernel.
> 
> But the real motivation for doing it in the kernel is due to Linux's
> flexibility, allowing for it to be used in a variety of use-cases. For
> instance, Linux is used as a bootloader kernel (see LinuxBoot) allowing
> for the starting of the target OS kernel from the hardware D-RTM trust
> chain. It can be used in the kexec path to again root the follow-on
> kernel in the hardware D-RTM instead of an elongated S-RTM trust chain.
> I gave a presentation at LPC 2020[1] covering several use cases if you
> are interested.
> 
> [1] https://lpc.events/event/7/contributions/739/

Could we please get a condensed version of that into the cover letter
and documentation?

But, in the end, this is a change in direction. I don't think what you
have here sufficiently justifies the move from an exokernel to the
in-kernel approach.

I'm open to hearing more, but the justification just isn't here.

>> Say we axed tboot support from 6.16, but merged Trenchboot. A user on
>> old hardware upgrades their kernel. What happens to them?
> 
> I would not advocate for the remove of tboot support.

Humor me, please.

What has to happen for Trenchboot to replace tboot if a user is already
using tboot?

You might not thing it's reasonable and so don't want to answer my
question. But I'm not the expert here. I don't know why it's not feasible.

>>>> so that Linux support for TXT/tboot can just go away?
>> You didn't _really_ answer the question.
>>
>> Summarizing, I think you're saying that TXT/tboot Linux support can just
>> go away, but it will be help if its maintainers help its users
>> transition.
>>
>> Does anybody disagree with that?
> 
> As the lead of the TrenchBoot project, I would not call for the removal
> of tboot. We did a lot of collaboration with the previous tboot
> maintainer, assisting each other with our solutions. Some may want to
> use TXT under the Exo-kernel model that tboot provides. This is one use
> case where Linux could work in that fashion but would be extremely less-
> than-ideal. Likewise, it would not be ideal to try to add a bunch of
> drivers to tboot in order to support the advanced policy-based
> environment measurement system that can be achieved with a Linux
> configuration.

This is a bit hand-wavy for my taste.

Can you give one concrete example of something that's hard or impossible
with tboot but is easy with Trenchboot?

>>> In that perfect world, Intel ACM and tboot developers would review
>>> the TrenchBoot Linux series
>>
>> So, I was looking on the cc list and I didn't see them on there.
>> Shouldn't they be cc'd if you want them to review the series? A little
>> poking at lore makes me think that they were *NEVER* cc'd.
>>
>> Is that right, or is my lore-foo weak?
> 
> As I mentioned, we did a significant amount of collaboration with Lukasz
> Hawrylko when he was the sole tboot maintainer for Intel. By the time he
> moved on, TB was fairly well complete, and at that point the goal was to
> get it to an acceptable state for the maintainers. We would be more than
> glad to have the current tboot maintainers review it if they would like.
Here's the deal: I want *an* ack from the tboot MAINTAINER on at least
one patch in this patch set. There's not a chance that we merge
duplicate, parallel in-kernel functionality without them saying that
this is a reasonable approach.

Let me know if I can help facilitate that in any way.

I kinda wish that someone would have told me a few years ago that if
tboot didn't take your patches that a 5,000-line series was going to
plop into my inbox a dozen or more times.


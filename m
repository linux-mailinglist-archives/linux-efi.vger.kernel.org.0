Return-Path: <linux-efi+bounces-3479-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA0A9FE17
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 02:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2063E188B121
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5573FD1;
	Tue, 29 Apr 2025 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="oiQiVIHX"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B122CA9;
	Tue, 29 Apr 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745885190; cv=pass; b=c7ZDSOmEHV2I7NcEEF58Et8nge3Ft3+wUUYfowaZEQ/tF52KiOVAlEyTXH+aSZID/muQbxzEuyb50q16aZ/mT+MRzzBgIc4Kd1rzCOj1clU6eZgFk1RvYP2CuDSEcLbXQBLRQlikljGgkcm0jPGDPB6FIbGdGmFWOlZd1UtsF18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745885190; c=relaxed/simple;
	bh=OU9Ghy8+eSxoK0NbwE5KHZUoqiy+c9F84bsvJLecChQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URM37SAdJhZJHhrqZglLzi4JZnnDgrwWZeLIpYa5VHUWCOXBDjvcXrADzsBTS18CYHv+PGFFWO0F0l8gwe8Fz3EoEj8idQxnJLDKue9BDJWVfJbMrkAU33meL7cxfvPk5IR8VIKnlicTEbXS+JlRLskuvBlsAO9NSzcmdrzTl84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=oiQiVIHX; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1745885077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Logc8z/07pN8LWrc0PGRlkCTpHyoLZMWG3FS0c+sci4cRjcD+BSUhZNaD/WbV1DgCJYwypQsK1s4W1ImEjHIyoV3+WQMKxuyTbPj1jou++labzGhXlPI9hGP0x0/Cf3yXYsUn/KeBBecldUyHIXGxQ2iQzZ2cZB1iAwFSBEOmAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745885077; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OSda1AXViPXbP/04jOiKLk9by22dDyr6arZA0oU2vwo=; 
	b=hgnzw2g3duNba/j3my1iEopj0mvLEWQNtafd2LL8YlG0Bn9sckkzE59aNuAIRpGD3SrEwvFSn1nXwA5nQF/fPpwT0ne0/ydfnIpltaBTsHrGZKE1uCEUA82a/ScLcPNIw2cDn4ChbYYfqMqe/DMBoCICx4Ph2LoMdc895UdHjYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745885077;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OSda1AXViPXbP/04jOiKLk9by22dDyr6arZA0oU2vwo=;
	b=oiQiVIHXBTtp5yPnXedORfWpvHJho9x0XgueeaibA1uFAZJG8kOuFlyPnRX1fYkn
	iqks6y90jZccBAyRcNby3jr3x/HVjPwQpExMIIWdM8FCui8gh5VeFPvHGWCcTO0hnE3
	5jUKkWkRLIQdx+JALDxQP5mHPv8mPmxjRsnxyj8U=
Received: by mx.zohomail.com with SMTPS id 174588507400921.811169222545573;
	Mon, 28 Apr 2025 17:04:34 -0700 (PDT)
Message-ID: <03d0db6b-628e-4a5e-8e71-852233b83f60@apertussolutions.com>
Date: Mon, 28 Apr 2025 20:04:31 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Rich Persaud <persaur@gmail.com>
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
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <9b18e8e3-f3e2-48d4-839a-56e1d8f62657@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Dave!

On 4/25/25 10:12, Dave Hansen wrote:
> On 4/25/25 03:12, Rich Persaud wrote:
>> ﻿On Apr 24, 2025, at 2:45 PM, Dave Hansen <dave.hansen@intel.com>
>> wrote:
>>> ﻿On 4/21/25 09:26, Ross Philipson wrote:
>>>> This patchset provides detailed documentation of DRTM, the
>>>> approach used for adding the capbility, and relevant API/ABI
>>>> documentation. In addition to the documentation the patch set
>>>> introduces Intel TXT support as the first platform for Linux
>>>> Secure Launch.
>>>
>>> So, I know some of the story here thanks to Andy Cooper. But the
>>> elephant in the room is:
>>>
>>>> INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT) M:      Ning Sun
>>>> <ning.sun@intel.com> L:      tboot-devel@lists.sourceforge.net
>>>> S:      Supported W:      http://tboot.sourceforge.net T: hg
>>>> http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot F:
>>>> Documentation/arch/x86/intel_txt.rst F:      arch/x86/ kernel/
>>>> tboot.c F:      include/linux/tboot.h
>>>
>>> Linux already supports TXT. Why do we need TrenchBoot?
>>
>> One reason is to generalize DRTM support to other platforms.
> 
> OK, but why do this in Linux as opposed to tboot? Right now, much of the
> TXT magic is done outside of the kernel. Why do it *IN* the kernel?

There was a patch set submitted to tboot to add AMD support. It was 
rejected as tboot is solely focused on Intel TXT implementation.

This meant I either had to go the route of yet another standalone loader 
kernel or do it in the kernel. Doing it as an external loader would have 
required a new set of touchpoints, like the one you are highlighting. At 
which point, I am sure I would have gotten the question of why I didn't 
do it in the kernel.

But the real motivation for doing it in the kernel is due to Linux's 
flexibility, allowing for it to be used in a variety of use-cases. For 
instance, Linux is used as a bootloader kernel (see LinuxBoot) allowing 
for the starting of the target OS kernel from the hardware D-RTM trust 
chain. It can be used in the kexec path to again root the follow-on 
kernel in the hardware D-RTM instead of an elongated S-RTM trust chain. 
I gave a presentation at LPC 2020[1] covering several use cases if you 
are interested.

[1] https://lpc.events/event/7/contributions/739/

>>> Also, honestly, what do you think we should do with the Linux
>>> tboot code? Is everyone going to be moving over to Trenchboot>
>> OpenXT will migrate development of measured launch from tboot to
>> TrenchBoot Secure Launch, after upstream Linux and Xen have support
>> for both Intel and AMD DRTM. Previously-deployed Intel devices using
>> tboot, derived from OpenXT, will need support until users upgrade
>> their hardware.
> 
> Say we axed tboot support from 6.16, but merged Trenchboot. A user on
> old hardware upgrades their kernel. What happens to them?

I would not advocate for the remove of tboot support.

>>> so that Linux support for TXT/tboot can just go away?
> You didn't _really_ answer the question.
> 
> Summarizing, I think you're saying that TXT/tboot Linux support can just
> go away, but it will be help if its maintainers help its users transition.
> 
> Does anybody disagree with that?

As the lead of the TrenchBoot project, I would not call for the removal 
of tboot. We did a lot of collaboration with the previous tboot 
maintainer, assisting each other with our solutions. Some may want to 
use TXT under the Exo-kernel model that tboot provides. This is one use 
case where Linux could work in that fashion but would be extremely 
less-than-ideal. Likewise, it would not be ideal to try to add a bunch 
of drivers to tboot in order to support the advanced policy-based 
environment measurement system that can be achieved with a Linux 
configuration.

>> In that perfect world, Intel ACM and tboot developers would review
>> the TrenchBoot Linux series
> 
> So, I was looking on the cc list and I didn't see them on there.
> Shouldn't they be cc'd if you want them to review the series? A little
> poking at lore makes me think that they were *NEVER* cc'd.
> 
> Is that right, or is my lore-foo weak?

As I mentioned, we did a significant amount of collaboration with Lukasz 
Hawrylko when he was the sole tboot maintainer for Intel. By the time he 
moved on, TB was fairly well complete, and at that point the goal was to 
get it to an acceptable state for the maintainers. We would be more than 
glad to have the current tboot maintainers review it if they would like.

V/r,
Daniel


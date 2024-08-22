Return-Path: <linux-efi+bounces-1575-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B895BE3C
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2906C1F24CBA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E71CEAC6;
	Thu, 22 Aug 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="LWndbxnZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DFEC5;
	Thu, 22 Aug 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351476; cv=pass; b=DjtlAO4jxEDjb5OCzhDa6aC9dqZcDzuWs2vbKD5M2zonlfxDgH7CBSrZ2B2ZfvzaZoai1+MVtCYKp3IGF3FGzlQZ/mxdx3eF5IpARPPC+7sKMSp3nYGByWTQqVC6cNJ5Yt2GqgY0gV5WH7F1Ex3LcFXcWBO50sokM5ViOFEfpfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351476; c=relaxed/simple;
	bh=agHBdZkQ8BulJoORPycTlSOnOyfy9kfTwiKBhxMAjag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkQwmhFYO7roLIV4f+GbFbuS4asXoazYfaCyLI0+rIiytKmygp1j8G6FNMayAE5LNaFeZA5YwleJvGdIt7b2409PvLPC7VzX/bJzh62zUo6KxPuxgfQwg6SqljzeEinSvV5q2cbyKEbJH1WzL5ydL4b0TY9iZpQd1giLUDHxsHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=LWndbxnZ; arc=pass smtp.client-ip=136.143.184.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1724351396; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ensxJanajnfNH4lrohozTfRp/kJ8ndAR/I5SeOCvPtvZpwA/RS3UKS9IzW5MnGlu3KwD9JZgR/559mn/GKEg7+II30GBHjPG+RHQQXv6qYJ8VO6d6q5godbIQcqq8y5Wsi0Giv6acyQMSSuozV5LPKeS57s5x4o9g8w+sokW13c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724351396; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MyQlkXBuBh5D5+ORO/Ajt6ntHefewg/FMRXibyLJvKQ=; 
	b=fPGGbQa6PDJETfzD86dOnyy2nf1dhiCXht9Z7kAfpQDeTDuKfPlCsPgzwzvQy4C7qDUHI6mVeTa8+DiKlK4twHkkFW7Rmr4iNCsDZl/Ko9tv8Bi0jkphPJpIC2WLsxxLAEHGJm+ZQJ0UDZdtX2DQt0UJL9HnfiEXQoDXnto9fHQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724351396;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MyQlkXBuBh5D5+ORO/Ajt6ntHefewg/FMRXibyLJvKQ=;
	b=LWndbxnZqsXgRW0zxX0skSHrs/RICB+4zvHapAfsJIHhBjt1SzpRUZ8bMV2l5ynf
	xRPob/zjMHRjYX8ykLglY1hM59kdZCqo6e2s59dYvXpsTBX6lSomKRhRHWTKfRE2XAz
	FMGosfle+46Swp76HbPabYQUH+ZMH+FO0Ir/i62I=
Received: by mx.zohomail.com with SMTPS id 1724351393878947.9797156192928;
	Thu, 22 Aug 2024 11:29:53 -0700 (PDT)
Message-ID: <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
Date: Thu, 22 Aug 2024 14:29:48 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Thomas Gleixner <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <87ttflli09.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/15/24 15:10, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
>> On 5/31/24 09:54, Eric W. Biederman wrote:
>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>>>> but why would you not at least *prefer* SHA-256?
>>>
>>> Yes.  Please prefer to use SHA-256.
>>>
>>> Have you considered implementing I think it is SHA1-DC (as git has) that
>>> is compatible with SHA1 but blocks the known class of attacks where
>>> sha1 is actively broken at this point?
>>
>> We are using the kernel's implementation, addressing what the kernel
>> provides is beyond our efforts. Perhaps someone who is interested in
>> improving the kernel's SHA1 could submit a patch implementing/replacing
>> it with SHA1-DC, as I am sure the maintainers would welcome the help.
> 
> Well, someone who is interested to get his "secure" code merged should
> have a vested interested to have a non-broken SHA1 implementation if
> there is a sensible requirement to use SHA1 in that new "secure" code,
> no?
> 
> Just for the record. The related maintainers can rightfully decide to
> reject known broken "secure" code on a purely technical argument.
> 
> Thanks,
> 
>          tglx
> 

There is one simple question, does allowing the Secure Launch code to 
record SHA1 measurements make the system insecure, and the answer is 
absolutely not.

The role of the Secure Launch code base in the context of the larger 
launch process is to function as observer. Within this role, its only 
responsibility is continuing the trust chain(s) that were started by the 
CPU/Hardware. It does so by measuring the components and configuration 
it is responsible for loading and applying, i.e. in TCG parlance, it is 
continuing the construction of the transitive trust for the system. In 
this aspect, the only degradation of security that can affect the 
kernel's role is whether all the necessary entities are safely measured 
and not what algorithms are used.

If the system integrator, whether that be the OEM, your employer, the 
distro maintainer, the system administrator, or the end user, configures 
the DL preamble to only use SHA1 or used older hardware that has a 
TPM1.2, then they are accepting the risk it creates in their solution. 
In fact, a greater threat to the security of the launch is the 
misconfiguration of the IOMMU, which risks the kernel's ability to 
safely make measurements, as compared to the use of SHA1. Yet it was 
insisted in past reviews that we allow the user to specify an incorrect 
IOMMU policy.

In the end, the "security" of an RTM solution is how and what 
measurements are used to assess the health of a system. Thus bringing it 
back to the opening question, if SHA1 measurements are made but not 
used, i.e. the attestation enforcement only uses SHA2, then it has zero 
impact on the security of the system.

Another fact to consider is that the current Intel's TXT MLE 
specification dictates SHA1 as a valid configuration. Secure Launch's 
use of SHA1 is therefore to comply with Intel's specification for TXT. 
And like the IOMMU situation, having the option available allows the 
user to determine how they ultimately want to integrate Secure Launch 
into their integrity management. And because Secure Launch will only 
attempt SHA1 if it was in the TXT configuration, when either Intel 
removes SHA1 from the MLE specification or firmware manufactures begin 
disabling the SHA1 banks, this will obviously mean that Secure Launch 
will not produce SHA1 measurements.

On a side note, with my remote attestation hat on, the SHA1 measurements 
can in fact be extremely useful. If an attestation was made containing 
both SHA1 and SHA2 chains, and the SHA1 of an event was correct but the 
SHA2 was not, either a natural collision happened or someone maliciously 
caused a collision. The former has an extremely low probability, while 
the latter is highly probable.

Thus, with this information alone, it is possible to make the reasonable 
determination the device is compromised. Whereas if both hashes are 
mismatched, without any additional information it is equally probable of 
either misconfiguration or compromise. And to state the obvious, with 
only SHA2, further information is needed to distinguish between 
misconfiguration and compromise.

V/r,
Daniel P. Smith


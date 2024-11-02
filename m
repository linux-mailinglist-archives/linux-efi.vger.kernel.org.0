Return-Path: <linux-efi+bounces-2119-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9C9BA0E2
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91DC1F20EFA
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8CC19CC27;
	Sat,  2 Nov 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="HMoqqFZ3"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA63187355;
	Sat,  2 Nov 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559294; cv=pass; b=St/LRaF/duWwXCgWiXp2/uqQDbqbtlIMJSXnn2sZo8M5ES7l84DEXDwha16LbayJfD6kTSru5Y7hbxVbVyKi0sneupIcd4QyIxR+VmjC71gII47RvDc2+emGJz3epqN5ymsWI3w/OExL8Gyh5ZBt61Wb5NYDxqEGDauEnLKtFQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559294; c=relaxed/simple;
	bh=tzq8MUO4DASEqGBmbnj727C9xM3H3yjsM31INtVh2YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQcAG2JY28/4BMfikCmx/cHg37V6bc3BZ038I/RO+yb6s6hq0MgQ2k8dDWlib2+1+bIX3sjdjp9c+cIIdr+E/BAkuv89V48poNSOeDLBGM4x6Y3Dk1tpLPiHtGVSHWIg5izSZYlB6VleL3uGGCvEwJCvkdsXUNOqGduwsOU7di8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=HMoqqFZ3; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730559194; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fchL7Vh5qY08psQ/08OOnraY2HijL72ac6IUg7ZcyBbNBablRK8mrsH3fiJNl56YNA7grz/hsLxSEYjz7Yx+am8GrhGp6i73o+8Vn+COIrp2yv3Uf+Hxt1htZywTyXpGNxI5XgQ3xi/J7Y7lQ2ZgunXPgq7T59R6RPhmUj7LhMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730559194; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u2SobBqxr48eivoI/S5ZeOG/ZaZMSGirllbqhTNJt70=; 
	b=cuch7DLIWGOoujAtqfZJVTtxJd4UeOH6Zt9IsHIuanFQUXQzs5ifUI4JKs5QuJQsPPLu8XTTFK0+WhMOkU7GBtmpHeF4FgFD/s068/gX1FAmIP7IR3izs7Zo3pxwctk2mp2N0DAudcBHHO1uhiRsNA+pgNiZawXuW58g5CcZO+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730559194;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u2SobBqxr48eivoI/S5ZeOG/ZaZMSGirllbqhTNJt70=;
	b=HMoqqFZ3vn8uQS+CnbNDF+M0DVlEUxX8H2aOeWCXUhIvO4tUv1LOGQYxmtW2cz2q
	i0YNg3lKZSJam/JM+Me9CH2zJMfHQg6s1EGlKkJdrou9KC4+ZpBzkiNpzSGcPLps1jS
	SMZT/8/mp6faO1BxosaNeewawQln05nbq8pF/ifA=
Received: by mx.zohomail.com with SMTPS id 1730559193059824.214881281503;
	Sat, 2 Nov 2024 07:53:13 -0700 (PDT)
Message-ID: <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
Date: Sat, 2 Nov 2024 10:53:04 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luto,

My apologies, I missed this response and the active on v11 cause me to 
get an inquiry why I hadn't responded.

On 9/21/24 18:40, Andy Lutomirski wrote:
> On Sat, Sep 21, 2024 at 11:37 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> On 9/13/24 23:57, Andy Lutomirski wrote:
>>> On Thu, Sep 12, 2024 at 5:34 PM Daniel P. Smith
>>> <dpsmith@apertussolutions.com> wrote:
>>>>
> 
>>> What, exactly, is your patchset doing that requires hashing at all?
>>> (I assume it's extending a PCR and generating an event log entry.).
>>> What, exactly, does it mean to "cap" a PCR?  How is this different
>>> from what your patchset does?
>>
>>
> 
> ...
> 
>> I did not see the term actually defined in the client profile, but the
>> term "cap" refers to the specific action of hashing a value across a set
>> of PCRs. This is to reflect that certain events have occurred and will
>> result in a different but predictable change to the PCR value. Often
>> times this is to ensure that if there are TPM objects sealed to the
>> system with either that event having or have not occurred, they cannot
>> be unsealed. Thus, one has "capped" the PCRs as a means to close access
>> to the “acceptable” system state.
> 
> Okay, so I read Ross's earlier email rather differently:
> 
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>> to safely use SHA-256 for everything else.
> 
> I assumed that "deliberately cap" meant that there was an actual
> feature where you write something to the event log (if applicable) and
> extend the PCR in a special way that *turns that PCR off*.  That is,
> it does something such that later-loaded software *can't* use that PCR
> to attest or unseal anything, etc.
> 
> But it sounds like you're saying that no such feature exists.  And a
> quick skim of the specs doesn't come up with anything.  And the SHA1
> banks may well be susceptible to a collision attack.

Correct, the only entity that can disable PCR banks is the firmware. 
When it initializes the TPM, it can disable banks/algorithms. After 
that, when an extend operation is done, the TPM is expecting an entry 
for all active PCR banks and the TPM itself does the extend hash that is 
stored into the PCRs.

> So what are the kernel's choices wrt the SHA-1 PCRs?  It can:
> 
> a) Perform business as usual: extend them consistently with the
> SHA-256 PCRs.  This is sort of *fine*: the kernel code in question is
> not relying on the security of SHA-1, but it is making it possible for
> future code to (unwisely) rely on them.  (Although, if the kernel is
> loading a trustworthy initramfs, then there won't be a collision, and
> there is no known second-preimage attack against SHA-1.)
> 
> b) Same as (a), but with countermeasures: do something to the effect
> of *detecting* the attack a la SHA1-DC and panic if an attack is
> detected.  Maybe this is wise; maybe it's not.
> 
> c) Do not extend the SHA-1 PCRs and pretend they don't exist.  This
> seems likely to cause massive security problems, and having the kernel
> try to defend its behavior by saying "we don't support SHA-1 -- this
> is a problem downstream" seems unwise to me.

I will chime in here to say that you can't ignore them, but you can send 
a fixed value, either well-known or junk, as the SHA1 value when doing 
the extend operation as you suggest in (e).

> d) Extend them but in an unconventional way that makes using them
> extra secure.  For example, calculate SHA-256(next stage), then extend
> with (next stage || "Linux thinks this is better" || SHA-256(next
> stage).  This makes the SHA-1 banks usable, and it seems like it will
> probably defeat anything resembling a current attack.  But maybe this
> is silly.  It would probably require doing the same thing to the
> SHA-256 banks for the benefit of any software that checks whether the
> SHA-1 and SHA-256 banks are consistent with each other.
> 
> e) Actually try to make the SHA-1 PCRs unusable.  For example, extend
> them with random numbers.
> 
> My inclination is that having some kind of Linux "policy" that SHA-1
> is forbidden adds no actual security value.  Option (a) honestly seems
> fine.  Nothing in the kernel *relies* on the SHA-1 hash being secure.
> But option (b) also seems okay if someone is willing to put the effort
> into implementing it and creating a proper test case.

Obviously, for the most part, we are in agreement. The one caveat is 
that I don't think the effort to shore-up SHA1 provides a good return on 
the costs it would incur. With no intent to disparage any one person, 
there generally will be two groups that would use SHA1. The first would 
be those limited by their platform and understand the risks. The second 
would be those attempting to do a cryptographic-based security solution 
that has either been living under a rock the last few years or has done 
zero research into the capabilities they are using for their solution. 
IMHO it is better to not inhibit the first group trying to save the 
latter group as the latter are always doomed to failure.

> But the description of all this could certainly do a better job of
> explaining what's going on.

I would be glad to do so, and have tried several ways to explain it. 
Even working with multiple people that understand the problem to draft a 
better explanation. It would be greatly appreciated if you could provide 
what points you think should be clarified to better help convey the 
situation.

> --Andy
> 
>> [1] A future expansion of Secure Launch will be to enable usage of
>> Intel's Hardware Shield, link below, to provide runtime trustworthy
>> determination of SMM. The full extent of this capability can only be
>> achieved under a DRTM launch of the system with Intel TXT. When enabled,
>> this can be used to verify the SMM protections are in place and inform
>> the kernel's memory management which regions of memory are safe from SMM
>> tampering.
>>
>> https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-based-computing-whitepaper.pdf
> 
> Wow.  I skimmed this paper.  What an overcomplicated solution to a
> problem that doesn't deserve to exist in the first place.

While we could have a long discussion over the merits of SMM, the fact 
we have to face is that it is here, and it is not going anywhere any 
time soon. I honestly found AMD's SMM Containerization (Appendix D of 
the AMD64 Architecture Programmer’s Manual - Volume 2) the better 
approach, and it saddens me that it is completely disabled.

v/r,
dps



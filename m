Return-Path: <linux-efi+bounces-1792-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904697DE56
	for <lists+linux-efi@lfdr.de>; Sat, 21 Sep 2024 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B7AB20D24
	for <lists+linux-efi@lfdr.de>; Sat, 21 Sep 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720B2B9A5;
	Sat, 21 Sep 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="T1NF7p1R"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender3-of-o57.zoho.com (sender3-of-o57.zoho.com [136.143.184.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63B3BB48;
	Sat, 21 Sep 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943915; cv=pass; b=DaCxcdBHBZlzl80N9uJ844kHe5WOf3nIdGwjm2SnjbnwX72DW6ON3fK08pi3ZYGd0GQifWjiBGNUV8QHhAlVWCWxK+Se9Bn8GnfMSBtb46+kPhg/psqaJKdGlKsnDZrf0k3fwwKElaEjQeTE4hwfXNnqFg4SowLtXbH6XpDI1xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943915; c=relaxed/simple;
	bh=WpadbEHEfXCgwZTQEX+7bHS29I7aOtuKslLsrT04Dzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTZjLdyoNt/lFMNkqGZ/q9reNk0CQg5KyHTM/C9eAvlNpk0albWLsKVfUpu9P24zzgXTFZ7XRlTXHofhaFRnPUmhNRVvYe5i5JyXeXSPD2IltEfHj5FNvI1E/hTPFHPdpiLHSEB31gXDODU0qExGXtRuSqsQW0F1Lq2nNrZLcnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=T1NF7p1R; arc=pass smtp.client-ip=136.143.184.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1726943834; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Isu+KNxmEdff4Yf8v+8NIVgqd1KCyNgZK+jRYblRct4+s63Fu1VdgNY+M14Y2pOA4BelJ1fkDlz6rpFcX2n9z+5hFvWgLO6UoLBdT3BokM9arPI4q4s+oaIj4sTIuuP1sl1/fJIdkhZjBibY1wVUqBQU0DG+TGZ9FlNn4/7RqWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726943834; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=epVfrURWgC20QBuvtkf5SBZ7wdGePGXbAnPnMOgBIC8=; 
	b=akg5M36Efr83ZaGZr4tah8q5qwThdoBARKYSFfDrSEnLwQRYUe3CojwDtZhe7qga86BxANRNPH7H/t9vDdPD24UZCYUnEsc+4bJAPdb0yWs9nh+0CSkk6oN0MnLZclXDF3ziTf3S6u7Wf5N9qqYIseUjEIpRuaKjIt3gamJqESI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726943834;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=epVfrURWgC20QBuvtkf5SBZ7wdGePGXbAnPnMOgBIC8=;
	b=T1NF7p1RrY7do2w/YnOlDlPCBTTaewBsDGRb3wToOj7vxq+uyrWbNkuXqe0v7ikm
	fVyli/s99EXCa5tZkKzlfoMHeiNKS4LpdfvPMyvXyJTPWh5mC9Broq5SqKNAS9Y+uvq
	X+P/OtTvPsQH9O+fB8+5pkmUQS7yT6rtiL+YDmWk=
Received: by mx.zohomail.com with SMTPS id 1726943833180834.882107651291;
	Sat, 21 Sep 2024 11:37:13 -0700 (PDT)
Message-ID: <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
Date: Sat, 21 Sep 2024 14:36:58 -0400
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
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/13/24 23:57, Andy Lutomirski wrote:
> On Thu, Sep 12, 2024 at 5:34 PM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> Hey again,
>>
>> On 9/4/24 21:01, Daniel P. Smith wrote:
>>> Hi Luto.
>>>
>>> On 8/28/24 23:17, Andy Lutomirski wrote:
>>>> On Thu, Aug 15, 2024 at 12:10 PM Thomas Gleixner <tglx@linutronix.de>
>>>> wrote:
>>>>>
>>>>> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
>>>>>> On 5/31/24 09:54, Eric W. Biederman wrote:
>>>>>>> Eric Biggers <ebiggers@kernel.org> writes:
>>>>>>>> That paragraph is also phrased as a hypothetical, "Even if we'd
>>>>>>>> prefer to use
>>>>>>>> SHA-256-only".  That implies that you do not, in fact, prefer
>>>>>>>> SHA-256 only.  Is
>>>>>>>> that the case?  Sure, maybe there are situations where you *have*
>>>>>>>> to use SHA-1,
>>>>>>>> but why would you not at least *prefer* SHA-256?
>>>>>>>
>>>>>>> Yes.  Please prefer to use SHA-256.
>>>>>>>
>>>>>>> Have you considered implementing I think it is SHA1-DC (as git has)
>>>>>>> that
>>>>>>> is compatible with SHA1 but blocks the known class of attacks where
>>>>>>> sha1 is actively broken at this point?
>>>>>>
>>>>>> We are using the kernel's implementation, addressing what the kernel
>>>>>> provides is beyond our efforts. Perhaps someone who is interested in
>>>>>> improving the kernel's SHA1 could submit a patch implementing/replacing
>>>>>> it with SHA1-DC, as I am sure the maintainers would welcome the help.
>>>>>
>>>>> Well, someone who is interested to get his "secure" code merged should
>>>>> have a vested interested to have a non-broken SHA1 implementation if
>>>>> there is a sensible requirement to use SHA1 in that new "secure" code,
>>>>> no?
>>>>>
>>>>> Just for the record. The related maintainers can rightfully decide to
>>>>> reject known broken "secure" code on a purely technical argument.
>>>>>
>>>>
>>>> Wait, hold on a second.
>>>>
>>>> SHA1-DC isn't SHA1.  It's a different hash function that is mostly
>>>> compatible with SHA1, is different on some inputs, and is maybe more
>>>> secure.  But the _whole point_ of using SHA1 in the TPM code (well,
>>>> this really should be the whole point for new applications) is to
>>>> correctly cap the SHA1 PCRs so we can correctly _turn them off_ in the
>>>> best way without breaking compatibility with everything that might
>>>> read the event log.  I think that anyone suggesting using SHA1-DC for
>>>> this purpose should give some actual analysis as to why they think
>>>> it's an improvement, let alone even valid.
>>>
>>> I would say at a minimum it is to provide a means to cap the PCRs.
>>> Devices with TPM1.2 are still prevalent in the wild for which members of
>>> the TrenchBoot community support, and there are still valid (and secure)
>>> verification uses for SHA1 that I outlined in my previous response.
>>>
>>>> Ross et al, can you confirm that your code actually, at least by
>>>> default and with a monstrous warning to anyone who tries to change the
>>>> default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
>>>> all stop hassling the people trying to develop this series about the
>>>> fact that they're doing their best with the obnoxious system that the
>>>> TPM designers gave them?
>>>
>>> Our goal is to keep control in the hands of the user, not making
>>> unilateral decisions on their behalf. In the currently deployed
>>> solutions it is left to the initrd (user) to cap the PCRs. After some
>>> thinking, we can still ensure user control and give an option to cap the
>>> PCRs earlier. We hope to post a v11 later this week or early next week
>>> that introduces a new policy field to the existing measurement policy
>>> framework. Will add/update the kernel docs with respect to the policy
>>> expansion. We are also looking the best way we might add a warning to
>>> the kernel log if the SHA1 bank is used beyond capping the PCRs.
>>
>> As the attempt was made to lay in the policy logic, it started to become
>> convoluted and unnecessarily complicated. Thus creating more risk with
>> all the bookkeeping and yet sha1 hashes still have to be sent, the null
>> hash in this case, since the TPM driver will reject extends that do not
>> have hashes for all active banks. At this point, we have opted to keep
>> the logic simple and add a section to our documentation advising of the
>> potential risk should one choose to incorporate SHA1 in their
>> attestations of the platform.
>>
> 
> I've read the TPM standard a bit, but it's been awhile, and it's too
> complicated anyway.  So, can you remind me (and probably 3/4 of the
> other people on this thread, too):

Sure, but honestly if you were to ask me in person, I would have given 
you the explanation as provided in the Secure Launch Overview in the 
documentation patch.

> What, exactly, is your patchset doing that requires hashing at all?
> (I assume it's extending a PCR and generating an event log entry.).
> What, exactly, does it mean to "cap" a PCR?  How is this different
> from what your patchset does?


The SINIT ACM is provided a structure that basically says, here is an 
address and size of what it will execute next. It will use that 
information to take its transitive trust measurement of the kernel 
before handing control to the Linux kernel. The Secure Launch code is 
responsible for ensuring everything that can influences its execution to 
be measured and stored into the TPM for attestations to be made at a 
latter time. The most important part is the transitive trust measurement 
of the next part to be executed, the initramfs. Specifically, the Secure 
Launch code must be able to handle the situation where the initramfs 
independent of the kernel and loaded separately. Additionally, the 
policy function provided for optional system state to also be measured 
and recorded, as the attestation evaluator might want them.

At the end of the day, this capability is strictly a passive (mostly, 
see note [1] below) solution with the responsibility to maintain the 
DRTM trust chain by taking meaningful measurements. This includes the 
next component in the trust chain and then hand execution to that next 
component.

The TCG specs and good practices provide that a component in either SRTM 
or DRTM trust chains should extend a non-event record to the tpm and/or 
its log. This is to indicate the transition point from one component in 
the trust chain to the next component. Under the client profile, 
firmware is required to do this by extending an event of type 
EV_SEPARATOR before "Ready to Boot".

I did not see the term actually defined in the client profile, but the 
term "cap" refers to the specific action of hashing a value across a set 
of PCRs. This is to reflect that certain events have occurred and will 
result in a different but predictable change to the PCR value. Often 
times this is to ensure that if there are TPM objects sealed to the 
system with either that event having or have not occurred, they cannot 
be unsealed. Thus, one has "capped" the PCRs as a means to close access 
to the “acceptable” system state.

To close and reiterate, Secure Launch only responsibility is to send 
measurements to the TPM. The TPM and TPM driver has an expectation that 
every PCR extend event contains a hash for every active algorithm bank. 
For Secure Launch, to send SHA1 measurements has zero impact on the 
security of the system. Whether those measurements are used for TPM 
integrity reporting and security policy enforcement by user space or an 
enterprise is outside the scope of the Secure Launch capability and the 
kernel.

[1] A future expansion of Secure Launch will be to enable usage of 
Intel's Hardware Shield, link below, to provide runtime trustworthy 
determination of SMM. The full extent of this capability can only be 
achieved under a DRTM launch of the system with Intel TXT. When enabled,
this can be used to verify the SMM protections are in place and inform 
the kernel's memory management which regions of memory are safe from SMM 
tampering.

https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-based-computing-whitepaper.pdf

> With that answered, it will hopefully be easy to see that you're
> making the right call :)
> 
> --Andy
> 


Return-Path: <linux-efi+bounces-2371-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052759EFCDD
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2024 20:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D628AE81
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2024 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EF1A707A;
	Thu, 12 Dec 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="QVDohNEt"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE59193084;
	Thu, 12 Dec 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033479; cv=pass; b=L3DoHImzYZ1j1GtgiYhQnF3NQ5511ayrnb7lD8QPWpLYoTLGVWgc+i78eE2Dhs8JcF02tJd3pV3j+f9rW6f9mfr4boOmXChbYvHd94HrieaA4xO7I/i6xM/spJjVrLkKEfVr5EQrVownwDdJrPJIQW6VgV8pq87rCllq4QhKDho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033479; c=relaxed/simple;
	bh=n1v6zNCsRs2o2jizjOrt1bu69OqmpyMVRYYWsIc/7AI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cED3R0DdFJNEmVTgEDX4KkhiIWzTOZ1c7d7QCUu6tCk+g1lBVMK7x0wcjD3K77WyKLze0Yj558azJPpU4EsN7rtll2Y3CtqdvWxt/RlMZBJah2uKJFCN/VVZTDE9QZjoEsW5GpZSEre8raE7OBH9rsKhK53d9jyciByLXVnFfEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=QVDohNEt; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1734033395; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q6mhoiQlF+X3Ga4ZbHzXRV6VVWH2dGJgGQKxrl5lkAWanRx2Le+mSx31+22MQIcXLoc8EtHoPhHrDYEM+msozrQ4RcJ1rH7twm6cqhD4rhy0TrQmxdlP/5tFq4Xm9kqVfXdE5iteCULBlNl3/1YZEFFKV3feqYfnq3cZMUkLYyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734033395; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K/doDuiYr3tUCbk+zjyulpISltgEnye5889UgTLaMDE=; 
	b=ls2U7TrIakrTDRJ7HeNm343oldeSEYv+ZVbXKq0MvFSJ0oocIax92S8aXmXmlr3ZeWEkYyx8KeZ0WrdqmjAoB1fOSzWeW+IjStvsG98AwO7eWg7cpbeOUJzF3lgKl18AO02RuFWCa2HTtxEceCWHcLOBK9hYfMS9b1yb8c/qcOc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734033395;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K/doDuiYr3tUCbk+zjyulpISltgEnye5889UgTLaMDE=;
	b=QVDohNEtg4WAsD+rnGYfbH1QAd3geV/N+7ot1IVth65Z01IMdqkPjO/8p8ZUofZh
	57jvnBs6vQe9xGOre8kTaX0BrQe7Yva1slxsmJ6sPDiAv57NKeUZweTzhfL+ObwhP3z
	rT54chqC9/LSdDMrGr1dETa3zNasJLin+cRlaw1o=
Received: by mx.zohomail.com with SMTPS id 1734033391603444.6542107983282;
	Thu, 12 Dec 2024 11:56:31 -0800 (PST)
Message-ID: <61a4e812-9514-41a6-a000-e6c026a4ec45@apertussolutions.com>
Date: Thu, 12 Dec 2024 14:56:27 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
 davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hey Luto!

Let me try to address your concerns below.

On 11/18/24 15:02, Andy Lutomirski wrote:
> On Mon, Nov 18, 2024 at 11:12 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
>>> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
>>> exclusively use TPM2_PCR_Event.  I would expect that passing, say,
>>> the entire kernel image to TPM2_PCR_Event would be a big mistake, so
>>> instead Linux should hash the relevant data with a reasonable
>>> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
>>> not* include SHA-1, and may or may not be configurable at build time
>>> to include things like SM3), concatenate them, and pass that to
>>> TPM2_PCR_Event.  And Linux should make the value that it passed to
>>> TPM2_PCR_Event readily accessible to software using it, and should
>>> also include some straightforward tooling to calculate it from a
>>> given input so that software that wants to figure out what value to
>>> expect in a PCR can easily do so.
>>
>> Just for clarity, this is about how the agile log format works.  Each
>> event entry in the log contains a list of bank hashes and the extends
>> occur in log event order, so replaying a log should get you to exactly
>> the head PCR value of each bank.  If a log doesn't understand a format,
>> like SM3, then an entry for it doesn't appear in the log and a replay
>> says nothing about the PCR value.
> 
> I have no idea what the "agile log format" is or what all the formats
> in existence are.  I found section 4.2.4 here:
> 
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p41_pub.pdf
> 
> It says:
> 
> This field contains the list of the digest values Extended. The Extend
> method varies with TPM command, so there is
> no uniform meaning of TPM Extend in this instance, and separate
> descriptions are unavoidable. If using the
> TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
> not the resulting value of the PCR after the
> TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
> command, this field contains the digest
> structure returned by the TPM2_PCR_Event command (that contains the
> digest(s) submitted to each PCR bank as
> the internal Extend operation). This field SHALL contain the
> information from the TPML_DIGEST_VALUES used in
> the Extend operation.


Let me start with providing background on the two measurement policies 
that is implemented by Intel TXT (from Intel TXT Developers Guide):

  - Maximum Agility PCR Extend Policy: ACM can support algorithm agile 
commands TPM2_PCR_Event; TPM2_HashSequenceStart; TPM2_HashUpdate; 
TPM2_EventSequenceComplete. When this policy is selected, ACM will use 
the commands above if not all PCR algorithms are covered by embedded set 
of algorithms and will extend all existing PCR banks. Side effect of 
this policy is possible performance loss.

‒ Maximum Performance PCR Extend Policy: ACM can support several hash 
algorithms via embedded SW. When this policy is selected, ACM will use 
embedded SW to compute hashes and then will use TPM2_PCR_Extend commands 
to extend them into PCRs. If PCRs utilizing hash algorithms not 
supported by SW are discovered, they will be capped with “1” value. This 
policy, when selected, will ensure maximum possible performance but has 
side effect of possible capping of some of the PCRs.

Allow me to clarify/expand on the last statement in Maximum Agility. 
There is almost certainly a performance loss as anything larger than 
1024 bytes, for example the Linux kernel, the ACM will bit-banging the 
bytes to the TPM using the TPM2_Hash* functions.

Before addressing the next point, I would also clarify how the D-CRTM 
measurement taken by the CPU is done. It uses the _TPM_HASH_* functions, 
Section 22.9 of TPM2 Commands specification, to store SHA256(SINIT ACM) 
| EDX into all active PCR banks. For clarity, when this done, EDX holds 
the 4-byte value of the SENTER parameters for which 0 is the only valid 
value currently.


> So we're logging the values with which we extend the PCRs.  Once upon
> a time, someone decided it was okay to skip extending a PCR bank:
> 
> https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/writeup.html
> 
> and it was not a great idea.


Let's begin by why/how that attack occurs. The TPM Carte Blanche attack 
took advantage of the fact that without BootGuard in place, the SRTM 
measurements are done by the software/firmware, to include the 
self-referential S-CRTM measurement. In particular, for the target 
platform, it just so happens that it was possible to construct a 
configuration where not a single hash would be sent to the SHA256 bank. 
This allowed the attacker the ability to replay any set of measurements, 
i.e. carte blanche control, into a completely empty PCR bank for which 
the attestation service would accept quotes. The key to this attack 
requires both, access to an empty PCR bank, and an attestation service 
that will accept a quote with only the exploited bank present.

Let us return to my statements above, which will demonstrate why 
TXT/DRTM completely invalidates the attack. First, as noted above, when 
the CPU is processing the GETSEC[SENTER] instruction, it (the CPU) will 
compute the D-CRTM as SHA256(SINIT ACM) | EDX, sending it to the TPM 
using _TPM_HASH_* functions. The _TPM_HASH_* functions result in all PCR 
banks to be extended with the D-CRTM value. If Maximum Performance PCR 
Extend policy is in use, which is the default policy used by TrenchBoot, 
any algorithm not supported by the ACM is capped by sending the value 
"1" as the digest value for the extend. Therefore, after the TXT 
sequence has completed and before control is given to the Linux kernel 
by the ACM, all PCR banks will consist of either, the D-CRTM + all ACM 
measurements, or the D-CRTM + TPM2_PCR_Extend(0x1). There will be no PCR 
banks with empty DRTM PCRs, thus none of the banks would be usable for a 
TPM Carte Blanche-style attack.


> There seem to be six (!) currently defined hashes: SHA1, SHA256,
> SHA384, SHA512, SM2 and SM3.  I haven't spotted anything promising not
> to add more.  It seems to be that Linux really really ought to:
> 
> (a) extend all banks.  Not all banks that the maintainers like, and
> not all banks that the maintainers knew about when having this
> discussion.  *All* banks.  That means TPM2_PCR_Event().  (Or we refuse
> to boot if there's a bank we don't like.)
> 
> (b) Make a best effort to notice if something is wrong with the TPM
> and/or someone is MITMing us and messing with us.  That means
> computing the hash algorithms we actually support and checking whether
> TPM2_PCR_Event() returns the right thing.  I'm not seeing a specific
> attack that seems likely that this prevents, but it does seem like
> decent defense in depth, and if someone chooses to provision a machine
> by reading its event log and then subsequently getting an attestation
> that a future event log matches what was read, then avoiding letting
> an attacker who temporarily controls the TPM connection from
> corrupting the results seems wise.  And I don't see anything at all
> that we gain by removing a check that (TPM's reported SHA1 == what we
> calculated) in the name of "not supporting SHA1") other than a few
> hundred bytes of object code.  (And yes, SHA1 is much more likely to
> be supported than SM3, so it's not absurd to implement SHA1 and not
> implement SM3.)


Or,

(c) Upon initialization, cap the PCR banks with unsupported algorithms 
using a well-known value.

A problem with (a) is that the result will be an unorthodox event, 
PCR_EXTEND(H(H'(data))). An attestation verifier will have to be aware 
of that this is being done, and have a way to determine which method was 
used for each event. This creates a potentially expensive cost for any 
existing attestation solutions to incorporate support for the unorthodox 
event. At least for DRTM solutions, it seeks to solve a problem that TXT 
does not experience.

For Linux Secure Launch, I would like to propose an alternative to what 
the current logic does in the setup kernel. Specifically, Secure Launch 
will trigger a TXT reset when an unsupported algorithm is encountered. 
Instead, I would like to propose the adoption of (c), and have it 
extends a well-known, fixed value for unsupported algorithms. Secure 
Launch can leverage the fact that the TPM driver's extend function 
already expects to be given digests for all active algorithms. 
Therefore, it will record the well-known value, 0x01 to follow the ACM, 
into the digest buffers of any algorithms that Secure Launch does not 
support. This will result in the well-known value being extended each 
time a measurement is recorded. This will not be a problem as no one 
should be using those banks for attestation and can ignore those digests 
in the event log.

I would like to note that we made a conscious design decision early on 
to use the PCR performance policy approach. We weighed a variety of 
security concerns, hardware availability, and the practicality of 
integrating the capability into our respective efforts. I do not want 
you to feel as though we are not taking your comments seriously. Ross 
reached out to some their contacts, and I reached out to a colleague 
with domain experience as well. From a cursory review, no one saw an 
issue from a crypto standpoint, beyond some algorithm recommendations. 
As we highlighted, they did caution about the resulting unorthodox 
measurement that would impose a burden on attestation solutions.

Hopefully With the background and context presented, you would agree the 
above is a reasonable approach. If you do have concerns, please let us know.

V/r,
Daniel P. Smith


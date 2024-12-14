Return-Path: <linux-efi+bounces-2376-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D09F1C2E
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 03:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE09188CF10
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2024 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6718622;
	Sat, 14 Dec 2024 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="i9wFs1ix"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654B10940;
	Sat, 14 Dec 2024 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145094; cv=pass; b=AkZSUOvCMXBP0B2rLeSAOeEIErCFclyww96sEbihTCnmCJ4LVt+M467QHlioz7WCHXXoRGx+DvYRypOGx50OeMjQirpd2Nq6K4lId2fYg79sV6AvMLxoAUzJ/BGRbCK1xi0PSo8jtahzO85mTHIvxPChRD3l1cXxDEOAJJawPyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145094; c=relaxed/simple;
	bh=o4mGcJVgmz+f6KDgXPTOaRjH//QGgbtIH9gxPhWSFpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVjiyP243Utcy1gu3zt11PFNm9A1Iq0uk90etTTdP6qPoT0WbMr5WquQUMkrbSmNxAmJa25uh2fVnW/S+Oq9VbIpFgPDDlBDtsHbci0Mx1Ini33FW8hJDPabUFJDEWeeB626U9H+2eJopba9yyQ5fGa80r2Z9vDE+icuAUbmdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=i9wFs1ix; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1734145007; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=awW+SO0XKfy+0Pyi8ms7Cp4QZGyd4GSS0XoyLpNZ+3KR4GlJldIQRAYxtIalKXFl1fEFdisd8D97ja3DjnohuFmSB1Ygw5D97ISKbidoeX6+AmF/APCcCTG6/UzKbjkkVGRJltHvAGPonTQcTNtVyPFrWKySiBL0GqrcmhJfNI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734145007; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yTLX58/fR9Jhi/uY5ah/JDfKClGzaUuJTL0r4DQjPxQ=; 
	b=CTuxE1O+s21+0aPjUFyTrerXIgUIiKt7ah+lthtZoumZR7nSTL+zGSTvt0agOuXHkLAZwmrXfxt9KSW6rov1a3dd0kiE6Lrx/J+N6JZhojMxpKYXJdxZsBV0meQ/Qe9rtKgaITO2lYGRd/aFOiTiOv1hcO2+hRl4Dr15RIQxM0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734145007;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yTLX58/fR9Jhi/uY5ah/JDfKClGzaUuJTL0r4DQjPxQ=;
	b=i9wFs1ixxA7BrvBE2uuw9mPD8rk4qfbIvREXIubQVyrEXf50FdudxBFP+JxaW0WL
	y6u4NCewpCrGXiCsxMoLM/jx4cb/Q4o4cC7QCD280PX7naa1cQZzP0vJTG1RBD8eaSd
	9JNjKqNoAj2jHCMwpd0BeiVFz1ALbpPTUONd/Eq0=
Received: by mx.zohomail.com with SMTPS id 1734145005147748.7051374178144;
	Fri, 13 Dec 2024 18:56:45 -0800 (PST)
Message-ID: <5330397a-e74a-4061-ba6d-fa522877f237@apertussolutions.com>
Date: Fri, 13 Dec 2024 21:56:40 -0500
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
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 <61a4e812-9514-41a6-a000-e6c026a4ec45@apertussolutions.com>
 <CALCETrXQqR6Az7puNXLfhoL37iLHtG1qOyqC_K301TGmMOQvvA@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CALCETrXQqR6Az7puNXLfhoL37iLHtG1qOyqC_K301TGmMOQvvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 12/12/24 17:30, Andy Lutomirski wrote:
> On Thu, Dec 12, 2024 at 11:56 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> Hey Luto!
>>
>> Let me try to address your concerns below.
>>
>> On 11/18/24 15:02, Andy Lutomirski wrote:
>>> On Mon, Nov 18, 2024 at 11:12 AM James Bottomley
>>> <James.Bottomley@hansenpartnership.com> wrote:
>>>>
>>>> On Mon, 2024-11-18 at 10:43 -0800, Andy Lutomirski wrote:
>>>>> Linux should not use TPM2_PCR_Extend *at all*.  Instead, Linux should
>>>>> exclusively use TPM2_PCR_Event.  I would expect that passing, say,
>>>>> the entire kernel image to TPM2_PCR_Event would be a big mistake, so
>>>>> instead Linux should hash the relevant data with a reasonable
>>>>> suggestion of hashes (which includes, mandatorily, SHA-384 and *does
>>>>> not* include SHA-1, and may or may not be configurable at build time
>>>>> to include things like SM3), concatenate them, and pass that to
>>>>> TPM2_PCR_Event.  And Linux should make the value that it passed to
>>>>> TPM2_PCR_Event readily accessible to software using it, and should
>>>>> also include some straightforward tooling to calculate it from a
>>>>> given input so that software that wants to figure out what value to
>>>>> expect in a PCR can easily do so.
>>>>
>>>> Just for clarity, this is about how the agile log format works.  Each
>>>> event entry in the log contains a list of bank hashes and the extends
>>>> occur in log event order, so replaying a log should get you to exactly
>>>> the head PCR value of each bank.  If a log doesn't understand a format,
>>>> like SM3, then an entry for it doesn't appear in the log and a replay
>>>> says nothing about the PCR value.
>>>
>>> I have no idea what the "agile log format" is or what all the formats
>>> in existence are.  I found section 4.2.4 here:
>>>
>>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_IWG_CEL_v1_r0p41_pub.pdf
>>>
>>> It says:
>>>
>>> This field contains the list of the digest values Extended. The Extend
>>> method varies with TPM command, so there is
>>> no uniform meaning of TPM Extend in this instance, and separate
>>> descriptions are unavoidable. If using the
>>> TPM2_PCR_Extend command, this field is the data sent to the TPM (i.e.,
>>> not the resulting value of the PCR after the
>>> TPM2_PCR_Extend command completes). If using the TPM2_PCR_Event
>>> command, this field contains the digest
>>> structure returned by the TPM2_PCR_Event command (that contains the
>>> digest(s) submitted to each PCR bank as
>>> the internal Extend operation). This field SHALL contain the
>>> information from the TPML_DIGEST_VALUES used in
>>> the Extend operation.
>>
>>
>> Let me start with providing background on the two measurement policies
>> that is implemented by Intel TXT (from Intel TXT Developers Guide):
>>
>>    - Maximum Agility PCR Extend Policy: ACM can support algorithm agile
>> commands TPM2_PCR_Event; TPM2_HashSequenceStart; TPM2_HashUpdate;
>> TPM2_EventSequenceComplete. When this policy is selected, ACM will use
>> the commands above if not all PCR algorithms are covered by embedded set
>> of algorithms and will extend all existing PCR banks. Side effect of
>> this policy is possible performance loss.
>>
>> ‒ Maximum Performance PCR Extend Policy: ACM can support several hash
>> algorithms via embedded SW. When this policy is selected, ACM will use
>> embedded SW to compute hashes and then will use TPM2_PCR_Extend commands
>> to extend them into PCRs. If PCRs utilizing hash algorithms not
>> supported by SW are discovered, they will be capped with “1” value. This
>> policy, when selected, will ensure maximum possible performance but has
>> side effect of possible capping of some of the PCRs.
>>
> 
> What is responsible for choosing which of these policies to use?


It is setup by the Dynamic Launch Preamble (GRUB) that will invoke the 
Dynamic Launch Event (GETSEC[SENTER]).


>> Allow me to clarify/expand on the last statement in Maximum Agility.
>> There is almost certainly a performance loss as anything larger than
>> 1024 bytes, for example the Linux kernel, the ACM will bit-banging the
>> bytes to the TPM using the TPM2_Hash* functions.
> 
> Surely, if Linux's stub started using TPM2_PCR_Event, it would first
> hash any large inputs and then send the _hash_ to TPM2_PCR_Event
> instead of, say, bit-banging the entire initramfs to the TPM.  But
> you're talking about the ACM and I'm talking about the Linux stub code
> in this patchset.


I think there might be some confusion on how this starts, let me provide 
a quick, enumerated flow:

1. GRUB prepares launch environment (Linux kernel, SINIT ACM, 
OsSinitData) and calls GETSEC[SENTER] instruction
2. The CPU signals PCH that DRTM has started, unlocking Locality 4
3. The CPU loads the SINIT ACM into CRAM, measures it with SHA256 and 
uses _TPM_HASH_START /_TPM_HASH_DATA / _TPM_HASH / _TPM_HASH_END to 
extend SHA256(ACM) | EDX into PCR17 for all PCR banks
4. The CPU then jumps into the ACM
5. The ACM does a series of actions and measurements of the system into 
PCRs 17 and 18 for SHA1, SHA256, SHA384, and SM3_256 (PCR Performance 
Policy)
6. The ACM then measures the "MLE", the Linux kernel in this case, using 
the same algorithms
7. The ACM then caps PCRs 17 and 18 by extending 0x01 for any 
unsupported algorithm the TPM supports.
8. The ACM then jumps to the Secure Launch entry point in the setup kernel

If the initramfs is external, then yes, the setup kernel would get to do 
the measurement. If it is a unified kernel image, well, that whole thing 
will be bit banged to the TPM by the ACM if the PCR Agile Policy is used.

> But the capping-with-"1" does suggest that maybe one can actually cap
> with "1" without preventing downstream software from consuming the
> event log.

Correct, capping the PCR should never block downstream software from 
consuming the event log.

>>
>> Before addressing the next point, I would also clarify how the D-CRTM
>> measurement taken by the CPU is done. It uses the _TPM_HASH_* functions,
>> Section 22.9 of TPM2 Commands specification, to store SHA256(SINIT ACM)
>> | EDX into all active PCR banks. For clarity, when this done, EDX holds
>> the 4-byte value of the SENTER parameters for which 0 is the only valid
>> value currently.
>>
>>
>>> So we're logging the values with which we extend the PCRs.  Once upon
>>> a time, someone decided it was okay to skip extending a PCR bank:
>>>
>>> https://google.github.io/security-research/pocs/bios/tpm-carte-blanche/writeup.html
>>>
>>> and it was not a great idea.
>>
>>
>> Let's begin by why/how that attack occurs. The TPM Carte Blanche attack
>> took advantage of the fact that without BootGuard in place, the SRTM
>> measurements are done by the software/firmware, to include the
>> self-referential S-CRTM measurement. In particular, for the target
>> platform, it just so happens that it was possible to construct a
>> configuration where not a single hash would be sent to the SHA256 bank.
>> This allowed the attacker the ability to replay any set of measurements,
>> i.e. carte blanche control, into a completely empty PCR bank for which
>> the attestation service would accept quotes. The key to this attack
>> requires both, access to an empty PCR bank, and an attestation service
>> that will accept a quote with only the exploited bank present.
>>
>> Let us return to my statements above, which will demonstrate why
>> TXT/DRTM completely invalidates the attack. First, as noted above, when
>> the CPU is processing the GETSEC[SENTER] instruction, it (the CPU) will
>> compute the D-CRTM as SHA256(SINIT ACM) | EDX, sending it to the TPM
>> using _TPM_HASH_* functions. The _TPM_HASH_* functions result in all PCR
>> banks to be extended with the D-CRTM value. If Maximum Performance PCR
>> Extend policy is in use, which is the default policy used by TrenchBoot,
>> any algorithm not supported by the ACM is capped by sending the value
>> "1" as the digest value for the extend. Therefore, after the TXT
>> sequence has completed and before control is given to the Linux kernel
>> by the ACM, all PCR banks will consist of either, the D-CRTM + all ACM
>> measurements, or the D-CRTM + TPM2_PCR_Extend(0x1). There will be no PCR
>> banks with empty DRTM PCRs, thus none of the banks would be usable for a
>> TPM Carte Blanche-style attack.
> 
> Sure, a "carte blanche" attack in the sense that the PCRs are entirely
> blank won't happen, but if any component in the chain does not extend
> a bank, then an attacker can replace the code _after_ that component
> without being noticed.


There are two scenarios that could be considered here. The first is if 
an algorithm is added to the TPM that neither the ACM nor the TPM driver 
supports. The second is if an algorithm supported by the ACM and the TPM 
driver is added, but not supported by Secure Launch.

In the first case, the PCR and corresponding log entries for the new 
algorithm will have the D-CRTM event and Cap (0x01) event. Rendering the 
bank unusable for the attacker.

For the second case, this is a "it all depends on the usage". First and 
foremost, I would say it is ultimately a failure of the Attestation 
Service if it evaluated algorithms that Secure Launch is not advertised 
to support.

With that, let's consider the options for bad components under the 
second case:
- A bad kernel image will be detected since the ACM is what measures it.
- A bad initramfs, assuming that (c) below was not implemented, then the 
initramfs could add a fake entry for itself into the bank in question.
- Any component after this depends on the use case. The primary use case 
currently is to combine Secure Launch with TrenchBoot additions to 
u-root making it an intermediate bootloader that kexec's into the target 
kernel. I bring this up because when the kexec is done, Secure Launch 
does GETSEC[SEXIT]. The result being that it closes all localities 
except Locality 0. They cannot be re-opened without doing a new Dynamic 
Launch, which will reset them all back to 0.

I would also like to note that Secure Launch would not be the only 
in-kernel capability that would have to scramble to add support for the 
additional algorithm if it suddenly became available to block a Carte 
Blanche attack.


>> (c) Upon initialization, cap the PCR banks with unsupported algorithms
>> using a well-known value.
>>
>> A problem with (a) is that the result will be an unorthodox event,
>> PCR_EXTEND(H(H'(data))). An attestation verifier will have to be aware
>> of that this is being done, and have a way to determine which method was
>> used for each event. This creates a potentially expensive cost for any
>> existing attestation solutions to incorporate support for the unorthodox
>> event. At least for DRTM solutions, it seeks to solve a problem that TXT
>> does not experience.
>>
>> For Linux Secure Launch, I would like to propose an alternative to what
>> the current logic does in the setup kernel. Specifically, Secure Launch
>> will trigger a TXT reset when an unsupported algorithm is encountered.
>> Instead, I would like to propose the adoption of (c), and have it
>> extends a well-known, fixed value for unsupported algorithms. Secure
>> Launch can leverage the fact that the TPM driver's extend function
>> already expects to be given digests for all active algorithms.
>> Therefore, it will record the well-known value, 0x01 to follow the ACM,
>> into the digest buffers of any algorithms that Secure Launch does not
>> support. This will result in the well-known value being extended each
>> time a measurement is recorded. This will not be a problem as no one
>> should be using those banks for attestation and can ignore those digests
>> in the event log.
> 
> This seems to be at least not terrible.


With (c) in place, it would completely close off the second case for the 
case when the initramfs is not part of the kernel image.


> Or I suppose one could use TPM_HASH_ functions? The spec for them is
> somewhat impenetrable to me.


Do you mean TPM2_HashSequenceStart / TPM2_SequenceUpdate / 
TPM2_EventSequenceComplete? If you really meant _TPM_Hash_Start / 
_TPM_Hash_Data / _TPM_Hash_End, then no, you cannot call these. They are 
not sent via the Command Buffer but directly through the TPM interface. 
Have a look at Section 34 of the TPM Architecture[1]. While the spec 
authors wrote it generically, as if there is more than one way for an 
H-CRTM to be established, the only way available for x86 is DRTM.

[1] 
https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-1-Architecture.pdf

Ross has prepared a new version of the series using (c), which actually 
reduces the size and complexity of the SL setup code. Once it has been 
tested, Ross will post it so you can have some concrete code to look at 
and consider the proposal.

V/r,
Daniel P. Smith





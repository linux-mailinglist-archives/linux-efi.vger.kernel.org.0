Return-Path: <linux-efi+bounces-441-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF2844821
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074E5287639
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jan 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EEB3B189;
	Wed, 31 Jan 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="Touy7tyx"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D73B198;
	Wed, 31 Jan 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730098; cv=pass; b=pbYs0rl+lP33d3AK8yZuerAYPkufqGhPxudxU1jpSIuScy9HdzQumwJFmP06MnmBgbZutW5HmbHv3XAmdphxeD+cd3DdWgypDtwjMFubhZDsbIClF0oUPMDBrUg5TWLs54osbJZKzWBrDTMFejiTs9faIF1TenCH0MLuBenxv/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730098; c=relaxed/simple;
	bh=MVaPKWXDpTdplz7PBiWoPwFbLQhMQk9zgGSMyc9P+Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYJ0EzX0KSM24utu2nPX4o84QaYQUhmggkco009NogAxlfSpHsUllbI3sJvv9g9auRNvgCfR4+g+VATQGPlkWDe5KSL8RsbimC32+EnHyiQh1mZJmG+FucX5v+YXWEuHGXz4xdgi0qelqtO5PUdtdGIv0rVnNFEbvO1LSuYElnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=Touy7tyx; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706730045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JmiHzRNYzl8PNHVj/q3cq1jsYD13Wow6VM65eoYQvbvL7XWdxDkRjSkaq+Us6I6iCiSah8xk2sDB8k9cDdkApeORl5eJcPjEJBJ+ujX6Lwbl42vttFUcfdG6GiUsvWaQpzQV+FhubqRgyuTWr+c8ovRH0qfLDI/7G9u3hm01uvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706730045; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Exjrm0JkMmrLHfveYJPV4JzDlCBEpPbHczsuJz8we7Q=; 
	b=R6fUABgPPLK4rzWIfi2PHbAQWuLxbFDoJ1MOU914VB53HaC6gEHHO64MD6b5uuexKnUad58yTH1tBLGZkJHBIF6Gz9V9sH/S3FCzHrRXmVfSoJGWx6xj3zqIlxRML5pFGHOP4criJ8aKqajXMs5PGGSDdqEKkyIWF0C6V23LoAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706730045;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Exjrm0JkMmrLHfveYJPV4JzDlCBEpPbHczsuJz8we7Q=;
	b=Touy7tyxCDR6MDVHEF9X5UOd2e11wC8c5olfzh93diH2AcMUlPbV8TfJ8uqABQs6
	rozg5ugsmviXJTlkRegSFn4yy4BbMM4C0tKG3oJA4zW0jqrJMOVwDOz2x1a7ctOVf3r
	MBwHetGfwY3/p9Sp5cUjgZFBpeMQdsjggAtJxqZI=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706730042244444.47380530398664; Wed, 31 Jan 2024 11:40:42 -0800 (PST)
Message-ID: <e2c2f9af-4828-4deb-9625-83159034ea1c@apertussolutions.com>
Date: Wed, 31 Jan 2024 14:40:38 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To: Alyssa Ross <hi@alyssa.is>, Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-3-ross.philipson@oracle.com>
 <scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Alyssa, apologies for the late response.


On 11/12/23 13:07, Alyssa Ross wrote:
>> +Load-time Integrity
>> +-------------------
>> +
>> +It is critical to understand what load-time integrity establishes about a
>> +system and what is assumed, i.e. what is being trusted. Load-time integrity is
>> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
>> +action to assess an entity being loaded into memory before it is used. A
>> +variety of mechanisms may be used to conduct the assessment, each with
>> +different properties. A particular property is whether the mechanism creates an
>> +evidence of the assessment. Often either cryptographic signature checking or
>> +hashing are the common assessment operations used.
>> +
>> +A signature checking assessment functions by requiring a representation of the
>> +accepted authorities and uses those representations to assess if the entity has
>> +been signed by an accepted authority. The benefit to this process is that
>> +assessment process includes an adjudication of the assessment. The drawbacks
>> +are that 1) the adjudication is susceptible to tampering by the Trusted
>> +Computing Base (TCB), 2) there is no evidence to assert that an untampered
>> +adjudication was completed, and 3) the system must be an active participant in
>> +the key management infrastructure.
>> +
>> +A cryptographic hashing assessment does not adjudicate the assessment but
>> +instead, generates evidence of the assessment to be adjudicated independently.
>> +The benefits to this approach is that the assessment may be simple such that it
>> +may be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
>> +it is possible for the adjudication to be conducted where it cannot be tampered
>> +with by the TCB. The drawback is that a compromised environment will be allowed
>> +to execute until an adjudication can be completed.
>> +
>> +Ultimately, load-time integrity provides confidence that the correct entity was
>> +loaded and in the absence of a run-time integrity mechanism assumes, i.e.
>> +trusts, that the entity will never become corrupted.
> 
> I'm somewhat familiar with this area, but not massively (so probably the
> sort of person this documentation is aimed at!), and this was the only
> section of the documentation I had trouble understanding.
> 
> The thing that confused me was that the first time I read this, I was
> thinking that a hashing assessment would be comparing the generated hash
> to a baked-in known good hash, simliar to how e.g. a verity root hash
> might be specified on the kernel command line, baked in to the OS image.
> This made me wonder why it wasn't considered to be adjudicated during
> assessment.  Upon reading it a second time, I now understand that what
> it's actually talking about is generating a hash, but not comparing it
> automatically against anything, and making it available for external
> adjudication somehow.
> 
> I don't know if the approach I first thought of is used in early boot
> at all, but it might be worth contrasting the cryptographic hashing
> assessment described here with it, because I imagine that I'm not going
> to be the only reader who's more used to thinking about integrity
> slightly later in the boot process where adjudicating based on a static
> hash is common, and who's mind is going to go to that when they read
> about a "cryptographic hashing assessment".

The scenario that first came to mind for you, specifically the verity 
root hash, is in fact a form of signature checking assessment. A 
signature is nothing more than saying here is a hash with provenance 
that is enforced by the measuring entity. For a PKI signature, e.g. UEFI 
Secure Boot, the provenance is confirming that the encrypted portion of 
the signature can be decrypted using the CA public key. For the case of 
dm-verity, the provenance of the hash is its source, that it came from 
the command line. If you consider the consequences presented for a 
signature checking assessment, one should see the same issues with 
dm-verity: 1) any logic in the kernel, intended or injected, could 
tamper with the validation of the hash, 2) there is no evidence of each
block hashed into the final hash that is assessed, and 3) the system is 
responsible to ensure only the correct hash has been provided on the 
command line.

Another way to consider the above, there are always two actions for 
assessing integrity, measurement and assessment. When both actions are 
delegated to a single entity along with a mechanism to provide the known 
good, this is a signature checking assessment. When these two actions 
are delegated to two separate entities, this is a cryptographic hashing 
assessment. In TCG parlance, the former is a Root of Trust for 
Verification (RTV) chain and the latter is a Root of Trust for 
Measurement (RTM) chain.

And to clarify the example provided by Ross in using the TPM seal 
method. This is a cryptographic hashing assessment, as the two functions 
are done by separate entities. The software makes the measurements while 
the TPM makes the assessment. In theory, the solution employing a TPM 
seal will have established what the expected sequence of measurements 
should be, and ensured the TPM seal was the final and correct measurement.

I don't know if you will find it too rudimentary, but I feel I did a 
fairly decent job covering on this in the first ever TrenchBoot talk[1].

[1] https://www.platformsecuritysummit.com/2018/speaker/smith/

> The rest of the documentation was easy to understand and very helpful to
> understanding system launch integrity.  Thanks!

I am very glad to hear you found it helpful. This is a very complex 
topic, and trying to break it all down for an audience that may have 
zero background and an interest to help is no small undertaking.

V/r,
Daniel P. Smith


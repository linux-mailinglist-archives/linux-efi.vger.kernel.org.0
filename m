Return-Path: <linux-efi+bounces-6115-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNU8AScvjmnGAgEAu9opvQ
	(envelope-from <linux-efi+bounces-6115-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 20:51:03 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A0130C80
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21A49300B2B0
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107F2D061D;
	Thu, 12 Feb 2026 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="h5+avsIC"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9F26E71E;
	Thu, 12 Feb 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770925857; cv=pass; b=Zv6G1whUW3j1G+rcr0TlL0rZE2Re+y3xSx9v/BurjUBallK7pTLPc7qXW0MlVyfEP7VRlw+g5Q9th+YsDx/mJevR5BpmqfM9kIJMW3lv6f/A8iJXRS3V0mbOsDjZVQXw/XNowW80x7jFCeJzI6s++5wZkFgDsG2rZFy06cYwLYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770925857; c=relaxed/simple;
	bh=mWESc47AJA+lHjf4Pyt7BlLH+EidFtKQ5OpkN7dFCVI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hxv768XO+ELCIwouAVyJU5TE7iuivFrJ6b2BgfkQNGk7Clh6KIIo+FJdeRT6zgHRjBV7MaLBzYcmIqzhoeeQNkA23mFcf2Njs34Kue1ipnGtwTfBw4CMXTVbOfekqfoP0dOiVsOaUwY4TOECuHd4q3I1Ntp9vCxDlZCAy6wAIxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=h5+avsIC; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1770925777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ekcngpQ7NDkJ36AcYIWdWlZ1fnNZ2sBsMVqKfQdPEAq58d7uMUtli6X+0bwOeui8WnB1pIqRwn71DQN7aam7YVAhb3unullQN1FZ6dpqtrJiMEcoV5P74qWTGdr10ySbJK53R619BDyXoz26vuQ4fhObiFvFGltRtylIVBXPB3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770925777; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q5f0KQ4HpmngY/cB/yWwkzlIghghBJhp3nW+USmOVik=; 
	b=OIRmMZhuRv8EZPoPzI7yEywLPwm+gEF6hQf8YhVXec3TUKj8kphv8Bok1BkrKY6kg8Zds4WaDKCRwojR09EbV9nzUmCmlI7JwpCXrxbFUB9tqh4FSyAMnsF7QU130EX88bKnzzIFVJNQ0tqew2FndgXupSdn4mE9HtTlfHpV1vI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770925777;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Q5f0KQ4HpmngY/cB/yWwkzlIghghBJhp3nW+USmOVik=;
	b=h5+avsIC4D+GQntqrkrmOIS0ovmvmsYj1+nhBO/DqWIV6Bykd4KyYsWXp8F/SUiR
	ZU2xI9FpC0N5mPDGNqVAd8YQbXOK9S591m6BI5Y1JzLXv23Ed2xfUL3cUmcVA0Cmv4h
	L2Mmf0cjD7KzvGdsop+j+QLY5Uf5ACm56YBFzmKU=
Received: by mx.zohomail.com with SMTPS id 1770925773787976.3595214538861;
	Thu, 12 Feb 2026 11:49:33 -0800 (PST)
Message-ID: <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
Date: Thu, 12 Feb 2026 14:49:31 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, bp@alien8.de,
 "H . Peter Anvin" <hpa@zytor.com>, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
Content-Language: en-US
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[apertussolutions.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[apertussolutions.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6115-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[apertussolutions.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpsmith@apertussolutions.com,linux-efi@vger.kernel.org];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,zytor.com,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trenchboot.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 258A0130C80
X-Rspamd-Action: no action

On 2/9/26 09:04, Ard Biesheuvel wrote:
> On Tue, 16 Dec 2025, at 00:32, Ross Philipson wrote:
>> Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
>> Root of Trust (DRTM) support in the kernel. This is complementary to
>> better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.
>>
>> This series provides the common infrastructure along with Intel TXT
>> support, without needing the tboot exokernel. Support for AMD SKINIT is
>> pending the common infrastructure getting nailed down, and ARM are
>> looking to build on it too.
>>
>> Originally, tboot were approached to see if they'd take support for
>> other vendors, but they elected not to. Hence this approach instead.
>>
>> Work is being coordinated by the Trenchboot project,
>> https://trenchboot.org/,
>> organising Secure Launch support for upstream open source projects
>> including
>> Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM
>> easy
>> to use.  e.g. for Grub, it's simply adding "slaunch" as a command in
>> the boot
>> stanza.  See
>> https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
>> for more details
>>
>> Patch set based on commit:
>> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
>>
>> Depends on v3 of the following TPM patch set (note this patch
>> set is being actively worked on separately):
>> [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
>> Message ID: 20250929194832.2913286-1-jarkko@kernel.org
>>
>> Finally we would like to thank everyone for their input and
>> assistance. It has all been very helpful in improving the quality of
>> our solution and in reviewing/strengthening our security posture.
>>
> 
> Hi Daniel and Ross,
> 
> I have finally gotten around to getting the right hardware and building GRUB and Linux with your patches, and I have managed to get them running on an old Skylake HP laptop successfully.

That is great to hear!

> Surprisingly, even when doing a secure launch, the EFI runtime services still work happily, which means (AIUI) that code that was excluded from the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM entirely in the case some exploit is hidden in the EFI runtime code? Should we measure the contents of EfiRuntimeServicesCode regions too?

Yes, in fact in the early days I specifically stated that we should 
provide for the ability to measure the RS blocks. Particularly if you 
are not in an environment where you can isolate the calls to RS from the 
TCB. While the RS can pose runtime corruption risks, the larger concern 
is integrating the D-RTM validation of the Intel System Resources 
Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Intel 
System Security Report (ISSR). Within the ISSR is a list of memory 
regions which the SMM Policy Shim (SPS) restricts a SMI handler's access 
when running. This allows a kernel to restrict what access a SMI handler 
are able to reach, thus allowing them to be removed from the TCB when 
the appropriate guards are put in place.

If you are interested in understanding these further, Satoshi Tanda has 
probably the best technical explanation without Intel market speak.

ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html

> In any case, I am aware that upstreaming this work has been a painful experience so far. Unfortunately, I don't think we're quite there yet.
>
> The way the work is divided between GRUB and Linux seems to be predicated entirely (at least originally) on the idea that the GRUB->Linux handover and the secure launch should be one and the same. I.e., GRUB sets the stage, pokes the ACM, which returns to the loaded linux image and boots it. This requires a lot of coordination, e.g., putting a MLE header in the kernel image and exposing it to GRUB in a certain manner, resource tables and other things that have to remain in sync between both sides.

I would add one clarification, where you say GRUB, we would say any 
bootloader and where you say Linux, we would say any kernel that could 
be started with D-RTM. While you all care about Linux specifically, the 
goal for TrenchBoot is to build a common approach that we can implement
across any other open source OS.

> There also appears to be an assumption that the fact that the ACM returns to the loaded image in 32-bit mode requires a round trip through the decompressor, which may relocate itself in memory and do other things that the slaunch code then has to work around again.
> 
> Due to the changes to the EFI boot path, this design has been watered down a bit already, in the sense that GRUB invokes the EFI entry point as usual, and only later, the pivot via the ACM is made.
> 
> Other than the SHA-1 debate [*], the main issue I have with this approach is that it adds things to the boot ABI that are closely tied to TXT on the one hand, and bzImage oddities on the other (kernel_info, setup block etc). IOW, the complete lack of abstractions is going to make this a maintenance burden going forward.
> 
> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
> 
> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
> - the EFI stub executes and decompresses the kernel as usual
> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
> 
> The only pre-launch ABI that is being added here is a GRUB-specific protocol that is not necessarily tied to TXT. (For legacy boot, it should be feasible to call back into GRUB too, although it would be more of a ad-hoc construction, via the SLR table perhaps.) But no kernel_info and MLE headers etc being added to the ABI surface. Also, there is no longer a need for the GRUB code to understand how the decompressor is constructed, with a setup block etc, or take special care to perform PMR checks when its moves itself around in memory.

> [*] which I still don't get: why is it fine to cap other banks with a single 0x1 byte [as the ACM does too, apparently], but do we require an SHA-1 implementation for capping the SHA-1 banks? Also, the TXT spec dropped all support for TPM1.2 so I wonder if that should be dropped from this series as well.

I think this is a great approach for UEFI, though we need to reconcile 
this with non-UEFI situations such as booting under coreboot. The one 
concern we have before committing to yet another rework is to get 
confirmation from the x86 maintainers. Would they be okay with a new 
entry point into the mainline kernel, or any other major sticking points 
they might see from this approach?

Dave Hansen, since you have been helping us as an x86 maintainer, would 
be willing to provide feedback on our concerns moving forward with the 
above proposal?

> Code can be found here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/grub.git/log/?h=sl-v2
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-slaunch
> 
> I am aware that this is not the feedback you are waiting for at this point, given that we're at v15 already. But there are some warts in the current design that really need to be addressed before we can proceed with this IMHO.
>

V/r,
DPS








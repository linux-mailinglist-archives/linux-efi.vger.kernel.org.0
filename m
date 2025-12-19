Return-Path: <linux-efi+bounces-5911-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015DECD1F41
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B79DD303D68F
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449B32B98E;
	Fri, 19 Dec 2025 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="EHw8A+Hx"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFA304976;
	Fri, 19 Dec 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179652; cv=pass; b=MSUDCutRx+430SAu7MHCLJ8aYlNYfOLhXSYRKUzNIyoeKxFMwGr3bmapIa3v/Xcy0kxeZDRK814X+lw8KTfs68SRjEGMh0+aXPpZNE/J09Ogcl+Cdhn6ht52sPPP227LTc8P/IKJxisS0AL3C6xhTPdqVXTJKHPMI3TdTuYlavc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179652; c=relaxed/simple;
	bh=/KdBLu3zLIn3vMbwoWA7KwHaiELSeLp1z4W3gn1njws=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=az+ip4YPj8Ob79HVm6dXysC3V/sa805/UDBuAW03yhlVI5akPQ1Db/x4DjOjxVmaOcUGMlbOnuxeWh/PfkLI3GD0fMPNqKUubk9FgOzgiF0FAWHGvpVALvOkZIBjSPcjouKzao7CrznDdKBtXsVFut+O9vVli7QYDU5ar4gE7kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=EHw8A+Hx; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1766179569; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XPk0Sln3Cy5qk9DCbfpON90DRrJ6nI9A6vUs+SDznVkOPF+0/KPsmXq9b9DDLc6G7FyU9F0CJt5VdkipC61Tei3S1DepoHDKMSB/wa2v9KRUb9My7p/5zHLBW0qRwtrPr9SufQtphsiNXeZQiLxYJ9H+5FZQbYi9qJSWKunnNjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766179569; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1ksQG2W08myKpheAB5+lngG8EZBBbzC4ZDZ4Ho0k7yk=; 
	b=HHVC7hMBfBO846ScF3bcXEHdCW2AJdpkSX1+Km6al2QM4b7oRgPtjjGMrZRAwh5WlSjVAOXmyUdSTN9Li2b/cTPSg+suLtNT0t3rwlYlwliPjw17QP4i47ZCByfWQDxeh730ZvkQm2tgepZ45g5KibgWi2FxQ/jEV0HTbDrKJTI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766179569;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1ksQG2W08myKpheAB5+lngG8EZBBbzC4ZDZ4Ho0k7yk=;
	b=EHw8A+Hx1IszIEM+SW2HJBnE2oDNbQgT9FR2t1QSNOin+e1UbG5VkGGIH85bazia
	mcgs4w2xqMOHq6EQHfPnSgU1DLIxdXTY0aLA1V0H8NrITQ6SXGv6YwAcPw2Mt5z7DpN
	a0wdNOlnOWMU3TV6djzu7cPpRXAjLpHsQ1z+BoW0=
Received: by mx.zohomail.com with SMTPS id 1766179565947257.12757632667626;
	Fri, 19 Dec 2025 13:26:05 -0800 (PST)
Message-ID: <62227ed3-3804-4795-93c9-ce2bbad3f2a7@apertussolutions.com>
Date: Fri, 19 Dec 2025 16:26:02 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v15 19/28] x86/tpm: Early TPM PCR extending driver
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-20-ross.philipson@oracle.com>
 <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
Content-Language: en-US
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hey Dave!

On 12/16/25 16:53, Dave Hansen wrote:
> I'm mostly spot-checking this to see what kind of shape it's in and how
> much work and diligence has been applied in the last 8 months since v14.
> 
> On 12/15/25 15:33, Ross Philipson wrote:
> ...
>> The driver could be extended for further operations if needed. This
>> TPM dirver implementation relies as much as possible on existing mainline
> 
> <sigh>
> 
> v15 and no spell checking. :(
> 
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/early_tpm_extend.c
>> @@ -0,0 +1,601 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2010-2012 United States Government, as represented by
>> + * the Secretary of Defense.  All rights reserved.
> 
> IANAL, but this looks fishy.
> 
> It's theoretically fine to go grab random code off the Internet and
> submit it to the kernel, given the correct license. But I do want to
> know what its story is and where it came from.


Let me provide some context as to the code origin. Ross, before joining 
Oracle, and I have a long history of working with DRTM/Intel TXT within 
Xen. When it was requested to go back to sending the measurements to the 
TPM in the setup kernel, we needed to find a minimal code base to 
provide the command buffer packing until the TPM driver could be fully 
refactored. We knew that Xen's vtpm framework provided a simple macro 
system to provide contextual TPM command buffer packing. We decided this 
would be a lightweight choice that would be easy to cut down to only 
what is needed to handle the very few TPM commands we will need to send. 
And to that extent, there have been internal reviews that have reduced 
the amount of that original code.

> I also seem to remember that there are special rules around the US
> federal government's inability to hold copyrights. This seems worth at
> least a mention ... somewhere.

IANAL either, but in general the safest/correct approach is to retain 
any CRs placed on the code being reused, and the above is the CR on the 
source from the Xen tree.

> This is helpful, for instance:
> 
>> + * based off of the original tools/vtpm_manager code base which is:
>> + * Copyright (c) 2005, Intel Corp.
>> + * All rights reserved.
> 
> so thanks for that one.

That's the origin of all the code reuse, we can do an review to see if 
any of the code that originated from the USG code is still present.

>> + * Redistribution and use in source and binary forms, with or without
>> + * modification, are permitted provided that the following conditions
>> + * are met:
>> + *
>> + *   * Redistributions of source code must retain the above copyright
>> + *     notice, this list of conditions and the following disclaimer.
>> + *   * Redistributions in binary form must reproduce the above
>> + *     copyright notice, this list of conditions and the following
>> + *     disclaimer in the documentation and/or other materials provided
>> + *     with the distribution.
>> + *   * Neither the name of Intel Corporation nor the names of its
>> + *     contributors may be used to endorse or promote products derived
>> + *     from this software without specific prior written permission.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
>> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
>> + * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
>> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
>> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
>> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
>> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
>> + * OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
> 
> Also, IANAL, but this looks BSD-ish.
> 
> I would have kinda expected the SPDX header to say BSD-blah-blah and not
> GPL-2.0-only.
> 
> I'd really appreciate if you could go have a huddle with your corporate
> Open Source folks and make sure this is all proper. To me, it looks
> fishy at _best_.
> 
> ...
>> +/*
>> + * We're far too early to calibrate time.  Assume a 5GHz processor (the upper
>> + * end of the Fam19h range), which causes us to be wrong in the safe direction
>> + * on slower systems.
>> + */
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog
> 
> Imperative voice please.
> 
> ...
>> +static int __tis_recv_data(struct tpm_chip *chip, u8 *buf, int count)
>> +{
>> +	int size = 0;
>> +	int burstcnt;
>> +
>> +	while (size < count && __tis_wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, chip->timeout_c) == 0) {
>> +		burstcnt = __tis_get_burstcount(chip);
>> +
>> +		for ( ; burstcnt > 0 && size < count; --burstcnt)
>> +			buf[size++] = tpm_read8(chip, TPM_DATA_FIFO(chip->locality));
>> +	}
>> +
>> +	return size;
>> +}
>> +
>> +/**
>> + * tpm_tis_check_locality - Check if the given locality is the active one
>> + * @chip:	The TPM chip instance
>> + * @loc:	The locality to check
>> + *
>> + * Return: true - locality active, false - not active
>> + */
>> +bool tpm_tis_check_locality(struct tpm_chip *chip, int loc)
>> +{
>> +	if ((tpm_read8(chip, TPM_ACCESS(loc)) & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) == (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
>> +		chip->locality = loc;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * tpm_tis_release_locality - Release the active locality
>> + * @chip:	The TPM chip instance
>> + */
>> +void tpm_tis_release_locality(struct tpm_chip *chip)
>> +{
>> +	if ((tpm_read8(chip, TPM_ACCESS(chip->locality)) & (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) == (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
>> +		tpm_write8(chip, TPM_ACCESS(chip->locality), TPM_ACCESS_RELINQUISH_LOCALITY);
>> +
>> +	chip->locality = 0;
>> +}
> 
> I guess some folks aren't enforcing the 80-column limits. But this is
> not even close. It's almost 80x2.
> 
> Has there even been an attempt to make this conform to kernel coding
> style? What other checkpatch.pl warnings are being ignored?




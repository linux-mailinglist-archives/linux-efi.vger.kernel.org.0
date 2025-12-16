Return-Path: <linux-efi+bounces-5887-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E70CC545A
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC198306AE3B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A30332571B;
	Tue, 16 Dec 2025 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY+IQBO6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EE335577;
	Tue, 16 Dec 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922023; cv=none; b=NjDRrOa+IfIRGxO57S+1Bz9PxIWoV/a2+qMBoFqhEeJShvAJphd/0qrbVhP2gFcyopF9BDFBCDSV2R4DQslrvaubrZ2rc8Y0+HKKDldt6uYtSRMEg020IgtnIXwV4CV4pmiHX0KpUQeOQIbjILCKjLX5NVbF8JQRGy0fgBrGMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922023; c=relaxed/simple;
	bh=BCk1z+n4t1aGaqZ/BTXTCFErniFsz8hfx3uLoM+C9Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmKOZVmEC4err50qr6BS0i+oHCvuCd5T47immBAZfvOCYvQoxVwx7a4fiwudCgcSiso3uOmMIa0RaXtXdjrgnrHtr0iyOpKdiF1TokTZp0WOABtX5K6LoATZr5A8EPyQZX3ahsRViNxy4rrUqxXxHPMw6MHz7DQPGftUYK1yXpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eY+IQBO6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765922020; x=1797458020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BCk1z+n4t1aGaqZ/BTXTCFErniFsz8hfx3uLoM+C9Fo=;
  b=eY+IQBO6aP93ndoA4ovjCWjUabBjtETN3DQ5FKF0UihPo772d7BLfZKa
   XBbMwqQ/DwVS0PEYNs81y2wVdBr37fAlWfqj7IotYjSvV8ojsui4wA8XS
   L7UxRPL7mqEG4Xgmn9xYbVUnPpQ2cwrEUEKL9lNgY0RgRnC5PbeEbaryi
   kybKQCOIBf8pLbLMysD2NUM7KqZCGs0F0O6uFtMnBL/dk/uTh1Empv46J
   8rXGwzGS1XOgzb5Te+/CcNtxTWqeDWbVd+FKWYjWae4sH+1OdqggfjB9e
   uCz4cHb3X5W5X1oMFFaCpFZL+Awe66MmSTFzZzyEN3lkSCM9I0krRw8yp
   g==;
X-CSE-ConnectionGUID: eQW4EHimSC2r0LxKpoe+uQ==
X-CSE-MsgGUID: H0j3FQERSgSazMqrEkMP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="66839461"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="66839461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 13:53:37 -0800
X-CSE-ConnectionGUID: MuHVZirMQBWFrzeuQtaT0Q==
X-CSE-MsgGUID: BGkMrOwZQRm6jxep5Zx8cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="198185330"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.199]) ([10.125.110.199])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 13:53:37 -0800
Message-ID: <56929e8b-a7cf-4390-b4ec-0b4c2c32b311@intel.com>
Date: Tue, 16 Dec 2025 13:53:35 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/28] x86/tpm: Early TPM PCR extending driver
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-20-ross.philipson@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251215233316.1076248-20-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'm mostly spot-checking this to see what kind of shape it's in and how
much work and diligence has been applied in the last 8 months since v14.

On 12/15/25 15:33, Ross Philipson wrote:
...
> The driver could be extended for further operations if needed. This
> TPM dirver implementation relies as much as possible on existing mainline

<sigh>

v15 and no spell checking. :(

> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_tpm_extend.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2010-2012 United States Government, as represented by
> + * the Secretary of Defense.  All rights reserved.

IANAL, but this looks fishy.

It's theoretically fine to go grab random code off the Internet and
submit it to the kernel, given the correct license. But I do want to
know what its story is and where it came from.

I also seem to remember that there are special rules around the US
federal government's inability to hold copyrights. This seems worth at
least a mention ... somewhere.

This is helpful, for instance:

> + * based off of the original tools/vtpm_manager code base which is:
> + * Copyright (c) 2005, Intel Corp.
> + * All rights reserved.

so thanks for that one.

> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above
> + *     copyright notice, this list of conditions and the following
> + *     disclaimer in the documentation and/or other materials provided
> + *     with the distribution.
> + *   * Neither the name of Intel Corporation nor the names of its
> + *     contributors may be used to endorse or promote products derived
> + *     from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> + * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
> + * OF THE POSSIBILITY OF SUCH DAMAGE.
> + */

Also, IANAL, but this looks BSD-ish.

I would have kinda expected the SPDX header to say BSD-blah-blah and not
GPL-2.0-only.

I'd really appreciate if you could go have a huddle with your corporate
Open Source folks and make sure this is all proper. To me, it looks
fishy at _best_.

...
> +/*
> + * We're far too early to calibrate time.  Assume a 5GHz processor (the upper
> + * end of the Fam19h range), which causes us to be wrong in the safe direction
> + * on slower systems.
> + */

https://docs.kernel.org/process/maintainer-tip.html#changelog

Imperative voice please.

...
> +static int __tis_recv_data(struct tpm_chip *chip, u8 *buf, int count)
> +{
> +	int size = 0;
> +	int burstcnt;
> +
> +	while (size < count && __tis_wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, chip->timeout_c) == 0) {
> +		burstcnt = __tis_get_burstcount(chip);
> +
> +		for ( ; burstcnt > 0 && size < count; --burstcnt)
> +			buf[size++] = tpm_read8(chip, TPM_DATA_FIFO(chip->locality));
> +	}
> +
> +	return size;
> +}
> +
> +/**
> + * tpm_tis_check_locality - Check if the given locality is the active one
> + * @chip:	The TPM chip instance
> + * @loc:	The locality to check
> + *
> + * Return: true - locality active, false - not active
> + */
> +bool tpm_tis_check_locality(struct tpm_chip *chip, int loc)
> +{
> +	if ((tpm_read8(chip, TPM_ACCESS(loc)) & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) == (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
> +		chip->locality = loc;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * tpm_tis_release_locality - Release the active locality
> + * @chip:	The TPM chip instance
> + */
> +void tpm_tis_release_locality(struct tpm_chip *chip)
> +{
> +	if ((tpm_read8(chip, TPM_ACCESS(chip->locality)) & (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID)) == (TPM_ACCESS_REQUEST_PENDING | TPM_ACCESS_VALID))
> +		tpm_write8(chip, TPM_ACCESS(chip->locality), TPM_ACCESS_RELINQUISH_LOCALITY);
> +
> +	chip->locality = 0;
> +}

I guess some folks aren't enforcing the 80-column limits. But this is
not even close. It's almost 80x2.

Has there even been an attempt to make this conform to kernel coding
style? What other checkpatch.pl warnings are being ignored?


Return-Path: <linux-efi+bounces-1543-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737A953AD6
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 21:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B013287821
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595726BFC7;
	Thu, 15 Aug 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="XB5405LS"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10734545;
	Thu, 15 Aug 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749888; cv=pass; b=TtlUJeEIQ1MzrbgMKNg8rOd1KK7XkzTOhdHoPzfm1FAUcLFYgDAS86w9U6hnbsvKfeYyP5kqEo4GcB7iqXXC3oWzaxKMCCjfWUQvJE6uvW+CI+ZzyIU53qhvvk1CYFZFPv5/KyVXdWcMQsngETJ01LD8dmvR09WNFFjqShQ2Iyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749888; c=relaxed/simple;
	bh=Ms9Fpt97Fmxe6Rx8okpeNFoiXGMmMmrPmHt6l/vlBZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIQjuOxsGvvKYXMND1FvB4Haah3QYkqL15SnK+rLWXldgTSOfM1L8grbhiKcLl9lZSSeJPVOJ/mRfNeBVQOh6+1vOnBgId9/3HriOtkufgbcHFJ3xABzoG4LqDD9miHI6EP3KW/9euJ8OYOYuCSaYALjqEXbERFHnX9X60QImeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=XB5405LS; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1723749845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eCR+ownc2K5nhjbnzLCk8mQRLiIfIIVGVqZyVkyxbKj5zEH/F8WuodIG4DDdZud29ubCfObYUsNlR6VzWJMRkcKydjw01hkGG2IoE0UwZEtmF6U08fziJxQq4LfARXwyaleGw2ErE3JIZSR+WviZYRjMFngQPbPyj9AIxlvsAEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723749845; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+UN78hyEChy5/BcN7wOK0jAZMASV1l7rKkiHw5UEFag=; 
	b=f+b27MPFTDDwYUwBHSuMsS2XeHjmizmG6hnhRc6iQBLYirhzmyyUzmUV6qf5s5QnsBrSEPxlUe7J2m9QuDXnwHfaR91FA6ogQe/VO/OYc2lEGkEIiUdYlU8XQYvNaEJLRgugvYAgEDZ6W94gjsGKI5OOVDLLN5PVsME8OPDlVTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723749845;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+UN78hyEChy5/BcN7wOK0jAZMASV1l7rKkiHw5UEFag=;
	b=XB5405LSOwCca8ZSFn1+Doi1AedyI6ptJvjtYUb4GcBr5IlE1r5URdz29JBsaalx
	oFeTAOtoDjD/OVOhotQnKPNWQmhBlGMJ2yCvbc5u8s/0qlTseKPuvtLeqGK3bvLzgLJ
	e9g7SqJ6O3MGzJuFKEOmmHe6/+E8pJWjAQO2TFU0=
Received: by mx.zohomail.com with SMTPS id 1723749843823897.2191746657345;
	Thu, 15 Aug 2024 12:24:03 -0700 (PDT)
Message-ID: <32f0bc58-c0a1-4c11-bd02-c6e61b0e2eb6@apertussolutions.com>
Date: Thu, 15 Aug 2024 15:24:00 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/19] tpm: Ensure tpm is in known state at startup
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
 luto@amacapital.net, nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-15-ross.philipson@oracle.com>
 <D1RIB8BHWRC5.3RRW0ZKV3KDVM@kernel.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <D1RIB8BHWRC5.3RRW0ZKV3KDVM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/4/24 16:14, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> When tis core initializes, it assumes all localities are closed. There
> 
> s/tis_core/tpm_tis_core/

Ack.

>> are cases when this may not be the case. This commit addresses this by
>> ensuring all localities are closed before initializing begins.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>>   include/linux/tpm.h             |  6 ++++++
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 7c1761bd6000..9fb53bb3e73f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   	u32 intmask;
>>   	u32 clkrun_val;
>>   	u8 rid;
>> -	int rc, probe;
>> +	int rc, probe, i;
>>   	struct tpm_chip *chip;
>>   
>>   	chip = tpmm_chip_alloc(dev, &tpm_tis);
>> @@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>   		goto out_err;
>>   	}
>>   
>> +	/*
>> +	 * There are environments, like Intel TXT, that may leave a TPM
> 
> What else at this point than Intel TXT reflecting the state of the
> mainline?

Leaving the TPM in Locality 2 is a requirement of the TCG D-RTM 
specification. This will be the situation for AMD and Arm as well. The 
comment can be updated to ref the TCG spec instead of a specific 
implementation.

>> +	 * locality open. Close all localities to start from a known state.
>> +	 */
>> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
>> +		if (check_locality(chip, i))
>> +			tpm_tis_relinquish_locality(chip, i);
>> +	}
> 
> To be strict this should be enabled only for x86 platforms.
> 
> I.e. should be flagged.

As mentioned above, this will also affect Arm.

>> +
>>   	/* Take control of the TPM's interrupt hardware and shut it off */
>>   	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>   	if (rc < 0)
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index c17e4efbb2e5..363f7078c3a9 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -147,6 +147,12 @@ struct tpm_chip_seqops {
>>    */
>>   #define TPM2_MAX_CONTEXT_SIZE 4096
>>   
>> +/*
>> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
>> + * Client Platform Profile Specification.
>> + */
>> +#define TPM_MAX_LOCALITY		4
>> +
>>   struct tpm_chip {
>>   	struct device dev;
>>   	struct device devs;
> 
> 
> BR, Jarkko

v/r,
dps


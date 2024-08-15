Return-Path: <linux-efi+bounces-1541-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA79953A61
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 20:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7021F25536
	for <lists+linux-efi@lfdr.de>; Thu, 15 Aug 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329B55898;
	Thu, 15 Aug 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="KMBGiphP"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9574C1B;
	Thu, 15 Aug 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748003; cv=pass; b=T55hP4rJogbsysaI+11aiMqkjLr1sn0pNt6OZlR7cGcw1AG2877omY3QBlz+MpFIyFBNTMwnx/AQV+9XdwBVIXVTCTTkGOGcx2NR2GNPEHqUshHUdHlOguUw88/D2y8fwD/W3YQYGJwlGMsplb0SZQpXbfA6IsoqR134P8on9OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748003; c=relaxed/simple;
	bh=lWtEzZTnjeO7sP/Z/eydiRNQbFyHPGhOpXG+L61XeEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlkEe1auPChDzRN7VO4YvOHBEDzpWpKrvt+ZJ5fIMrShL2hSEC2YqQl14USlgs8W2O0TRJO8E3C06v9oWAIklpEe+DOtS3cmCPUt1AloMVOCHG00uPXuBFfDcEqVLR4CB2Vg+R/7j5XZ7RTbwH7AkZIHXlhWtdL3kcGY7ax8hZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=KMBGiphP; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1723747960; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lGQnJwWdJJ4ywbbojAYOnqryarPns2CMXDKokOBIJseapgyZ5BP8hMgJI3CqtKaJhanGd3OeehRFMQGlKLMrgjX1QIzlEJKykXQLPVOVfhuNd+yA1QjRdOByfE73tQqO55RLnWajYSyqeUdVauozOyqVdeb850D/RtxXjyvX59w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723747960; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NP/xwA+MiGQi10iGWtBmt4bdqeO+r3FlpaBQizZgMds=; 
	b=fVagd9ChqwsgXAwK3i/XGAqfj6KsMjNx1Ww3fe/dyut4+J3ZSOddOJCmcMZVYKUhFrvEx3tmEPpILG5kS9f0CUHwXEpIOe4QQHRZy1UvMo2lA7iXn+GpCYSq0/LdKDR6ugyo2nEH1r0oTCjLS6J8i1TmyPAcgEJghjwguyvmFTY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723747960;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NP/xwA+MiGQi10iGWtBmt4bdqeO+r3FlpaBQizZgMds=;
	b=KMBGiphPqb82t8tWuViwLByoijVyQm8Sw7dkedsHdP7RBPM5ethawfXpHsWwtgFY
	8Lr0r0wkuWJXXXq2bmRtuqrl97XtCSn3fHn0cKkLhzlIodpredHOWno7TzXbdbHds1i
	5O5Q6eP8HNG2oq1adlZH+s6kqqnGSt++JOyqwhD0=
Received: by mx.zohomail.com with SMTPS id 1723747957560766.699837070187;
	Thu, 15 Aug 2024 11:52:37 -0700 (PDT)
Message-ID: <1c3d7b31-89c0-400f-8f37-45089f7078e8@apertussolutions.com>
Date: Thu, 15 Aug 2024 14:52:33 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/19] tpm: Protect against locality counter underflow
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
 <20240531010331.134441-14-ross.philipson@oracle.com>
 <D1RI95NQL24F.2E53ZWDFAA8QM@kernel.org>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <D1RI95NQL24F.2E53ZWDFAA8QM@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/4/24 16:12, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>> locality request is allowed to be sent to the TPM. In the commit, the counter
>> is indiscriminately decremented. Thus creating a situation for an integer
>> underflow of the counter.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
>> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
> 
> Not sure if we have practical use for fixes tag here but open for
> argument ofc. I.e. I'm not sure what is the practical scenario to
> worry about if Trenchboot did not exist.

We can drop the fixes line.

>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 176cd8dbf1db..7c1761bd6000 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   
>>   	mutex_lock(&priv->locality_count_mutex);
>> -	priv->locality_count--;
>> +	if (priv->locality_count > 0)
>> +		priv->locality_count--;
> 
> I'd signal the situation with pr_info() in else branch.

Ack.

>>   	if (priv->locality_count == 0)
>>   		__tpm_tis_relinquish_locality(priv, l);
>>   	mutex_unlock(&priv->locality_count_mutex);
> 
> BR, Jarkko


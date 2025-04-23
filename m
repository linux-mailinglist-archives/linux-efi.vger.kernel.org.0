Return-Path: <linux-efi+bounces-3439-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF474A998B1
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896475A4374
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367429344F;
	Wed, 23 Apr 2025 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="s0J2v2eH"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE28A1F7;
	Wed, 23 Apr 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437185; cv=pass; b=kx5gduC7zpLbEx9KmyOHGdOhTkQFwPOdDM4RPQZIsQ0+jBvtl/9DEd6cWK+3ziC6piwV7J3ejIHCYLXgXab6oB9G3RAN8Ay1TSb83fu5wq1jglfjoga/dYm04OdtpDofx18MROZUnjqDnFUM2kZJR75JLi6AKGhudD7Nr3A+xHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437185; c=relaxed/simple;
	bh=JQ+3b0W/MNKeBpR4ba1CCpDH+a2ulOgu0Qk3jNG/zgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtwnTnnM1hdcM1ZoR1qurpHFz+KEBQd4H+wWUhn8vBE6EuFT9Wmsys/DG4u795a/RaSJ1WTbiPLPqYyh482pbzIxj+15+rUk7wIAVUKIl5whto6jtlivpCu5Sjpdj/4PxK+9W8bmu5uTCguXMoKh0q68llzRdrPATvMQepUkZ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=s0J2v2eH; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1745437122; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VnVKjdl3e3iMvdK9Rxuf4HSbjbQzdwR/xipAehrjgOAnz255F+p1SoBty458RRvh7Ue+EXWgZN8hNlRHX7hO1vLiaju/zyYl0c+AdaOO6i4ChBky0g58XIHIWKeYPz7u/4HBUVA5tHTqvuhCotP1VCtXh3QekGd5UoOHogNsuFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745437122; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FETEiRCISdYgHI8lwABdikQrD0gNW/XmKFvVVI6xmiM=; 
	b=SoA5Y+iC4DE+GNaDavJMbE2dO+1m9ibXWll07xF16DS1elQrx+v6HjO5c7PGvah8WbNWAcB9kjA154/TIuj5+C9T8lgeJYe6rVGG1CgFDaotfGf8hx7dRP0bmhM6Ug7VtQJ1aP6qG4VAeRkmBNCxpOiPx/w2bs6KlAT7J7h/QuQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745437122;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FETEiRCISdYgHI8lwABdikQrD0gNW/XmKFvVVI6xmiM=;
	b=s0J2v2eHuQm04u0jvNRhD0qBjB4NQUt8srdfSMnQO5LyaPub+xNWCNivjEuNxzCr
	YcnGqtpHFu48DxKvWd1JyG5ay73dTnw4h6CggzZ8tmGxa5eMBz3zD+zdRgVUUuKMgOk
	BwP0ixBLGLLFFexacW9Do97Hb8vRUgc6HPkTcmMo=
Received: by mx.zohomail.com with SMTPS id 1745437118502545.35750540574;
	Wed, 23 Apr 2025 12:38:38 -0700 (PDT)
Message-ID: <799b6ed6-c23f-44ca-96bb-d4683fc92c33@apertussolutions.com>
Date: Wed, 23 Apr 2025 15:38:35 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-17-ross.philipson@oracle.com>
 <4w5oshnh6opkrhngzy74cagd7vio45wz6cv3ltmowfbcipdjvs@rijgzlucl6jd>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <4w5oshnh6opkrhngzy74cagd7vio45wz6cv3ltmowfbcipdjvs@rijgzlucl6jd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/22/25 06:20, Stefano Garzarella wrote:
> On Mon, Apr 21, 2025 at 09:27:09AM -0700, Ross Philipson wrote:
>> DRTM needs to be able to set the locality used by kernel. Provide
>> a one-shot function tpm_chip_set_locality() for the purpose.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> drivers/char/tpm/tpm-chip.c     | 34 ++++++++++++++++++++++++++++++++-
>> drivers/char/tpm/tpm_tis_core.c |  2 ++
>> include/linux/tpm.h             |  4 ++++
>> 3 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index e25daf2396d3..a603f0dadd43 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>>     if (!chip->ops->request_locality)
>>         return 0;
>>
>> -    rc = chip->ops->request_locality(chip, 0);
>> +    rc = chip->ops->request_locality(chip, chip->kernel_locality);
>>     if (rc < 0)
>>         return rc;
>>
>> @@ -380,6 +380,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>     }
>>
>>     chip->locality = -1;
>> +    chip->kernel_locality = 0;
>>     return chip;
>>
>> out:
>> @@ -695,3 +696,34 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>>     tpm_del_char_device(chip);
>> }
>> EXPORT_SYMBOL_GPL(tpm_chip_unregister);
>> +
>> +/**
>> + * tpm_chip_set_locality() - Set the TPM locality kernel uses
>> + * @chip:    &tpm_chip instance
>> + * @locality:   new locality
>> + *
>> + * This a one-shot function. Returns zero or POSIX error on failure.
>> + */
>> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
>> +{
>> +    int ret;
>> +
>> +    if (locality < 0 || locality >= TPM_MAX_LOCALITY)
> 
> Since `locality` is unsigned, we can skip the `locality < 0` check.

You are correct, will be fixed.

>> +        return -EINVAL;
>> +
>> +    ret = tpm_try_get_ops(chip);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
>> +        tpm_put_ops(chip);
>> +        return -EINVAL;
> 
> IIUC this operation is allowed only one time.
> So, this case seems more like an operation that's not allowed because 
> it's already been done, so what about returning "-EPERM".

Sure we can change it to "-EPERM".


v/r,
Daniel P. Smith

> 
>> +    }
>> +
>> +    chip->kernel_locality = locality;
>> +    chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>> +    tpm_put_ops(chip);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/ 
>> tpm_tis_core.c
>> index 222081e5c7f7..2bc0cf46adbf 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1124,6 +1124,8 @@ int tpm_tis_core_init(struct device *dev, struct 
>> tpm_tis_data *priv, int irq,
>>     if (IS_ERR(chip))
>>         return PTR_ERR(chip);
>>
>> +    chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
>> +
>> #ifdef CONFIG_ACPI
>>     chip->acpi_dev_handle = acpi_dev_handle;
>> #endif
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 86fe8f6a2d52..884791acba2e 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -207,6 +207,8 @@ struct tpm_chip {
>>
>>     /* active locality */
>>     int locality;
>> +    /* the locality used by kernel */
>> +    u8 kernel_locality;
>>
>> #ifdef CONFIG_TCG_TPM2_HMAC
>>     /* details for communication security via sessions */
>> @@ -355,6 +357,7 @@ enum tpm_chip_flags {
>>     TPM_CHIP_FLAG_SUSPENDED            = BIT(8),
>>     TPM_CHIP_FLAG_HWRNG_DISABLED        = BIT(9),
>>     TPM_CHIP_FLAG_DISABLE            = BIT(10),
>> +    TPM_CHIP_FLAG_SET_LOCALITY_ENABLED    = BIT(11),
>> };
>>
>> #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>> @@ -448,6 +451,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>> extern int tpm_is_tpm2(struct tpm_chip *chip);
>> extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
>> extern void tpm_put_ops(struct tpm_chip *chip);
>> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
>> extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf 
>> *buf,
>>                 size_t min_rsp_body_length, const char *desc);
>> extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>> -- 
>> 2.39.3
>>
>>
> 



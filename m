Return-Path: <linux-efi+bounces-2914-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0344A56178
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 08:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A74C1897841
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A419E7E2;
	Fri,  7 Mar 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+TToUeV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51A176FB0;
	Fri,  7 Mar 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331144; cv=none; b=Y7GaNGEb3lHc++936fqJfhqdCUA8KJA89w4vJddn6I9Ub5MZ2gJRTi+vvLPiQVHmMb3ZjhtcOmqPbAdzuZDhm22/8zvASBod3B871wmExqGMh9a2K2gVuHBkRxMeNaxZIn6Aq4LLBUKl7+1V+yd4XFWTWVsKvBtc3ddmBwNJkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331144; c=relaxed/simple;
	bh=sg8lIGdAcGl0Nr7oC/i8DO5aGMtK0VBBp7rTicPtVSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGj5+YIpUFYAEA6TNHFcFo4g+y/Eyt0I6MyLNaPm7bhl5P3qgAQcBaO0dHgNRVpgzVp9k/d04ctvHCA/n+zoavy57tgeIJq/UuyTcjrgKBF48LD3JJrDrIUDc0LZ050gYTFiHEG9/o8Wbs8fJQvJjC/sd2ySat9sg49L+as5Veg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+TToUeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDDC4CED1;
	Fri,  7 Mar 2025 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331144;
	bh=sg8lIGdAcGl0Nr7oC/i8DO5aGMtK0VBBp7rTicPtVSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+TToUeVCHBzNksGAEG0u+yLGt8bvrcxM7loUzqKPduGAUIlplwWspTULdQPdjlH4
	 GiIHNjrpiuW7p+QViOsfTzbBmyCiyApLGI5cCE2MFrSQ0RrJYp5TgavHxM9owckfo7
	 NMglh+EaRJwTZ3teO30vIMBPemxWXlznQAg2i1MHbowYQWEvEaGY7ENdAydD1TyH67
	 w2kgj5te2Uhvtan2sHnLEdv9rhdXCkkJU8/djRahDRp/Z6nQlO/+Yu08ym29ot3XPi
	 stHDV+5JeyLLIGeEw57wTTTeQTZntvfQ0G0PMMoNrAI5y+srz6NQ6G9rAzc8aOzmXl
	 0ZJOQUqSdSzlA==
Date: Fri, 7 Mar 2025 09:05:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 14/19] tpm, tpm_tis: Close all localities
Message-ID: <Z8qaw4XwH3QljLEM@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-15-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-15-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:11AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> There are environments, for example, those that comply with the TCG D-RTM
> specification that requires the TPM to be left in locality 2. Prepare
> kernel for such environments by closing all the localities.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  include/linux/tpm.h             |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..c58f360fb4a4 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
>  
>  	chip = tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> +	/*
> +	 * There are environments, for example, those that comply with the TCG D-RTM
> +	 * specification that requires the TPM to be left in Locality 2.
> +	 */

I'd just shorten this into

/*
 * In order to comply with the TCG D-RTM specification, relinquish all
 * the localities.
 */

And that's it. It's a punctual reminder and that is what source code
comments should be for.


> +	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..c5a4a2d7dd15 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -147,6 +147,12 @@ struct tpm_chip_seqops {
>   */
>  #define TPM2_MAX_CONTEXT_SIZE 4096
>  
> +/*
> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
> + * Client Platform Profile Specification.
> + */
> +#define TPM_MAX_LOCALITY		4
> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;
> -- 
> 2.39.3
> 

Otherwise, this is great.

BR, Jarkko


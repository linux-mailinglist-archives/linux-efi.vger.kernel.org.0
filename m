Return-Path: <linux-efi+bounces-2916-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE3A56182
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 08:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985933B1C94
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274819F13F;
	Fri,  7 Mar 2025 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZxQF3Pw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C4176FB0;
	Fri,  7 Mar 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331268; cv=none; b=quefddd1SgWnWKdJaK2AHKsIdtHvpMz6lg9w44rtYP0Z1V00tWAPgj7YKAPOSiyK329j89ShOc4VneTIxwFb6Ygx+Iy7T7kGgEB7geSj3yNZCFrSXfOqUZW/Of2BN1+aUQeIm9a5zL/tvFFmjfCqYW8zJ641qUc0MkneTO8Gac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331268; c=relaxed/simple;
	bh=FQYkLNrXHPmIZXXCW1n9/+zsZlTNiY/EpABZDoK4Z/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prKoSqmMTPwWo5bqqRv7PIIDc+UXmu9RPjOVPHkalcQZBiQ7iKH0N2Cn/ez2TnG41dwwEnFFuQnLPG8vxhspc684Sl9NXxDtpsbMHVIHmz3DOi4UX2Hp9CvNsX5Wz1yH+5XUboLchWYdY+rufend2b+31+q0i+MIuaeeDPXtZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZxQF3Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D70C4CEE2;
	Fri,  7 Mar 2025 07:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331267;
	bh=FQYkLNrXHPmIZXXCW1n9/+zsZlTNiY/EpABZDoK4Z/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZxQF3PwMBrIUJGvEwd0OpHhSkjNZ0F9Q+DCcHxqEBPemCull3iLygCOqS2k7PMTl
	 w34lkiEgRucscwsxBeJ6U6OTx5jOMqyyTaYbi48NgAVCduBeOIDBH7KWZ5bdaINJ6F
	 uvudaaobM5itEz5+UAyhj00DbmcHXfG4dlHIhTN6Pxi1XKlVsNOCOoW/JokS5DYtfV
	 jiZ8eWD6JTP4mN6APnj2NrEonV/6HsO+/PnlKjdxGNwD4O5gKPLCdyFNLNpEAMzo3H
	 tE39UjeANmfQ8hXutOnv5CZazD047K3lJPNvGqfY6yxpO/fphjlgVUS53+Hmq0geSi
	 Jvi0bmFcJLZPg==
Date: Fri, 7 Mar 2025 09:07:42 +0200
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
Subject: Re: [PATCH v12 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
Message-ID: <Z8qbPvCdhlVzkK1H@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-17-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-17-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:13AM -0800, Ross Philipson wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> a one-shot function tpm_chip_set_locality() for the purpose.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>  drivers/char/tpm/tpm_tis_core.c |  2 ++
>  include/linux/tpm.h             |  4 ++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 7df7abaf3e52..ac200514c4d7 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  	if (!chip->ops->request_locality)
>  		return 0;
>  
> -	rc = chip->ops->request_locality(chip, 0);
> +	rc = chip->ops->request_locality(chip, chip->kernel_locality);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -374,6 +374,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	}
>  
>  	chip->locality = -1;
> +	chip->kernel_locality = 0;
>  	return chip;
>  
>  out:
> @@ -689,3 +690,33 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  	tpm_del_char_device(chip);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_unregister);
> +
> +/**
> + * tpm_chip_set_locality() - Set the TPM locality kernel uses
> + * @chip:	&tpm_chip instance
> + * @locality:   new locality
> + *
> + * This a one-shot function. Returns zero or POSIX error on failure.
> + */
> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
> +{
> +	int ret;
> +
> +	if (locality < 0 || locality >= TPM_MAX_LOCALITY)
> +		return -EINVAL;
> +
> +	ret = tpm_try_get_ops(chip);
> +	if (ret)
> +		return ret;
> +
> +	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
> +		tpm_put_ops(chip);
> +		return -EINVAL;
> +	}
> +
> +	chip->kernel_locality = locality;
> +	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
> +	tpm_put_ops(chip);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c86100ad743a..b85677eccc86 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1114,6 +1114,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> +	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
> +
>  #ifdef CONFIG_ACPI
>  	chip->acpi_dev_handle = acpi_dev_handle;
>  #endif
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c5a4a2d7dd15..9f910d3bc2e4 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -207,6 +207,8 @@ struct tpm_chip {
>  
>  	/* active locality */
>  	int locality;
> +	/* the locality used by kernel */
> +	u8 kernel_locality;
>  
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	/* details for communication security via sessions */
> @@ -354,6 +356,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
>  	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
>  	TPM_CHIP_FLAG_DISABLE			= BIT(10),
> +	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
>  };
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> @@ -447,6 +450,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
>  extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
>  extern void tpm_put_ops(struct tpm_chip *chip);
> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
>  extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
>  				size_t min_rsp_body_length, const char *desc);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
> -- 
> 2.39.3
> 

+1 for this.

BR, Jarkko


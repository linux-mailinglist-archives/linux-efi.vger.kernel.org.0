Return-Path: <linux-efi+bounces-2092-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C99B8DFC
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DB1B22864
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579DE156C6F;
	Fri,  1 Nov 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf3qRIjn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78C1B95B;
	Fri,  1 Nov 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453844; cv=none; b=aB43nx3UWPdpK9oU1b7QRjvY3S6pYh4H+qrtljbNJw+IL1GOa/0xuiNJclzHEKJGK4t5tyravQnsU9KMt3U9UO0TJ8ym5CPV+LUumICmrgcdHFry79gV++crGSXwN2gjlno5d9P7P+hlYgdsWkdlwzUw062ZLW1ugJxCcKbgw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453844; c=relaxed/simple;
	bh=eAP8wfaTPD3Rk5TZK/GAd2plZiwGTqBnBqW26aAhRSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=maYhdEE/UNrIDJzGk6eYoRC5zdSSBFdMP9qa684rSU4FuzWQTR2zAsA5HvbtP6CIW+XjaByY6dKpDsp3vpE7+NP4S+Og91YmGmNp7jo9+tTu2EyL1g+diSMQ0uIKpazuIABoVMDKcAU1H5hGaTd/lzpKQj3Kl3FRLr07ia0X3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf3qRIjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED49AC4CECD;
	Fri,  1 Nov 2024 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730453843;
	bh=eAP8wfaTPD3Rk5TZK/GAd2plZiwGTqBnBqW26aAhRSg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uf3qRIjn3V1T8PXWduVCQE6hlQS1iRMagcqQGVbwyG93uUa2Qz1tTCJyJsE53dPhm
	 OxZbE+hbi7H7sQcYewIqWYLBqxQXU/ClegGR0jqE5tsneJBZ549xr5k0AYVyqZoOLg
	 8+yRUmKhhLpKtGCjIeretJxyYeEbM10s+yV/ayLJE2oZZXAK2PjwO4LUR5vWKdSveh
	 GXD3Cu4oTEfL+gaCXdeEZFbSBIM0Uqyjnvoo2Bdy3R6hhQJVmRiWWUZzMbixf5fLKp
	 wj35hKbn7eSoj7Rk5Rfx/Kqkju0xa+0vOTBVfZB9GY2diYC9JiDlmDJur0Ps+qTw3D
	 zAVnXwgz6pQBQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 11:37:19 +0200
Message-Id: <D5AQOVB2XBF4.3A3CO7K6O8JKF@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 15/20] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-16-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-16-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis_tis_core initializes, it assumes all localities are closed. Ther=
e
> are cases when this may not be the case. This commit addresses this by

The second sentence is just a claim. Please explain.

> ensuring all localities are closed before initializing begins.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  include/linux/tpm.h             |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index a6967f312837..22ebf679ea69 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1107,7 +1107,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
> =20
>  	chip =3D tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1169,6 +1169,15 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
> =20
> +	/*
> +	 * There are environments, for example, those that comply with the TCG =
D-RTM
> +	 * specification that requires the TPM to be left in Locality 2.
> +	 */

I don't understand this comment. What is "environment"?

> +	for (i =3D 0; i <=3D TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e93ee8d936a9..98f2c7c1c52e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -147,6 +147,12 @@ struct tpm_chip_seqops {
>   */
>  #define TPM2_MAX_CONTEXT_SIZE 4096
> =20
> +/*
> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of =
the
> + * Client Platform Profile Specification.
> + */
> +#define TPM_MAX_LOCALITY		4
> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;

BR, Jarkko


Return-Path: <linux-efi+bounces-1143-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B118FBD23
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39AE1C23FD3
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032314B071;
	Tue,  4 Jun 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9K/+UVI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8B2F25;
	Tue,  4 Jun 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532096; cv=none; b=VdxCy+SqQo/MYNeqbfpFvG9K28NhPddlYaHYAAOUvXCCWIXFvWNgYb0CZkoBEeohHHMRZC0ghsn1KyYSXiQK9QzuGf8PWVLpaKVsCao+S5mvy5mBDdmnuMvJLJqedCKCvG2Nzv/2NS8E1YqekR76AFxskxkGn+Wu/BsVSlbg/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532096; c=relaxed/simple;
	bh=1dJyobrXgBY+x5j48CVCOANJ3cfEJFSAQaYi7nvuypo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JFwSDfEZFdXvSCmCPaD9O9D8N7+QFnGoPBkYbm81JEhX35y/kqPn1NF8HZVUryghkO2sZnzELIRWEeaQQIu3x+WofE24oKOuA3FANMp9MaX5xEAHTasyaPfVjRJ4r2tOBsHkQ3VVstKkEB21iu9rQfU8ZO3wh74B1ibBriN6t80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9K/+UVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24356C2BBFC;
	Tue,  4 Jun 2024 20:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532095;
	bh=1dJyobrXgBY+x5j48CVCOANJ3cfEJFSAQaYi7nvuypo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F9K/+UVI55Cki+Zo9OV87c2eeM0ifYp6hzMMXIULk9SS+odlEkpfVLeUXP4r+oQI6
	 wfMGyaFnOX6GdfRpZY9TJNS1oJsfXJZ/IJX+nmhl0yKUw8hVNf0D8m74ltEtcmCyco
	 Ibm1AFdqcrhjN2qr54RkgXTWstymQme4U/+2ZmqA9Nh5hJlq/w8xFHYQXLWKvwZMST
	 jTybqZsrdfgundyOcDQUAtKTV3IprZxJLaq7OYxtGU3mYBJCYfOw9B6zyfb3iCJ1tI
	 QImFf84vT1cJ8PQjS/IYtU0wuNW911HYfxYBIB0HbKIa2FXKYvJiHgBoDofVRq/bSK
	 tkhBei/QCWaHA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:14:47 +0300
Message-Id: <D1RIB8BHWRC5.3RRW0ZKV3KDVM@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 14/19] tpm: Ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-15-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-15-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> When tis core initializes, it assumes all localities are closed. There

s/tis_core/tpm_tis_core/

> are cases when this may not be the case. This commit addresses this by
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
> index 7c1761bd6000..9fb53bb3e73f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
> =20
>  	chip =3D tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
> =20
> +	/*
> +	 * There are environments, like Intel TXT, that may leave a TPM

What else at this point than Intel TXT reflecting the state of the
mainline?

> +	 * locality open. Close all localities to start from a known state.
> +	 */
> +	for (i =3D 0; i <=3D TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}

To be strict this should be enabled only for x86 platforms.

I.e. should be flagged.

> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c17e4efbb2e5..363f7078c3a9 100644
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


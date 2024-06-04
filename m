Return-Path: <linux-efi+bounces-1144-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845078FBD45
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A13B21F8E
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC314B954;
	Tue,  4 Jun 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Q8kmRl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DA372;
	Tue,  4 Jun 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532837; cv=none; b=NG2ndoiLnHPKKSueUfsJJ5P5dpQXVJ807famt2FACb9L2t5TV7Q/5vfM6KenkZN3trxo7nWkRFUEJmk2sywu49fSu94J6bKqada7WJglcJm9pIDiNQFqxqZV5fjJ+3ZnG8VYZV8NbCno/yhczkjmGmMnbDDt8ACTwz/2b06AiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532837; c=relaxed/simple;
	bh=EWZoRD7uLz6RSNswJ4Vk8CAivXRc1LdOOzxMYPLMI7U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lW+l49XlpLaPXeHnKlXRaAeM7gmJ1fW2wdLUdWTaNAxzNXHqvD1nmeNMth3Hb823lBqcU1D02CS7RrqqEexDt468ewvmCZgErG0UtY795t1cZ9sQ3VTVBZ+M+dotOhGohfF1rrQEfWhU41IP1uKZYpXRL9bpmaUl2yxlYAh76gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Q8kmRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F25C2BBFC;
	Tue,  4 Jun 2024 20:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717532836;
	bh=EWZoRD7uLz6RSNswJ4Vk8CAivXRc1LdOOzxMYPLMI7U=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=s+Q8kmRl/zaGIIZ1ThM916E4j9n3mSDWOwtpyL1+fz8ThfDoK0bV50VLk/GU2a1nb
	 AR4BixgQR9V5PRy0lKr5MBzwHpum03NYvMf3dxzdMPUeBdpFm5234PF0rSaIQoscku
	 oCUgzeTOWBmhgapQV1mOtGfThZb6W3xzt+BupS7/68ym1uXddAKgt436nJUiFlKPMy
	 LyM3/6GeW9unhy/DHsJdSQAF8NOUbISCK0aFAGal45iAHLMuaes9tDrd5ukvYxPnQV
	 MRZnm+zr4jADLjmZKWajgVUYPM9gICE8nPgTdWE2q1U53xzA2CZFV5NRLnRsbie6Zb
	 9QW5SeAEOr6xw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:27:09 +0300
Message-Id: <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 16/19] tpm: Add ability to set the preferred locality
 the TPM chip uses
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-17-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-17-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> Curently the locality is hard coded to 0 but for DRTM support, access
> is needed to localities 1 through 4.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
>  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>  drivers/char/tpm/tpm.h           |  1 +
>  include/linux/tpm.h              |  4 ++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 854546000c92..73eac54d61fb 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  	if (!chip->ops->request_locality)
>  		return 0;
> =20
> -	rc =3D chip->ops->request_locality(chip, 0);
> +	rc =3D chip->ops->request_locality(chip, chip->pref_locality);
>  	if (rc < 0)
>  		return rc;
> =20
> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> =20
> +/**
> + * tpm_chip_preferred_locality() - set the TPM chip preferred locality t=
o open
> + * @chip:	a TPM chip to use
> + * @locality:   the preferred locality
> + *
> + * Return:
> + * * true      - Preferred locality set
> + * * false     - Invalid locality specified
> + */
> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
> +{
> +	if (locality < 0 || locality >=3DTPM_MAX_LOCALITY)
> +		return false;
> +
> +	mutex_lock(&chip->tpm_mutex);
> +	chip->pref_locality =3D locality;
> +	mutex_unlock(&chip->tpm_mutex);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
> +
>  /**
>   * tpm_try_get_ops() - Get a ref to the tpm_chip
>   * @chip: Chip to ref
> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	}
> =20
>  	chip->locality =3D -1;
> +	chip->pref_locality =3D 0;
>  	return chip;
> =20
>  out:
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
> index 5da134f12c9a..35f14ccecf0e 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(tpm_is_tpm2);
> =20
> +/**
> + * tpm_preferred_locality() - set the TPM chip preferred locality to ope=
n
> + * @chip:	a TPM chip to use
> + * @locality:   the preferred locality
> + *
> + * Return:
> + * * true      - Preferred locality set
> + * * false     - Invalid locality specified
> + */
> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
> +{
> +	return tpm_chip_preferred_locality(chip, locality);
> +}
> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);

 What good does this extra wrapping do?

 tpm_set_default_locality() and default_locality would make so much more
 sense in any case.

 BR, Jarkko


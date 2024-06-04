Return-Path: <linux-efi+bounces-1164-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1158FBF52
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975EE1F22EB0
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A1145349;
	Tue,  4 Jun 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1taLLy8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5F199A2;
	Tue,  4 Jun 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541435; cv=none; b=MOiVNMtSV+f8NpoIrGnx3oZATnwmk5IzlbZkrU/KO6jgAmXjCLX2PgyOnHSP1TDOyNF7BSYOC1ZXQCgl3LQ5l8Yqz1RpMbN9cas5r0RYu1DTt2hRo9S/Q4RZFW921ao51SBfF7VcbaGv468kErBXWw4RQCM35NxUaMVJRXDX7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541435; c=relaxed/simple;
	bh=ege4vjOJhEIvZKGgsEARopmGzWR0ra0W6Va4o3bk6Vw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tlXtf/Phm5Qj/tLrrj2wvBXwxRlXVqWImbmh2Dt9ah7HTWFYlKXAwq0K2dcSlMjxVMx517JrxpvGuRJB4MEpdrKmsESMk2xO4wDJGldEltjPpA8Qbb0EqWROR9yxDWt/UeP/S5R1JqPltR8sFJHwuPE/oTio/gXlpXQt3/qBy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1taLLy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4CCC2BBFC;
	Tue,  4 Jun 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541435;
	bh=ege4vjOJhEIvZKGgsEARopmGzWR0ra0W6Va4o3bk6Vw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=e1taLLy8RGqZhbpnU0DTI33LuGV0zz2zuk65csiP3dNrr3yJHBAtjd8XlgdEMsgLo
	 g46tIPD1lu27t1fne5zVzyp8SHX6ffTE22LZdgiadbcN1Lcxf47pWP0NBulMN2NPZP
	 dU3/yi9BIbaakGf8OH02qkg9aqL8STP+8fgg5oygMC5cW80nzzClrecmddLZtfKZA4
	 pxx3S9498UD/pIfFd/+MRx4dR4eIXI4XPkZXSedGq1Iu2P3WGJebjBUVEpgVSqWxAH
	 0DK2X+qJkj0zTuggldM9iP94ULVCm7EPYs+BjUkziKPuTt8qEdBenQJRxzhWKu5uT+
	 S2YWrHaH1SA/g==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:50:27 +0300
Message-Id: <D1RLMF7VZ0BQ.1Y0SVHN39UQNN@kernel.org>
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
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-17-ross.philipson@oracle.com>
 <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
 <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>
In-Reply-To: <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>

On Wed Jun 5, 2024 at 1:14 AM EEST,  wrote:
> On 6/4/24 1:27 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> Curently the locality is hard coded to 0 but for DRTM support, access
> >> is needed to localities 1 through 4.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
> >>   drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
> >>   drivers/char/tpm/tpm.h           |  1 +
> >>   include/linux/tpm.h              |  4 ++++
> >>   4 files changed, 43 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >> index 854546000c92..73eac54d61fb 100644
> >> --- a/drivers/char/tpm/tpm-chip.c
> >> +++ b/drivers/char/tpm/tpm-chip.c
> >> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chi=
p)
> >>   	if (!chip->ops->request_locality)
> >>   		return 0;
> >>  =20
> >> -	rc =3D chip->ops->request_locality(chip, 0);
> >> +	rc =3D chip->ops->request_locality(chip, chip->pref_locality);
> >>   	if (rc < 0)
> >>   		return rc;
> >>  =20
> >> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
> >>   }
> >>   EXPORT_SYMBOL_GPL(tpm_chip_stop);
> >>  =20
> >> +/**
> >> + * tpm_chip_preferred_locality() - set the TPM chip preferred localit=
y to open
> >> + * @chip:	a TPM chip to use
> >> + * @locality:   the preferred locality
> >> + *
> >> + * Return:
> >> + * * true      - Preferred locality set
> >> + * * false     - Invalid locality specified
> >> + */
> >> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
> >> +{
> >> +	if (locality < 0 || locality >=3DTPM_MAX_LOCALITY)
> >> +		return false;
> >> +
> >> +	mutex_lock(&chip->tpm_mutex);
> >> +	chip->pref_locality =3D locality;
> >> +	mutex_unlock(&chip->tpm_mutex);
> >> +	return true;
> >> +}
> >> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
> >> +
> >>   /**
> >>    * tpm_try_get_ops() - Get a ref to the tpm_chip
> >>    * @chip: Chip to ref
> >> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pde=
v,
> >>   	}
> >>  =20
> >>   	chip->locality =3D -1;
> >> +	chip->pref_locality =3D 0;
> >>   	return chip;
> >>  =20
> >>   out:
> >> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-i=
nterface.c
> >> index 5da134f12c9a..35f14ccecf0e 100644
> >> --- a/drivers/char/tpm/tpm-interface.c
> >> +++ b/drivers/char/tpm/tpm-interface.c
> >> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
> >>   }
> >>   EXPORT_SYMBOL_GPL(tpm_is_tpm2);
> >>  =20
> >> +/**
> >> + * tpm_preferred_locality() - set the TPM chip preferred locality to =
open
> >> + * @chip:	a TPM chip to use
> >> + * @locality:   the preferred locality
> >> + *
> >> + * Return:
> >> + * * true      - Preferred locality set
> >> + * * false     - Invalid locality specified
> >> + */
> >> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
> >> +{
> >> +	return tpm_chip_preferred_locality(chip, locality);
> >> +}
> >> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);
> >=20
> >   What good does this extra wrapping do?
> >=20
> >   tpm_set_default_locality() and default_locality would make so much mo=
re
> >   sense in any case.
>
> Are you mainly just talking about my naming choices here and in the=20
> follow-on response? Can you clarify what you are requesting?

I'd prefer:

1. Name the variable as default_locality.
2. Only create a single expored to function to tpm-chip.c:
   tpm_chip_set_default_locality().
3. Call this function in all call sites.

"tpm_preferred_locality" should be just removed, as tpm_chip_*
is exported anyway.

BR, Jarkko


Return-Path: <linux-efi+bounces-1142-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E18FBD1A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34532830E3
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3114B071;
	Tue,  4 Jun 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWambTg6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC11E892;
	Tue,  4 Jun 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531933; cv=none; b=C99Win9EpzDcG8us3x2M+Mbcio5W4PqLR8JLHaTferf4j2A217HZP3Uaha3LjsLa3LjpTwas3S2LcJwo/+ZyxO77IIQMX4WpAca5pt9YbGdgvoBwlZMCNkIatYSEP+JBCfdjBceFRRhH1DCnMkLGnJoaFPVFdotLHJJVaEGhS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531933; c=relaxed/simple;
	bh=Xh63A7TD6mb8qSMe+jtLlQgcmtNjDBvQNIrZ/CLVB5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=muQB5HH/2w4QOujSHxNe0q1GUCYy1OTNLeio1rihskqXqeaM5IwwWfOy9/szHsrAOfoWh4G3Ev8Uk1DaM4kBr9fITEDLjHawEnTorkzB+BRZEy+LfuOpLBKXd6pA6X+EO9cC1YaCudun1VWTEyFC0m3p7xbLZViwqPyJhLWmNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWambTg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57DDC2BBFC;
	Tue,  4 Jun 2024 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531932;
	bh=Xh63A7TD6mb8qSMe+jtLlQgcmtNjDBvQNIrZ/CLVB5Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZWambTg6yb/UrCbZ7miWvZqg7168mDRTkwDbXwt0fAnwLef8WNiEg+6HUOAsrce3N
	 z2CY+y3egawd+jRXtJ0LprLnxfLHqzEMwo9UEjhBMTGUUJ8y0fy1G+9NmRD4Ugcbqm
	 IUP3HokldOC+3gzkBHwQ+OwMsros/gDaro4uEpLzLkmf4tK8nI7SH+L8Q5H6BRDVVx
	 CODJdx50y1lKgshh8ti0RlMQdBKuXLMvs6DwPcpN51P+J7Quy1DvdBdOXgXks1lDGQ
	 stUXZPPjswSahTuhj0LHX3txOknL7UB/RrSdnDEDt7391TxhXoyirthwtwh6Oxug9h
	 bzJZA+Vpm2TBQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:12:04 +0300
Message-Id: <D1RI95NQL24F.2E53ZWDFAA8QM@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 13/19] tpm: Protect against locality counter
 underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-14-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-14-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> Commit 933bfc5ad213 introduced the use of a locality counter to control w=
hen a
> locality request is allowed to be sent to the TPM. In the commit, the cou=
nter
> is indiscriminately decremented. Thus creating a situation for an integer
> underflow of the counter.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")

Not sure if we have practical use for fixes tag here but open for
argument ofc. I.e. I'm not sure what is the practical scenario to
worry about if Trenchboot did not exist.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 176cd8dbf1db..7c1761bd6000 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chi=
p *chip, int l)
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> =20
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;

I'd signal the situation with pr_info() in else branch.

>  	if (priv->locality_count =3D=3D 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);

BR, Jarkko


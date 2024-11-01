Return-Path: <linux-efi+bounces-2091-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDB9B8DED
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797C11C21A1C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF915696E;
	Fri,  1 Nov 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP7H7Akl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1114A4F7;
	Fri,  1 Nov 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453598; cv=none; b=Ng6YYCWevn4DkSKI6QLjULYSJgKGL9hVcw1k6rzM52ajJVk3xFHCIY6d6Kmpq7BHGtqtsQvNi9rHLpRbfGjL6jVaKiI5g1Gv8N8Hpp0VSpqjwOJ/kNxcuBC6cOp1CTOlFkiCd6o/dGUcD2Y3jm/0zjAQI12yaUKZWn8MqV8WfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453598; c=relaxed/simple;
	bh=NwWCs6WM3syfKj7MjlqJouLOOSPhG9Wx+R6ZwW1C3TM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dd/GalyuXbEeQc2aheyhx9JOAOh7r+p0k0QY1ObZUmc+ufJZqbI4BSOoIWfvohHrtbDoF883WCXOB+iju8c+eQ5sKGiqlY37IOVFvHmzxGvIO8R3QHTeuRi0gV9WXi/BIMRU8dnxmUfS0q+DeO9+Co3UX39LU1yKBgsMdguKYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP7H7Akl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C0C4CECD;
	Fri,  1 Nov 2024 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730453597;
	bh=NwWCs6WM3syfKj7MjlqJouLOOSPhG9Wx+R6ZwW1C3TM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UP7H7AklAaM/Ys4LMMzt+OLFxwV3c1kO/yKJIL3aPp9S8iQZFBk41Cz+DTCLB6WnN
	 icplAKJ1JuJBqsv7i17oeUUkFAeuZrUYpEQCDD5PcveWTrmrIdWnCviwFrtwngig5k
	 gX73tKB4R0KzQh2OmbGnH/jNKb5xOaZgS1QlTtpPe6PiDiD4jEl7vNMPI5qOFBKmCz
	 luk7q9o4Xju2pp/tbtE6ot7F4RwhX5DyRGI0xoy8VjaWSjsMctAngJqoBHBb1rQAmq
	 CKeMPQCEGCt8o8E4xpJxbXwQjmL/qjOfS211csjXoE9akkkOszWs8Bb8mPNHCj2eIg
	 vn9sMkK17xQAg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 11:33:13 +0200
Message-Id: <D5AQLQJ7LN9K.3F3RQZVUMH0GG@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 14/20] tpm: Protect against locality counter
 underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-15-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-15-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
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

Remove reported-by.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index fdef214b9f6b..a6967f312837 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,10 @@ static int tpm_tis_relinquish_locality(struct tpm_ch=
ip *chip, int l)
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> =20
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;
> +	else
> +		pr_info("Invalid: locality count dropped below zero\n");

Explain the context.

>  	if (priv->locality_count =3D=3D 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);

BR, Jarkko


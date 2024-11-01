Return-Path: <linux-efi+bounces-2093-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB89B8E8F
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C19B1C21291
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E915D5B6;
	Fri,  1 Nov 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOMg2SZJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371715886C;
	Fri,  1 Nov 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455485; cv=none; b=VRuqlAALfUb3j1UHKNAe8Em95jevnq2tWgTuRODcZbtuTY1+c0vjiFoMZh+Gj3m2pAl7Y6p/mjRT1TeKdLccC/2Nvp2WFpamaBmNjVOOwbQ1nLneCPTKul7XOCrIQWoiGY2lKXOO8gtn2w/DGh8KCXkhkykOryLqJxG8NDIZHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455485; c=relaxed/simple;
	bh=ItQI00nS8tC10ZV8l2jyRO6gDNvw+VRojMmh7RUgXnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=O9rVOXWydgqhEhMBP66sNELAZQfe1EmkughdleQ/FTMs4SfuzRYAlpj3UFLYTCGZFNiDcLJ5hEBpdcmrNiog+CFHUhe57Ve0jVV3qG5K0x7PnbUqjz7YqL+9HnuBvk2fwfdeNFZ0JaCJoTQvpXTLWLCExFCc6J82NBBOcRefAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOMg2SZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6CDC4CED1;
	Fri,  1 Nov 2024 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455485;
	bh=ItQI00nS8tC10ZV8l2jyRO6gDNvw+VRojMmh7RUgXnI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fOMg2SZJB9VVqSZQ39KHQMlL2y8sJbkrgDhxf7Z8ZlTa/VEnVFFfhaaRPrtwP8/yh
	 POWHBMEO8mFRPnTFzrzEAvAEa7YdtvJVaxBM49PI/q8ZQvP3Ym8s220U+NYbs9OsdS
	 +vuoKWKCLZUorjlnKqZZaysZwEpw/R1tDdJNbIBLC8DK5NT7+pO7AolUM2yicAOYd9
	 mhheEhTsmnGjUz9/4jZki/KtKYunba+0jUH54/79vbCL8pbHJ+pCAz4ugGM27D+IUj
	 rJ4UiSjiCb3r6TDI0JUpPfI/DvTRhUCObpYTAuV8sPwA4fh1Mkuv/pfrUbjsKVyDRn
	 VRPZSZJ8prfFA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 12:04:41 +0200
Message-Id: <D5AR9TGFZL14.AZMGA2G8GTDA@kernel.org>
Subject: Re: [PATCH v11 16/20] tpm: Make locality requests return consistent
 values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-17-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-17-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The function tpm_tis_request_locality() is expected to return the localit=
y
> value that was requested, or a negative error code upon failure. If it is=
 called
> while locality_count of struct tis_data is non-zero, no actual locality r=
equest
> will be sent. Because the ret variable is initially set to 0, the
> locality_count will still get increased, and the function will return 0. =
For a
> caller, this would indicate that locality 0 was successfully requested an=
d not
> the state changes just mentioned.
>
> Additionally, the function __tpm_tis_request_locality() provides inconsis=
tent
> error codes. It will provide either a failed IO write or a -1 should it h=
ave
> timed out waiting for locality request to succeed.
>
> This commit changes __tpm_tis_request_locality() to return valid negative=
 error
> codes to reflect the reason it fails. It then adjusts the return value ch=
eck in
> tpm_tis_request_locality() to check for a non-negative return value befor=
e
> incrementing locality_cout. In addition, the initial value of the ret val=
ue is
> set to a negative error to ensure the check does not pass if
> __tpm_tis_request_locality() is not called.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 22ebf679ea69..20a8b341be0d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -210,7 +210,7 @@ static int __tpm_tis_request_locality(struct tpm_chip=
 *chip, int l)
>  again:
>  		timeout =3D stop - jiffies;
>  		if ((long)timeout <=3D 0)
> -			return -1;
> +			return -EBUSY;
>  		rc =3D wait_event_interruptible_timeout(priv->int_queue,
>  						      (check_locality
>  						       (chip, l)),
> @@ -229,18 +229,21 @@ static int __tpm_tis_request_locality(struct tpm_ch=
ip *chip, int l)
>  			tpm_msleep(TPM_TIMEOUT);
>  		} while (time_before(jiffies, stop));
>  	}
> -	return -1;
> +	return -EBUSY;
>  }
> =20
>  static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	int ret =3D 0;
> +	int ret =3D -EBUSY;
> +
> +	if (l < 0 || l > TPM_MAX_LOCALITY)
> +		return -EINVAL;
> =20
>  	mutex_lock(&priv->locality_count_mutex);
>  	if (priv->locality_count =3D=3D 0)
>  		ret =3D __tpm_tis_request_locality(chip, l);
> -	if (!ret)
> +	if (ret >=3D 0)
>  		priv->locality_count++;
>  	mutex_unlock(&priv->locality_count_mutex);
>  	return ret;

First of all, -1 is as consistent value as a value can be.

Secondly:

	if (tpm_tis_request_locality(chip, 0) !=3D 0)
		return -EBUSY;

What am I missing here?

BR, Jarkko


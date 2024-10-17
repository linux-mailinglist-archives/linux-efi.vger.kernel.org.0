Return-Path: <linux-efi+bounces-2001-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D549A2DAE
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D612281821
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABE227380;
	Thu, 17 Oct 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJuuYgsy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD221BB0A;
	Thu, 17 Oct 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192861; cv=none; b=EDDltws1Kf2+2z3mGvxxLsR5kmkRZNzO+uETFKFn+DgNBCi8leJGf6/LbMcXtmczLhN7eU4ukjEJ+K7MHdaMIKttGuZpmqUVOonl9tntJr93gUeEcoZOCffvg2Hh635E9vAMysW5QKwFj07LtTJUHOb5y2cKXIHTIPf3wKx9AqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192861; c=relaxed/simple;
	bh=iBin2gEAj9eK+e6L4R6gufQlpREIM1UzHslw/jCq2wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=il5MX6q4Vjtk4dLfvyi0k+SHwAcv0n8G8E7YW78QDGTSyUOXDPp5DgVHTBwqqE9OSA8xhe3nJLbKqiOM18K44dEH6Pt+k4RSP01uk9g9X0duoxBQbG4ViJEXjS2AnRmWa86jqxxXQ+/VDoWCtElBDvoGsnOf0fXpKsP9KAwAn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJuuYgsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B6C4CEC3;
	Thu, 17 Oct 2024 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729192860;
	bh=iBin2gEAj9eK+e6L4R6gufQlpREIM1UzHslw/jCq2wI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mJuuYgsyjuTUEp2M2pIFyofTpPot3uzebvGM7vwOZ71+isB9r6QDx6QeeNwkbH/Na
	 6c2teUzGlW0mKIHwSZNGA0spequBo5N2C+8zObFCmrFmT6a3MxpVm/s1/4+cnCaatZ
	 FL6MPWL8QfUO/rYRWZ1zMbwgiw/ybD6WWdzLzHJFIZOKUkL54kfE9JtSbVRCEZ1nJ8
	 Y+PXuENxELagO0oaL5rX+yfDgFno52KGx1n90gEWq3bMHsbScC4MvujWpXbnnxYj45
	 DUbWbHRBfZDAXMgdRGMGiudbFYoraFBbLb5d8iPbQdzQq8YKVibmgiZ5J+3I0YtBGN
	 UhaNwuV97bfJQ==
Message-ID: <24f4db65f9417b5a686b642bf5a8559236efafb9.camel@kernel.org>
Subject: Re: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>, 
	linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, ardb@kernel.org, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com, mic@digikod.net,
 casey@schaufler-ca.com,  stefanb@linux.ibm.com, ebiggers@kernel.org,
 rdunlap@infradead.org,  linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 linux-efi@vger.kernel.org,  linux-integrity@vger.kernel.org
Date: Thu, 17 Oct 2024 22:20:55 +0300
In-Reply-To: <20241017155516.2582369-5-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.=C2=A0 This
> new
> usage will be used for validating keys added to the new clavis LSM
> keyring.
> This will be introduced in a follow-on patch.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> =C2=A0crypto/asymmetric_keys/asymmetric_type.c | 1 +
> =C2=A0crypto/asymmetric_keys/pkcs7_verify.c=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0include/linux/verification.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> =C2=A03 files changed, 4 insertions(+)
>=20
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c
> b/crypto/asymmetric_keys/asymmetric_type.c
> index 43af5fa510c0..d7bf95c77f4a 100644
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -25,6 +25,7 @@ const char *const
> key_being_used_for[NR__KEY_BEING_USED_FOR] =3D {
> =C2=A0	[VERIFYING_KEY_SIGNATURE]		=3D "key sig",
> =C2=A0	[VERIFYING_KEY_SELF_SIGNATURE]		=3D "key self sig",
> =C2=A0	[VERIFYING_UNSPECIFIED_SIGNATURE]	=3D "unspec sig",
> +	[VERIFYING_CLAVIS_SIGNATURE]		=3D "clavis sig",
> =C2=A0};
> =C2=A0EXPORT_SYMBOL_GPL(key_being_used_for);
> =C2=A0
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c
> b/crypto/asymmetric_keys/pkcs7_verify.c
> index f0d4ff3c20a8..1dc80e68ce96 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -428,6 +428,7 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
> =C2=A0		}
> =C2=A0		/* Authattr presence checked in parser */
> =C2=A0		break;
> +	case VERIFYING_CLAVIS_SIGNATURE:
> =C2=A0	case VERIFYING_UNSPECIFIED_SIGNATURE:
> =C2=A0		if (pkcs7->data_type !=3D OID_data) {
> =C2=A0			pr_warn("Invalid unspecified sig (not pkcs7-
> data)\n");
> diff --git a/include/linux/verification.h
> b/include/linux/verification.h
> index cb2d47f28091..02d2d70e2324 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -36,6 +36,8 @@ enum key_being_used_for {
> =C2=A0	VERIFYING_KEY_SIGNATURE,
> =C2=A0	VERIFYING_KEY_SELF_SIGNATURE,
> =C2=A0	VERIFYING_UNSPECIFIED_SIGNATURE,
> +	/* Add new entries above, keep VERIFYING_CLAVIS_SIGNATURE at
> the end. */
> +	VERIFYING_CLAVIS_SIGNATURE,
> =C2=A0	NR__KEY_BEING_USED_FOR
> =C2=A0};
> =C2=A0extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR]=
;

This looks as good as it can get. Just wondering that does this Clavis
thing connect with the TPM2 asymmetric keys that I've been working on?
I.e. can they be used in tandem. I should really update that patch set
(latest from April).

BR, Jarkko


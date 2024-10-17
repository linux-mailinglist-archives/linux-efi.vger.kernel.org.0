Return-Path: <linux-efi+bounces-2006-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0B9A302A
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 23:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E5D1F22FE1
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F20F1D63F1;
	Thu, 17 Oct 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/5veJ3k"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15E1D1F7E;
	Thu, 17 Oct 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202290; cv=none; b=COFOhMuOpFFXatnWiNBbP6YyWJGXGSG3JZsDomhNrZm1z+KekAyWOQlZ1tMGLEHoCNUJu+knSEc6IGTPNwtc86wOc+zTMP0dvjBnanTcLgxyRi+ERUiKsjEaDl8lzcWb7eY6P6rZQSZrl3Qva4yMcOt/baaYb3JIUXIMeohRpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202290; c=relaxed/simple;
	bh=KHR/VZNuK28wg96sxQVqQhjXxhUA5+d9A8qACNPCbYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUe9HUjmB4SImFMldCYoQCWgTZtikKV/WlZsHMWSlluR0g8mQAVT594LtSA0tHtCQnGulQ0Y39C+flCrSEf82G06vLl/BAyHha3Q8g/Sz1k2YkhWzug5hn142ILbkrH/BxTMdcRdC4e+kg/GK8Chblo2aWnnJ6CM4f+ryYeXUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/5veJ3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4594C4CEC3;
	Thu, 17 Oct 2024 21:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202289;
	bh=KHR/VZNuK28wg96sxQVqQhjXxhUA5+d9A8qACNPCbYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b/5veJ3kqMVo6mmiuWbC7SkFWLN0qSDEjKc/PqmJahowPVC7Hyze6LqFvaQmnOy2x
	 0bqGMeCkb7aPgiSWw4eyss6T7FMhWLrvt5pD8J32iXVWxVS+FU2uoJgm9sENSKaCPO
	 Ufe0Ltm8+UDrof8dxoB0X9wqZTJU/VTgTNviMvcfQU/Ji960kvCMhTw6z0GbKa2K0S
	 brMQ/lGX8V1peAfd0LFMULJnb4JngoJR4v+9frZcwx0DDPsZPpIGtr1gp+MoMe7zq+
	 5e+q0JeFIKF9TYIbTQDboWI4Fws/tOIde2I/ZGkeDkEs/wdDnnlLnisnabLQRQMrri
	 ZpRDZ42pwwALA==
Message-ID: <2e696bea1657b6c1a9309be7aa0e217fec47b750.camel@kernel.org>
Subject: Re: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
 David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "davem@davemloft.net" <davem@davemloft.net>,  Ard Biesheuvel
 <ardb@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,  "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
 Stefan Berger <stefanb@linux.ibm.com>,  "ebiggers@kernel.org"
 <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-efi@vger.kernel.org"
 <linux-efi@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>
Date: Fri, 18 Oct 2024 00:58:05 +0300
In-Reply-To: <46017A8E-88EB-4B8D-9FB2-643F9A5BF7F0@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-5-eric.snowberg@oracle.com>
	 <24f4db65f9417b5a686b642bf5a8559236efafb9.camel@kernel.org>
	 <46017A8E-88EB-4B8D-9FB2-643F9A5BF7F0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 21:42 +0000, Eric Snowberg wrote:
>=20
>=20
> > On Oct 17, 2024, at 1:20=E2=80=AFPM, Jarkko Sakkinen <jarkko@kernel.org=
>
> > wrote:
> >=20
> > On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> > > Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.=C2=A0
> > > This
> > > new
> > > usage will be used for validating keys added to the new clavis
> > > LSM
> > > keyring.
> > > This will be introduced in a follow-on patch.
> > >=20
> > > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > ---
> > > =C2=A0crypto/asymmetric_keys/asymmetric_type.c | 1 +
> > > =C2=A0crypto/asymmetric_keys/pkcs7_verify.c=C2=A0=C2=A0=C2=A0 | 1 +
> > > =C2=A0include/linux/verification.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > > =C2=A03 files changed, 4 insertions(+)
> > >=20
> > > diff --git a/crypto/asymmetric_keys/asymmetric_type.c
> > > b/crypto/asymmetric_keys/asymmetric_type.c
> > > index 43af5fa510c0..d7bf95c77f4a 100644
> > > --- a/crypto/asymmetric_keys/asymmetric_type.c
> > > +++ b/crypto/asymmetric_keys/asymmetric_type.c
> > > @@ -25,6 +25,7 @@ const char *const
> > > key_being_used_for[NR__KEY_BEING_USED_FOR] =3D {
> > > =C2=A0 [VERIFYING_KEY_SIGNATURE] =3D "key sig",
> > > =C2=A0 [VERIFYING_KEY_SELF_SIGNATURE] =3D "key self sig",
> > > =C2=A0 [VERIFYING_UNSPECIFIED_SIGNATURE] =3D "unspec sig",
> > > + [VERIFYING_CLAVIS_SIGNATURE] =3D "clavis sig",
> > > =C2=A0};
> > > =C2=A0EXPORT_SYMBOL_GPL(key_being_used_for);
> > > =C2=A0
> > > diff --git a/crypto/asymmetric_keys/pkcs7_verify.c
> > > b/crypto/asymmetric_keys/pkcs7_verify.c
> > > index f0d4ff3c20a8..1dc80e68ce96 100644
> > > --- a/crypto/asymmetric_keys/pkcs7_verify.c
> > > +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> > > @@ -428,6 +428,7 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
> > > =C2=A0 }
> > > =C2=A0 /* Authattr presence checked in parser */
> > > =C2=A0 break;
> > > + case VERIFYING_CLAVIS_SIGNATURE:
> > > =C2=A0 case VERIFYING_UNSPECIFIED_SIGNATURE:
> > > =C2=A0 if (pkcs7->data_type !=3D OID_data) {
> > > =C2=A0 pr_warn("Invalid unspecified sig (not pkcs7-
> > > data)\n");
> > > diff --git a/include/linux/verification.h
> > > b/include/linux/verification.h
> > > index cb2d47f28091..02d2d70e2324 100644
> > > --- a/include/linux/verification.h
> > > +++ b/include/linux/verification.h
> > > @@ -36,6 +36,8 @@ enum key_being_used_for {
> > > =C2=A0 VERIFYING_KEY_SIGNATURE,
> > > =C2=A0 VERIFYING_KEY_SELF_SIGNATURE,
> > > =C2=A0 VERIFYING_UNSPECIFIED_SIGNATURE,
> > > + /* Add new entries above, keep VERIFYING_CLAVIS_SIGNATURE at
> > > the end. */
> > > + VERIFYING_CLAVIS_SIGNATURE,
> > > =C2=A0 NR__KEY_BEING_USED_FOR
> > > =C2=A0};
> > > =C2=A0extern const char *const
> > > key_being_used_for[NR__KEY_BEING_USED_FOR];
> >=20
> > This looks as good as it can get. Just wondering that does this
> > Clavis
> > thing connect with the TPM2 asymmetric keys that I've been working
> > on?
> > I.e. can they be used in tandem. I should really update that patch
> > set
> > (latest from April).
>=20
> With some changes, I think they could be used in tandem.=C2=A0 If I'm
> looking at=20
> the correct series, tpm2_key_rsa_describe would need to be changed to
> return a unique identifier, instead of "TPM2/RSA".=C2=A0 This identifier
> could be=20
> used instead of the skid when creating a Clavis ACL.=C2=A0 There would
> probably=20
> also need to be a new system kernel keyring containing these TPM
> keys.=20
> Similar to the builtin, secondary, machine, etc.

I think when I finally get into working on this again I focus on
purely to get ECDSA right. Thanks for the tip, most likely this
revamp will happen post your patch set. I'm still busy fixing
corner cases with the bus encryption that James Bottomley
contributed.

BR, Jarkko


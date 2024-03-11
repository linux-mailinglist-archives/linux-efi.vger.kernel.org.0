Return-Path: <linux-efi+bounces-803-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046AC87889D
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 20:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850821F21913
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554754BE4;
	Mon, 11 Mar 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5vFsQrT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9D548E8;
	Mon, 11 Mar 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184599; cv=none; b=jUtklG5/AoW5bp7cepa7zCQ5Tp76PSoQE98WEPdu0ZW4XBf9Vf4ByNIS0XC5F+8Mh1qs1rqzmYrjWu95+3xKM+kuNJ5lwIETCn2zZzzq8afKJgElekMTT1NV7L3p5FBdefX/QJSmUXPlvHUupKbdnyOg0EiiTF/XzknGeBJFoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184599; c=relaxed/simple;
	bh=kHNcU/A8IStZaoPe8vAtp85g+y8rB2nN2+64t8in89A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Gy61XF3CSuQepVvbWvZEfjVeo+da569nyEb5EViZQGJ4ldZLrwk1DSLsugX7AsMKwkpyivhLXZ0pCxKNftQ1MEDREqwg7yVhn3+xQPkQmO7+ewf+sbRveiqp7nSu6+eB66Xz+iorMeblXLgwYuHRRFBo4zTKcvo7zBg7G0WbEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5vFsQrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D7C433F1;
	Mon, 11 Mar 2024 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710184598;
	bh=kHNcU/A8IStZaoPe8vAtp85g+y8rB2nN2+64t8in89A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l5vFsQrTqjh4SfjpBId+PeI4ofS5IFdGN1d/VsuWjkXswLxM/Qzbris9WuT9u3NA8
	 T0TUHWDIyYKjL8Ck97AT20dCFLj6QLK5pjdt0ImoxEi1iCWxP34zpLrSrWSOedjapr
	 4ZPNQJHJfbvX6cJP0ydLWwKelcu38pWoiVgodlWZvmQ/RruSrCmm0syda/qxH0ng8P
	 MXOG9g9ZRXikle6izCj/0sUNBedg7Wp+Qh+Wd/oTn+wI/xWKTNxZK7umV6Y/Uj293J
	 d+Zn37LQp5yTAYTwgV5WMGENAnN+OYc2TP/Hboidu09nwI7YLzfkEXthL2AlZoSoKy
	 sG3pa612/QKmg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 21:16:31 +0200
Message-Id: <CZR5UBHJL9RC.1NA7Q0F10XSJF@kernel.org>
Cc: <dhowells@redhat.com>, <dwmw2@infradead.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
 <dmitry.kasatkin@gmail.com>, <mic@digikod.net>, <casey@schaufler-ca.com>,
 <stefanb@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system
 key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Snowberg" <eric.snowberg@oracle.com>,
 <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
In-Reply-To: <20240311161111.3268190-2-eric.snowberg@oracle.com>

On Mon Mar 11, 2024 at 6:11 PM EET, Eric Snowberg wrote:
> Introduce a new function to allow a keyring to link to a key contained
> within one of the system keyrings (builtin, secondary, or platform).
> Depending on how the kernel is built, if the machine keyring is
> available, it will be checked as well, since it is linked to the secondar=
y
> keyring. If the asymmetric key id matches a key within one of these
> system keyrings, the matching key is linked into the passed in
> keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/system_keyring.c        | 29 +++++++++++++++++++++++++++++
>  include/keys/system_keyring.h |  7 ++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..b647be49f6e0 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -426,3 +426,32 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +
> +/**
> + * system_key_link - Link to a system key
> + * @keyring: The keyring to link into
> + * @id: The asymmetric key id to look for in the system keyring
> + */
> +int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
> +{
> +	struct key *tkey;

I'd suggest to replace this with just 'tkey'. Single obscure character
does not bring any readability value.

> +
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	tkey =3D find_asymmetric_key(secondary_trusted_keys, id, NULL, NULL, fa=
lse);
> +#else
> +	tkey =3D find_asymmetric_key(builtin_trusted_keys, id, NULL, NULL, fals=
e);
> +#endif

I'd have just single call site here and inside ifdef-shenanigans i'd
just set helper "keyring" to point to the appropriate keyring.

> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	tkey =3D find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, fal=
se);
> +

Please remove this empty line as the check below is associated with it.

> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	return -1;
> +
> +found:
> +	key_link(keyring, tkey);
> +	return 0;
> +}
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index 8365adf842ef..b47ac8e2001a 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -9,6 +9,7 @@
>  #define _KEYS_SYSTEM_KEYRING_H
> =20
>  #include <linux/key.h>
> +struct asymmetric_key_id;
> =20
>  enum blacklist_hash_type {
>  	/* TBSCertificate hash */
> @@ -28,7 +29,7 @@ int restrict_link_by_digsig_builtin(struct key *dest_ke=
yring,
>  				    const union key_payload *payload,
>  				    struct key *restriction_key);
>  extern __init int load_module_cert(struct key *keyring);
> -
> +extern int system_key_link(struct key *keyring, struct asymmetric_key_id=
 *id);
>  #else
>  #define restrict_link_by_builtin_trusted restrict_link_reject
>  #define restrict_link_by_digsig_builtin restrict_link_reject
> @@ -38,6 +39,10 @@ static inline __init int load_module_cert(struct key *=
keyring)
>  	return 0;
>  }
> =20
> +static inline int system_key_link(struct key *keyring, struct asymmetric=
_key_id *id)
> +{
> +	return 0;
> +}
>  #endif
> =20
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING

BR, Jarkko


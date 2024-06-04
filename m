Return-Path: <linux-efi+bounces-1132-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99D8FBB40
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAE51F26D1D
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04799149DE3;
	Tue,  4 Jun 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrMIn52w"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF5179BC;
	Tue,  4 Jun 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524487; cv=none; b=Xxp/H2XBSY8gZpFwRQKOyY93lgAOZVRHqYXtE6PdfrMb+N8pFWTCO/LMZ+w4YylvRsyVQYD55mp+Tfnkz2iZG7tBpKLv7tMGzXA1VE9/ue9D6Q6KxF8bI8Cwgfscz0gcfKuBWNaBAs4KttZXKHUrLx1GZlMpljmD/lIjkSZ1QRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524487; c=relaxed/simple;
	bh=NSPTMuwx9KcCNJAhfWh9J5IIW23EBXou0acUEEypYOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jVbbZt7cGsI91qHmzNVGBOUIe/WdF32P+oIX7UXBQKot1Mr3DF2/6Z1SF+LcEkdA6NJQ4JG2p3x1oEtPEbuIQo0BeVyMM3u1u4VqG56OVZeckhHpCl1j7kFTm4sYAGTdLd663rIOtKj8hqdClH1K1rM7mGhPLM6Bjf+ZmbyYh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrMIn52w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2AC2BBFC;
	Tue,  4 Jun 2024 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717524487;
	bh=NSPTMuwx9KcCNJAhfWh9J5IIW23EBXou0acUEEypYOw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=WrMIn52wdfKfEhHzGwaV1Pr93jMN7MkSqau/TchUVXcoY0bNU77+AfhtzpdY2MCOJ
	 bprVAdu8kHTBbRtZKz0EXEr3Z445Gl8lpu9FrZURcmOZweOnMRhYDYluxlhIeDEWEi
	 IgdX2duN3nbCrxA2aTbj29W6FZCo76WpqvtqWdYSAHJo2XgUFKQlOpf/onoGHRZx8M
	 rSxdo6JZcLR+S7i89QvM7ip0cnzIDx9XbFnzAsRMzQ+Zr8OMTq/0dwUrrvriCqQJv/
	 nX7kXvZyY0AxVULvlb3Rdp3roE0QB19lXelv9CHABPKSWO55soQUCypRBbM+l791T1
	 0O7A76W1ZNf/g==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 21:08:00 +0300
Message-Id: <D1RFM5ZWU1O4.1QU546DO1UNKD@kernel.org>
Subject: Re: [RFC PATCH v2 1/8] certs: Introduce ability to link to a system
 key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Snowberg" <eric.snowberg@oracle.com>,
 <linux-security-module@vger.kernel.org>
Cc: <dhowells@redhat.com>, <dwmw2@infradead.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
 <dmitry.kasatkin@gmail.com>, <mic@digikod.net>, <casey@schaufler-ca.com>,
 <stefanb@linux.ibm.com>, <ebiggers@kernel.org>, <rdunlap@infradead.org>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-efi@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
 <20240531003945.44594-2-eric.snowberg@oracle.com>
In-Reply-To: <20240531003945.44594-2-eric.snowberg@oracle.com>

On Fri May 31, 2024 at 3:39 AM EEST, Eric Snowberg wrote:
> Introduce a new function to allow a keyring to link to a key contained
> within one of the system keyrings (builtin, secondary, or platform).

"Introduce system_key_link(), a new function..."

I hate when the exact thing added is not immediately transparent from
the commit message ;-) Helps a lot when bisecting for instance.

> Depending on how the kernel is built, if the machine keyring is
> available, it will be checked as well, since it is linked to the secondar=
y
> keyring. If the asymmetric key id matches a key within one of these
> system keyrings, the matching key is linked into the passed in
> keyring.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/system_keyring.c        | 31 +++++++++++++++++++++++++++++++
>  include/keys/system_keyring.h |  7 ++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..94e47b6b3333 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -426,3 +426,34 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +
> +/**
> + * system_key_link - Link to a system key

"system_key_link() - Link to a system key"

> + * @keyring: The keyring to link into
> + * @id: The asymmetric key id to look for in the system keyring
> + */

Really could use some overview keyrings traversed just as a reminder.

> +int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
> +{
> +	struct key *system_keyring;
> +	struct key *key;
> +
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	system_keyring =3D secondary_trusted_keys;
> +#else
> +	system_keyring =3D builtin_trusted_keys;
> +#endif

Why not simply make secondary_trusted_keys in the first place be alias
to builtin_trusted_keys when it is not enabled?

> +
> +	key =3D find_asymmetric_key(system_keyring, id, NULL, NULL, false);
> +	if (!IS_ERR(key))
> +		goto found;
> +
> +	key =3D find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, fals=
e);
> +	if (!IS_ERR(key))
> +		goto found;
> +
> +	return -ENOKEY;
> +
> +found:

"link:"?

Then you could see already from goto statement what will happen next
(your call anyway).

> +	key_link(keyring, key);
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


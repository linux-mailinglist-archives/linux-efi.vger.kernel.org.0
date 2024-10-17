Return-Path: <linux-efi+bounces-2002-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1059A2DC2
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0412839BB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0222738E;
	Thu, 17 Oct 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chi2u6P7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E5227387;
	Thu, 17 Oct 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193270; cv=none; b=h0s93Ts+asn9Lr/dONqeWZzrSkJrsPzuawck4QpTC6/oYlOrubivGdj+dUWxrOylaRDOdSjbvxpKXBYL15rqn1MoxOhY1/M1frGnO5RLN97h10VbJMOJ4o8AiDYafaVq0qTkUFy6lXjK2q536ErXticwGUl6/EBzJf+DR9aLwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193270; c=relaxed/simple;
	bh=mnV5yf+yYTKcaaxgBfshBpP5wV2UjJUhow7iEdtj22I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZ+Vx1ulc+/AtPTs7hPaweYHxMHfx+JnmyaAO3CgGAluiuuFrc7n/sxurPnr1LtgL6jiSExSTsWmB78rZ/XpQT9bRcZSFL8Y56nvwY0vYa1xJv401ZANbm4tBhGK/0k5/6MJDUBn1qF+sW3imVko9HVDA1NJ+FQlw06tekVs8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chi2u6P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75222C4CED2;
	Thu, 17 Oct 2024 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729193270;
	bh=mnV5yf+yYTKcaaxgBfshBpP5wV2UjJUhow7iEdtj22I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=chi2u6P7l6DcY8p5mmatPeZyvBKFugUZrHAZ22Mk7O7ZuKbozy72lJtyRhVKWkK/+
	 m9uTgX5Ga9s87w8Rn3fePCSITtOmaEKvJUzHkFzqIOlHJLbJLfkwFyf7N7yIkIb0AG
	 tLLY4eUWq85k8PeGOAzLbqQCLxMGZxB5ZyFnqHfJ1j4+JFDm3qd8tpEFh4PYeeFSPI
	 lQW4UHq8hTIuTh6iRFZNsDK8U40wbfu6dSuROBrjoQo3P/+Z3Hcmfx1u5ei9ceZ9Jm
	 GhgG6AUu4hf748wjqSziK5s9qtEf7UWtihHplZttX8lKRWko4NLRwu4mk3T57U7KWu
	 SbZnfJSalKpVA==
Message-ID: <d5be6d8cef1033d1f4b99dc6d15076638fa598ad.camel@kernel.org>
Subject: Re: [RFC PATCH v3 06/13] clavis: Populate clavis keyring acl with
 kernel module signature
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
Date: Thu, 17 Oct 2024 22:27:45 +0300
In-Reply-To: <20241017155516.2582369-7-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-7-eric.snowberg@oracle.com>
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
> If the kernel is built with CONFIG_MODULE_SIG_KEY, get the subject
> key identifier and add an ACL for it within the .clavis keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Super sound splits! Nice to review, have to give credit on this
:-)

> ---
> =C2=A0certs/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0certs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++=
++++++++
> =C2=A0certs/clavis_module_acl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 7 +++++++
> =C2=A0security/clavis/clavis.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 +++++++++
> =C2=A0security/clavis/clavis_keyring.c | 27 +++++++++++++++++++++++++++
> =C2=A05 files changed, 64 insertions(+)
> =C2=A0create mode 100644 certs/clavis_module_acl.c
>=20
> diff --git a/certs/.gitignore b/certs/.gitignore
> index cec5465f31c1..dc99ae5a2585 100644
> --- a/certs/.gitignore
> +++ b/certs/.gitignore
> @@ -3,3 +3,4 @@
> =C2=A0/extract-cert
> =C2=A0/x509_certificate_list
> =C2=A0/x509_revocation_list
> +/module_acl
> diff --git a/certs/Makefile b/certs/Makefile
> index f6fa4d8d75e0..f2555e5296f5 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -6,6 +6,7 @@
> =C2=A0obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_keyring.o
> system_certificates.o
> =C2=A0obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o
> blacklist_hashes.o
> =C2=A0obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificates.o
> +obj-$(CONFIG_SECURITY_CLAVIS) +=3D clavis_module_acl.o
> =C2=A0
> =C2=A0$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
> =C2=A0CFLAGS_blacklist_hashes.o :=3D -I $(obj)
> @@ -75,6 +76,25 @@ $(obj)/signing_key.x509: $(filter-out
> $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(
> =C2=A0
> =C2=A0targets +=3D signing_key.x509
> =C2=A0
> +ifeq ($(CONFIG_MODULE_SIG_KEY),)
> +quiet_cmd_make_module_acl =3D GEN=C2=A0=C2=A0 $@
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd_make_module_acl =3D \
> +	echo > $@
> +else
> +quiet_cmd_make_module_acl =3D GEN=C2=A0=C2=A0 $@
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd_make_module_acl =3D \
> +	openssl x509 -in $< -inform der -ext subjectKeyIdentifier=C2=A0 -
> nocert | \
> +	tail -n +2 | cut -f2 -d '=3D'| tr -d ':' | tr '[:upper:]'
> '[:lower:]' | \
> +	sed 's/^[ \t]*//; s/.*/"00:&",/' > $@
> +endif
> +
> +$(obj)/module_acl: $(obj)/signing_key.x509 FORCE
> +		$(call if_changed,make_module_acl)
> +
> +$(obj)/clavis_module_acl.o: $(obj)/module_acl
> +
> +targets +=3D module_acl
> +
> =C2=A0$(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
> =C2=A0
> =C2=A0$(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS)
> $(obj)/extract-cert FORCE
> diff --git a/certs/clavis_module_acl.c b/certs/clavis_module_acl.c
> new file mode 100644
> index 000000000000..fc2f694c48f9
> --- /dev/null
> +++ b/certs/clavis_module_acl.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +
> +const char __initconst *const clavis_module_acl[] =3D {
> +#include "module_acl"
> +	NULL
> +};
> diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
> index 7b55a6050440..92f77a1939ad 100644
> --- a/security/clavis/clavis.h
> +++ b/security/clavis/clavis.h
> @@ -11,4 +11,13 @@ struct asymmetric_setup_kid {
> =C2=A0	struct asymmetric_key_id id;
> =C2=A0	unsigned char data[CLAVIS_BIN_KID_MAX];
> =C2=A0};
> +
> +#ifndef CONFIG_SYSTEM_TRUSTED_KEYRING
> +const char __initconst *const clavis_module_acl[] =3D {
> +	 NULL
> +};
> +#else
> +extern const char __initconst *const clavis_module_acl[];
> +#endif
> +
> =C2=A0#endif /* _SECURITY_CLAVIS_H_ */
> diff --git a/security/clavis/clavis_keyring.c
> b/security/clavis/clavis_keyring.c
> index 00163e7f0fe9..2a18d0e77189 100644
> --- a/security/clavis/clavis_keyring.c
> +++ b/security/clavis/clavis_keyring.c
> @@ -259,6 +259,31 @@ static struct key_restriction
> *clavis_restriction_alloc(key_restrict_link_func_t
> =C2=A0	return restriction;
> =C2=A0}
> =C2=A0
> +static void clavis_add_acl(const char *const *skid_list, struct key
> *keyring)
> +{
> +	const char *const *acl;
> +	key_ref_t key;
> +
> +	for (acl =3D skid_list; *acl; acl++) {
> +		key =3D key_create(make_key_ref(keyring, true),
> +				 "clavis_key_acl",
> +				=C2=A0 *acl,
> +				=C2=A0 NULL,
> +				=C2=A0 0,
> +				=C2=A0 KEY_POS_SEARCH | KEY_POS_VIEW |
> KEY_USR_SEARCH | KEY_USR_VIEW,
> +				=C2=A0 KEY_ALLOC_NOT_IN_QUOTA |
> KEY_ALLOC_BUILT_IN |
> +				=C2=A0 KEY_ALLOC_BYPASS_RESTRICTION);
> +		if (IS_ERR(key)) {
> +			if (PTR_ERR(key) =3D=3D -EEXIST)
> +				pr_info("Duplicate clavis_key_acl
> %s\n", *acl);
> +			else
> +				pr_info("Problem with clavis_key_acl
> %s: %pe\n", *acl, key);
> +		} else {
> +			pr_info("Added clavis_key_acl %s\n", *acl);
> +		}
> +	}
> +}
> +
> =C2=A0static int __init clavis_keyring_init(void)
> =C2=A0{
> =C2=A0	struct key_restriction *restriction;
> @@ -274,6 +299,8 @@ static int __init clavis_keyring_init(void)
> =C2=A0	if (IS_ERR(clavis_keyring))
> =C2=A0		panic("Can't allocate clavis keyring\n");
> =C2=A0
> +	clavis_add_acl(clavis_module_acl, clavis_keyring);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

Not yet tagging, but neither anything to complain. LGTM

BR, Jarkko


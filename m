Return-Path: <linux-efi+bounces-2455-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FC9FB7EF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 01:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD25164749
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EC4A00;
	Tue, 24 Dec 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quaODbVK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E33139D;
	Tue, 24 Dec 2024 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734998506; cv=none; b=KfzVA0kRNf+GFZFEjoPQE99hObJSmbyZGB7FrSvTieQNHO0ZIsnbfKv/CaTqOIM9X92z58yGjOgrNo0aQEaS+MFGkFwyE9Jvr2W4TeYSpGxovdYIh0tHbmkjK0RIsA3x8qKY+Unrya/Hm7Ho7AWUV/zkIRu/JpHnJrwiz8COx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734998506; c=relaxed/simple;
	bh=u1+9Pz1OKTqLhFmzv3jI0M4CPMVg8U3YR0TahO4hPFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXaznDRv5Q0bwQ7eSPGs5SLl4gUMb6LTKoI5TNs2lf/0wptlvwDHlJAaeb/yZjxCBTZb6RUeL8UiMmdhapkz5Bm1Y9A0TJJ/HnjRHG6tQhRd6x/d2n3hl7PcpIJuc3MMCL4bXQJjWfp5gpv/rAWwpG9gLy65/9CRZCI0pyQ7fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quaODbVK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNFBD91021508;
	Tue, 24 Dec 2024 00:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uwUmvX
	5S9nM1MyhDFTK4w5BojjJCP+XnvxNB3Dfqja4=; b=quaODbVKNJHcuJNmxC/k26
	7tNwa84qZW2Tu4nJe5Githl1akhGQDbeDd/HwmQbhs9o1RY1UYd2iolGyQFzAj3/
	gs+TGmJyWhDqoMI4pkFvoTUfXN6KSo9CdZVp2ZUNPHNyIHEXO+pfp3dLjzBnCUEk
	QDOQ2pP7nkMdl5WPL5iuUQHoSv4xgQ1chPhW3wFZKY0z4xOtwKyXazXVSn6BYj7K
	tZCVDrKrS0WVpcO4ezs8PQtN24Eq6zW10RhJfAahxviYslhhPwgM+3LWIcgmbQA3
	X361vPNprzQ2NVTKIFN/3FRcDU18o0ISnkLY1+bsIJ2wWR5VZ2qrQbPXskmIQdZA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bh4qpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:01:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNNxdXQ014655;
	Tue, 24 Dec 2024 00:01:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bh4qp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:01:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNLm4LG012247;
	Tue, 24 Dec 2024 00:01:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43paq1feg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:01:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO017qp27591364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 00:01:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A6E58052;
	Tue, 24 Dec 2024 00:01:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7461758068;
	Tue, 24 Dec 2024 00:01:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.60.117])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 00:01:05 +0000 (GMT)
Message-ID: <0dcd6ccea49026950608d8ddde5700ace84a2548.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
        casey@schaufler-ca.com, stefanb@linux.ibm.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Mon, 23 Dec 2024 19:01:04 -0500
In-Reply-To: <20241017155516.2582369-4-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J2F-klKFcVeLI4t274NTsYKA_DP-mlDZ
X-Proofpoint-GUID: IWUKzvFlHO1GXA6B2hPNlVshe3jHipdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230213

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Introduce a new system keyring called clavis.  This keyring shall contain
> a single asymmetric key. This key may be a linked to a key already
> contained in one of the system keyrings (builtin, secondary, or platform)=
.

Although "This key may be a linked to ..." is might be correct.  Being
introduced in this patch is only the ability of loading a key by specifying=
 it
on the boot command line.  In this case, the key must be on one of the syst=
em
keyrings.

> One way to add this key into this keyring is during boot by passing in th=
e
> asymmetric key id within the new "clavis=3D" boot param.  If a matching k=
ey
> is found in one of the system keyrings, a link shall be created. This
> keyring will be used in the future by the new Clavis LSM.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  include/linux/integrity.h                     |   8 ++
>  security/Kconfig                              |   1 +
>  security/Makefile                             |   1 +
>  security/clavis/Kconfig                       |  11 ++
>  security/clavis/Makefile                      |   3 +
>  security/clavis/clavis.h                      |  13 ++
>  security/clavis/clavis_keyring.c              | 115 ++++++++++++++++++
>  security/integrity/iint.c                     |   2 +
>  9 files changed, 160 insertions(+)
>  create mode 100644 security/clavis/Kconfig
>  create mode 100644 security/clavis/Makefile
>  create mode 100644 security/clavis/clavis.h
>  create mode 100644 security/clavis/clavis_keyring.c
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..d71397e7d254 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -645,6 +645,12 @@
>  	cio_ignore=3D	[S390]
>  			See Documentation/arch/s390/common_io.rst for details.
> =20
> +	clavis=3D		[SECURITY,EARLY]
> +			Identifies a specific key contained in one of the system
> +			keyrings (builtin, secondary, or platform) to be used as
> +			the Clavis root of trust.
> +			Format: { <keyid> }

Include .machine keyring here.

> +
>  	clearcpuid=3DX[,X...] [X86]
>  			Disable CPUID feature X for the kernel. See
>  			arch/x86/include/asm/cpufeatures.h for the valid bit
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359b..837c52e1d83b 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -23,6 +23,14 @@ enum integrity_status {
>  #ifdef CONFIG_INTEGRITY
>  extern void __init integrity_load_keys(void);
> =20
> +#ifdef CONFIG_SECURITY_CLAVIS
> +void __init late_init_clavis_setup(void);
> +#else
> +static inline void late_init_clavis_setup(void)
> +{
> +}
> +#endif
> +
>  #else
>  static inline void integrity_load_keys(void)
>  {
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..714ec08dda96 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -225,6 +225,7 @@ source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
>  source "security/ipe/Kconfig"
> +source "security/clavis/Kconfig"
> =20
>  source "security/integrity/Kconfig"
> =20
> diff --git a/security/Makefile b/security/Makefile
> index cc0982214b84..69576551007a 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+=3D bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
>  obj-$(CONFIG_SECURITY_IPE)		+=3D ipe/
> +obj-$(CONFIG_SECURITY_CLAVIS)		+=3D clavis/
> =20
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+=3D integrity/
> diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
> new file mode 100644
> index 000000000000..04f7565f2e2b
> --- /dev/null
> +++ b/security/clavis/Kconfig
> @@ -0,0 +1,11 @@
> +config SECURITY_CLAVIS
> +	bool "Clavis keyring"

Isn't SECURITY_CLAVIS the new LSM?  Why is the bool defined as just "Clavis
keyring"?

> +	depends on SECURITY
> +	select SYSTEM_DATA_VERIFICATION
> +	select CRYPTO_SHA256
> +	help
> +	  Enable the clavis keyring. This keyring shall contain a single asymme=
tric key.
> +	  This key shall be linked to a key already contained in one of the sys=
tem
> +	  keyrings (builtin, secondary, or platform). One way to add this key
> +	  is during boot by passing in the asymmetric key id within the "clavis=
=3D" boot
> +	  param.  This keyring is required by the Clavis LSM.

If SECURITY_CLAVIS is a new LSM, the 'help' shouldn't be limited to just th=
e
clavis keyring, but written at a higher level describing the new LSM.  For
example,

This option enables the Clavis LSM, which provides the ability to configure=
 and
enforce the usage of keys contained on the system keyrings -
.builtin_trusted_keys, .secondary_trusted_keys, .machine, and .platform
keyrings.  The clavis LSM defines a keyring named "clavis", which contains =
a
single asymmetric key and the key usage rules.

The single asymmetric key may be specified on the boot command line ...

[The patch that introduces the key usage rules would add additional info he=
re.]

[The patch that adds the Documentatoin would add a reference here.]

> diff --git a/security/clavis/Makefile b/security/clavis/Makefile
> new file mode 100644
> index 000000000000..16c451f45f37
> --- /dev/null
> +++ b/security/clavis/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_SECURITY_CLAVIS) +=3D clavis_keyring.o
> diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
> new file mode 100644
> index 000000000000..5e397b55a60a
> --- /dev/null
> +++ b/security/clavis/clavis.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SECURITY_CLAVIS_H_
> +#define _SECURITY_CLAVIS_H_
> +#include <keys/asymmetric-type.h>
> +
> +/* Max length for the asymmetric key id contained on the boot param */
> +#define CLAVIS_BIN_KID_MAX   32
> +
> +struct asymmetric_setup_kid {
> +	struct asymmetric_key_id id;
> +	unsigned char data[CLAVIS_BIN_KID_MAX];
> +};
> +#endif /* _SECURITY_CLAVIS_H_ */
> diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_ke=
yring.c
> new file mode 100644
> index 000000000000..400ed455a3a2
> --- /dev/null
> +++ b/security/clavis/clavis_keyring.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/security.h>
> +#include <linux/integrity.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/system_keyring.h>
> +#include "clavis.h"
> +
> +static struct key *clavis_keyring;
> +static struct asymmetric_key_id *clavis_boot_akid;
> +static struct asymmetric_setup_kid clavis_setup_akid;
> +static bool clavis_enforced;
> +
> +static bool clavis_acl_enforced(void)
> +{
> +	return clavis_enforced;
> +}

Add blank line between functions.

Mimi

> +static int restrict_link_for_clavis(struct key *dest_keyring, const stru=
ct key_type *type,
> +				    const union key_payload *payload, struct key *restrict_key)
> +{
> +	/*
> +	 * Allow a single asymmetric key into this keyring. This key is used as=
 the
> +	 * root of trust for anything added afterwards.
> +	 */
> +	if (type =3D=3D &key_type_asymmetric && dest_keyring =3D=3D clavis_keyr=
ing &&
> +	    !clavis_acl_enforced()) {
> +		clavis_enforced =3D true;
> +		return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static struct asymmetric_key_id *clavis_parse_boot_param(char *kid, stru=
ct asymmetric_key_id *akid,
> +							 int akid_max_len)
> +{
> +	int error, hex_len;
> +
> +	if (!kid)
> +		return 0;
> +
> +	hex_len =3D strlen(kid) / 2;
> +
> +	if (hex_len > akid_max_len)
> +		return 0;
> +
> +	akid->len =3D hex_len;
> +	error =3D hex2bin(akid->data, kid, akid->len);
> +
> +	if (error < 0) {
> +		pr_err("Unparsable clavis key id\n");
> +		return 0;
> +	}
> +
> +	return akid;
> +}
> +
> +static int __init clavis_param(char *kid)
> +{
> +	clavis_boot_akid =3D clavis_parse_boot_param(kid, &clavis_setup_akid.id=
,
> +						   ARRAY_SIZE(clavis_setup_akid.data));
> +
> +	return 1;
> +}
> +
> +__setup("clavis=3D", clavis_param);
> +
> +static struct key *clavis_keyring_alloc(const char *desc, struct key_res=
triction *restriction)
> +{
> +	struct key *keyring;
> +
> +	keyring =3D keyring_alloc(desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, curre=
nt_cred(),
> +				KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_WRITE |
> +				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH | KEY_USR_WRITE,
> +				KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
> +				restriction, NULL);
> +	return keyring;
> +}
> +
> +static struct key_restriction *clavis_restriction_alloc(key_restrict_lin=
k_func_t check_func)
> +{
> +	struct key_restriction *restriction;
> +
> +	restriction =3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> +
> +	if (restriction)
> +		restriction->check =3D check_func;
> +
> +	return restriction;
> +}
> +
> +static int __init clavis_keyring_init(void)
> +{
> +	struct key_restriction *restriction;
> +
> +	restriction =3D clavis_restriction_alloc(restrict_link_for_clavis);
> +	if (!restriction)
> +		panic("Can't allocate clavis keyring restriction\n");
> +
> +	clavis_keyring =3D clavis_keyring_alloc(".clavis", restriction);
> +	if (IS_ERR(clavis_keyring))
> +		panic("Can't allocate clavis keyring\n");
> +
> +	return 0;
> +}
> +
> +void __init late_init_clavis_setup(void)
> +{
> +	clavis_keyring_init();
> +
> +	if (!clavis_boot_akid)
> +		return;
> +
> +	system_key_link(clavis_keyring, clavis_boot_akid);
> +}
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 068ac6c2ae1e..87a8bfc0662f 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -36,6 +36,8 @@ int integrity_kernel_read(struct file *file, loff_t off=
set,
>   */
>  void __init integrity_load_keys(void)
>  {
> +	late_init_clavis_setup();
> +
>  	ima_load_x509();
> =20
>  	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))



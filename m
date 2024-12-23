Return-Path: <linux-efi+bounces-2435-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953079FB211
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ADC161449
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771F1B393A;
	Mon, 23 Dec 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjO5KOjs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C17E0FF;
	Mon, 23 Dec 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970380; cv=none; b=Qm3+1Dj7cXnL+cN+IH06H0rMDTruzTdloiExWCq9daxXey9SCCKuqTMhg0LkO5SZAQpl2BViK/m1dqv+JDH8QQA2C1Fu0zoflkS6wyQZe9kjJiSYnTYWyr4b6adZ0qvbijHW8BLKr9isOWnN5limWwZBjOe62cqmxMZe1ObdEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970380; c=relaxed/simple;
	bh=UtOCTThwOblyR5slazuQ5DRaahQq72ajfmyR4avObJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zr4mL0pmGN77EfQipP/5U4XlQOe7xbGJpc7z5kzDEriaWQc2tzvjIi0FbKGORkMnKTRLyffzsn3f7edlOnQi7OwjcLoPVkBrzHF/svU8OMEBYLEb0f7F8BQ7OrHRdYqNEgqF+IxgkQXLgyWY8HFXRlsx0QSSZ2nybp0CPEgsx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gjO5KOjs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNE6m0g010100;
	Mon, 23 Dec 2024 16:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N0YlXv
	pThyCaloTijE44N+X/vXn8K189/uxnRfbTsO8=; b=gjO5KOjszlMa3CE1dvBXXa
	Zcp8iyosndSxa8eReS1uoUGP1nvV+ZWm5+QjuhX6W7w286Tsi2dT59DnBu+qHmVW
	y1K4+d2Gau6M3rpSmQd64ih+Ls1LT2OziM67fXxqM8C9nXWNM6l1bZrrsSazBe1N
	TWQv3cVr0F2QFi5xt9WmhaQFWW5C3iLugiijCRE7WYaqsUe0GzsXnJgDEQLItO91
	5e9aUQ4uh6Hr6Bzn6oLBniXgwko+/XIWiCiQgHBG72p3TarNYmqSG2GwgXBygkJ6
	ucVwqbDxZgg6YcqvjejM5ENbIoHUrlkXvhkYJWyTZFIRtT6Ut6E+MT7lcy6In9dQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q9b4ggby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:11:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNGBUHY022869;
	Mon, 23 Dec 2024 16:11:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q9b4ggbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:11:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNEe4gv020602;
	Mon, 23 Dec 2024 16:11:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p8cy6ee0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:11:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BNGBTlK27394700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 16:11:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5871C5805A;
	Mon, 23 Dec 2024 16:11:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E12A75803F;
	Mon, 23 Dec 2024 16:11:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.210])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Dec 2024 16:11:27 +0000 (GMT)
Message-ID: <984b472672b4ff4b93963700e9c52dc873ea1924.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 02/13] certs: Introduce ability to link to a
 system key
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
Date: Mon, 23 Dec 2024 11:11:27 -0500
In-Reply-To: <20241017155516.2582369-3-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-3-eric.snowberg@oracle.com>
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
X-Proofpoint-ORIG-GUID: zWC_HwY6eOMjnFjJIxS35vwJKxpFNaBC
X-Proofpoint-GUID: t9XBt8-Af9dxcZVpdvCwK2uRSMsNNu_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230143

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Introduce system_key_link(), a new function to allow a keyring to link
> to a key contained within one of the system keyrings (builtin, secondary,
> or platform). Depending on how the kernel is built, if the machine
> keyring is available, it will be checked as well, since it is linked to
> the secondary keyring. If the asymmetric key id matches a key within one
> of these system keyrings, the matching key is linked into the passed in
> keyring.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  certs/system_keyring.c        | 30 ++++++++++++++++++++++++++++++
>  include/keys/system_keyring.h |  7 ++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index e344cee10d28..4abee7514442 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -20,6 +20,9 @@
>  static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
> +#define system_trusted_keys secondary_trusted_keys
> +#else
> +#define system_trusted_keys builtin_trusted_keys
>  #endif
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>  static struct key *machine_trusted_keys;
> @@ -420,3 +423,30 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +
> +/**
> + * system_key_link - Link to a system key
> + * @keyring: The keyring to link into
> + * @id: The asymmetric key id to look for in the system keyring
> + *
> + * Search the system keyrings to see if one of them contains a matching =
"id".
> + * If there is a match, link the key into "keyring".  System keyrings al=
ways
> + * includes the builtin. If any of the following keyrings are enabled:
> + * secondary, machine, and platform they are searched as well.
> + */
> +int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
> +{
> +	struct key *key;
> +
> +	key =3D find_asymmetric_key(system_trusted_keys, id, NULL, NULL, false)=
;
> +	if (!IS_ERR(key))
> +		return key_link(keyring, key);
> +
> +	if (platform_trusted_keys) {
> +		key =3D find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, fal=
se);
> +		if (!IS_ERR(key))
> +			return key_link(keyring, key);
> +	}
> +
> +	return -ENOKEY;
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



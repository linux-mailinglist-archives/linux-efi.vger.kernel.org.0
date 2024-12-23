Return-Path: <linux-efi+bounces-2434-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C141A9FAED5
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 14:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F28164870
	for <lists+linux-efi@lfdr.de>; Mon, 23 Dec 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C4198A36;
	Mon, 23 Dec 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sDnmWTjU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6F46B5;
	Mon, 23 Dec 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734960171; cv=none; b=A0IPawblX4DXgkxXi9TuHOka2WbfyXAoZt32PoGuxIQPS4dHyLXw+8bNZxKb3DBhWaqJlGw57Aunz1wC2obKDm6tP5L/C83CYm2rbQ9huexc6LZD2BJzOUoo7W1NdzyPOuZmGw2kUSMCAh2Kzvoy3iV8E8/QXAiY9ZMPBaPL2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734960171; c=relaxed/simple;
	bh=CY7ULUEktcxb7bamYkQGXj29N7yWje9RXY2qaPrPHvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8FtQp7lGwvXMvHVVRaoS9f5uAxfK2WgV2xHBBHvX1QQQGrFpU8N9tRMpDJavKXXniL3mIBeH4nlb1eO23vGmA1W6ehN0P32GjbFNWdMFop6UPO0o8k2s8/kQFVRcW+C1LROI6btuMifJ0b/drOxV3HtSfP7gO4g+2SE1o3k4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sDnmWTjU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9dTmq008340;
	Mon, 23 Dec 2024 13:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/c4Nm7
	sg2cVOF8w//xiKp7ZsdTuXYYOJCJo/aawRB6o=; b=sDnmWTjUJOzKddET5t4Doo
	aFKpWtjTWktSrcRvWWiKE4CTGTRqGwZvQjPsIMZKXKscjhxyiZ97D7T9A0LUwQui
	p+ZWaDP1S3qd3Lcuih3xQjpDcSvEsjeeXlF1JCvfqQGx4YS8sgYsebxJWnAZHgdv
	gIbQZlmtgP+Qc2dPHQOJL5Vqw+m9n9urJrsecyZZiTdTqC2ZErcUOyEnrsZWVkNf
	tYGZoNAft4YoJ86GFfp86zm9vOybK42CeOr5/+Lb07YnpNMX4oYCghoQrPRZcTfG
	9ybC5qdfQU2Wx8imdPef7qwM9QsmHviY7wxbJ3kN8hKIYLH4sMfsONOimMdg+0Jg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pm84kwu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:21:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BNDFIxj012699;
	Mon, 23 Dec 2024 13:21:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43pm84kwu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:21:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9H8ls002321;
	Mon, 23 Dec 2024 13:21:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43p80sdxwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:21:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BNDLLoe30737034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 13:21:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E583358058;
	Mon, 23 Dec 2024 13:21:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CEB35805B;
	Mon, 23 Dec 2024 13:21:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.114.169])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Dec 2024 13:21:18 +0000 (GMT)
Message-ID: <2e413e587556199c7403ecedef2ed854cd3e6c39.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 01/13] certs: Remove
 CONFIG_INTEGRITY_PLATFORM_KEYRING check
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
Date: Mon, 23 Dec 2024 08:21:17 -0500
In-Reply-To: <20241017155516.2582369-2-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-2-eric.snowberg@oracle.com>
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
X-Proofpoint-GUID: sbOmppHa-sbKqs0AgnwwS539HRIC0BOV
X-Proofpoint-ORIG-GUID: yVV2p4LF8p3a9CrduIMLzaI2EJWjuhss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230117

Hi Eric,

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Remove the CONFIG_INTEGRITY_PLATFORM_KEYRING ifdef check so this
> pattern does not need to be repeated with new code.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Ok. The reason why testing the Kconfig is unnecessary should be included in=
 the
patch description.  For example,

Commit 219a3e8676f3 ("integrity, KEYS: add a reference to platform keyring"=
)
unnecessarily added the Kconfig test.  As platform_trusted_keys is already
initialized, simply use it.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  certs/system_keyring.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..e344cee10d28 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,9 +24,7 @@ static struct key *secondary_trusted_keys;
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
>  static struct key *machine_trusted_keys;
>  #endif
> -#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  static struct key *platform_trusted_keys;
> -#endif
> =20
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> @@ -345,11 +343,7 @@ int verify_pkcs7_message_sig(const void *data, size_=
t len,
>  		trusted_keys =3D builtin_trusted_keys;
>  #endif
>  	} else if (trusted_keys =3D=3D VERIFY_USE_PLATFORM_KEYRING) {
> -#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>  		trusted_keys =3D platform_trusted_keys;
> -#else
> -		trusted_keys =3D NULL;
> -#endif
>  		if (!trusted_keys) {
>  			ret =3D -ENOKEY;
>  			pr_devel("PKCS#7 platform keyring is not available\n");



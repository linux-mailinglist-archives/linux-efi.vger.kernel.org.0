Return-Path: <linux-efi+bounces-2456-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740629FB803
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 01:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52BE7A1CA0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2024 00:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80936186A;
	Tue, 24 Dec 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJConUAX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818A17E4;
	Tue, 24 Dec 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734999519; cv=none; b=GDmvV9oWt6A5QXvaGrmgLGioMPvtISFFEoyr9UUsJnEpSSV8I4P4kTOCTEwf/sPwgzQcWvaFLCjL0QmAEc9+edGviwwExYcQNafRLF172ZN59uJL9Qnj5ANsr32+EkLw2ISva4cDz0VWMih169R7i9k04U70lY5f41CI9yc/YpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734999519; c=relaxed/simple;
	bh=3UhbGILcrWULMLdg1+XW8gVa5bPMXPLhUDrJO/Se/BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzNAnS4fNH/DdBu3qyvQm/fXqtqGCFvKqXHPCqPrF+9vkJ4e8+D0UrZvJ7WbKfLkzcGzYobdbXLN3Z4sUmmQYTN34lHMnOi2fCIunnCJo0glarPPZhgHkSYQVkg5xUCWAx2bZa0jFMl2H0FT5MGXdCnpmU72fGHlyR10k20JZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJConUAX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGUbhx017033;
	Tue, 24 Dec 2024 00:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mH67t9
	Zp7Y1TdkUy6upzvHdJNGON/ZWVFQBBYpDBaR4=; b=TJConUAXqBFGuXUv+ff3/W
	BdjxrsydVNQVaZ1UMg/pU4ogwEJIfTZLGfaXyn9Ziopw4CoUKlNAk9kowjAlSoeV
	EwMnS27do9N4RT+15+YFfW+0NfPSUq0QyyhYGBwU09vhMH8jvnHwHf96+onEZ3ug
	OFbVqZ7uvPlPYfLvZ31DsQp3irImgzg9iel2n7a0zCKQ/TfLFbUm2H7pbT7//Gem
	QYKli4qYBcox7TIjx6eR/X+yx+ECcRJGFd9htjoGkPq+RLTqMwP5UvAoQAcHg6qh
	kV2UwaiQfwnRXLTrXh4/fOgusHH7epH9JWAG2gUx5EJk8sq/rNsOShcKAOYWkV4w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bbcseq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:17:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BO0H6xX012770;
	Tue, 24 Dec 2024 00:17:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43q0bbcsek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:17:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNM56Vg012172;
	Tue, 24 Dec 2024 00:17:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43paq1fg1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 00:17:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO0H43424445506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 00:17:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7DE658059;
	Tue, 24 Dec 2024 00:17:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 885AB5805B;
	Tue, 24 Dec 2024 00:17:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.60.117])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Dec 2024 00:17:02 +0000 (GMT)
Message-ID: <12e2743cfe0c05c613a622ea52a126f48368b896.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 04/13] keys: Add new verification type
 (VERIFYING_CLAVIS_SIGNATURE)
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
Date: Mon, 23 Dec 2024 19:17:02 -0500
In-Reply-To: <20241017155516.2582369-5-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-5-eric.snowberg@oracle.com>
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
X-Proofpoint-ORIG-GUID: RCdIhosAkX66439YbLm7ICKtAfMUR9Ck
X-Proofpoint-GUID: gnh4xadAoPqnCC3cDvda3ru9aAne3kHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=897 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230213

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> Add a new verification type called VERIFYING_CLAVIS_SIGNATURE.  This new
> usage will be used for validating keys added to the new clavis LSM keyrin=
g.
> This will be introduced in a follow-on patch.
>=20
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  crypto/asymmetric_keys/asymmetric_type.c | 1 +
>  crypto/asymmetric_keys/pkcs7_verify.c    | 1 +
>  include/linux/verification.h             | 2 ++
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric=
_keys/asymmetric_type.c
> index 43af5fa510c0..d7bf95c77f4a 100644
> --- a/crypto/asymmetric_keys/asymmetric_type.c
> +++ b/crypto/asymmetric_keys/asymmetric_type.c
> @@ -25,6 +25,7 @@ const char *const key_being_used_for[NR__KEY_BEING_USED=
_FOR] =3D {
>  	[VERIFYING_KEY_SIGNATURE]		=3D "key sig",
>  	[VERIFYING_KEY_SELF_SIGNATURE]		=3D "key self sig",
>  	[VERIFYING_UNSPECIFIED_SIGNATURE]	=3D "unspec sig",
> +	[VERIFYING_CLAVIS_SIGNATURE]		=3D "clavis sig",
>  };
>  EXPORT_SYMBOL_GPL(key_being_used_for);
> =20
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_ke=
ys/pkcs7_verify.c
> index f0d4ff3c20a8..1dc80e68ce96 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -428,6 +428,7 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
>  		}
>  		/* Authattr presence checked in parser */
>  		break;
> +	case VERIFYING_CLAVIS_SIGNATURE:

Add "fallthrough;"

https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=3Dfa=
llthrough#implicit-switch-case-fall-through


>  	case VERIFYING_UNSPECIFIED_SIGNATURE:
>  		if (pkcs7->data_type !=3D OID_data) {
>  			pr_warn("Invalid unspecified sig (not pkcs7-data)\n");
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index cb2d47f28091..02d2d70e2324 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -36,6 +36,8 @@ enum key_being_used_for {
>  	VERIFYING_KEY_SIGNATURE,
>  	VERIFYING_KEY_SELF_SIGNATURE,
>  	VERIFYING_UNSPECIFIED_SIGNATURE,
> +	/* Add new entries above, keep VERIFYING_CLAVIS_SIGNATURE at the end. *=
/
> +	VERIFYING_CLAVIS_SIGNATURE,
>  	NR__KEY_BEING_USED_FOR
>  };
>  extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];



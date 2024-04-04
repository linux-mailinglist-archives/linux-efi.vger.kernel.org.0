Return-Path: <linux-efi+bounces-923-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D989917C
	for <lists+linux-efi@lfdr.de>; Fri,  5 Apr 2024 00:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85CB1F25758
	for <lists+linux-efi@lfdr.de>; Thu,  4 Apr 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5716FBB7;
	Thu,  4 Apr 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4oH4Elk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB453362;
	Thu,  4 Apr 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270458; cv=none; b=dsPhNhicpc2ZGc7DZqpwLYEf3a4MF389bBRF3Upk4CjXCLRNbUQSUP6RrP/PsoHVhd0suacyVN5S73GqWOH1hJk9Sny4eCnNRGrAZp7f/Na7jFaodGp5v5X7BgjswgwPlpQIV2WWhiKrDP7CF94OyYOF1G14qSbCx5raTUOiitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270458; c=relaxed/simple;
	bh=DoIlRKwTL8vbnbGM7jECgkzATCO3fQBe1AnqLyBEHww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=hvdtWGLiPm557JGiRinvU0n83l4s9VspQxBgj3bLHtX0yDFcsDc+60+DVOkaVEPTRXXHVq/dO4S2x49e476/+1LNzgD2Gv+PzaecoGKrQ4nhxNn2HGMFYuMKUTmVJw/DPCPI9bwgEKs7TMPxhdyZ6ySWOY9P7vOXi7n7GPWcD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4oH4Elk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434McIDm029658;
	Thu, 4 Apr 2024 22:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tQRre0KXLGsI11sDwmF5qub2ia0q8UziRDhc9OD5urk=;
 b=M4oH4ElkTj3nRz/tWL9Kff0Xl88bJ/Rs677rlZiTTNDA19IJBT8tOpddOdjP8nKzUXWs
 fEOWkVSANpGC5FcBGZTu5i1OtA1f6weWKP9cWRRQCwSFpcwLNh3JBenmFL2VBA2IK1Z2
 b1YgHJTT9BPSq5LsFlIPdInLv+ijO/n9tQnp2pYNaufpc29BW1snzyWNERcTdgehKvLT
 LyNb2N4VmJbDMYsQqrsoXEIgBnbYEJLtZXwVwptoM2Hkp0eoX937LrPPB9CTzLWCOY66
 DwFokZ687u/NljptomUpJGRhwEVbdTKrfEY1li52sigLAiP/tIrvsBYmjFnIdd9CWt2S qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xa55mg059-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 22:40:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434MeKfs032203;
	Thu, 4 Apr 2024 22:40:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xa55mg056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 22:40:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434MZIZf003659;
	Thu, 4 Apr 2024 22:40:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epyf1js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 22:40:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434MeGZY13107966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 22:40:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A487A5803F;
	Thu,  4 Apr 2024 22:40:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2CC658062;
	Thu,  4 Apr 2024 22:40:14 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.110.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 22:40:14 +0000 (GMT)
Message-ID: <c3267eef03fd3e8bffe77c86debd9353627108c1.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, mic@digikod.net,
        casey@schaufler-ca.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date: Thu, 04 Apr 2024 18:40:14 -0400
In-Reply-To: <20240311161111.3268190-2-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
	 <20240311161111.3268190-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: shsqQcvZE4KgIF-sF57SvAQTIjirUnrg
X-Proofpoint-GUID: FvgZr0pLBBrRXAv1oxnxukm3-50-AxWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_19,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040163

Hi Eric,

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..b647be49f6e0 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -426,3 +426,32 @@ void __init set_platform_trusted_keys(struct key
> *keyring)
>  	platform_trusted_keys = keyring;
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
> +
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	tkey = find_asymmetric_key(secondary_trusted_keys, id, NULL, NULL,
> false);
> +#else
> +	tkey = find_asymmetric_key(builtin_trusted_keys, id, NULL, NULL, false);
> +#endif
> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	tkey = find_asymmetric_key(platform_trusted_keys, id, NULL, NULL,
> false);
> +
> +	if (!IS_ERR(tkey))
> +		goto found;
> +
> +	return -1;

Normally "goto" is for the error.  Invert the logic. 

Mimi

> +
> +found:
> +	key_link(keyring, tkey);
> +	return 0;
> +}
> 







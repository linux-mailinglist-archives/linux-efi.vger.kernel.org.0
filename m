Return-Path: <linux-efi+bounces-2789-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF726A32613
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 13:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816F03A5CF7
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4420D4EB;
	Wed, 12 Feb 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bU3Rd2tJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC9F20C487;
	Wed, 12 Feb 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364280; cv=none; b=eC1V6NbN2D+wZehPEJirz05q/pZ15BReOilCNivm5qtY+PYXnFSXkNR9Tqiz9orfJ7q1oDNJwSBDmPrUE+X+SOvLWRRQHvBPPBv+lU3gsBQ8UgjYNtHW8iUpJMiMltXaV+spXzqhoZPDQ+aK9N6/ZP0qsQBw7cwHrBNG+w8i89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364280; c=relaxed/simple;
	bh=+mhHkXqhc4VDwPi7MLWcNjZdhTc4zZo0gwq+T5cTOIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qt0m9RiwmHpRLQ+XABRLF70jn5Z3s8Omob7SQxcEzofj9DsdXtgtXADQGaShYhHZ8Nzjt6U/VYRJA+MqLDmALy3uzGNLld4J3hmKFLToTVHkIFZefFDFRhKpoHc0QFLmC0CyoXPE1ncwS+jdmU4MIe0C4OfW7hVFgDo4meB9P3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bU3Rd2tJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CBpiSd013640;
	Wed, 12 Feb 2025 12:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+mhHkX
	qhc4VDwPi7MLWcNjZdhTc4zZo0gwq+T5cTOIY=; b=bU3Rd2tJlFFQqu5BV1YnSW
	tkSX87Qk0oNHNsqBvOCKKjQZaMiiiZktgkFwm6RXdYLRIRz3064de3ZJXTpXluHu
	jR03F9uRrZfaZigIPn78pnGDR9HygsJhvJ5DYCArhv2PG3aDrjD9XnfD+jBDYhlz
	xI8W+J8GZ+nTiq+IF6s6C8efmO99g52z7VbIvRvo7u/PcEmBojze6dbCKo6XXUlL
	j/3GiABLIEtJd6Ef0p7jqIKghjbxcTQr0y0HzxcxSdS0S7J5xaN+VGT0Pq9ntVu1
	f6RR3BKMvXasb0aO6cNUobfx/7R+rEz600ZMWb7fDBrUlrWX8HgZMXek6yAfaF7A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa3bm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 12:43:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51CCK66g021894;
	Wed, 12 Feb 2025 12:43:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa3bky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 12:43:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CCdn11028217;
	Wed, 12 Feb 2025 12:43:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyygqa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 12:43:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CCh1wq27132606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 12:43:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3245805F;
	Wed, 12 Feb 2025 12:43:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3039258051;
	Wed, 12 Feb 2025 12:43:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.88])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 12:43:00 +0000 (GMT)
Message-ID: <6f7120f292a7863e7c69d3cb49f224efd12ee629.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 07/13] keys: Add ability to track intended usage
 of the public key
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>,
        Eric Snowberg
	 <eric.snowberg@oracle.com>
Cc: linux-security-module@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net,
        ardb@kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        mic@digikod.net, casey@schaufler-ca.com, stefanb@linux.ibm.com,
        ebiggers@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date: Wed, 12 Feb 2025 07:42:59 -0500
In-Reply-To: <Z6UU7anXtW43AhNR@kernel.org>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-8-eric.snowberg@oracle.com>
	 <Z6UU7anXtW43AhNR@kernel.org>
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
X-Proofpoint-GUID: WPOio9vJuKimRSeTX5erqwTICYwt3Uiv
X-Proofpoint-ORIG-GUID: PANYEldy6s1JY0QEJs3RxZgvBxokQCaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=923 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120097

On Thu, 2025-02-06 at 22:13 +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 17, 2024 at 09:55:10AM -0600, Eric Snowberg wrote:
> > Add two new fields in public_key_signature to track the intended usage =
of
> > the signature.=C2=A0 Also add a flag for the revocation pass.=C2=A0 Dur=
ing signature
> > validation, two verifications can take place for the same signature.=C2=
=A0 One
> > to see if it verifies against something on the .blacklist keyring and
> > the other to see if it verifies against the supplied keyring. The flag
> > is used to determine which stage the verification is in.
> >=20
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>=20
> Mimi, was this the patch set you asked to look at while ago?</offtopic>

Yes, in particular please take a look at Paul's comment on 00/13.

Mimi


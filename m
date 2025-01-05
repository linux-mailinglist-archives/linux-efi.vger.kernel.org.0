Return-Path: <linux-efi+bounces-2504-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A8A01948
	for <lists+linux-efi@lfdr.de>; Sun,  5 Jan 2025 12:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37119162DC9
	for <lists+linux-efi@lfdr.de>; Sun,  5 Jan 2025 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CC148FF6;
	Sun,  5 Jan 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V8Bisobr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D7481AF;
	Sun,  5 Jan 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736077452; cv=none; b=FUPCJJ1g8LXrkh3EqfsPi+Luf4XMh2RY8WxpLJDHfnRi33v+L0QnLfGRNPUtGc/Ewl5oPOpHXeXT5FuUUxA/j0fgrKJP9YaM1i/egzy9pXHjF6DbXYHz3j4RhUxog2g3HhaULv27az9d2Dvyi1VfmygPbtwXU3lVChvarAVibyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736077452; c=relaxed/simple;
	bh=xkfgb6Sd1ulgJ7/LliRmwusBTtMnmiO1ZANLHq5aNug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KkguIz5a7/ZYMk2tOfaLYTVK/KSfOlaydKiF1+Aigt0EWzqHGHTaNB9sAhCkIS987nIdlqx/r6dtKWP8MREnzL4uwWuQGZJ299e2eZGsRA3FMZdftD5Si2yfiXGtQnHui0QOde4Twq3erVQRK5QsJfRL5rehzTxyWkj/lxgP2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V8Bisobr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5055kYie031524;
	Sun, 5 Jan 2025 11:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ztQZpw
	rvYpm8N90TBeMAKwI8i1YzUMJ+VrLWH0M4IrM=; b=V8Bisobr9DPhIycEZO/yK3
	8reJj0b7Hyq1SWeB6cg9/f+C3EOk05uzch3bBpKmek8Ptt6mUIzFpuS/mM4mWoyk
	WX+eXS5G1u7OfynjpgEGgcbmZKhnzQ9AHR4D09UVKNnjDYeC4+wcz9GZ1QtNeOcd
	krlZgBYC5lsQEwIjUoMyQTJTsplxJPPyuy4Y0jp8xpx+9WR0rplndmNkeeYDcSq4
	zCWrBAhme8W+Hq2kx7lE0TssN3ndWhInVRAqTKRqpO8F4LyzNJDXu0ySQU0cNLK1
	VAVQ72vdKZczQWOeTKm+4j7pSiNCSvDJip25Dgm40NzMb7gj9NSeVpTK0W1+qqtA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yeta9mq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 11:43:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 505BhRjI000960;
	Sun, 5 Jan 2025 11:43:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yeta9mpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 11:43:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50590b3R026183;
	Sun, 5 Jan 2025 11:43:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj11s8xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 11:43:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 505BhQ3g42730114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Jan 2025 11:43:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D729358068;
	Sun,  5 Jan 2025 11:43:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6434B5805A;
	Sun,  5 Jan 2025 11:43:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.62.226])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Jan 2025 11:43:24 +0000 (GMT)
Message-ID: <f6be3ecad5695090658e49e8f456ae9e47d757c0.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
 <ardb@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org"
 <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "mic@digikod.net"
 <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "stefanb@linux.ibm.com" <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org"
 <ebiggers@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Sun, 05 Jan 2025 06:43:24 -0500
In-Reply-To: <13BE76D4-9001-4D80-A4AF-4DE63827E05A@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-4-eric.snowberg@oracle.com>
	 <0dcd6ccea49026950608d8ddde5700ace84a2548.camel@linux.ibm.com>
	 <13BE76D4-9001-4D80-A4AF-4DE63827E05A@oracle.com>
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
X-Proofpoint-GUID: sig2SoG3AAGaYXx8mtGO7hvUTP29djQ5
X-Proofpoint-ORIG-GUID: AoU9_S5OgzMIiXM9Pq47Sjgz1XjNymLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=650 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501050106

Hi Eric,

On Fri, 2025-01-03 at 23:27 +0000, Eric Snowberg wrote:
> > > +config SECURITY_CLAVIS
> > > + bool "Clavis keyring"
> >=20
> > Isn't SECURITY_CLAVIS the new LSM?=C2=A0 Why is the bool defined as jus=
t "Clavis
> > keyring"?
> >=20
> > > + depends on SECURITY
> > > + select SYSTEM_DATA_VERIFICATION
> > > + select CRYPTO_SHA256
> > > + help
> > > +=C2=A0=C2=A0 Enable the clavis keyring. This keyring shall contain a=
 single asymmetric key.
> > > +=C2=A0=C2=A0 This key shall be linked to a key already contained in =
one of the system
> > > +=C2=A0=C2=A0 keyrings (builtin, secondary, or platform). One way to =
add this key
> > > +=C2=A0=C2=A0 is during boot by passing in the asymmetric key id with=
in the "clavis=3D" boot
> > > +=C2=A0=C2=A0 param.=C2=A0 This keyring is required by the Clavis LSM=
.
> >=20
> > If SECURITY_CLAVIS is a new LSM, the 'help' shouldn't be limited to jus=
t the
> > clavis keyring, but written at a higher level describing the new LSM.=
=C2=A0 For
> > example,
> >=20
> > This option enables the Clavis LSM, which provides the ability to confi=
gure and
> > enforce the usage of keys contained on the system keyrings -
> > .builtin_trusted_keys, .secondary_trusted_keys, .machine, and .platform
> > keyrings.=C2=A0 The clavis LSM defines a keyring named "clavis", which =
contains a
> > single asymmetric key and the key usage rules.
> >=20
> > The single asymmetric key may be specified on the boot command line ...
> >=20
> > [The patch that introduces the key usage rules would add additional inf=
o here.]
> >=20
> > [The patch that adds the Documentatoin would add a reference here.]
>=20
> I went the route of creating the keyring in this patch and then introduci=
ng the=20
> LSM which uses it in a later patch.=C2=A0 My reasoning was it can be test=
ed=20
> independently.=C2=A0 Also, I thought it would make it easier to review, s=
ince=20
> everything isn't contained within a single patch.=C2=A0 I could look at c=
ombining=20
> them together if you think that would be better.

SECURITY_CLAVIS is not just about the CLAVIS keyring, right?  The Kconfig c=
an be
defined and used here, but eventually the SECURITY_CLAVIS "help" needs to b=
e
updated to describe the new LSM.

thanks,

Mimi


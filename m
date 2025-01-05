Return-Path: <linux-efi+bounces-2505-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0714A01980
	for <lists+linux-efi@lfdr.de>; Sun,  5 Jan 2025 14:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2051882DE7
	for <lists+linux-efi@lfdr.de>; Sun,  5 Jan 2025 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90914F9EE;
	Sun,  5 Jan 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AxUZnk5L"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13F150980;
	Sun,  5 Jan 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082017; cv=none; b=IDrQ3MGk1B0WX5pqsPfhxiU13LyZQTeVJxBUT6bch78O561044ehgQQfg6EW2GjjHY5h+Dor2gE1T4v1kyiX6xps8fqE4DTynH+VkuAGWv+XScGqw7sWMgza+O1j/5o9g6SxcFnOuJnrT09aSSbU3S2BBHXgRJJFMuQ1UQMYoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082017; c=relaxed/simple;
	bh=gvis4SR/MbP0rEJuqQir65QphJBwsZNDw6ueWCgw5gE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3WW/jYb/nomWtSo3NXob9EC6JDSiBE2YeykbfDDkrYwEo0g6ckR2TIFUJWjd87xlWGuZxdPh6CHMIA3vLLCy9cvgslY9uNyn1QIRH7wdu3v47gzIOsA2zEySjpvX6boTd8Ev5xiJTp/3NiOGIzEsOB+4+4SoCAd7r5XUBfWfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AxUZnk5L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505BkLhn011998;
	Sun, 5 Jan 2025 12:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sXijJM
	kyzCgi7iVH4zfN3oNlQTg/BGz4Ny95xTicY6o=; b=AxUZnk5LYvj61dQJDgiDZm
	JHAf+y5VSL5pW5lkmRsvuzotCmW6d3eviKTIgaWUrbzbFB9KSZa5nLDlDkjApu4a
	VpZHLV8SBpcTZcg/M7C8fcvUPBCAr50ykFVHYtl0Yty+YW3ViQ2gP/mODmNcK+i7
	Snek47nN/PYO5GCispAbLUbDhNeNJbhXbzLFlKYH0HcSCt486SxHUjz6TCdfiYf+
	jMNvlC7oG3Aeu8zFh/E/ZlUTnq3tClTH2RvcBatWbyYGcSjR29GhDY9vLp1wnRh5
	J5tnV/rcoGwjs61ImOB0856JP55kubN0U0rS7efa12osu7xqvQfviv5A6M9pzwEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yf4h1x63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 12:59:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 505Cxf7E011565;
	Sun, 5 Jan 2025 12:59:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yf4h1x5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 12:59:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 505Bue26008970;
	Sun, 5 Jan 2025 12:59:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyhvrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Jan 2025 12:59:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 505CxdRp20447920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Jan 2025 12:59:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 462175805A;
	Sun,  5 Jan 2025 12:59:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF1458051;
	Sun,  5 Jan 2025 12:59:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.62.226])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Jan 2025 12:59:37 +0000 (GMT)
Message-ID: <f7f82ef6ed63b91739e9c10cc34ea9931690aeff.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ardb@kernel.org"
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
Date: Sun, 05 Jan 2025 07:59:37 -0500
In-Reply-To: <6DDCFABC-8440-4316-98D4-E3F5C9532925@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-9-eric.snowberg@oracle.com>
	 <0d71ffced35abf40bbfadb6e03b053c24757183d.camel@linux.ibm.com>
	 <6DDCFABC-8440-4316-98D4-E3F5C9532925@oracle.com>
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
X-Proofpoint-GUID: sthn3heN-F8elAPpIVeydWkNYF6OSDI1
X-Proofpoint-ORIG-GUID: sd254BjKuFHqdxrpjccUdOhjZwxzLQpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501050121

On Fri, 2025-01-03 at 23:32 +0000, Eric Snowberg wrote:
>=20
> > On Dec 24, 2024, at 10:43=E2=80=AFAM, Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> >=20
> > On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> > > Introduce a new LSM called clavis.  The motivation behind this LSM is=
 to
> > > provide access control for system keys.  The access control list is
> > > contained within a keyring call .clavis.  During boot if the clavis=
=3D boot
> > > arg is supplied with a key id contained within any of the current sys=
tem
> > > keyrings (builtin, secondary, machine, or platform) it shall be used =
as
> > > the root of trust for validating anything that is added to the ACL li=
st.
> > >=20
> > > The first restriction introduced with this LSM is the ability to enfo=
rce
> > > key usage.  The kernel already has a notion of tracking key usage.  T=
his
> > > LSM adds the ability to enforce this usage based on the system owners
> > > configuration.
> > >=20
> > > Each system key may have one or more uses defined within the ACL list=
.
> > > Until an entry is added to the .clavis keyring, no other system key m=
ay
> > > be used for any other purpose.
> > >=20
> > > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > ---
> > > Documentation/admin-guide/LSM/clavis.rst      | 191 +++++++++++++++++=
+
> > > MAINTAINERS                                   |   7 +
> > > crypto/asymmetric_keys/signature.c            |   4 +
> > > include/linux/lsm_count.h                     |   8 +-
> > > include/linux/lsm_hook_defs.h                 |   2 +
> > > include/linux/security.h                      |   7 +
> > > include/uapi/linux/lsm.h                      |   1 +
> > > security/Kconfig                              |  10 +-
> > > security/clavis/Makefile                      |   1 +
> > > security/clavis/clavis.c                      |  26 +++
> > > security/clavis/clavis.h                      |   4 +
> > > security/clavis/clavis_keyring.c              |  78 ++++++-
> > > security/security.c                           |  13 ++
> > > .../selftests/lsm/lsm_list_modules_test.c     |   3 +
> > > 14 files changed, 346 insertions(+), 9 deletions(-)
> > > create mode 100644 Documentation/admin-guide/LSM/clavis.rst
> > > create mode 100644 security/clavis/clavis.c
> > >=20
> > > diff --git a/Documentation/admin-guide/LSM/clavis.rst b/Documentation=
/admin-guide/LSM/clavis.rst
> > > new file mode 100644
> > > index 000000000000..0e924f638a86
> > > --- /dev/null
> > > +++ b/Documentation/admin-guide/LSM/clavis.rst
> > > @@ -0,0 +1,191 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=3D=3D=3D=3D=3D=3D
> > > +Clavis
> > > +=3D=3D=3D=3D=3D=3D
> > > +
> > > +Clavis is a Linux Security Module that provides mandatory access con=
trol to
> > > +system kernel keys (i.e. builtin, secondary, machine and platform). =
These
> > > +restrictions will prohibit keys from being used for validation. Upon=
 boot, the
> > > +Clavis LSM is provided a key id as a boot parameter.  This single ke=
y is then
> > > +used as the root of trust for any access control modifications made =
going
> > > +forward. Access control updates must be signed and validated by this=
 key.
> > > +
> > > +Clavis has its own keyring.  All ACL updates are applied through thi=
s keyring.
> > > +The update must be signed by the single root of trust key.
> > > +
> > > +When enabled, all system keys are prohibited from being used until a=
n ACL is
> > > +added for them.
> >=20
> > Until the single key has been loaded, Clavis is not enabled.  Any key o=
n the
> > system trusted keyrings remains usable for any purpose.
> >=20
> > -> When enabled, meaning the single key has been loaded onto the Clavis=
 keyring,
> > all system keys are prohibited ...
> >=20
> > Until clavis is enabled, in my opinion the defaults should be restricti=
ve (e.g.
> > CONFIG_INTEGRITY_CA_MACHINE_KEYRING,
> > CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN). Once Clavis is ena=
bled,
> > based on a new helper function is_clavis_enforced() we could consider r=
elaxing
> > some of the existing keyring requirements (e.g. kernel modules).

For example, kernel/module/signing.c: mod_verify_sig() would be updated to =
check
whether Clavis is configured and enabled and then search/use keys on the ot=
her
system keyrings.

>=20
> If I made this change, would it be acceptable to update the Kconfig=20
> description for CONFIG_INTEGRITY_CA_MACHINE_KEYRING and CONFIG_SECONDARY_=
TRUSTED_KEYRING_SIGNED_BY_BUILTIN=20
> that the restriction only applies when Clavis is not enabled?  You don't=
=20
> think there would be push back that those restrictions are not always=20
> being enforced?

Instead I would add a Kconfig "Note:" indicating that enabling Clavis relax=
es
the requirement that the key exists on the system trusted
.secondary_trusted_keys keyring.

thanks,

Mimi


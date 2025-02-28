Return-Path: <linux-efi+bounces-2860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC2A49B87
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605FC3B2C7F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846226E970;
	Fri, 28 Feb 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RqFyqPgU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506426E174;
	Fri, 28 Feb 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751777; cv=none; b=RcF9fi6mgD8bXQQTnAmLb4LNmdHlEJ/uSHx6168Bks/Opql3j+QqvxLv56tPJQyGFIV4C/q7ArNU3tFdj+B83pHm/PWtMg5+ttRXqUAiA1vl+xd73+vajTyObAURGfa8gHO0EUtxeD3V5+t/ky8F3kMRFp6B3A8Um+h+ccrXRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751777; c=relaxed/simple;
	bh=qwiwX7ilQe4AxIwbOiZQdwGCH/mPZg+/LA5+GbPnb5U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=VouxBkWoXTIaJ01NzGtUrbr7b3qNFeS3d5UikIffsYEaF9H0/yOf7uHEQe2TENHUOZsScAC1M1VcEbFwV11QXyJrOLqB9We3Z1lfmrDOaIXoMfVEpQMSVoepibXKjeDRFQggtwpInw2ttdNPUr7cKZRfZgFs27LRwldxCFSukSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RqFyqPgU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S6PdnB031358;
	Fri, 28 Feb 2025 14:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZlHYAH
	d+v8kB7zXgWIauJWsRMxKuy43e8Nv9TXFnhUM=; b=RqFyqPgUfhgKOXFJ0rsDX4
	p/NdL5k3rUXrWw2VgUmuMAr0IqF9jU/mXxvUcNw8baXqrxqHDbKq01WK8Zd/hjhc
	LOlhaC2zZkLUUxJC2qTiLpIjWmAKLB5xxdUrdtLVF0MxH8eT4UYpo6/Jwcvz15NT
	BQvT4yX2wIh0NH/E0D+k3951W1+j/18BlRUuSyZJtpD/Tq5fN/sk9UFlllviIv7r
	OYBqX1+U7ZszZa3krlqdtRvKtfkU1p7EFkFQ1DtHbxLf9VVQtjzdBCRr4sIe4xAw
	ly4eyTRb4gQP+O33cUeohn6ikqw3eC2vv9f9EbuCvLDom3dxRuF4/eyTwj0DmOaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6j1xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 14:09:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SDxGMS020959;
	Fri, 28 Feb 2025 14:09:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6j1xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 14:09:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDiGDU026269;
	Fri, 28 Feb 2025 14:09:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnxsuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 14:09:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SE92Uv25231764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 14:09:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6315D5806A;
	Fri, 28 Feb 2025 14:09:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F77558061;
	Fri, 28 Feb 2025 14:09:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.61.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 14:09:01 +0000 (GMT)
Message-ID: <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells
 <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David
 Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>,
        "Serge
 E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan Berger
 <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
In-Reply-To: <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
	 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
	 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
	 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
	 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
	 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
	 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 09:08:33 -0500
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AeDZ_ey0lISVUY625VsQIU2sGo9yqqm5
X-Proofpoint-GUID: ZodbjM8bn3G8bxv9jpetEvBt5Lej-tp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=870 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280102

On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> On Thu, Feb 27, 2025 at 3:41=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Mon, 2025-01-06 at 17:15 +0000, Eric Snowberg wrote:
> > > > On Jan 5, 2025, at 8:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com=
> wrote:
> > > > On Fri, Jan 3, 2025 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >=20
> > > > > Regardless, back to Clavis ... reading quickly through the cover
> > > > > letter again, I do somewhat wonder if this isn't better integrate=
d
> > > > > into the keyring proper; have you talked to both David and Jarkko
> > > > > about this?
> > > >=20
> > > > I realize I should probably expand on my thinking a bit, especially
> > > > since my comment a while regarding LSMs dedicated to enforcing acce=
ss
> > > > control on keys is what was given as a reason for making Clavis a L=
SM.
> > > >=20
> > > > I still stand by my comment from over a year ago that I see no reas=
on
> > > > why we couldn't support a LSM that enforces access controls on
> > > > keyrings/keys.  What gives me pause with the Clavis LSM is that so
> > > > much of Clavis is resident in the keyrings themselves, e.g. Clavis
> > > > policy ACLs and authorization keys, that it really feels like it
> > > > should be part of the keys subsystem and not a LSM.  Yes, existing
> > > > LSMs do have LSM specific data that resides outside of the LSM and =
in
> > > > an object's subsystem, but that is usually limited to security
> > > > identifiers and similar things, not the LSM's security policy.
> >=20
> > Hi Jarkko, David,
> >=20
> > Both Paul's and my main concerns with this patch set is storing policy =
in the
> > keyring.  We would appreciate your chiming in here about storing key po=
licy in
> > the keyring itself.
>=20
> I'd still also like to see some discussion about moving towards the
> addition of keyrings oriented towards usage instead of limiting
> ourselves to keyrings that are oriented on the source of the keys.
> Perhaps I'm missing some important detail which makes this
> impractical, but it seems like an obvious improvement to me and would
> go a long way towards solving some of the problems that we typically
> see with kernel keys.

The proliferation of keyrings won't solve the key usage problem for IMA-
appraisal.  IMA-appraisal can be used to verify the kexec image, kernel mod=
ules,
firwmare, etc, but it also verifies file signatures contained in userspace
packages.  To support the latter case, keyrings would need to be applicatio=
n
specific.  (This version of Clavis doesn't solve the latter key usage for I=
MA-
appraisal either.)

The keys baked into the kernel are trusted because the kernel itself was si=
gned
and verified (secure boot).  Anyone building a kernel can build a key into =
the
kernel image, which establishes a "root of trust".  That key can then be us=
ed to
verify and load other keys onto the IMA keyring.

The problem is how to safely establish a root of trust without baking the k=
ey
into the kernel image and then limiting that trust to specific usages or
applications.

Mimi


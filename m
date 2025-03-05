Return-Path: <linux-efi+bounces-2893-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E1A4F49B
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 03:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E518890CE
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B3155300;
	Wed,  5 Mar 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxLpUloY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90FBA33;
	Wed,  5 Mar 2025 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141251; cv=none; b=JXAPYrrFQlgvp7kQ96JtuLR0jooYpQXtheQww0kXjlZg6kI42U6O6RlMtYiuh0UsqNgVTpW5uzbfTBAKal8FF1atIoKu3h2TaAUOYv44npot869CyJ+BXgwJIvkEMgO+rqTT2O8b9pQEDwTQIx8cT2devaYbdhoLu1GZomJm7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141251; c=relaxed/simple;
	bh=DEwvgwSbkSKjwlGb8RKq+vjVIuLkEnP0M6uNU6COGgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUXAgoAebzA+Wn/ZLOFSW6Uji6DqzXmo6HESYgVQltbEn7oLNlibb7YGTqa78dSAw/p7JURRafe+f1eN3DPB7Q3TBOsB3R5R2PlH8I4yPz/LnjHJgX0QR/173vL0zjSrer8rV38U+GiDVHTTwrQV9i4clhxzbJ+npK66OZnyAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxLpUloY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524F3wKJ021557;
	Wed, 5 Mar 2025 02:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UEHyv1
	UMd8svf8497SlYa3GAV3U/iyxZlBpB+YXJRv4=; b=DxLpUloY82YtPCtmYjoa6X
	cykY/W6/bYfi5NK/BN1DdhK7c0ommRHOaA7bfPJVhlzPBJSrvkvlSnJoQBPDdS10
	6SX3JngCdHBTMmAcL/7pmzZhmUhjauMu4B032CDyVv2NNmYwzfVYhhY8eoxrsNKg
	Tw6U2+RKlqjx9m7c21D3KpqSgJzefeKbeeSPBsN7zPax93dptrLQhWEjKXNhbSAA
	cZeJvCB2R8caAdYPFhOAXhpWnbS7Ivf+nRUMY2DDUMaoW87km7foh7yi8MpCJNOQ
	GbjYAkMOLT198SCnLu7sm7IzjTumtHYWoRAfVAcGl4qUOGHxwLQ++5tBdK6IqDJQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7nsk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 02:20:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5252DXvR003512;
	Wed, 5 Mar 2025 02:20:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455sw7nsk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 02:20:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5251gVHj000362;
	Wed, 5 Mar 2025 02:20:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt0ruf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 02:20:18 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5252KIW425035504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 02:20:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D3158055;
	Wed,  5 Mar 2025 02:20:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C77F958054;
	Wed,  5 Mar 2025 02:20:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.117.76])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 02:20:15 +0000 (GMT)
Message-ID: <b464675506fa8d7ccef737d3bcddd0ec26b9b2c3.camel@linux.ibm.com>
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
Date: Tue, 04 Mar 2025 21:20:15 -0500
In-Reply-To: <CAHC9VhRrko_CdZJg81=s-ShGfusaJqhvrX8+R6STPbMhpnEwCQ@mail.gmail.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
	 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
	 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
	 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
	 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
	 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
	 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
	 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
	 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
	 <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
	 <CAHC9VhSzc6N0oBesT8V21xuwB11T7e6V9r0UmiqHXvCg5erkVA@mail.gmail.com>
	 <a1d6ce786256bbade459f98e0b4074e449048fee.camel@linux.ibm.com>
	 <CAHC9VhT27Ge6woKbBExu2nT_cQE79rG+rrgp3nDYjvjcztVQXg@mail.gmail.com>
	 <049a04b2e07e9e984ada32277cbbde42bdf7bb1b.camel@linux.ibm.com>
	 <CAHC9VhRrko_CdZJg81=s-ShGfusaJqhvrX8+R6STPbMhpnEwCQ@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: Q-zdvcvbBeLNCLsw1PdLVf31hw2jci3l
X-Proofpoint-GUID: QXPI0DVpMOZnc9RxeOZRYHa2sGYwbbH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=838 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050013

On Tue, 2025-03-04 at 21:09 -0500, Paul Moore wrote:
> On Tue, Mar 4, 2025 at 8:50=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> > On Tue, 2025-03-04 at 19:19 -0500, Paul Moore wrote:
> > > On Tue, Mar 4, 2025 at 7:54=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > > On Mon, 2025-03-03 at 17:38 -0500, Paul Moore wrote:
> > > > > On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linux.=
ibm.com> wrote:
> > > > > > On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > > > > > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@lin=
ux.ibm.com> wrote:
> > > > > > > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > Ok, let's go through different scenarios to see if it would sca=
le.
> > > > > >=20
> > > > > > Scenario 1: Mostly distro signed userspace applications, minimu=
m number of
> > > > > > developer, customer, 3rd party applications.
> > > > > >=20
> > > > > > Scenario 2: Multiple developer, customer, 3rd party application=
s, signed by the
> > > > > > same party.
> > > > > >=20
> > > > > > Scenario 3: extreme case - every application signed by differen=
t party.
> > > > > >=20
> > > > > > With the minimum case, there would probably be a default key or=
 sets of
> > > > > > permissible keys.  In the extreme case, the number of keyrings =
would be
> > > > > > equivalent to the number of application/software packages.
> > > > >=20
> > > > > Perhaps we're not understanding each other, but my understanding =
of
> > > > > the above three scenarios is that they are all examples of signed
> > > > > applications where something (likely something in the kernel like=
 IMA)
> > > > > verifies the signature on the application.  While there are going=
 to
> > > > > be differing numbers of keys in each of the three scenarios, I be=
lieve
> > > > > they would all be on/linked-to the same usage oriented keyring as=
 they
> > > > > all share the same usage: application signatures.
> > > >=20
> > > > Yes they're all verifying file signatures, but the software package=
s are from
> > > > different sources (e.g. distro, chrome), signed by different keys.
> > >=20
> > > Yep.
> > >=20
> > > > Only a
> > > > particular key should be used to verify the file signatures for a p=
articular
> > > > application.
> > >=20
> > > That's definitely one access control policy, but I can also envision =
a
> > > scenario where I have just one keyring for application signatures wit=
h
> > > multiple keys from multiple vendors.
> >=20
> > Having a single keyring with keys from multiple software vendors is the=
 status
> > quo.
>=20
> A single keyring with keys from multiple vendors does happen today
> yes, but there is no separation based on how those keys are used, e.g.
> separate application signature and kernel module signature keyrings.

As soon as you add multiple vendors keys on the kernel module signature key=
ring,
you'll need finer grained access control.

Mimi





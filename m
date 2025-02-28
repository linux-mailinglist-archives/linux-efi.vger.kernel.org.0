Return-Path: <linux-efi+bounces-2865-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2383A4A01F
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 18:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CB817423D
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0F1F0993;
	Fri, 28 Feb 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sQf6Jlti"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0261F4CBB;
	Fri, 28 Feb 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763147; cv=none; b=Hk5qQa08q00dMHp32vSPefhSHPIQhCUEQbGu1NRD7XO+bOIO0/h4LhY+3++yZhx8VbmJFiEH/IXUkfEDCA3UliM73ZQJ/WqxHv1mCC1VP+WrV52GLcMQiJEX6b5jP6gTe4ICgARgSxvP2C/FHzBlCDLdiFBb731S5ZmyJhLs8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763147; c=relaxed/simple;
	bh=tFPUAOZ7VH1fyKHvn2KCF+e0JSHMFVJ/lWU5iQYMW5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pF+ZLvCeLyMXy8uJVfB1tSulvra1Vxvh0rue+ljEERWyihYvDM3sI6NOEEHXm4FAd24wVq+TYi+fpYPsKbKm/9n37LaP5toShzVE6Wk42aZis4WwZVihqOncbsofBXUwLC4/ZNhWRS4Y0SXVN3J+39i92I3kg0PTf2Hq5ygEP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sQf6Jlti; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEM8nw031285;
	Fri, 28 Feb 2025 17:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AfJZZ4
	P8aLFKGjvF5SbiLt3OZTgxhSBB2nnR1vftcKY=; b=sQf6Jlti7VgvaEF5HtqGcQ
	nLyvJfOsKzHcaHX3djJ2wlJnnfwlU+0yy9vCyz1FntJvwjbI5mIz8dkSoaqYGvBL
	CGPFed783c+SBA8wKaITOOGSPjecDzoS9iuQH3gl6xYEpVjCs74ejmvsQfmLUT0n
	uW0CEULQTLktoOY3tACimNP5Wi40CeNQ0vcAfXTZdlFbnJpD6u0qfF43z8dUtcfB
	6siESRvkRF+oQIN/0G6S6iC0+r2HOn6Imj9wg/o1AOnDqZKdt0G5Ju1zXbgacUA1
	zRRGwNKcHCLYNpVH5T45tfNLKCOPxk/0adsUl+zLcejeWaF/Et9cB71d/LYzylKw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6k2rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 17:18:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SHGZ6X006585;
	Fri, 28 Feb 2025 17:18:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4537v6k2rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 17:18:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFe1DD002567;
	Fri, 28 Feb 2025 17:18:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k7bkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 17:18:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SHI7Fq3474156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 17:18:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93EED58056;
	Fri, 28 Feb 2025 17:18:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1275158065;
	Fri, 28 Feb 2025 17:18:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.177.107])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 17:18:05 +0000 (GMT)
Message-ID: <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
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
Date: Fri, 28 Feb 2025 12:18:05 -0500
In-Reply-To: <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: TJ0i-k6VuBBhF5LbgAg1t_hLv7ci0mhy
X-Proofpoint-GUID: J3bqoxtpxMOyvXGmd8rKs6GZbRgsSSmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=769 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280124

On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > >=20
> > > I'd still also like to see some discussion about moving towards the
> > > addition of keyrings oriented towards usage instead of limiting
> > > ourselves to keyrings that are oriented on the source of the keys.
> > > Perhaps I'm missing some important detail which makes this
> > > impractical, but it seems like an obvious improvement to me and would
> > > go a long way towards solving some of the problems that we typically
> > > see with kernel keys.
> >=20
> > The proliferation of keyrings won't solve the key usage problem for IMA=
-
> > appraisal.  IMA-appraisal can be used to verify the kexec image, kernel=
 modules,
> > firwmare, etc, but it also verifies file signatures contained in usersp=
ace
> > packages.
>=20
> To be clear I don't think the usage oriented keyring idea will solve
> every keyring problem, but it seems like it solves a fair number of
> things that I've heard lately.
>=20
> >  To support the latter case, keyrings would need to be application
> > specific.  (This version of Clavis doesn't solve the latter key usage f=
or IMA-
> > appraisal either.)
>=20
> Application specific keyrings are more-or-less what I've been trying
> to describe.

Ok, let's go through different scenarios to see if it would scale.

Scenario 1: Mostly distro signed userspace applications, minimum number of
developer, customer, 3rd party applications.

Scenario 2: Multiple developer, customer, 3rd party applications, signed by=
 the
same party.

Scenario 3: extreme case - every application signed by different party.

With the minimum case, there would probably be a default key or sets of
permissible keys.  In the extreme case, the number of keyrings would be
equivalent to the number of application/software packages.

>=20
> > The keys baked into the kernel are trusted because the kernel itself wa=
s signed
> > and verified (secure boot).  Anyone building a kernel can build a key i=
nto the
> > kernel image, which establishes a "root of trust".  That key can then b=
e used to
> > verify and load other keys onto the IMA keyring.
>=20
> Sure, I'm not saying that trust isn't important, and that there are
> varying levels of trust.  My argument is that having additional,
> usage/application oriented keyrings which contain links back to keys
> imported and stored in the traditional trust oriented keyrings could
> neatly solve a number of keyring access control issues.
>=20
> > The problem is how to safely establish a root of trust without baking t=
he key
> > into the kernel image and then limiting that trust to specific usages o=
r
> > applications.
>=20
> My takeaway from Clavis was that it was more about establishing a set
> of access controls around keys already present in the keyrings and my
> comments about usage/spplication oriented keyrings have been in that
> context.  While the access control policy, regardless of how it is
> implemented, should no doubt incorporate the trust placed in the
> individual keys, how that trust is established is a separate issue
> from access control as far as I'm concerned.

Clavis defined both a mechanism for establishing trust and access control r=
ules.

Clavis defined a single Clavis key to establish trust.  The Clavis policy r=
ules
were signed by the Clavis key.  The Clavis policy rules defined the access
control.

Mimi




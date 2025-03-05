Return-Path: <linux-efi+bounces-2891-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A307A4F40D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241B11677A2
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBF1519B0;
	Wed,  5 Mar 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E5/MT/Cv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7A42AA3;
	Wed,  5 Mar 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139410; cv=none; b=Wy4P+0knkVUiNZVXi9r8l3DaCjyURhxaFOD2AZAK5BN+yj84FREfVclr2hnZYrKP7hAhDk1m6wYUFPvT4R78ov+DxEVUA5iJG6R5+xdQyrPUMV0CvLEsQqkY7I5JWvdm2ef1dAYFP3wEUxUfycKUu5xabiRKTBBb4PG9WHY798U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139410; c=relaxed/simple;
	bh=qFgwKZn4SsCG+16JbP2gd9ODg/z0S7Aycu8iSE1bwf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caxkJ5q1Q+3bTcVDlyePDSRW0oICfRhRQPmj/B89OMN2J4NEUpTc3vqKjEoFbPKAmCbxbUGMKdq+l9hb6xUs4XJkuRM0hM+DwEkp4l2/BegoW4UICnNBP2sqe05sLOuVJSkfAVMwC06/Sl7JqCkWb4Uot3ed6Gj4XawK50UMAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E5/MT/Cv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NfqSK026633;
	Wed, 5 Mar 2025 01:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CuZIx5
	nkVo6I0CL8AQ5UzBAF6gl8XJ4kt21qQJrPGOg=; b=E5/MT/CvinWecxL0GtkRd2
	ObDRDrvan1TSQJ1dpC//ujYbrKmOQeP0zP1+zaj6sTuDN6wEoXxSIHLheMGjzkre
	ed+t63V/sAyeqd3ttWQMBWVDYvOf1CXqC7CoedlK5a1DRoYx+pOeEwKL09i8hXC1
	rCMr1wsAH0dx88TyfoQlAmEnqbCeQ+O6PbJ0xQVJu+pGdcomEE3gVo6qVGcV0C2X
	h2vsgo3tWJQQhwtDYxpEjOBt9DVrt7i5JWzAYnqsG+eNPYBDUBEwnTo08a/IjSYl
	92vrpOIlF1J37CWVpBOqu1kiT2nJYCJZ5nT7xvEx8Qnmustg+jF+JogAEX7GE/Gw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j33ata-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:49:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5251nY2U011981;
	Wed, 5 Mar 2025 01:49:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j33at6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:49:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5250fv1x020877;
	Wed, 5 Mar 2025 01:49:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk03xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:49:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5251nWc327066966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 01:49:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EAA15805C;
	Wed,  5 Mar 2025 01:49:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBAD658054;
	Wed,  5 Mar 2025 01:49:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.117.76])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 01:49:29 +0000 (GMT)
Message-ID: <049a04b2e07e9e984ada32277cbbde42bdf7bb1b.camel@linux.ibm.com>
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
Date: Tue, 04 Mar 2025 20:49:29 -0500
In-Reply-To: <CAHC9VhT27Ge6woKbBExu2nT_cQE79rG+rrgp3nDYjvjcztVQXg@mail.gmail.com>
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
X-Proofpoint-GUID: vPAMVo_1dd0T1Il92qGZMHIKED5dHpTp
X-Proofpoint-ORIG-GUID: _9QlG5-sInrj__RkfEdfb6w8j00c5FfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050009

On Tue, 2025-03-04 at 19:19 -0500, Paul Moore wrote:
> On Tue, Mar 4, 2025 at 7:54=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> > On Mon, 2025-03-03 at 17:38 -0500, Paul Moore wrote:
> > > On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > > On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > > > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.i=
bm.com> wrote:
> > > > > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > >=20
> > > ...
> > >=20
> > > > Ok, let's go through different scenarios to see if it would scale.
> > > >=20
> > > > Scenario 1: Mostly distro signed userspace applications, minimum nu=
mber of
> > > > developer, customer, 3rd party applications.
> > > >=20
> > > > Scenario 2: Multiple developer, customer, 3rd party applications, s=
igned by the
> > > > same party.
> > > >=20
> > > > Scenario 3: extreme case - every application signed by different pa=
rty.
> > > >=20
> > > > With the minimum case, there would probably be a default key or set=
s of
> > > > permissible keys.  In the extreme case, the number of keyrings woul=
d be
> > > > equivalent to the number of application/software packages.
> > >=20
> > > Perhaps we're not understanding each other, but my understanding of
> > > the above three scenarios is that they are all examples of signed
> > > applications where something (likely something in the kernel like IMA=
)
> > > verifies the signature on the application.  While there are going to
> > > be differing numbers of keys in each of the three scenarios, I believ=
e
> > > they would all be on/linked-to the same usage oriented keyring as the=
y
> > > all share the same usage: application signatures.
> >=20
> > Yes they're all verifying file signatures, but the software packages ar=
e from
> > different sources (e.g. distro, chrome), signed by different keys.
>=20
> Yep.
>=20
> > Only a
> > particular key should be used to verify the file signatures for a parti=
cular
> > application.
>=20
> That's definitely one access control policy, but I can also envision a
> scenario where I have just one keyring for application signatures with
> multiple keys from multiple vendors.

Having a single keyring with keys from multiple software vendors is the sta=
tus
quo.

>=20
> > Clavis limits key usage based on LSM hooks (e.g. kernel modules, kernel=
 image,
> > firmware, etc).  It's a good start, but even this probably is not fine =
enough
> > granularity.
>=20
> Which is fine, but like I said earlier, it makes far more sense to me
> to move towards usage oriented keyrings and then apply whatever
> additional access control granularity is required to meet a given
> scenario.

Since you didn't agree with my example of "usage oriented keyrings", please
provide an example.

>=20
> It's also worth (re)mentioning that what makes Clavis not-a-LSM in my
> mind is how it is implemented, not necessarily its security goals.  If
> Clavis were to be implemented in such a way that it only relied on
> security/LSM blobs and not keys/keyrings it might be more suitable.
>=20
> > > > > My takeaway from Clavis was that it was more about establishing a=
 set
> > > > > of access controls around keys already present in the keyrings an=
d my
> > > > > comments about usage/spplication oriented keyrings have been in t=
hat
> > > > > context.  While the access control policy, regardless of how it i=
s
> > > > > implemented, should no doubt incorporate the trust placed in the
> > > > > individual keys, how that trust is established is a separate issu=
e
> > > > > from access control as far as I'm concerned.
> > > >=20
> > > > Clavis defined both a mechanism for establishing trust and access c=
ontrol rules.
> > > >=20
> > > > Clavis defined a single Clavis key to establish trust.  The Clavis =
policy rules
> > > > were signed by the Clavis key.  The Clavis policy rules defined the=
 access
> > > > control.
> > >=20
> > > Unfortunately I think we're getting a little ambiguous with how we ar=
e
> > > using the word "trust".  Just as "security" can mean different things
> > > depending on context, so can "trust" as the qualities we are trusting
> > > will vary depending on context.  I'll leave it at that for now as I
> > > believe we are talking about different things in the paragraphs above=
.
> > >=20
> > > Regardless, I'll also say this regarding Clavis and key/keyring acces=
s
> > > controls - as implemented, Clavis doesn't look like a LSM to me for
> > > the reasons already given.  If all of the various keys subsystem
> > > maintainers believe it is the Right Thing To Do inside the keys
> > > subsystem then it isn't my place to have a say in that.  I personally
> > > believe that doing the work to support usage oriented keyrings before=
,
> > > or while, implementing a Clavis-like mechanism is the better option,
> > > but that is a decision for you and the other key maintainers.
> >=20
> > "Usage oriented keyrings" similarly implies any key on a particular key=
ring is
> > acceptable.
>=20
> Yep.
>=20
> > Without understanding what you mean by "usage oriented keyrings", I
> > would assume it would work initially, but eventually it too will not be=
 fine
> > enough granularity.
>=20
> It all depends on what your goals are, but like I said above, it
> really seems to me like this is a good first step which can be
> followed up with additional granularity.

Without a concrete example of "usage oriented keyrings", it's hard to under=
stand
why "additional" granularity should be deferred.  From my perspective,
"additional" granularity is the main issue.

Mimi


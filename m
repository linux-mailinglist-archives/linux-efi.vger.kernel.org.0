Return-Path: <linux-efi+bounces-2875-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03315A4DE6C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B407A7AB907
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93C203714;
	Tue,  4 Mar 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O5lhTMDA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193C1EA7CE;
	Tue,  4 Mar 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092874; cv=none; b=sbHsYXSF6bYxIE7Th1em/QoRiIFUu5oN/RDsDrdWl4DGLpATy67DeRXw+WC43lTIwQAyt3qiz3GDPIbOn9BD3zvRglTA74OgFi3VlAvFLcyP99wAI2scq9Ib8GDfwuUdEgF8QDj9Z4TWdUkRysefQbKFDkoMY6a0icx9xy/clDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092874; c=relaxed/simple;
	bh=HyinxsF89BDo1NSbgsVB0G53ZZrA9ZNM5huh2XiqTQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWBlqjWVILEOeRIckrCCPDkBgtw6XarIyJRZpiaKfZiuBUkkqyaybEm3gr1MS6O/QP32pi7/1qmTSq7FUQjnwJFj7IuGn6jXlg8MsaliyLhSVyydvPzDZfBsyQGFE37mCw7msPv+ZqQxvI3kMAdVhnioNvlRv1NcgE9gSmudTwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O5lhTMDA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249iOol022691;
	Tue, 4 Mar 2025 12:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lav0QD
	Qn3uzKDyq4Ig1kWXcr+7nIByvHXWzRPJRorA0=; b=O5lhTMDAUDbCKgM9h+X2Kl
	v9OiUDth8TCYYGw4mmx5UnSZXTowT2eZKpor9AnZiJBJBFbyt1t9z4BL2OV73yhy
	QyTsP5Lgh94O+EzAmpp9ZDL6I8BiBSSge4q8JVvLqc2YWHl9E4u+SKQclQN6pKOC
	feLBTiUfbfsbLT8W8lUGk4EXaGr7BqCyyMnHRrF6mnry4U07USs1MkmiuxE5nYDt
	GJezwxB8meFs2CgnTYQ6ecKd4Nntji+DGpydk3REjL3XIn1fxYmdQeXNhGV/XvV4
	tY0EqFXvi7D7K+UcJwBlNePcD0uU1UGcECJrqE5hsvj5J0UUnrtmXnvXg0PVPlKQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku53x3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:53:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 524CHkpg004153;
	Tue, 4 Mar 2025 12:53:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455ku53x3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:53:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5249WBQU025031;
	Tue, 4 Mar 2025 12:53:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f91vyjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 12:53:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524CrM7x24248876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 12:53:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7575B5805B;
	Tue,  4 Mar 2025 12:53:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D51D5804B;
	Tue,  4 Mar 2025 12:53:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.57.16])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 12:53:20 +0000 (GMT)
Message-ID: <a1d6ce786256bbade459f98e0b4074e449048fee.camel@linux.ibm.com>
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
Date: Tue, 04 Mar 2025 07:53:19 -0500
In-Reply-To: <CAHC9VhSzc6N0oBesT8V21xuwB11T7e6V9r0UmiqHXvCg5erkVA@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: P-IbRL-M3d-yxwOmiVwyy_AGpbk01k41
X-Proofpoint-GUID: P5z29jqVGSnxacVJavhV21wsnAx8KUBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040102

On Mon, 2025-03-03 at 17:38 -0500, Paul Moore wrote:
> On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> > > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
>=20
> ...
>=20
> > Ok, let's go through different scenarios to see if it would scale.
> >=20
> > Scenario 1: Mostly distro signed userspace applications, minimum number=
 of
> > developer, customer, 3rd party applications.
> >=20
> > Scenario 2: Multiple developer, customer, 3rd party applications, signe=
d by the
> > same party.
> >=20
> > Scenario 3: extreme case - every application signed by different party.
> >=20
> > With the minimum case, there would probably be a default key or sets of
> > permissible keys.  In the extreme case, the number of keyrings would be
> > equivalent to the number of application/software packages.
>=20
> Perhaps we're not understanding each other, but my understanding of
> the above three scenarios is that they are all examples of signed
> applications where something (likely something in the kernel like IMA)
> verifies the signature on the application.  While there are going to
> be differing numbers of keys in each of the three scenarios, I believe
> they would all be on/linked-to the same usage oriented keyring as they
> all share the same usage: application signatures.

Yes they're all verifying file signatures, but the software packages are fr=
om
different sources (e.g. distro, chrome), signed by different keys.  Only a
particular key should be used to verify the file signatures for a particula=
r
application.  The scenarios, described above, are the ratio of distro/singl=
e
entity vs. non distro/single entity signed packages, which would correspond=
 to
the number of keyrings.

Clavis limits key usage based on LSM hooks (e.g. kernel modules, kernel ima=
ge,
firmware, etc).  It's a good start, but even this probably is not fine enou=
gh
granularity.

>=20
> > > My takeaway from Clavis was that it was more about establishing a set
> > > of access controls around keys already present in the keyrings and my
> > > comments about usage/spplication oriented keyrings have been in that
> > > context.  While the access control policy, regardless of how it is
> > > implemented, should no doubt incorporate the trust placed in the
> > > individual keys, how that trust is established is a separate issue
> > > from access control as far as I'm concerned.
> >=20
> > Clavis defined both a mechanism for establishing trust and access contr=
ol rules.
> >=20
> > Clavis defined a single Clavis key to establish trust.  The Clavis poli=
cy rules
> > were signed by the Clavis key.  The Clavis policy rules defined the acc=
ess
> > control.
>=20
> Unfortunately I think we're getting a little ambiguous with how we are
> using the word "trust".  Just as "security" can mean different things
> depending on context, so can "trust" as the qualities we are trusting
> will vary depending on context.  I'll leave it at that for now as I
> believe we are talking about different things in the paragraphs above.
>=20
> Regardless, I'll also say this regarding Clavis and key/keyring access
> controls - as implemented, Clavis doesn't look like a LSM to me for
> the reasons already given.  If all of the various keys subsystem
> maintainers believe it is the Right Thing To Do inside the keys
> subsystem then it isn't my place to have a say in that.  I personally
> believe that doing the work to support usage oriented keyrings before,
> or while, implementing a Clavis-like mechanism is the better option,
> but that is a decision for you and the other key maintainers.

"Usage oriented keyrings" similarly implies any key on a particular keyring=
 is
acceptable.  Without understanding what you mean by "usage oriented keyring=
s", I
would assume it would work initially, but eventually it too will not be fin=
e
enough granularity.

Mimi


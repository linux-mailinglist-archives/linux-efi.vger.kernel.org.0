Return-Path: <linux-efi+bounces-2857-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB1A48A05
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A1E16A4BD
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04426FA59;
	Thu, 27 Feb 2025 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GlRhrY3C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801A26F465;
	Thu, 27 Feb 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688919; cv=none; b=R44srOwG/6hGI6MFdizhcfzPUdHT8B4w5FL0Y4MAh5+0VovjHS7HFSlDZLVpNv12RBuZFtBM5ZQRF0KpmMMHpqKHtFxFU2UjTsBwx2HR2njmO2nM178qD8gPeFBo+ZnxdllHWIXz5b2Gmj9wXzFnsUgsTD+/m7GtWr/dTCTYQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688919; c=relaxed/simple;
	bh=toTm+VBOYQ59OnGvbnbG9hh7ctRpGyripY+1Kc9tK+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uynv1scFdh1DjZBMjlgPQdk+78gy9OTJKrGo4z1XvXaDU0kZvyG+OvK3xDbSlIcyUJ61mdsx3CH5whly/qi7w7ps4Oo85u2mYHBoQBJEpA8FE7WFwaD3I0sZ8gSROqyoUspL9GzIBYbc/xuQa7ROiOH3yVgbIJ5KUCPDQuEBZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GlRhrY3C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJs6lB027755;
	Thu, 27 Feb 2025 20:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5gf2oW
	EChCVKSlevRHGAWCIEoWOv/4y51kS80LfNMGo=; b=GlRhrY3ClvIbJpQ+8vn42U
	Bgq1QaiBUslQJ6QGTlybaFjewOovxoNI2qrtV0DNhz2OV/YeItP8NgVaoXKGkbtw
	mWK6OGK7Cqz1TPmz3WbW6wPcTHuDPMu8b5g7n7ZUXTajUER1w5gkpJKEAjzePM94
	GcK04PuLH2YLhT/SO22nD2TmcwX7knx29hCXN9irHwEjKYjWx+SNXuq+kNduynAW
	gJyXPZpGItpRO4xTQU4OZRNM170m+uzi2SJ5BILYIBV1O0JKImSpxl5QQ+CW3f0K
	m+zDnSohvPBt1HHoSi8KN3QOFGg7fEZ5PJPp5B11TtUd80FbFnHSzIHoJnOezXNw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452e4a5kgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 20:41:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51RKfNro026549;
	Thu, 27 Feb 2025 20:41:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452e4a5kgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 20:41:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51RI5BTv012741;
	Thu, 27 Feb 2025 20:41:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt32sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 20:41:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51RKfLiT32637492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:41:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F249858053;
	Thu, 27 Feb 2025 20:41:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D6058043;
	Thu, 27 Feb 2025 20:41:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 20:41:19 +0000 (GMT)
Message-ID: <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore
 <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
        Jarkko
 Sakkinen <jarkko@kernel.org>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>,
        "davem@davemloft.net"
 <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
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
Date: Thu, 27 Feb 2025 15:41:18 -0500
In-Reply-To: <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
	 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
	 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
	 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
	 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
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
X-Proofpoint-ORIG-GUID: qFjwsqYvnSasWmeKwDVF9xETelCqQs7K
X-Proofpoint-GUID: h6W6984XJjO07a7_N3AGcB_gqnHG76Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=992 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270152

On Mon, 2025-01-06 at 17:15 +0000, Eric Snowberg wrote:
>=20
> > On Jan 5, 2025, at 8:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> >=20
> > On Fri, Jan 3, 2025 at 11:48=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >=20
> > > Regardless, back to Clavis ... reading quickly through the cover
> > > letter again, I do somewhat wonder if this isn't better integrated
> > > into the keyring proper; have you talked to both David and Jarkko
> > > about this?
> >=20
> > I realize I should probably expand on my thinking a bit, especially
> > since my comment a while regarding LSMs dedicated to enforcing access
> > control on keys is what was given as a reason for making Clavis a LSM.
> >=20
> > I still stand by my comment from over a year ago that I see no reason
> > why we couldn't support a LSM that enforces access controls on
> > keyrings/keys.  What gives me pause with the Clavis LSM is that so
> > much of Clavis is resident in the keyrings themselves, e.g. Clavis
> > policy ACLs and authorization keys, that it really feels like it
> > should be part of the keys subsystem and not a LSM.  Yes, existing
> > LSMs do have LSM specific data that resides outside of the LSM and in
> > an object's subsystem, but that is usually limited to security
> > identifiers and similar things, not the LSM's security policy.

Hi Jarkko, David,

Both Paul's and my main concerns with this patch set is storing policy in t=
he
keyring.  We would appreciate your chiming in here about storing key policy=
 in
the keyring itself.

thanks,

Mimi

> >=20
> > That's my current thinking, and why I asked about locating Clavis in
> > the keys subsystem directly (although I still think better keyring
> > granularity and a shift towards usage based keyrings is the better
> > option).  If David and Jarkko are opposed to integrating Clavis into
> > the keys subsystem we can consider this as a LSM, I'm just not sure
> > it's the best first option.  Does that make sense?
>=20
> Thanks for your feedback Paul.  I have no preference if it is a new LSM=
=20
> or not.  My interest is finding the path of least resistance to get this =
type=20
> of capability added to mainline code.  Hopefully David and Jarkko will=
=20
> provide their opinions.



Return-Path: <linux-efi+bounces-6222-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC2wDtA8nmkrUQQAu9opvQ
	(envelope-from <linux-efi+bounces-6222-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 01:05:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069218E46D
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 01:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF2D3062218
	for <lists+linux-efi@lfdr.de>; Wed, 25 Feb 2026 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701C622F01;
	Wed, 25 Feb 2026 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TDPeo8v/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82A4A0C;
	Wed, 25 Feb 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977863; cv=none; b=uAYtS9XKNc+wSiF9YCoG8MK9I0RekUwo1iXkENKJSgAkGg+uth5cGIzbsauvYJP+MLzDbOq1FziXzJtPz7vSuGzNjOev9hHK2rUlwq97cSIiljAnyMN2y0kZ1npCmBhnoivHXtubTGCD+nuySyqnXBxc/qGMOFqamukxBg73IEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977863; c=relaxed/simple;
	bh=k5W8VL5lwkNu+ahLTvERTa+BjYNi4GO4VhNBxytZTFs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uNL/HpShtn0trq40z97S0DRwKoCoXJKEQGlL2WuKb9d1CHLsHcPRp7TUT9ORQ/NqHGnnHMBeCS3NLgaU1THv1NCuK1B7KIaCpYCAkfOYel0GeS++x5c/RbcxDWXjWFYS+wvwCg+qZ7oJDxdQ3rL/Hr4tCXnBjkyS+Ynq5DXv0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TDPeo8v/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OKo3mo2894740;
	Wed, 25 Feb 2026 00:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cFbFxI
	Lw8z/WHEBjoq2ZMztetevIFEwE8orbafe4X+g=; b=TDPeo8v/2+wirzhVbwsQUy
	hYpVYSVAc0lg1TDb8j+bjbT6nU7ETrG+IW1bV3dwqFTJ6ryXa/vazci9dAxEZTNG
	za6txZ0VpMGiiTyrUkYkGSynN5Ugck33b3VltjtkuYTBAXc2QR0FcN2P2Jgs9bPx
	33pfHCbLbYKsuq2iKQ4mZMaPcoeJcGDnQZdFaoTQPUpF6waYgUBh2mw1Xmyj4WfK
	jmg+Q3C2q+Q8FFiQtMa7+TqiQdMIpB2/iOqevicTdezsXzN5wVOQkBIzazGpnvp9
	ZrPaq3cjiJH4QOKOjUUkRtj0uNcvGJ+LBM3BOZgkZvNY8O2h1gvNk7hddd9AbgWQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471x2sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 00:03:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OLXORR030259;
	Wed, 25 Feb 2026 00:03:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkb1gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 00:03:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61P03DrN32375318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 00:03:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E5865805A;
	Wed, 25 Feb 2026 00:03:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3A8E5805C;
	Wed, 25 Feb 2026 00:03:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.151])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 00:03:10 +0000 (GMT)
Message-ID: <ad471c33eeb9e21c49ac81032dc64555a2fb816f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
        linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon	 <will@kernel.org>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov	 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"	 <x86@kernel.org>,
        "H.
 Peter Anvin" <hpa@zytor.com>,
        Roberto Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Jarkko
 Sakkinen <jarkko@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64
 ARCHITECTURE)"	 <linux-arm-kernel@lists.infradead.org>,
        open list
 <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)"	 <linuxppc-dev@lists.ozlabs.org>,
        "open list:S390 ARCHITECTURE"	
 <linux-s390@vger.kernel.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE
 (EFI)"	 <linux-efi@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        "open
 list:KEYS/KEYRINGS_INTEGRITY"	 <keyrings@vger.kernel.org>
In-Reply-To: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-2-coxu@redhat.com>
	 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
	 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
	 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
	 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
	 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
	 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
	 <aW2i3yacr5TvWU-m@Rk>
	 <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
	 <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Feb 2026 19:03:10 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KmeUE4GQkjFCEA-onCkjAzUZBg2oc_Jk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDIwOSBTYWx0ZWRfX2xjh5sVgzhOS
 dnNMnaiYXxvEopWHavbqXkdT3qDid/FcKrZW6PmQdfwrcST/ZX7r1DIOCK79NPeBkmvn5ZHnYe9
 iQCAUuGXNwIfntSmXBmb3sUwGlIdjaEKqZi1yYK+izhn6dUmiu/Nzuts6JG8Ag64IbvlsCzY9HR
 y1IRHwNmX0lY22905adj132keU3lKlbxSTaMIzXpdbD2idW7uvTZCuaRnWcSmyCenN1pvMDPDtz
 Ojr2imkhf9l9gWYtYrhl9C6I4J8BD8+fWsWgo8o8r/qtjNfpI8oxVuSL/ZlJTwW4+zm6hRkbkoN
 4lqBW+WzVRY5+AOS30Msdg/NZ8hJlFIKGLqUHVrs0oDlu2icF3c2sOI3QWj0LDoJJ5HzB/Elg74
 cnpm/637Zl1QbABBe956sXpIE+1HpOurd+ceDGYdkaBpuRjH9KncE0ga2Ag7Qpm+1XRIU3zjk+0
 9ddSy/sJJwN86SA5NEA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699e3c44 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=qGODes0vNXlHMsmaWvgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2x_WgBn-lXEWRE-KKGAySI2MMRU7Qajr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240209
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6222-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,vger.kernel.org,linux.ibm.com,huaweicloud.com,arm.com,kernel.org,ellerman.id.au,gmail.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9069218E46D
X-Rspamd-Action: no action

On Wed, 2026-01-21 at 17:25 +0100, Ard Biesheuvel wrote:
> On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >=20
> > On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
> >=20
> > > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/=
Kconfig
> > > index 976e75f9b9ba..5dce572192d6 100644
> > > --- a/security/integrity/ima/Kconfig
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> > >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > >          bool
> > >          depends on IMA_ARCH_POLICY
> > > +       depends on INTEGRITY_SECURE_BOOT
> > >=20
> > >=20
> > > Another idea is make a tree-wide arch_get_secureboot i.e. to move
> > > current arch_ima_get_secureboot code to arch-specific secure boot
> > > implementation. By this way, there will no need for a new Kconfig opt=
ion
> > > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
> > > concern.
> >=20
> > Originally basing IMA policy on the secure boot mode was an exception. =
 As long
> > as making it public isn't an issue any longer, this sounds to me.  Ard,=
 Dave, do
> > you have any issues with replacing arch_ima_get_secureboot() with
> > arch_get_secureboot()?
>=20
> I don't see an issue with that. If there is a legitimate need to
> determine this even if IMA is not enabled, then this makes sense.

Ard, Dave -

FYI, Coiby posted v3 of this patch set[1], which is queued in the next-
integrity-testing branch[2].

[1]
https://lore.kernel.org/linux-integrity/20260213012851.2532722-1-coxu@redha=
t.com/

[2] https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.g=
it/

Mimi


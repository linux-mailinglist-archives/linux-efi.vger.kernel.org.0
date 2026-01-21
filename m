Return-Path: <linux-efi+bounces-6028-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEChL9UMcWmPcQAAu9opvQ
	(envelope-from <linux-efi+bounces-6028-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 18:28:53 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954F5A87F
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952D86CF5BC
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29072989A2;
	Wed, 21 Jan 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7MQU+ob"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8631771E;
	Wed, 21 Jan 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009421; cv=none; b=Lv4E9pGc5/GBGFOGyCuHk6XpFsMt6dcstiJX09xU66SzLeNPprUlMTYrBBnf55zQYG0bKFtZqZxdWZh9wERONx/v+e3+oylt1C/ng7EJ3RByXFUKGM9E1LfnSNyvJ0RdjHcjd6KWFxtqwxm1EYn3MosOUinFPOagdI9UOtV5LFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009421; c=relaxed/simple;
	bh=n54IFLdybJqnbGVr/pLsbMWrzuKM8VC7sh6UyU2uJ7I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hhVBWrYPhLgY+LX+RlkWggXJztrn4t/KW27LApaHRymzEW+p/rB81W+1KZQzLrpyW7ITiRP1dVlRZd5sgmVXCL4jqc1EzBqBYdZDvZXB8PcvvTB4JQAu0qFgtu1/lBT3uMKRs3qLNwXXSP+nRSQh3g4NAbEIxya/UjOYB6GNYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7MQU+ob; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LCIPJC007922;
	Wed, 21 Jan 2026 15:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ptmlnh
	rcboQC2zSz3tkdWdWIHjt+pGDAQNrjfcEM9Ao=; b=R7MQU+obN+Qps4PgiI24Ew
	/tg73MOOpAIXEaySqQu7qpuwwKYHl9637G1gGm4LpJ2PWu5Z/T4NOLNYom2+S5vr
	srhYoUIvgDBQrVjo1HYcMdOulZS0VupOQWns9ZnfPpX7Ztjv02TtRF8HlkawN/nq
	3Ak6iWcgqyrpoU1dlZvAN1KYeK2vscKs4JjcOxdKg1PC/DIh43J1W6lElnb6UDkY
	uJFCeKaU3lS2IxSIfAOHxkjKAuSYN0wWMNxQggR2q6hK1YScGRtZRQvuOekEzYvn
	ZJ10UAMFtMOVSS16pGwG0gmu/qeStWTp3sum9s3sN+OXYJhaNj+34GwvvoLYKO3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukbxuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:29:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LFTIC8003745;
	Wed, 21 Jan 2026 15:29:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukbxus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:29:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LE7HHN009273;
	Wed, 21 Jan 2026 15:29:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kcpjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:29:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LFTGuU32834142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 15:29:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12AF05804E;
	Wed, 21 Jan 2026 15:29:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0E225803F;
	Wed, 21 Jan 2026 15:29:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.58.59])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 15:29:12 +0000 (GMT)
Message-ID: <90e382b630b9719bf3e0ac76da1ce8b467d7ca52.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org,
        Heiko
 Carstens	 <hca@linux.ibm.com>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan	 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin	
 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov <bp@alien8.de>,
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
In-Reply-To: <79185163-bf8f-4490-9396-3fd73b7a0c73@intel.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-2-coxu@redhat.com>
	 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
	 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
	 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
	 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
	 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
	 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
	 <79185163-bf8f-4490-9396-3fd73b7a0c73@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2026 10:29:12 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEyOSBTYWx0ZWRfX2ymvuQYTy22H
 qJNFLcQqWjeaCaLFEyKT6tfE0MW/e++nB0SRaSFVtToAa9ox6oeVXILCPxuv+vctXvPHW3rsYrQ
 +ejPAxy5nQRglPnamJCq1FFiP7jMKqOLF16rjF+Bx8AKWTma7YLK67DTU6FJbmSTRKOpWP3H1pu
 Wg7FpxlASD8gzCkZwBbwfrDAPc4zwN7GUrVCGuyQgBF6vKaRnD8zXGeJIzrhGxxnJfbBMnLTfZy
 TeJRkW492qytmES3d6FRnj0Rq9JTRV2s755lB3CGKXdkShUejNQZLiiBAo73NEyFpV+H4+8d40k
 RDpXSBrIKVh11RVald9e5I9lxAfIvQOyV3D9niyM9/EkSGYC52qa1uUWX4+rAvlXsEx+0yhfROv
 2tSF8yG6PJGDjvQRkGjOgB1n2uOpvIOEJ7uicvzpXhvpauEMpRWd0+DPjwyy8aOwzDmoMRnpfiT
 sac2pUBUVyCecKsNSdg==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=6970f0cf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=m0T7RSBcDQ_YrrizhwQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S936aB5gmoeXC2u8rCvDZx6qTRnYBrU1
X-Proofpoint-GUID: 1nKqWJ362P7-Wshb2BQ9Ah0DM2KFKlHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210129
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux.ibm.com,huaweicloud.com,arm.com,kernel.org,ellerman.id.au,gmail.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6028-lists,linux-efi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 2954F5A87F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dave!

On Mon, 2026-01-19 at 10:44 -0800, Dave Hansen wrote:
> On 1/18/26 10:25, Mimi Zohar wrote:
> > As not all arch's implement arch_integrity_get_secureboot, the definiti=
on in
> > include/linux/integrity.h would need to be updated.  Something like:
> >=20
> > -#ifdef CONFIG_INTEGRITY_SECURE_BOOT
> > +#if (defined(CONFIG_INTEGRITY_SECURE_BOOT) && \
> > +       (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_=
S390) \
> > +        || defined(CONFIG_PPC_SECURE_BOOT))
> >=20
> > Then IMA_SECURE_AND_OR_TRUSTED_BOOT and EVM could select INTEGRITY_SECU=
RE_BOOT,
> > as suggested.
>=20
> This seems to be going a wee bit sideways. :)

Agreed, that was my point. :)   "imply" was cleaner, but Ard objected to tw=
o
imply's.

>=20
> This kind of CONFIG complexity really should be left to Kconfig. C
> macros really aren't a great place to do it.
>=20
> The other idiom we use a lot is this in generic code:
>=20
> #ifndef arch_foo
> static inline void arch_foo(void) {}
> #endif
>=20
> Then all you have to do is make sure the arch header that #defines it is
> included before the generic code. I'm not a super huge fan of these
> because it can be hard to tell (for humans at least) _if_ the
> architecture has done the #define.
>=20
> But it sure beats that #ifdef maze.

Sure.


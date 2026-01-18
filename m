Return-Path: <linux-efi+bounces-6013-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851EED39919
	for <lists+linux-efi@lfdr.de>; Sun, 18 Jan 2026 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4311730054B1
	for <lists+linux-efi@lfdr.de>; Sun, 18 Jan 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B762FD68A;
	Sun, 18 Jan 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNrh8df0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258B23F422;
	Sun, 18 Jan 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760848; cv=none; b=A+Uln/two1UEBHzcnlpC26JCsULdT3yqKGNRRotz2FSJhyJJ0MyQFa7FCKWcsTg3CtYO3QOzJGzBshx8pj8rmfREdMJFV152ABxXUM4zF8dItoJNNFxcrXiZkWQZ2teeRA5NN92rxQvdKsphd46trsoMmHHCV6kd//eLh6BdWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760848; c=relaxed/simple;
	bh=FADLCu+PjV9eYlB2kecgHnyJMiyrYOG9KLPxU45leyk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DrnqSPqMtkMQqwRD5D+rTINSfAmM5+1VWzf98xfFxVSO4G3Xliomg36vWIMnoYR8FNpuQK++oFRjuRYagqpV1utjPfdgEIRJUcsJR+QqeOlOMRx5uesv3YxoJ5zFKwqpGHjKiKTALO4DNrLyW4DfEGOAEmk2xIC+qnbm8ZQTYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNrh8df0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60I4egOg016747;
	Sun, 18 Jan 2026 18:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jGVjL+
	2PB0QkiOp/por4+gCaTzAeutoSiNEWB+3nLQ0=; b=fNrh8df0yEqtIqqZ8/EUoa
	+/E7/gAoDcZjjIUtIu/jx+k/4Nb9PE0VMqN3WmgmFFtnglemCbPGNWKUL928zWNi
	LeiHfB90hOhAFJPIcgbPIksSzHl//gO61X99S5ESRWltq4oNhsUbyV9io0wGdViY
	QQkMntgj+2sNUt3KMdJ7Z81Wd8xdNy7WaDVQjoBpql5mBB57F5BsMHmwdjg1Buh+
	mbi62vDhD/nGBHS7vBAHF0OTUIwyjiU/BuXq9Eo+WKZtRxD6vXf1RimUslOP1p8r
	oDpyNxPT41bKQZHSgCXzPM5TnJzXHr0/lZD3FdXVeD35yWy7NNKOdGqpKPIzCzOg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujvtqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 18:25:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60IIPv9m027439;
	Sun, 18 Jan 2026 18:25:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyujvtqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 18:25:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60IFY2o7024583;
	Sun, 18 Jan 2026 18:25:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxar9ady-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 18:25:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60IIPtiM28705424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Jan 2026 18:25:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58D9658055;
	Sun, 18 Jan 2026 18:25:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 517EC58043;
	Sun, 18 Jan 2026 18:25:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.77.99])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Jan 2026 18:25:53 +0000 (GMT)
Message-ID: <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Ard Biesheuvel <ardb@kernel.org>
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
In-Reply-To: <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-2-coxu@redhat.com>
	 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
	 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
	 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
	 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
	 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Jan 2026 13:25:52 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MSBTYWx0ZWRfX0g2BmEfR84xp
 /uTTHELidZ/mQL1q0KSq1uwEu3J0TBmjili4JJnfxqu7yZxVZkMyr6UmIvqH+0I7n7uFtD4iucy
 DScx6BAVdVNcI/GfD6V0wraMD9LX6waG3fI6dvTcsSvfp3w6Nufa2RvSm0QUkNWg4HdYrbQOmGp
 T5VeeX2Lfp48bQVu4rlH6lyRn57ZyFP2nAbHoouzkcmnaUVbbKweYr+TJKfjhA0WVbP4rfCngDu
 oISOEpArAPdOR887OxMP5menJoDuECqBhEX0LniAf2HdVZRMPn5YpcfHWc28/E+ivsYrfCpy300
 5b7CE2RzCYZqL761ZaB6FY/ZN0uJhdphsCO1fIFiSZRToBCMWKOf7eCnwKUSyG+DBn+Iosbh2iy
 8JKmjMnLFfTO9BJVfXgZJl/q2rZEYyrPwq3M0HDSKgxRcerwt2QQ27fwbsyXQIhiyRtSkmKNBXh
 aOmA/AXw2CO1pT3z0xw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696d25b6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=AiHppB-aAAAA:8 a=NGAx97edFhLKIqwmpgIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6d0Yn0yd2RHIADtSz6qKVUUNVM3t80Ng
X-Proofpoint-GUID: g5bmud6ki9cH3-4uThB0p-gq08CkPdWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601180161

On Fri, 2026-01-16 at 18:27 +0100, Ard Biesheuvel wrote:
> On Fri, 16 Jan 2026 at 17:39, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >=20
> > On Fri, 2026-01-16 at 14:18 +0100, Ard Biesheuvel wrote:
> > > On Fri, 16 Jan 2026 at 14:11, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >=20
> > > > On Fri, 2026-01-16 at 10:41 +0100, Ard Biesheuvel wrote:
> > > > > On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
> > > > > >=20
> > > > > > EVM and other LSMs need the ability to query the secure boot st=
atus of
> > > > > > the system, without directly calling the IMA arch_ima_get_secur=
eboot
> > > > > > function. Refactor the secure boot status check into a general,
> > > > > > integrity-wide function named arch_integrity_get_secureboot.
> > > > > >=20
> > > > > > Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which=
 is
> > > > > > automatically configured by the supported architectures. The ex=
isting
> > > > > > IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture s=
pecific
> > > > > > IMA policy based on the refactored secure boot status code.
> > > > > >=20
> > > > > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> > > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > > > ---
> > > > > >  arch/arm64/Kconfig                            |  1 +
> > > > > >  arch/powerpc/Kconfig                          |  1 +
> > > > > >  arch/powerpc/kernel/Makefile                  |  2 +-
> > > > > >  arch/powerpc/kernel/ima_arch.c                |  5 --
> > > > > >  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
> > > > > >  arch/s390/Kconfig                             |  1 +
> > > > > >  arch/s390/kernel/Makefile                     |  1 +
> > > > > >  arch/s390/kernel/ima_arch.c                   |  6 --
> > > > > >  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
> > > > > >  arch/x86/Kconfig                              |  1 +
> > > > > >  arch/x86/include/asm/efi.h                    |  4 +-
> > > > > >  arch/x86/platform/efi/efi.c                   |  2 +-
> > > > > >  include/linux/ima.h                           |  7 +--
> > > > > >  include/linux/integrity.h                     |  8 +++
> > > > > >  security/integrity/Kconfig                    |  6 ++
> > > > > >  security/integrity/Makefile                   |  3 +
> > > > > >  security/integrity/efi_secureboot.c           | 56 +++++++++++=
++++++++
> > > > > >  security/integrity/ima/ima_appraise.c         |  2 +-
> > > > > >  security/integrity/ima/ima_efi.c              | 47 +----------=
-----
> > > > > >  security/integrity/ima/ima_main.c             |  4 +-
> > > > > >  security/integrity/platform_certs/load_uefi.c |  2 +-
> > > > > >  21 files changed, 111 insertions(+), 70 deletions(-)
> > > > > >  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
> > > > > >  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
> > > > > >  create mode 100644 security/integrity/efi_secureboot.c
> > > > > >=20
> > > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > > index 93173f0a09c7..4c265b7386bb 100644
> > > > > > --- a/arch/arm64/Kconfig
> > > > > > +++ b/arch/arm64/Kconfig
> > > > > > @@ -2427,6 +2427,7 @@ config EFI
> > > > > >         select EFI_STUB
> > > > > >         select EFI_GENERIC_STUB
> > > > > >         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > > > > +       imply INTEGRITY_SECURE_BOOT
> > > > >=20
> > > > > This allows both to be en/disabled individually, which I don't th=
ink
> > > > > is what we want. It also results in more churn across the
> > > > > arch-specific Kconfigs than needed.
> > > > >=20
> > > > > Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'e=
d
> > > > > INTEGRITY_SECURE_BOOT in its Kconfig definition?
> > > >=20
> > > > As much as possible, EVM (and other LSMs) shouldn't be dependent on=
 another LSM,
> > > > in this case IMA, being configured.
> > >=20
> > > Sure, but that is not my point.
> > >=20
> > > This arrangement allows for IMA_SECURE_AND_OR_TRUSTED_BOOT to be
> > > enabled without INTEGRITY_SECURE_BOOT, resulting in the stub
> > > implementation of arch_integrity_get_secureboot() being used, which
> > > always returns false.
> >=20
> > I understand your concern, but instead of "select"ing INTEGRITY_SECURE_=
BOOT from
> > IMA_SECURE_AND_OR_TRUSTED_BOOT, how making IMA_SECURE_AND_OR_TRUSTED_BO=
OT
> > dependent on both IMA_ARCH_POLICY and INTEGRITY_SECURE_BOOT.
> >=20
>=20
> Given that INTEGRITY_SECURE_BOOT has no dependencies of its own,
> afaict, selecting it is the least disruptive option, as otherwise,
> existing configs will disable IMA_SECURE_AND_OR_TRUSTED_BOOT as the
> kernel is being upgraded. But conceptually, I agree that they are
> equivalent.
>=20
> > Including the "imply INTEGRITY_SECURE_BOOT" here in the arch Kconfig al=
lows EVM
> > to query the secure boot state without relying on IMA_SECURE_AND_OR_TRU=
STED_BOOT
> > being configured.
>=20
> Yes, I understand that this is the whole point of the exercise. But
> 'imply' should be used with care, and in this case, implying both from
> CONFIG_EFI really makes little sense. INTEGRITY_SECURE_BOOT should be
> selected by options that need the functionality, not 'implied' by
> options that might provide it.

As not all arch's implement arch_integrity_get_secureboot, the definition i=
n
include/linux/integrity.h would need to be updated.  Something like:

-#ifdef CONFIG_INTEGRITY_SECURE_BOOT
+#if (defined(CONFIG_INTEGRITY_SECURE_BOOT) && \
+       (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390=
) \
+        || defined(CONFIG_PPC_SECURE_BOOT))

Then IMA_SECURE_AND_OR_TRUSTED_BOOT and EVM could select INTEGRITY_SECURE_B=
OOT,
as suggested.

Mimi


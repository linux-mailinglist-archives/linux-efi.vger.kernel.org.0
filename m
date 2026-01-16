Return-Path: <linux-efi+bounces-6009-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855B3D338AE
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 17:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8717E30A159C
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jan 2026 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804A395D80;
	Fri, 16 Jan 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUaZQ/mN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461033ADA4;
	Fri, 16 Jan 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581583; cv=none; b=dsokhqz4Xgi90IPAQ7+rLRBxfeAjMWWBvHMotU2R5zfll4YoF9lpAk+Kwz7h4KD7ufj4lAY71OXjrCbA4tLM11bPLpXingV5ByDdKkK7Otcr7c2q0mLR2M6NyQceU3MDUFRgUmZYjK326W2Mj3bXUFFhEjC6Oe3Od2yL+R4kYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581583; c=relaxed/simple;
	bh=fxruMBMnaXZDi2aOiU39kavczDFJjjp12qOlcz0CYE0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hfIe9LOvdgNududKS3CSIfJ3Wo3k+1hCYrqdO3jL7H7bOGKrdYV/lE/SrruWNktEPJrAWrlzz8IR00j79ZY1GOEqkRTcc1PNvZEjOrgN/gvqFQNG5DODETmhUWr8zl+kXokKRZ7aHOIPOBnjZQu6i5Qq6/HL90S8TOPRW0p6DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cUaZQ/mN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60GDHP70029226;
	Fri, 16 Jan 2026 16:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RoN1oj
	r5MYR8WVOifwR88Ffw20/RJ9UUbBOLTB+iK34=; b=cUaZQ/mNbLlBHYQafX6HAX
	qWG95pfUh3Bsl+I0lDUllvwlggKsG7sfH2VDuiC2IJGNO+F7u5OAwOHH3KG+9hs/
	Vj3qKB08w6tzN97YI0D3u2Xf2bjtor+NV2pyw4r210onY+MwlCOx/qRmQmDtIkVM
	h4O03p9UPEnvyERn8ZrYCMrhoIG+jRmoxQRTvW2wVToLOEBTF4WZx0D9rpNiFNv7
	yYqM4c0cprkScOYt1viWMrkhFbjJOcF43XIAwzS0YG/TcGEXcWRBYD7Su1P8lvMV
	wGqm6tEMQPE7+u4k30Aq/Cy3yM5e36lR+ausjtWI5np+fteyMPJRL4U2M0RVfQLA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9stbr5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 16:38:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60GGcj9u016730;
	Fri, 16 Jan 2026 16:38:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bq9stbr5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 16:38:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60GF2S16030126;
	Fri, 16 Jan 2026 16:38:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ak76ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 16:38:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60GGcgJT34210378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:38:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0CF58068;
	Fri, 16 Jan 2026 16:38:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6E1158065;
	Fri, 16 Jan 2026 16:38:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.160.11])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Jan 2026 16:38:39 +0000 (GMT)
Message-ID: <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
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
In-Reply-To: <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-2-coxu@redhat.com>
	 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
	 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
	 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Jan 2026 11:38:39 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=696a6996 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=AiHppB-aAAAA:8 a=zBo5Bit52hmzgxODDfcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HDcUgXMqcrTFQcSSHwm55CTcX_zwATbB
X-Proofpoint-GUID: Ms5Y-J-mUGXOf9HnmbrcFe2dwdu983UI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDExOCBTYWx0ZWRfX3faEyruqGvQW
 oupyyXcrvAM+R4BJlmjSvcRP4ebLmXZhJFlQva3o6KeDgGEArgdmUS24CbJCiH6jfhxW7FGAGWF
 HHRRx/Syu4McI8VLU2sev/aqwevPbDhZvdSYdhn4Tll/jefhRG3GgwItlQU2iK1yIRw5rsiGLvq
 BCkW4iiA4vxY4jdSO1mQJrvFC9SUavwqfVmK0ZBb3m7d37wDH1hR2ZXXvc6GyLFR5rDzzCoNRq8
 1Rai+F1uAEtkEelhFGfGM/0D9rHURNdigulpRPDyEn7kdi6FGPMMIIIaXPG2sQAHfPDeE0ojokF
 r350/RtFFrO6ZeMyVfHIj4zRt9LWZzxO3LlXdH+rlBc+LfekgBX7DznlV8vRIljfLt7CF9In3se
 slN0LiKdYvif4zFMLHTKScLdnsFw5VBmbqE/MHE8+quOOB6VVMnP5ANRv5r0sNQLmhiJPdp5NA7
 RrEcybl2m3gHsglFpPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601160118

On Fri, 2026-01-16 at 14:18 +0100, Ard Biesheuvel wrote:
> On Fri, 16 Jan 2026 at 14:11, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >=20
> > On Fri, 2026-01-16 at 10:41 +0100, Ard Biesheuvel wrote:
> > > On Thu, 15 Jan 2026 at 01:43, Coiby Xu <coxu@redhat.com> wrote:
> > > >=20
> > > > EVM and other LSMs need the ability to query the secure boot status=
 of
> > > > the system, without directly calling the IMA arch_ima_get_secureboo=
t
> > > > function. Refactor the secure boot status check into a general,
> > > > integrity-wide function named arch_integrity_get_secureboot.
> > > >=20
> > > > Define a new Kconfig option CONFIG_INTEGRITY_SECURE_BOOT, which is
> > > > automatically configured by the supported architectures. The existi=
ng
> > > > IMA_SECURE_AND_OR_TRUSTED_BOOT Kconfig loads the architecture speci=
fic
> > > > IMA policy based on the refactored secure boot status code.
> > > >=20
> > > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > ---
> > > >  arch/arm64/Kconfig                            |  1 +
> > > >  arch/powerpc/Kconfig                          |  1 +
> > > >  arch/powerpc/kernel/Makefile                  |  2 +-
> > > >  arch/powerpc/kernel/ima_arch.c                |  5 --
> > > >  arch/powerpc/kernel/integrity_sb_arch.c       | 13 +++++
> > > >  arch/s390/Kconfig                             |  1 +
> > > >  arch/s390/kernel/Makefile                     |  1 +
> > > >  arch/s390/kernel/ima_arch.c                   |  6 --
> > > >  arch/s390/kernel/integrity_sb_arch.c          |  9 +++
> > > >  arch/x86/Kconfig                              |  1 +
> > > >  arch/x86/include/asm/efi.h                    |  4 +-
> > > >  arch/x86/platform/efi/efi.c                   |  2 +-
> > > >  include/linux/ima.h                           |  7 +--
> > > >  include/linux/integrity.h                     |  8 +++
> > > >  security/integrity/Kconfig                    |  6 ++
> > > >  security/integrity/Makefile                   |  3 +
> > > >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++=
++++
> > > >  security/integrity/ima/ima_appraise.c         |  2 +-
> > > >  security/integrity/ima/ima_efi.c              | 47 +--------------=
-
> > > >  security/integrity/ima/ima_main.c             |  4 +-
> > > >  security/integrity/platform_certs/load_uefi.c |  2 +-
> > > >  21 files changed, 111 insertions(+), 70 deletions(-)
> > > >  create mode 100644 arch/powerpc/kernel/integrity_sb_arch.c
> > > >  create mode 100644 arch/s390/kernel/integrity_sb_arch.c
> > > >  create mode 100644 security/integrity/efi_secureboot.c
> > > >=20
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 93173f0a09c7..4c265b7386bb 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -2427,6 +2427,7 @@ config EFI
> > > >         select EFI_STUB
> > > >         select EFI_GENERIC_STUB
> > > >         imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > > +       imply INTEGRITY_SECURE_BOOT
> > >=20
> > > This allows both to be en/disabled individually, which I don't think
> > > is what we want. It also results in more churn across the
> > > arch-specific Kconfigs than needed.
> > >=20
> > > Wouldn't it be better if IMA_SECURE_AND_OR_TRUSTED_BOOT 'select'ed
> > > INTEGRITY_SECURE_BOOT in its Kconfig definition?
> >=20
> > As much as possible, EVM (and other LSMs) shouldn't be dependent on ano=
ther LSM,
> > in this case IMA, being configured.
>=20
> Sure, but that is not my point.
>=20
> This arrangement allows for IMA_SECURE_AND_OR_TRUSTED_BOOT to be
> enabled without INTEGRITY_SECURE_BOOT, resulting in the stub
> implementation of arch_integrity_get_secureboot() being used, which
> always returns false.

I understand your concern, but instead of "select"ing INTEGRITY_SECURE_BOOT=
 from
IMA_SECURE_AND_OR_TRUSTED_BOOT, how making IMA_SECURE_AND_OR_TRUSTED_BOOT
dependent on both IMA_ARCH_POLICY and INTEGRITY_SECURE_BOOT.

Including the "imply INTEGRITY_SECURE_BOOT" here in the arch Kconfig allows=
 EVM
to query the secure boot state without relying on IMA_SECURE_AND_OR_TRUSTED=
_BOOT
being configured.


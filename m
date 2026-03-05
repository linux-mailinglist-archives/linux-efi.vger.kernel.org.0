Return-Path: <linux-efi+bounces-6247-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JubAPG9qWnNDQEAu9opvQ
	(envelope-from <linux-efi+bounces-6247-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 18:31:29 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B4216421
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E6530579DF
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2026 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313E39E6FD;
	Thu,  5 Mar 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f5HhaZL2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24931FBCA7;
	Thu,  5 Mar 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731597; cv=none; b=dVpHcTHtl7sNzMHmv5R4We3lHKKRgdyJCTIUeeH6S/qfIv1/pOhDD6xf20bam8SwjDLWdm4Bp56kDJa1MT8Ao79CgtuDBQa4Agy6u0kjOE5rjWZQ0kcq1SrbouE6bp7THLUDZqAB1gziNrXlutcSt5AUHnBM4W1FpEbgu38ySEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731597; c=relaxed/simple;
	bh=+MuY8pawrgi2FwNb6rRlOW9g7zPesgMFXQ7H4DyrZcQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=bMOU+admFMdY47ynBatHaKybIYLOtltslRB0XrWwUJkLTcgEINA9A0JFQP1PHx2uCrUw7wTQ/LVczo0Pmbm11vrDhXd/I2IV/lhmOzDxI9R83sPmz7lMuwNCWOvlVgsgkhUV4swXcSl6cpaBJoYO4WwvBPwbUxnhKPTGmDp8jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f5HhaZL2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6256XhaF2358989;
	Thu, 5 Mar 2026 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pKEoPg
	CndWCLrBzB+ANvkugEGsbEG9dKmNVe+ux6b/I=; b=f5HhaZL2YLiPpyCKTkbu9J
	IGDq/HdnHKBMZigcHjg/Cd8VlwblJsE5+TR6lvbkI5Itkm2FCCPoXMXxxGzkVVvN
	bkMVpn/KPZJI92/LSPO0lr5t3nk74fy+h6B7QHwtK66PgaHvIhzoBAIVFUVNx7es
	hquql/vPTH9LvLzyoPvW3uKrBwLMuJiaoyB4zSQFiKMgm+Z214WiMZhbLKDnsQB9
	U5nt7kT7cFoq0J8dv4iysXNG/Lx8rndllpDctzwLpxo/qsWhw/+udsiCIS98ggBq
	yb3XfU9eksHCf7WGOG0KxVZb3P+eJYk7eIXLSYGp91e+yU344EWER5UygGXcPBww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk44ce4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:25:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625FQouo027658;
	Thu, 5 Mar 2026 17:25:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjm17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:25:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625HPips8979076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 17:25:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A49858056;
	Thu,  5 Mar 2026 17:25:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC9F5805D;
	Thu,  5 Mar 2026 17:25:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.185.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2026 17:25:42 +0000 (GMT)
Message-ID: <b33086b5f20a635a86d935fef3f4c429c723f6ac.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Ard Biesheuvel
 <ardb@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Coiby Xu
 <coxu@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Madhavan
 Srinivasan	 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin	 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle	
 <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar	
 <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen	
 <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>,
        open list	 <linux-kernel@vger.kernel.org>,
        "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
        "open list:S390 ARCHITECTURE"
 <linux-s390@vger.kernel.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE
 (EFI)"	 <linux-efi@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        "open
 list:KEYS/KEYRINGS_INTEGRITY"	 <keyrings@vger.kernel.org>
In-Reply-To: <c00-01.ttbfdx5@ub.hpns>
References: <20260213012851.2532722-2-coxu@redhat.com>
	 <c00-01.ttbfdx5@ub.hpns>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 12:25:42 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: n5u3KvkqHsHSG1MPOf93GcHhdfPo5Ydn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0MCBTYWx0ZWRfX2GwyKh4RC1hO
 8e835PXQ73sAhRTjc5hcUXNuRa16LUmjeYrKhRTH8uumRPD6u6AHpv+R1U4wbUNUKtaVD4BCTwU
 Gs+8eec+4MXi+5GADfbifXChrow3C7bOocLltn0fEKw6L/ghXKT3D9c7AQEND5Uxazf8QO/as6O
 J5n+fKJXv/TUTDvqUiyiZIgw51FJfJVs8F857zTKeHXbBMmRDNcvSlDk8Xig0Ffwjxv6t2OSjLR
 H1mzlFXc6/oBzQqofGITH/P1rzOap9r9zEpCq7G6PvzEKhDJtotff/HlT1iz6uiuttTQhZblak4
 7lPagrK2S28ATugKW7HODfQ1dDd7pFes418ioZ7o7ZU73J8mwDENhGclmBn91xk0SlzKfvnVbi7
 5YqF7xT68eY0VP3tD7JPON8zHDmEngH2dZZrq5VbC3H+w0alPrWtihSo4X35W0+8XOvAzN7Lv2h
 Ah50ca8+F56uPHOCZ7w==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a9bc9a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=FlYQV3jgbqAUZRz1eTYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1tcHdgBiVXli_g0ESprzx_tD6GHaaEJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050140
X-Rspamd-Queue-Id: 5D9B4216421
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,kernel.org,intel.com,redhat.com,huawei.com,ellerman.id.au,gmail.com,alien8.de,linux.intel.com,zytor.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-6247-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Thu, 2026-03-05 at 13:55 +0100, Vasily Gorbik wrote:
> On Fri, Feb 13, 2026 at 09:28:46AM +0800, Coiby Xu wrote:
> > EVM and other LSMs need the ability to query the secure boot status of
> > the system, without directly calling the IMA arch_ima_get_secureboot
> > function. Refactor the secure boot status check into a general function
> > named arch_get_secureboot.
> >=20
> > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  arch/powerpc/kernel/ima_arch.c                |  5 --
> >  arch/powerpc/kernel/secure_boot.c             |  6 ++
> >  arch/s390/kernel/ima_arch.c                   |  6 --
> >  arch/s390/kernel/ipl.c                        |  5 ++
> >  arch/x86/include/asm/efi.h                    |  4 +-
> >  arch/x86/platform/efi/efi.c                   |  2 +-
> >  include/linux/ima.h                           |  7 +--
> >  include/linux/secure_boot.h                   | 19 +++++++
> >  security/integrity/Makefile                   |  3 +-
> >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
> >  security/integrity/ima/ima_appraise.c         |  2 +-
> >  security/integrity/ima/ima_efi.c              | 47 +---------------
> >  security/integrity/ima/ima_main.c             |  3 +-
> >  security/integrity/integrity.h                |  1 +
> >  security/integrity/platform_certs/load_uefi.c |  2 +-
> >  security/integrity/secure_boot.c              | 16 ++++++
> >  17 files changed, 115 insertions(+), 70 deletions(-)
> >  create mode 100644 include/linux/secure_boot.h
> >  create mode 100644 security/integrity/efi_secureboot.c
> >  create mode 100644 security/integrity/secure_boot.c
>=20
> This triggers a warning on s390:
>=20
> arch/s390/kernel/ipl.c:2507:6: warning: no previous prototype for =E2=80=
=98arch_get_secureboot=E2=80=99 [-Wmissing-prototypes]
>  2507 | bool arch_get_secureboot(void)
>       |      ^~~~~~~~~~~~~~~~~~~
>=20
> @Mimi: could you please squash this fixup into the offending commit,
> or pick it up separately?

Thanks, Vasily.  It's now squashed.

Mimi


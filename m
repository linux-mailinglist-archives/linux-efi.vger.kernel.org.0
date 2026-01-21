Return-Path: <linux-efi+bounces-6029-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxiGogbcWmodQAAu9opvQ
	(envelope-from <linux-efi+bounces-6029-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 19:31:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26C5B4BF
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EE7C1F6A
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jan 2026 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6A36AB4B;
	Wed, 21 Jan 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fz46yFRn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F4350299;
	Wed, 21 Jan 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010088; cv=none; b=QroN9BYCHQl2gZkBK6UNucXeqpqyZ9Z9dBC3ZEo0orTgingPHgPqOOqmwg4JVCz6/VTHj9IN9EvhX2zFzc1M6E+3CUuB3oo1WagNOQEgErbGgZE5tgett/H1oZtF1PSsaC378NJlwkgKwPpEEKzrFzFCqHg5+Ajs069v16EvKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010088; c=relaxed/simple;
	bh=y1ImJ/lHUAuBqoK9nxj40M0Ec4FxeRNekNIObxI9hwg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=OUi3npv/vOwDUrY+2YcscafLZKhOfPuPsnVg89Kfo0Q2NE61yq8tRsv3I421Eo6bRn/655RY3g3KGnv3l+138P+hIMYNHf+pFF5H0edLlOsrnQ6jKWUOL1YMKaxQr9Bc+PgophV0PuoHIcKpssLSJ/Dh2YIP4V5ku79mMnz9QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fz46yFRn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LDFWum022363;
	Wed, 21 Jan 2026 15:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bJMVsq
	MsM4TnBCGz+qOUq+rSyO+NcLPnv+SRm0UJHUk=; b=Fz46yFRn/4wweJ9HwSyn0M
	O3wMo3wca7aVIRwbN9CVhisZqENfMc3HFhMI1R1Hx3KlGjqlCbZu8AwagKRLPCSE
	KtbG9M1zbOrU6CS/8hQ7+xY8nLu6NZBIPG3FqbU2NILd7Kr+x97ij2PEFDIvdotI
	oWWgB/SNLr12otmb1cQa5ke23HCD3AhJkN1Ur2fRH8sIgYjdrg+0kXlfxxvYZaeh
	XDi9IeeWEL8Gwxf+ieJlCDTdY+XCpQfVaWFMSPNvevLd6Fj10LKPVjInhi2ZhFAk
	lR7Iwg87QYukvsa1i02OLJ2S1y8vKtGPgs58751UIWYcUvh+c0nYDXPgWuhL/RZQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufkuhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:40:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LFeVHZ006354;
	Wed, 21 Jan 2026 15:40:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0ufkuhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:40:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LDDsf5027334;
	Wed, 21 Jan 2026 15:40:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrn4u84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 15:40:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60LFeSVo29426232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 15:40:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 559AA5804B;
	Wed, 21 Jan 2026 15:40:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2938158065;
	Wed, 21 Jan 2026 15:40:25 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.58.59])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Jan 2026 15:40:25 +0000 (GMT)
Message-ID: <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Dave
 Hansen	 <dave.hansen@intel.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
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
In-Reply-To: <aW2i3yacr5TvWU-m@Rk>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-2-coxu@redhat.com>
	 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
	 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
	 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
	 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
	 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
	 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
	 <aW2i3yacr5TvWU-m@Rk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2026 10:40:24 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WAqyQc7iYAb6bBztJEBir9hqT_fDY33W
X-Proofpoint-ORIG-GUID: cSwAFNrvWB6VDbqJDgghQDN6Ynh6VVyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEyOSBTYWx0ZWRfX3pjDpN110rfB
 f6LDluWAghYKhOYecWjxKqd1c4jRq0EL8adCIUMRJ1yCj9fhFWCTR8NlKTqMvOdjFnDezXfHyR7
 CRP+BNm9lrFrQrrUKiI9/q77mePoKraN92J2qBc1dRLRgRKb2rIpAL/MAru7pVfnrRhoBcXV5y5
 EVA9mCACOo0XE9en1N7SIg85RSjzUV59UIQBHeGztZoRKcuBrbh8cSsbnucRZMzSPSoRVhOx9ka
 wTaxrZmi1RmhiaBK0ahLVEuKzQi/GbfItGcq/AQqhGwiRRmIu+u6Aft6ydCxGG82EWnM/jdYsNE
 uqofPbC7m7ooe2l5GXr4FgTo1pvIYS1Kudl7tRh1P0c93Avu3UprXRB6JXXms7V/+I3K2wmMYek
 85uYlsmRGCksYBiXA9wQ58l+B+huOfRUe8zxiNqoAq9NlKw4z2E66a/6W4lRi3ioTJAz5IEM6hE
 Tu8ERwmmxKjDi9qIu/w==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=6970f370 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iN3FFbS9Bkn7VKFBHvUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210129
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
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,huaweicloud.com,arm.com,kernel.org,ellerman.id.au,gmail.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6029-lists,linux-efi=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 0C26C5B4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:

> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 976e75f9b9ba..5dce572192d6 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>          bool
>          depends on IMA_ARCH_POLICY
> +       depends on INTEGRITY_SECURE_BOOT
>=20
>=20
> Another idea is make a tree-wide arch_get_secureboot i.e. to move
> current arch_ima_get_secureboot code to arch-specific secure boot
> implementation. By this way, there will no need for a new Kconfig option
> INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
> concern.

Originally basing IMA policy on the secure boot mode was an exception.  As =
long
as making it public isn't an issue any longer, this sounds to me.  Ard, Dav=
e, do
you have any issues with replacing arch_ima_get_secureboot() with
arch_get_secureboot()?


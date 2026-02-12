Return-Path: <linux-efi+bounces-6117-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIZxKmk3jmkhBAEAu9opvQ
	(envelope-from <linux-efi+bounces-6117-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 21:26:17 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D1130EF3
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D6F33008602
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE12F7462;
	Thu, 12 Feb 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZWbkLAwn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA00242D84;
	Thu, 12 Feb 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770927972; cv=none; b=sOXpE0vbMK9J2Bd6sppzVH+Ota2dh0Ruz1Xqg0DyHs+Ne392wk6l1QiV+LBKBX6PsZlM7pHOlfZFOp3rcQOgohS0F/pKx3OflfB9ORmss8yyR6G7aTH/WiW0xg3jF3RESzlm0qEDDwtVVPOoOsPcRoyywQxj3COhSVwLHjzT7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770927972; c=relaxed/simple;
	bh=8IaK+mPLmqODUT1T5Ma9a4TIwbT/y3MgP/VUortegzM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=WcDJYD/TvM/wxoQUyvbwjTw6xdXxBDr+jWvHF4irB/YlU+dN8tnpgs556wnpDRuip92a9Am61OoJ6NJkTEaiZmF5hk7t5QA9t3AMxwTFgDYSGPLRzT1t3lrQEgouq4qghElvt0vS64LwrlCJMpgJgUfz6JWaopJ1IBX/8JoU50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZWbkLAwn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CK42Oq2890525;
	Thu, 12 Feb 2026 20:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/AQFd9
	vIuiZK1MsItmBHlvbYNCfVXPM+5ScmYYs9mLw=; b=ZWbkLAwnH/Mf7Vb3Fq2Hmh
	mByWePhvy1+ieWdA9hRLCmoYbYwnWs8zrbIW/8/Uac2QT/zGITnLJohKhAOxooh2
	cPufbdU1Xk4UgxZSY8Lw0INMeSIaBejxrW26T/dr87KkvcauiAKoURtMGF5rs2kj
	DPeSc1QxeWokVwBS/Vri5yb+ltCOjQuv/W3qRa/RZOGgINq/I7iW6xgs7ZHu8VkV
	kl1fLZoa4o9/34g/aERijUGC/58aZtp+swTMRAN8Am5v7uhivD9YR4EOuMu81iCu
	fk99bxwQdOp5dzuRM9yP4Laiwe9vVP2+SOz8gPYhrYCuTIywBbNe+cnk0KPE5FgQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696x5a69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 20:25:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CGf35A008400;
	Thu, 12 Feb 2026 20:25:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ym5yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 20:25:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61CKP0Qw22807052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 20:25:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCD658052;
	Thu, 12 Feb 2026 20:25:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8221258045;
	Thu, 12 Feb 2026 20:25:17 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.193])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Feb 2026 20:25:17 +0000 (GMT)
Message-ID: <0df1685d630035d5ab0e32f4b4d26db9bb6a91a4.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Ard Biesheuvel
 <ardb@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	 <mpe@ellerman.id.au>,
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
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav
 Petkov	 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"	 <x86@kernel.org>,
        "H.
 Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
        "open list:S390 ARCHITECTURE"
 <linux-s390@vger.kernel.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE
 (EFI)"	 <linux-efi@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        "open
 list:KEYS/KEYRINGS_INTEGRITY"	 <keyrings@vger.kernel.org>
In-Reply-To: <aY0rZp9ROwfjPgD8@Rk>
References: <20260203041434.872784-1-coxu@redhat.com>
	 <20260203041434.872784-2-coxu@redhat.com>
	 <66f9d13875e81a965984e2a661e992a3fe43c516.camel@linux.ibm.com>
	 <aY0rZp9ROwfjPgD8@Rk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Feb 2026 15:25:17 -0500
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698e3734 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=rnUjhx4C2NHl8nqPuY0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4ry9PeEgol-hXXYqsZobF_X61z83qHwt
X-Proofpoint-ORIG-GUID: akyquk1pgbcHhjp5hBb1sq5u85ZLzeyN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfXxoerCjpT3xeC
 zVMGloxz4oW7ZH0W1JnLHvCmD2zg4YHQTE47xu8EW/NtZWUolzpugCzh88tpiXJj8iOkzbnbbPZ
 oyEF2cGUDTu5zmXg0GtBJXqiqr97EYRxO1V21iNJikJ916bkPjgSnFA6BpA0M0rYIdcdoIj+kk4
 1i4FJaLyFR/moFs0b8otGG1PH+MKLZ+oHFFnHFHQ4sPEx9WulQqY/E3jyU7GINS1QGXJvKCJk5I
 BLQ7JehWDeB/ooCr0Ujtj8QDw/HRUHHNwldeQYGrazfVdj3idM15NpDUooVHxmuDbFoH3gEM7lj
 WHoVf28JqVzJbgbGqq81WWiNeu5YIu98GvfuDJuYYZdRvSHON/dYzvAFm3KkVh314o3tn6yJWfJ
 nKyi9ZPtfKieX3I0MtXxxahawVM8cAFwxtUb8gSHq0E7kpxWNF3F7pER/1KycdC4WYFEmoMCZUX
 i1bGF7uv4SxiPXz7Egw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6117-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,kernel.org,intel.com,huawei.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: BE9D1130EF3
X-Rspamd-Action: no action

On Thu, 2026-02-12 at 09:28 +0800, Coiby Xu wrote:
> On Mon, Feb 09, 2026 at 03:43:08PM -0500, Mimi Zohar wrote:
> > On Tue, 2026-02-03 at 12:14 +0800, Coiby Xu wrote:
> > > EVM and other LSMs need the ability to query the secure boot status o=
f
> > > the system, without directly calling the IMA arch_ima_get_secureboot
> > > function. Refactor the secure boot status check into a general functi=
on
> > > named arch_get_secureboot.
> > >=20
> > > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> >=20
> > Thanks, Coiby.  Other than unnecessarily splitting a line, the patch se=
t looks
> > good.  As soon as the open window closes, I'll queue these patches for =
linux-
> > next.
>=20
> Hi Mimi, thanks for reviewing the patch set! Would you like me to send a
> new version with the line splitting issue fixed?

Yes, thanks.

Mimi

>=20
> >=20
> > > diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/im=
a/ima_efi.c
> > > index 138029bfcce1..27521d665d33 100644
> > > --- a/security/integrity/ima/ima_efi.c
> > > +++ b/security/integrity/ima/ima_efi.c
> [...]
> > >  {
> > > -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()=
) {
> > > +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
> > > +	    arch_get_secureboot()) {
> >=20
> > No need to split the line here or below.
> >=20
> >=20
> > >  		if (IS_ENABLED(CONFIG_MODULE_SIG))
> > >  			set_module_sig_enforced();
> > >  		if (IS_ENABLED(CONFIG_KEXEC_SIG))
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/i=
ma/ima_main.c
> > > index 5770cf691912..6d093ac82a45 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -949,8 +949,8 @@ static int ima_load_data(enum kernel_load_data_id=
 id, bool contents)
> > >=20
> > >  	switch (id) {
> > >  	case LOADING_KEXEC_IMAGE:
> > > -		if (IS_ENABLED(CONFIG_KEXEC_SIG)
> > > -		    && arch_ima_get_secureboot()) {
> > > +		if (IS_ENABLED(CONFIG_KEXEC_SIG) &&
> > > +		    arch_get_secureboot()) {
> >=20
> > =3D=3D=3D>
> >=20
> > Mimi
> >=20
> > >  			pr_err("impossible to appraise a kernel image without a file desc=
riptor; try using kexec_file_load syscall.\n");
> > >  			return -EACCES;
> > >  		}
> >=20


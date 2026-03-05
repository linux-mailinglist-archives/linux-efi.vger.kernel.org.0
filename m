Return-Path: <linux-efi+bounces-6245-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIX1DPV9qWnA9AAAu9opvQ
	(envelope-from <linux-efi+bounces-6245-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 13:58:29 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D018C2123A3
	for <lists+linux-efi@lfdr.de>; Thu, 05 Mar 2026 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59857301D330
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2026 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CF39D6C2;
	Thu,  5 Mar 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Go259zIj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482F2989B0;
	Thu,  5 Mar 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715362; cv=none; b=simAn024MslzQ91yoxwIRNOm2bpzDpUbmlMWkc4++7abgaB2F9xSI9FmMqOD7gD2A9MsCyafWattb4EmBS+ISjQyoh1uj8qBH+KF3rZOZBVGTXge4iuiPcSfeVbGv2mvPwS5rAycsJ/pZw2mF3blRrEG0wV77JDJ1XHxVznlmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715362; c=relaxed/simple;
	bh=B7EMvc3myE97Jkf7cH5kQkeIoARk8LOW3DPlHDFB3OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZGUFq07EBC7Kmr1r3MsiVMSj9FXP+7qX6xBsKzIGdzbZSI6Zh5VelQ6PS4o6e6wUtzoByywdGoC+LLdcTvrsBnTIJaGviK0cmqiNVv5FnGHwisn/XMYWmTmcURndoni52HOJlOc/hm0DQDhO2o2gHr3HtoR0fhOsGQItCm6ufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Go259zIj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624LUFuQ2339714;
	Thu, 5 Mar 2026 12:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j46n/C
	l/uiusceyLFOPeUtqO6xM+QOc9rxRmh/YsaFw=; b=Go259zIjpiUsEZ2/VSp1+C
	ajKQN/kmWvrD0WAn+M79WyyoB6eOAjm9paqjImI05Yg622mR0mwRGhjnXuimibrj
	imWAt59vofH6aAXQmFuz70TaypdqlBR1ZzA6Q5Z5HE8VzRH1/+Y0FyFZ11MP2xg/
	djIhFxbFZxz7DOBJRaJdWke1zUk+0N1OmXQDfXEf2VNEd46D1UE09yiJ1eusG9k0
	TpQSWdUgSf/SkopozJf/rEgUa0cx+Cr0vmZQFa/YYWdSqG4hPqJtlcLM9LOt4m4v
	GQPiWRGYBa+47ir2Dyv3nQxU1LEyXbjQ7/2wgwFTH/D8FD4SmraXknK5jBRt0EGA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjbrkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 12:55:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6259TYY3016397;
	Thu, 5 Mar 2026 12:55:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpnbb4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 12:55:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625CtCPS24380116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 12:55:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D2E20043;
	Thu,  5 Mar 2026 12:55:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC6C20040;
	Thu,  5 Mar 2026 12:55:10 +0000 (GMT)
Received: from localhost (unknown [9.111.42.248])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Mar 2026 12:55:10 +0000 (GMT)
Date: Thu, 5 Mar 2026 13:55:09 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Coiby Xu <coxu@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: [PATCH 1/1] s390/ipl: Fix missing arch_get_secureboot() prototype
 warning
Message-ID: <p01-01.g9ec0a81d34d1.ttbfdx5@ub.hpns>
References: <20260213012851.2532722-2-coxu@redhat.com>
 <c00-01.ttbfdx5@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c00-01.ttbfdx5@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a97d36 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=xVpku4ZQUFglSi1p0tMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEwMyBTYWx0ZWRfX+RUQn6BMd6jT
 SH21bGK5IhuRS3+4aQfGKCoOdauWr6O8JO/otto6IL/mxask6aIaBTJKuK/BfMWXbWSVe7hJqMS
 IclNLXFmKCZ6YKMVqlWCSzEpHzITp8/HIx8PMJjdO2RzdiROBdj2xXW/ydOeq/9toaBoUxpzllk
 1aMqO/wmDBfEDrpAEQaCC4q39mStv0Ds3eBLOiGR0LCffXuc30hXi1plumFympjJRXPfrmVi6Vc
 ey1yJs4AgDFoEi4HVj+fU3G50EgNmoeslm5M/Y+8PZDtx+khYV+Lyt7KSJ9iaGPANH1DcvJ14ZB
 X1YdAuHhY3EuO47eqGxtmP32mRip1+IQQxDlFcKiQf4ba8UHtCjjqayW+Wx0WmNOeGbExaBTXOQ
 pRdskS0tqYVg+SufInrncQzxcQ+rSORmJLb+dGRtryi+DMoXnxzhFrzxjlhLPrEd9Qu/UUOrA1B
 aoUYVM+cJv650sOf6xQ==
X-Proofpoint-GUID: 18tUCaDZUazDvapJ0KrrVhGhLVF5GXbk
X-Proofpoint-ORIG-GUID: ySm98qxoHM4Lds6ch4Hca4o4NZD8yC-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050103
X-Rspamd-Queue-Id: D018C2123A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6245-lists,linux-efi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,kernel.org,intel.com,redhat.com,huawei.com,ellerman.id.au,gmail.com,alien8.de,linux.intel.com,zytor.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ub.hpns:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gor@linux.ibm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Include <linux/secure_boot.h> so arch_get_secureboot() has a visible
prototype and -Wmissing-prototypes no longer triggers.

arch/s390/kernel/ipl.c:2507:6: warning: no previous prototype for ‘arch_get_secureboot’ [-Wmissing-prototypes]
 2507 | bool arch_get_secureboot(void)
      |      ^~~~~~~~~~~~~~~~~~~

Fixes: 63e8a44395a4 ("integrity: Make arch_ima_get_secureboot integrity-wide")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index bdbbedf52580..2d01a1713938 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -21,6 +21,7 @@
 #include <linux/crash_dump.h>
 #include <linux/debug_locks.h>
 #include <linux/vmalloc.h>
+#include <linux/secure_boot.h>
 #include <asm/asm-extable.h>
 #include <asm/machine.h>
 #include <asm/diag.h>
-- 
2.53.0


Return-Path: <linux-efi+bounces-5857-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE0CC0389
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8FDC302BAB1
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8332C30A;
	Mon, 15 Dec 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9DG33JE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34F32BF20;
	Mon, 15 Dec 2025 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842080; cv=none; b=LHePYfks8PJydAU43GIbZL2/3+xJfWBScKGQpRixVIx95XO4ZXymIenA57TUiFHNWfTi1atFgZ3YP60g95K332swGc+uCSvbAApXiWydgBYQrDKlFwsbAO64BJ3SjeK9LkQWEbl/9nwc4X6a+OYLZQ6sGlq9di7IeNeF4PuyZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842080; c=relaxed/simple;
	bh=GVzFzzeNGPTsvunuacL1zcLM6PpjBnBKHmnoTAO0a+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I45yY5VDz1RyDQZsS04Fumh13ilbi7kHqKPbz2uf2SsTHAmZma0sJgpzK+VymCUGFrzgG+oNWVkxVSLwA+4luN9gf7PylRRged6q+nvm7D5O9m/UHPwiZBnqetVOxD6dxy2zDsD5IWQAPi9m1G4ewqQ5v4aL1tHpiGLQJSJBuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9DG33JE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJC9NN2854561;
	Mon, 15 Dec 2025 23:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8uofc
	bSfGlpCjUvBjSl72oxbTxOwKo5M7SgUb/feGLU=; b=Y9DG33JE+760toFIFlg1G
	tcLdzugveQhSZPvgize0rpPGCPaoO3Kt4GPXkE6bu+b+2GNvhV3rjKwKJ+bFjjmi
	SYd1RKA0NR4AHQK0gMHUpV6aaGyOSEM4FBx4tBoscGYs2QE7cHlFwdyWz8e44MDS
	MQqgQB+itIuzvXiT8BZNa6jQPJGmhXhLLDajXM3oM70qjcHauaOzvWC0PJIU+AVS
	bNyNo5ibnMNGjWOOmi4kKNTysrW1kbZ1SUWoPWqQu/83G3OFJGhqVljWTIWy/ig4
	hpChYV4CKD87y2eZ5h3Usfs+Ukolko7yBB0mUD284i7wmehkABUflt+r4XmMPO5J
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28b344-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLLApL006117;
	Mon, 15 Dec 2025 23:40:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck92f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeQWt023729;
	Mon, 15 Dec 2025 23:40:26 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck91s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:26 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v15 09/28] tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
Date: Mon, 15 Dec 2025 15:32:57 -0800
Message-ID: <20251215233316.1076248-10-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: XQTJJ1BtKhsapMRjwsbsyetQVE9Rggam
X-Proofpoint-ORIG-GUID: XQTJJ1BtKhsapMRjwsbsyetQVE9Rggam
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69409c6c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=tOEGE3zv9T2N6F5oSXYA:9 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX1jCzVDnWyKQy
 GsW9pqE951xsh7GSllEg6Tc3SptJjDkQU9rAtbBbAmuxFcnnODphcuLu8AURePoTBI7stcZLdS7
 ctOg3owCz0ZtRN0rHT1fEMBt6SREK6j/Cj7zEEF7bMBPddzzUSObZyCymyQP3JL3w2g4QznIxTf
 B0ow+i5UnPpFiVO0js34nBtYa3rrIuB8i8HoXiGr3PocIK0bKaZoYjpVacCh8hI9GF+byRWSLoG
 69nKoBvhBhpJXr0XvknvKh8/ZyeV/XmaaBZdimdQAe4Y1OoVf0ZizWTznGoSvOpRpYAOEeQPefc
 L4aT3lS9/Ie/z7wRbVc1QF1ExBK3vQWa1ulAgK5ZssCCFbg7OXsBZfpejMtF8uFenWJofnSOYdd
 YRcIa8+e2JywlOEvJnfFn6lKVx4q6iop8fQ0oLfj/d8GFjg4HMU=

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Validate that the input locality is within the correct range, as specified
by TCG standards, and increase the locality count also for the positive
localities.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 12a2340dd5e0..14a7e60bfbb8 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -233,10 +233,16 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
+	if (l < 0 || l > TPM_MAX_LOCALITY) {
+		dev_warn(&chip->dev, "%s: failed to request unknown locality: %d\n",
+			 __func__, l);
+		return -EINVAL;
+	}
+
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.43.7



Return-Path: <linux-efi+bounces-1107-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638968D5806
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 03:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005CEB2576B
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3943B757FB;
	Fri, 31 May 2024 01:32:58 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201E62A02;
	Fri, 31 May 2024 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119178; cv=none; b=e+mGPJ8x7Two75ImBLfbwH1z3TUysmKFJD/bWjkzOpUCKZsd45AZnERrxStvQgUCef7nqBNLalU+iagA1gpmrGcihJ0ZQfBuDUDxnEgIwydm8WQCwccjyfUO6uaPVTMLYdRPgSyrxM7mV2LjBjT6b+mZXcr1xwUn1Qy/7ByVNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119178; c=relaxed/simple;
	bh=JJTsUAPunBAjg1h6FzqMqjlaIn4SkUMCdP2ghGcYl+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4mHXCK3o5mXwwTW/C2iUxGbUKV92cvQcdyR6NEz3rO2+hp9aQ/kpyf8QjB9PwndIb8ooIGPZHq2PNm1wfnntSO/Fb0aEETmVc1uQ4wnxWAVB+7Zx4LwaM5fbb79yY98hF07ztessj0i1Cds6ot12bJvhQW2eUgtDN3u1OYjzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFVBn8018561;
	Fri, 31 May 2024 01:31:35 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3Db5NDsXm+3HZ1IU6nSFDdzN4zSa40CUJq8u61Rm7TCIY=3D;_b=3Dnc3CSmrt?=
 =?UTF-8?Q?TNEmHQ5iTiFg1/2ZsGQNOkCGS6+QtWba7anGqOq6ahkBAnR3p1HY5dkuaHqa_Kv?=
 =?UTF-8?Q?tNB7vstlOBv9JPeJ5x9gPSvjTZ1z80IF6nd9bAaqDjvQClmRcKJLEEub71QiVQP?=
 =?UTF-8?Q?dDC_2RmooWYVwR37gqgrWwHeJVi0Xk5qwv2Lb30D+79LHHlII6th2WsCoXX0Bxv?=
 =?UTF-8?Q?PFAYR8ejy_Uh7/vh0RXqjj6WVUMyeuZkbcMa4SGMIQYzRPyKSZI+iyI2AQVWuLn?=
 =?UTF-8?Q?hnYM7WVtFj0V6xQ_fGEYs8s6D6tkbE2PFZwp+u0ZVHKPlcBuNuKzkGX2R6bHyU/?=
 =?UTF-8?Q?FqNlZYep7Nnft2emYPRcs_LA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a3es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 01:31:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V0m0Hk016324;
	Fri, 31 May 2024 01:31:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t9842-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V1SKNm027418;
	Fri, 31 May 2024 01:31:32 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t96yw-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:32 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
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
Subject: [PATCH v9 17/19] tpm: Add sysfs interface to allow setting and querying the preferred locality
Date: Thu, 30 May 2024 18:03:29 -0700
Message-Id: <20240531010331.134441-18-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240531010331.134441-1-ross.philipson@oracle.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310010
X-Proofpoint-ORIG-GUID: ej6ynCvmicW4fYM626_JXYWy6934H7pR
X-Proofpoint-GUID: ej6ynCvmicW4fYM626_JXYWy6934H7pR

Expose a sysfs interface to allow user mode to set and query the preferred
locality for the TPM chip.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..5f4a966a4599 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -324,6 +324,34 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(null_name);
 #endif
 
+static ssize_t preferred_locality_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->pref_locality);
+}
+
+static ssize_t preferred_locality_store(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	unsigned int locality;
+
+	if (kstrtouint(buf, 0, &locality))
+		return -ERANGE;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -ERANGE;
+
+	if (tpm_chip_preferred_locality(chip, (int)locality))
+		return count;
+	else
+		return 0;
+}
+
+static DEVICE_ATTR_RW(preferred_locality);
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -336,6 +364,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_preferred_locality.attr,
 	NULL,
 };
 
@@ -344,6 +373,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_preferred_locality.attr,
 	NULL
 };
 
-- 
2.39.3



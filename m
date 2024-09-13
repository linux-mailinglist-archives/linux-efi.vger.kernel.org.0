Return-Path: <linux-efi+bounces-1765-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADF9789AF
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A151C23156
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8764148848;
	Fri, 13 Sep 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8kN+lzK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC83155324;
	Fri, 13 Sep 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258428; cv=none; b=ScqdPUeEHQ6zYLSy10RuCiCQBX02db+7sLHEIhQUsuesqzyYmuYmNJtXV7iT/XbOejIP/j5zM7nGfY2uRTJFaSMdFqVTwD3PGcjA0IqBRoSG3o2yi75SCG2Q6PEjXpT16dhz15/m1lGbKKpgPj3FoBxf3c3O/2u5G28vkCPHnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258428; c=relaxed/simple;
	bh=evGACnvbfWiO6UA74ZSlig8rEz1CWWsumAR/dQaj4BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeOlEKH5uub5+Svd81KqW6NsBel8navZKqM6EzkYPNc66J0sNlp+3ShJ6jTE2WtluV7JWDyaFbSRLvs70thRnws68RRPOA/Kok/N9e7r5/3Z4Yoba7rX9S8zig6/93XQKnoFMbODSbgmVHvuhKCcN7QljYuUb0hLxQB+7eaGGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8kN+lzK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0YBb008515;
	Fri, 13 Sep 2024 20:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=C
	BwVi+IOsZakjKwBef0tUPxe+z4b+8YEf5WOjhPKBpE=; b=A8kN+lzKJozUHAulB
	/AkIP5AH3IdzRIGkInalHtBzO3E5yeG2TfltJq/edNgd9u8V1LjWBHqS3t9XrRpk
	AMvmdJJHK3z0IxWTu3KDvrKX2JPzSp/wMsFmOM17Jk0IHGcW5ApXHnSfgwICyh/y
	tT1mofk7OcymSqHWf4bVO7QylwsU07twhit+zmroZP8EDbDxZ1M/zaIJkuKEeHHM
	M629d2+u7NdXrMQYhU8SgTqkH2sWcoAJNpYbQXSxKDT91WbbH0B2H8Ut45De7MYt
	iJHfPpdknUYYplsy+sJ05ZeOT7PeeSUJEmbZ/zA1JauixXaQjst75UrAu7OyXKQb
	n3LCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbegyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:13:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJdHWh033569;
	Fri, 13 Sep 2024 20:13:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3pkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:13:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DK89wV014063;
	Fri, 13 Sep 2024 20:12:59 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d3phc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:59 +0000
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
Subject: [PATCH v11 18/20] tpm: Add sysfs interface to allow setting and querying the default locality
Date: Fri, 13 Sep 2024 13:05:15 -0700
Message-Id: <20240913200517.3085794-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130143
X-Proofpoint-ORIG-GUID: UeAmSk6ezsrPwNpW8Vf7p4qYLbs0iKRK
X-Proofpoint-GUID: UeAmSk6ezsrPwNpW8Vf7p4qYLbs0iKRK

Expose a sysfs interface to allow user mode to set and query the default
locality set for the TPM chip.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..185a2f57d4cb 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -324,6 +324,34 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(null_name);
 #endif
 
+static ssize_t default_locality_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->default_locality);
+}
+
+static ssize_t default_locality_store(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t count)
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
+	if (tpm_chip_set_default_locality(chip, (int)locality))
+		return count;
+	else
+		return 0;
+}
+
+static DEVICE_ATTR_RW(default_locality);
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -336,6 +364,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_default_locality.attr,
 	NULL,
 };
 
@@ -344,6 +373,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_default_locality.attr,
 	NULL
 };
 
-- 
2.39.3



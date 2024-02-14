Return-Path: <linux-efi+bounces-545-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1A855633
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 23:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2591C22B0C
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 22:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C336145B0F;
	Wed, 14 Feb 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CSM/NBTh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B5145B0B;
	Wed, 14 Feb 2024 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950210; cv=none; b=ZFFRwwgosNg1O0WfpBAX3Gewa6riicHpnAJRC5r+5h17YLspZXsNkJqYslwdo3zN4ugDla89hB2gyDyen+inBtiHoZvHYr7nbyfYRQ7qgZuHpa+SMDq6OEXEaWB2TUE23ikN13ONDEu94cC9drEPSHns8IotMTVh3VgwZGJ2sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950210; c=relaxed/simple;
	bh=MNl7hgcOP5vxEvVNCEzBNGyFwxzXBCb8aF9uo9XJndM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClxwTzw9jUFHIv5FmTWCUz79nwgtpI6jBMRx5xUAfKcc+j3Rpx3fGmlL4aAP3vmMd6zweuk1/F1rw0O1VLtm5vZ9ui+Ebt0Rqwv5c1XlU2fURFQcxKoOYj/Ma3W1u29KGjkjZGyAM9L5fsBzbz0gRAmxY2Q6vrGI1HtfIT96k+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CSM/NBTh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELiWL1022704;
	Wed, 14 Feb 2024 22:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=beF73PhQOvafRvxMrE9SGfQcxB3UIdpTP6nEGkw+3vc=;
 b=CSM/NBTh3VceRVKHqcI17YhS46VV9GwoWB+I6DTJIkkGTxP+cjuP84HeG0F10IwfYrUY
 9xF1eBonh+nhFmrcYvMVHwWgXZkONcLPc32kXIFd/NOpxhXB9KFlzF3P7+dFatZYdAai
 gF8ro+Y7ZvhXs2V/APYGFRSDQrmdADRuicJJ8yp3d+hjOEE7WE17wDOMpVnoHI+kbM9B
 IzZwgdrdkylbRK/+efZWyYG4QeSckHFg6RceBEJqwjW55ZAFI67RQ0H291zBHsEVx+zq
 b8EIrorETHx8I8XybbwRrps6hHNmLylR5yxf2FIlkWWCPxHhjUhLcfUpHUidG4JCgp/J nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppghka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EM9iB8000639;
	Wed, 14 Feb 2024 22:31:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVK004281;
	Wed, 14 Feb 2024 22:31:44 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:44 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 13/15] tpm: Add sysfs interface to allow setting and querying the preferred locality
Date: Wed, 14 Feb 2024 14:18:45 -0800
Message-Id: <20240214221847.2066632-14-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: tT6BUrEPGTkbAvCJEEglQruin3qInev6
X-Proofpoint-GUID: tT6BUrEPGTkbAvCJEEglQruin3qInev6

Expose a sysfs interface to allow user mode to set and query the preferred
locality for the TPM chip.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..c43630d0996e 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,34 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
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
@@ -321,11 +349,13 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_preferred_locality.attr,
 	NULL,
 };
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_preferred_locality.attr,
 	NULL
 };
 
-- 
2.39.3



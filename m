Return-Path: <linux-efi+bounces-1600-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390595FD42
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9B61F22A1A
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8519EEC2;
	Mon, 26 Aug 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BL9NaMAx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61219EEBD;
	Mon, 26 Aug 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712255; cv=none; b=h8/IjQdChSOl9FE9Kp6PHVTT/52zoSdQkSgWuaNksZVZ7P3sI7lj1nc/dsfWBQQBsA9K01a15jZOfGTSEuVkECjvNRGnbPHp12jbKQeHqkscxxM6ZWUbH7/P2M2lYYlrgrhlu9i+RF8aSn8wlvlHYuL79f5DOxL/ach8S5sYdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712255; c=relaxed/simple;
	bh=evGACnvbfWiO6UA74ZSlig8rEz1CWWsumAR/dQaj4BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDEzvPH9PWGY4sDSW7i+G3+QPEBhYgyNx6ZBPE/kc34R+VwCQiW3H5u7Fp5Ud5HGFLmJCV0kA7Rr31qr1KmrfvXwLWaVn4tPOZv0qdnavYzRg25/BxFM+RjsLwBjd7RYZx+rGg59j1Yx/pveerPP4DIpb+BF0CWRND0e4Lq0Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BL9NaMAx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtSbR002141;
	Mon, 26 Aug 2024 22:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=C
	BwVi+IOsZakjKwBef0tUPxe+z4b+8YEf5WOjhPKBpE=; b=BL9NaMAxZ9+EQDu7W
	jC8UBAbrv+cKb0hz5lOQlTXq+4B2e8lCkZeA7ntotVoL+VJKldPZ1z7GH97TIQrd
	u3Q5RBUh7bVpP+5ZudhXpqJ73qWHrYPjpbCNuqwvn1czus1WQOWLtFCim3Z+skGN
	mZgwVUO+sndR6s4BYackGK+urG4kqO3obigjV20yW9UrqucyoTq8JLRoP+Nu1+RN
	CfyTQo95vnnKPkGjlIlg33wmpZ3guSK6+w119XyoZrC56g0n+IWfhvDKmYnthVbi
	A9MvxAIyz91UmA9eEvhf1jtlkT3Ophn/Oxzsw9XMntKtJ0XNf1OXwbmhrQ4nTrCX
	GvnXg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n4491k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 22:43:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QMQHJc016714;
	Mon, 26 Aug 2024 22:43:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5rmqx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:43:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QMhgf7030531;
	Mon, 26 Aug 2024 22:43:42 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5rmqu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:43:42 +0000
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
Subject: [PATCH v10 18/20] tpm: Add sysfs interface to allow setting and querying the default locality
Date: Mon, 26 Aug 2024 15:38:33 -0700
Message-Id: <20240826223835.3928819-19-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240826223835.3928819-1-ross.philipson@oracle.com>
References: <20240826223835.3928819-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_16,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260174
X-Proofpoint-GUID: 95a73I-2QyKUy8AihDryftqMY6G9QY72
X-Proofpoint-ORIG-GUID: 95a73I-2QyKUy8AihDryftqMY6G9QY72

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



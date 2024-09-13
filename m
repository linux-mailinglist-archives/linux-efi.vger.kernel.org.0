Return-Path: <linux-efi+bounces-1763-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E489789A4
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F071C20F1E
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3215098A;
	Fri, 13 Sep 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W53GKjoL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F214F9FD;
	Fri, 13 Sep 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258399; cv=none; b=NkLDyT1jJNRHUGcCH0e4QLF1ue/vqrh0Jpwk3t16Sts1+MCxYRdLjYSwfIAJZgjX4ockt6bKxZQ7us6HWfy5lFmHD1CsJEzxNDGGtOclfpN8oF+00qXeC3Bj2wRNTQftozGOB4H66fMmuNdT3MBpPoQKz1Xyz5MGCqMtehUL15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258399; c=relaxed/simple;
	bh=2Dx1poMFInj5NHx9OAbSKdQ7X35FioAzcok5qUhAaf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCWZQy29znXtVUYFmgGdClzuSB+VpBm2DLPmDXIxrZMrYqiPAQcpJXCjKjOI2OrzDO7+R++yc1YDk2z5Hi83RAlHmGK2Yk9qlArRxc0LPh/Zn4xRZXIMj9nhp07yNCguHuwKleLfzCztwraPd7LOt3xGBGG/carB7amCq82HsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W53GKjoL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0XjF003954;
	Fri, 13 Sep 2024 20:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=9
	Nw22CaxXzlTl2N9NHPGDeoB6dwSTixh6nR+/z+gl9o=; b=W53GKjoLCZFoF9yzW
	DEYoHLwxmoEZgNBxq40pwYmLkO4idjeP3AsUJFP7WmhTaQ9PZTQVSHeZ35ikWkMX
	jOXTS5yCDsIcmJf6drUzKCWX+TSZiKAx+3RtKhxrqt5FN+bro3E/+zF+f6fWS8Fa
	roc66vzja6rE6r/J3d5xoP7DK7ttImDLtnJ/lvUhOLsRcUyfHAMrU0P6rbawOWem
	n+BOaw11SCX//PDTDZ3FRN39S+NiOPYQBdVkLzTWzoj3zIqitWWJhFUWvDyTPFdn
	2UKP1ClNHIFszKTnOh1jaS21L5wSe+JtaRX5cfj45hij/PGPzUuExVv8jMn72RU9
	LrjIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8d6agx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:12:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ4g3J004165;
	Fri, 13 Sep 2024 20:12:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d5ys4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKBMgw026004;
	Fri, 13 Sep 2024 20:12:42 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d5yr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:42 +0000
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
Subject: [PATCH v11 16/20] tpm: Make locality requests return consistent values
Date: Fri, 13 Sep 2024 13:05:13 -0700
Message-Id: <20240913200517.3085794-17-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130143
X-Proofpoint-ORIG-GUID: V4M0O0VjBzVwMbm6LIknqvU7671prB7l
X-Proofpoint-GUID: V4M0O0VjBzVwMbm6LIknqvU7671prB7l

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The function tpm_tis_request_locality() is expected to return the locality
value that was requested, or a negative error code upon failure. If it is called
while locality_count of struct tis_data is non-zero, no actual locality request
will be sent. Because the ret variable is initially set to 0, the
locality_count will still get increased, and the function will return 0. For a
caller, this would indicate that locality 0 was successfully requested and not
the state changes just mentioned.

Additionally, the function __tpm_tis_request_locality() provides inconsistent
error codes. It will provide either a failed IO write or a -1 should it have
timed out waiting for locality request to succeed.

This commit changes __tpm_tis_request_locality() to return valid negative error
codes to reflect the reason it fails. It then adjusts the return value check in
tpm_tis_request_locality() to check for a non-negative return value before
incrementing locality_cout. In addition, the initial value of the ret value is
set to a negative error to ensure the check does not pass if
__tpm_tis_request_locality() is not called.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 22ebf679ea69..20a8b341be0d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -210,7 +210,7 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -1;
+			return -EBUSY;
 		rc = wait_event_interruptible_timeout(priv->int_queue,
 						      (check_locality
 						       (chip, l)),
@@ -229,18 +229,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
-	return -1;
+	return -EBUSY;
 }
 
 static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int ret = 0;
+	int ret = -EBUSY;
+
+	if (l < 0 || l > TPM_MAX_LOCALITY)
+		return -EINVAL;
 
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.39.3



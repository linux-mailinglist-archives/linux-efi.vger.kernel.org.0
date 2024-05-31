Return-Path: <linux-efi+bounces-1112-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44D8D5820
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 03:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987C4283317
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CB7C6C0;
	Fri, 31 May 2024 01:33:07 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BD1CFB9;
	Fri, 31 May 2024 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119187; cv=none; b=gzPaTn9s61CK7fasI7wULEjhhq4QIVG2YreYDQFiW1CdngWCyZkLebRnHHOVIl4wJF7sZC5FDp6+s4A2Z37d2IJY1cFXHhrGU1KMOf24pv12fX9g0+Iqt5Vtt6I2DVhlPtfS1Jnq740RP+0RYiiH1Zcf8HW/XbSU57vMYgv2Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119187; c=relaxed/simple;
	bh=21Gd/FJ9cS8dF+oK8xfo0oJ0zEAzfbnEJ2lvHYHhbro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2vOgZjd3hI1ee1/OgN9g24hecXxAjavJQ7H46aSirH7gHi2rx2qQOIc0Gj/jLdx8mXX4DmgUE6NcYLoJ9U5O09Mqb8lPfToAlGfjPGMkGVewpHARZtZSR3vunF/3E+6xjgEiZXQSj65PBjpdrBi8kR7PIHPFXHLC5pUkFdyeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFTWo8018614;
	Fri, 31 May 2024 01:31:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3D6F2INPJscoefbnmmbau5r3LErbL17wdYKjcUl0/tgoo=3D;_b=3DBwFJdPSJ?=
 =?UTF-8?Q?65+eye0oWEYJMhaHj/gDQHeTaAYZbJoPhAClWSGvnIhkRSG1941qinyiIf0U_+M?=
 =?UTF-8?Q?BU1mAG2HtxoTGsX/UQ4WnORPqq04l1SDwHloGlp38+lAybzqF9wIx2ytF5F6NM8?=
 =?UTF-8?Q?VO+_gcM9GPAmRg1wrOBReSJrza4trJMb6K/BtIS0PhgG1ZuDmdycIZOMNu+XltU?=
 =?UTF-8?Q?uqxUH+77w_rCMsVVz/tuaYIyv5H4V9eeVIHipOCnPj6sH1zEny4RDQB3GpM0Ccg?=
 =?UTF-8?Q?AkOoU7kIxODfpbG_V0yuvwwxyFDGvFzSErpKVSFs4yUSpg1JM5U+7NgAa3Agjf5?=
 =?UTF-8?Q?C2kSHiKZ6qsDIaV1CgvPG_LA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8a3ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 01:31:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44V0m0Hj016324;
	Fri, 31 May 2024 01:31:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t982d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:26 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V1SKNi027418;
	Fri, 31 May 2024 01:31:25 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50t96yw-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 31 May 2024 01:31:25 +0000
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
Subject: [PATCH v9 15/19] tpm: Make locality requests return consistent values
Date: Thu, 30 May 2024 18:03:27 -0700
Message-Id: <20240531010331.134441-16-ross.philipson@oracle.com>
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
X-Proofpoint-ORIG-GUID: Q4ictEJM04XqZ28HPZcSlOcPMH7y1fRs
X-Proofpoint-GUID: Q4ictEJM04XqZ28HPZcSlOcPMH7y1fRs

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
index 9fb53bb3e73f..685bdeadec51 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -208,7 +208,7 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -1;
+			return -EBUSY;
 		rc = wait_event_interruptible_timeout(priv->int_queue,
 						      (check_locality
 						       (chip, l)),
@@ -227,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
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



Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE998EA9AA
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 04:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfJaDd1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 23:33:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbfJaDd1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 23:33:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3T9oS129448
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:33:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyj0v9d58-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:33:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:31:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:31:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3Vjip50528310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:31:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A17A4062;
        Thu, 31 Oct 2019 03:31:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BABC5A405B;
        Thu, 31 Oct 2019 03:31:43 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:31:43 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH v10 3/9] powerpc: detect the trusted boot state of the system
Date:   Wed, 30 Oct 2019 23:31:28 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19103103-0008-0000-0000-000003295392
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-0009-0000-0000-00004A489CAF
Message-Id: <1572492694-6520-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=610 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310031
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

While secure boot permits only properly verified signed kernels to be
booted, trusted boot calculates the file hash of the kernel image and
stores the measurement prior to boot, that can be subsequently compared
against good known values via attestation services.

This patch reads the trusted boot state of a PowerNV system. The state
is used to conditionally enable additional measurement rules in the IMA
arch-specific policies.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/secure_boot.h |  6 ++++++
 arch/powerpc/kernel/secure_boot.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
index 07d0fe0ca81f..a2ff556916c6 100644
--- a/arch/powerpc/include/asm/secure_boot.h
+++ b/arch/powerpc/include/asm/secure_boot.h
@@ -11,6 +11,7 @@
 #ifdef CONFIG_PPC_SECURE_BOOT
 
 bool is_ppc_secureboot_enabled(void);
+bool is_ppc_trustedboot_enabled(void);
 
 #else
 
@@ -19,5 +20,10 @@ static inline bool is_ppc_secureboot_enabled(void)
 	return false;
 }
 
+static inline bool is_ppc_trustedboot_enabled(void)
+{
+	return false;
+}
+
 #endif
 #endif
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 63dc82c50862..a6a5f17ede03 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -7,6 +7,17 @@
 #include <linux/of.h>
 #include <asm/secure_boot.h>
 
+static struct device_node *get_ppc_fw_sb_node(void)
+{
+	static const struct of_device_id ids[] = {
+		{ .compatible = "ibm,secureboot-v1", },
+		{ .compatible = "ibm,secureboot-v2", },
+		{},
+	};
+
+	return of_find_matching_node(NULL, ids);
+}
+
 bool is_ppc_secureboot_enabled(void)
 {
 	struct device_node *node;
@@ -30,3 +41,18 @@ bool is_ppc_secureboot_enabled(void)
 	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
 	return enabled;
 }
+
+bool is_ppc_trustedboot_enabled(void)
+{
+	struct device_node *node;
+	bool enabled = false;
+
+	node = get_ppc_fw_sb_node();
+	enabled = of_property_read_bool(node, "trusted-enabled");
+
+	of_node_put(node);
+
+	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
+
+	return enabled;
+}
-- 
2.7.5


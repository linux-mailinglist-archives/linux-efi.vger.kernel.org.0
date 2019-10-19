Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11C3DD9E8
	for <lists+linux-efi@lfdr.de>; Sat, 19 Oct 2019 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJSSGt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 14:06:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbfJSSGs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 14:06:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9JI6fIh113360
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:06:47 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vqxmdumwa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:06:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 19 Oct 2019 19:06:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 19 Oct 2019 19:06:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9JI6cLF51052736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:06:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B17452059;
        Sat, 19 Oct 2019 18:06:38 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.146.216])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4796652052;
        Sat, 19 Oct 2019 18:06:35 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 3/8] powerpc: detect the trusted boot state of the system
Date:   Sat, 19 Oct 2019 14:06:12 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101918-0016-0000-0000-000002BA0396
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101918-0017-0000-0000-0000331B3453
Message-Id: <1571508377-23603-4-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=735 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910190171
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While secure boot permits only properly verified signed kernels to be
booted, trusted boot takes a measurement of the kernel image prior to
boot that can be subsequently compared against good known values via
attestation services.

This patch reads the trusted boot state of a PowerNV system. The state
is used to conditionally enable additional measurement rules in the IMA
arch-specific policies.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/secure_boot.h |  6 ++++++
 arch/powerpc/kernel/secure_boot.c      | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 99bba7915629..9753470ab08a 100644
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
@@ -28,3 +39,16 @@ bool is_ppc_secureboot_enabled(void)
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
+	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
+
+	return enabled;
+}
-- 
2.20.1


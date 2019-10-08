Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B78CF03E
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 03:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfJHBPE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Oct 2019 21:15:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729657AbfJHBPE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Oct 2019 21:15:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x981BoB0144223
        for <linux-efi@vger.kernel.org>; Mon, 7 Oct 2019 21:15:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgd6pdqb1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 07 Oct 2019 21:15:02 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 8 Oct 2019 02:15:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Oct 2019 02:14:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x981ErIf53084290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Oct 2019 01:14:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAB1D11C050;
        Tue,  8 Oct 2019 01:14:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5660E11C052;
        Tue,  8 Oct 2019 01:14:51 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.8])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Oct 2019 01:14:51 +0000 (GMT)
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
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v7 3/8] powerpc: detect the trusted boot state of the system
Date:   Mon,  7 Oct 2019 21:14:22 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100801-0020-0000-0000-00000375FA28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100801-0021-0000-0000-000021CC13C2
Message-Id: <1570497267-13672-4-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=636 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910080011
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PowerNV systems enables the IMA measurement rules only if the
trusted boot is enabled on the system.

This patch adds the function to detect if the system has trusted
boot enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/include/asm/secure_boot.h |  6 +++++
 arch/powerpc/kernel/secure_boot.c      | 35 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/secure_boot.h b/arch/powerpc/include/asm/secure_boot.h
index 23d2ef2f1f7b..ecd08515e301 100644
--- a/arch/powerpc/include/asm/secure_boot.h
+++ b/arch/powerpc/include/asm/secure_boot.h
@@ -12,6 +12,7 @@
 
 bool is_powerpc_os_secureboot_enabled(void);
 struct device_node *get_powerpc_os_sb_node(void);
+bool is_powerpc_trustedboot_enabled(void);
 
 #else
 
@@ -25,5 +26,10 @@ static inline struct device_node *get_powerpc_os_sb_node(void)
 	return NULL;
 }
 
+static inline bool is_powerpc_os_trustedboot_enabled(void)
+{
+	return false;
+}
+
 #endif
 #endif
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 0488dbcab6b9..9d5ac1b39e46 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -7,6 +7,27 @@
 #include <linux/of.h>
 #include <asm/secure_boot.h>
 
+static const char * const fwsecureboot_compat[] = {
+	"ibm,secureboot-v1",
+	"ibm,secureboot-v2",
+	NULL,
+};
+
+static struct device_node *get_powerpc_fw_sb_node(void)
+{
+	struct device_node *node;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fwsecureboot_compat); ++i) {
+		node = of_find_compatible_node(NULL, NULL,
+					       fwsecureboot_compat[i]);
+		if (node)
+			return node;
+	}
+
+	return NULL;
+}
+
 struct device_node *get_powerpc_os_sb_node(void)
 {
 	return of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");
@@ -40,3 +61,17 @@ bool is_powerpc_os_secureboot_enabled(void)
 	pr_info("secureboot mode disabled\n");
 	return false;
 }
+
+bool is_powerpc_trustedboot_enabled(void)
+{
+	struct device_node *node;
+
+	node = get_powerpc_fw_sb_node();
+	if (node && (of_find_property(node, "trusted-enabled", NULL))) {
+		pr_info("trustedboot mode enabled\n");
+		return true;
+	}
+
+	pr_info("trustedboot mode disabled\n");
+	return false;
+}
-- 
2.20.1


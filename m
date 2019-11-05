Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744CFF09F7
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 00:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKEXCT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 18:02:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730141AbfKEXCT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Nov 2019 18:02:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5MqGC8016151
        for <linux-efi@vger.kernel.org>; Tue, 5 Nov 2019 18:02:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3g6dm6ne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 05 Nov 2019 18:02:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <erichte@linux.ibm.com>;
        Tue, 5 Nov 2019 23:02:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 23:02:11 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA5N2AjT53739596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 23:02:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 375D611C052;
        Tue,  5 Nov 2019 23:02:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 748F511C050;
        Tue,  5 Nov 2019 23:02:08 +0000 (GMT)
Received: from [9.80.236.186] (unknown [9.80.236.186])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Nov 2019 23:02:08 +0000 (GMT)
Subject: [PATCH v10a 3/9] powerpc: detect the trusted boot state of the system
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <1572492694-6520-4-git-send-email-zohar@linux.ibm.com>
From:   Eric Richter <erichte@linux.ibm.com>
Date:   Tue, 5 Nov 2019 17:02:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1572492694-6520-4-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110523-0020-0000-0000-00000382E141
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110523-0021-0000-0000-000021D90D36
Message-Id: <e9eeee6b-b9bf-1e41-2954-61dbd6fbfbcf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=611 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050187
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
Signed-off-by: Eric Richter <erichte@linux.ibm.com>
---
v10a:
- moved get_ppc_fw_sb_node to patch 1 in the series

 arch/powerpc/include/asm/secure_boot.h |  6 ++++++
 arch/powerpc/kernel/secure_boot.c      | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

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
index 3f55be33f5c8..95d2ff086e55 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -32,3 +32,18 @@ bool is_ppc_secureboot_enabled(void)
 
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
2.20.1


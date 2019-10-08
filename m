Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45CCF040
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJHBPI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Oct 2019 21:15:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729691AbfJHBPH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Oct 2019 21:15:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x981Bq37072279
        for <linux-efi@vger.kernel.org>; Mon, 7 Oct 2019 21:15:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vgcd27cu2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 07 Oct 2019 21:15:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 8 Oct 2019 02:15:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Oct 2019 02:15:00 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x981EwQv37421284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Oct 2019 01:14:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1016911C04A;
        Tue,  8 Oct 2019 01:14:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE5811C050;
        Tue,  8 Oct 2019 01:14:55 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.8])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Oct 2019 01:14:55 +0000 (GMT)
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
Subject: [PATCH v7 4/8] powerpc/ima: add measurement rules to ima arch specific policy
Date:   Mon,  7 Oct 2019 21:14:23 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100801-0008-0000-0000-0000031EF97D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100801-0009-0000-0000-00004A3E0C55
Message-Id: <1570497267-13672-5-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910080011
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch adds the measurement rules to the arch specific policies on
trusted boot enabled systems.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/powerpc/kernel/ima_arch.c | 45 +++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index c22d82965eb4..88bfe4a1a9a5 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -12,8 +12,19 @@ bool arch_ima_get_secureboot(void)
 	return is_powerpc_os_secureboot_enabled();
 }
 
-/* Defines IMA appraise rules for secureboot */
+/*
+ * The "arch_rules" contains both the securebot and trustedboot rules for adding
+ * the kexec kernel image and kernel modules file hashes to the IMA measurement
+ * list and verifying the file signatures against known good values.
+ *
+ * The "appraise_type=imasig|modsig" option allows the good signature to be
+ * stored as an xattr or as an appended signature. The "template=ima-modsig"
+ * option includes the appended signature, when available, in the IMA
+ * measurement list.
+ */
 static const char *const arch_rules[] = {
+	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
+	"measure func=MODULE_CHECK template=ima-modsig",
 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #if !IS_ENABLED(CONFIG_MODULE_SIG_FORCE)
 	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
@@ -22,12 +33,40 @@ static const char *const arch_rules[] = {
 };
 
 /*
- * Returns the relevant IMA arch policies based on the system secureboot state.
+ * The "measure_rules" are enabled only on "trustedboot" enabled systems.
+ * These rules add the kexec kernel image and kernel modules file hashes to
+ * the IMA measurement list.
+ */
+static const char *const measure_rules[] = {
+	"measure func=KEXEC_KERNEL_CHECK",
+	"measure func=MODULE_CHECK",
+	NULL
+};
+
+/*
+ * Returns the relevant IMA arch policies based on the system secureboot
+ * and trustedboot state.
  */
 const char *const *arch_get_ima_policy(void)
 {
-	if (is_powerpc_os_secureboot_enabled())
+	const char *const *rules;
+	int offset = 0;
+
+	for (rules = arch_rules; *rules != NULL; rules++) {
+		if (strncmp(*rules, "appraise", 8) == 0)
+			break;
+		offset++;
+	}
+
+	if (is_powerpc_os_secureboot_enabled()
+	    && is_powerpc_trustedboot_enabled())
 		return arch_rules;
 
+	if (is_powerpc_os_secureboot_enabled())
+		return arch_rules + offset;
+
+	if (is_powerpc_trustedboot_enabled())
+		return measure_rules;
+
 	return NULL;
 }
-- 
2.20.1


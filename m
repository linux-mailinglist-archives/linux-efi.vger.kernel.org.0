Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF673CF048
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 03:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfJHBPT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Oct 2019 21:15:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729743AbfJHBPS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Oct 2019 21:15:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x981BpLP010306
        for <linux-efi@vger.kernel.org>; Mon, 7 Oct 2019 21:15:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vgfrjsf7v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 07 Oct 2019 21:15:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Tue, 8 Oct 2019 02:15:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Oct 2019 02:15:10 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x981F80714286902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Oct 2019 01:15:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F48A11C050;
        Tue,  8 Oct 2019 01:15:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B58411C054;
        Tue,  8 Oct 2019 01:15:06 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.80.231.8])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Oct 2019 01:15:05 +0000 (GMT)
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
Subject: [PATCH v7 7/8] ima: check against blacklisted hashes for files with modsig
Date:   Mon,  7 Oct 2019 21:14:26 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
References: <1570497267-13672-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100801-4275-0000-0000-0000036F0112
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100801-4276-0000-0000-000038821078
Message-Id: <1570497267-13672-8-git-send-email-nayna@linux.ibm.com>
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

Asymmetric private keys are used to sign multiple files. The kernel
currently support checking against the blacklisted keys. However, if the
public key is blacklisted, any file signed by the blacklisted key will
automatically fail signature verification. We might not want to blacklist
all the files signed by a particular key, but just a single file.
Blacklisting the public key is not fine enough granularity.

This patch adds support for blacklisting binaries with appended signatures,
based on the IMA policy.  Defined is a new policy option
"appraise_flag=check_blacklist".

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy  |  1 +
 security/integrity/ima/ima.h          |  9 +++++++
 security/integrity/ima/ima_appraise.c | 39 +++++++++++++++++++++++++++
 security/integrity/ima/ima_main.c     | 12 ++++++---
 security/integrity/ima/ima_policy.c   | 10 +++++--
 security/integrity/integrity.h        |  1 +
 6 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29ebe9afdac4..4c97afcc0f3c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,6 +25,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
+				[appraise_flag=[check_blacklist]]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ed86c1f70d7f..63e20ccc91ce 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -256,6 +256,8 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
+int ima_check_blacklist(struct integrity_iint_cache *iint,
+			const struct modsig *modsig, int action, int pcr);
 int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
@@ -271,6 +273,13 @@ int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
 #else
+static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
+				      const struct modsig *modsig, int action,
+				      int pcr)
+{
+	return 0;
+}
+
 static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct integrity_iint_cache *iint,
 					   struct file *file,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 136ae4e0ee92..fe34d64a684c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -12,6 +12,7 @@
 #include <linux/magic.h>
 #include <linux/ima.h>
 #include <linux/evm.h>
+#include <keys/system_keyring.h>
 
 #include "ima.h"
 
@@ -303,6 +304,44 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
 	return rc;
 }
 
+/*
+ * ima_blacklist_measurement - Checks whether the binary is blacklisted. If
+ * yes, then adds the hash of the blacklisted binary to the measurement list.
+ *
+ * Returns -EPERM if the hash is blacklisted.
+ */
+int ima_check_blacklist(struct integrity_iint_cache *iint,
+			const struct modsig *modsig, int action, int pcr)
+{
+	enum hash_algo hash_algo;
+	const u8 *digest = NULL;
+	u32 digestsize = 0;
+	u32 secid;
+	int rc = 0;
+	struct ima_template_desc *template_desc;
+
+	template_desc = lookup_template_desc("ima-buf");
+	template_desc_init_fields(template_desc->fmt, &(template_desc->fields),
+				  &(template_desc->num_fields));
+
+	if (!(iint->flags & IMA_CHECK_BLACKLIST))
+		return 0;
+
+	if (iint->flags & IMA_MODSIG_ALLOWED) {
+		security_task_getsecid(current, &secid);
+		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
+		rc = is_binary_blacklisted(digest, digestsize);
+
+		/* Returns -EPERM on blacklisted hash found */
+		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+			process_buffer_measurement(digest, digestsize,
+						   "blacklisted-hash", pcr,
+						   template_desc);
+	}
+
+	return rc;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 77115e884496..40d30ab17cbe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -335,10 +335,14 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
-		inode_lock(inode);
-		rc = ima_appraise_measurement(func, iint, file, pathname,
-					      xattr_value, xattr_len, modsig);
-		inode_unlock(inode);
+		rc = ima_check_blacklist(iint, modsig, action, pcr);
+		if (rc != -EPERM) {
+			inode_lock(inode);
+			rc = ima_appraise_measurement(func, iint, file,
+						      pathname, xattr_value,
+						      xattr_len, modsig);
+			inode_unlock(inode);
+		}
 		if (!rc)
 			rc = mmap_violation_check(func, file, &pathbuf,
 						  &pathname, filename);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5380aca2b351..bfaae7a8443a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -765,8 +765,8 @@ enum {
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
-	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_template, Opt_err
+	Opt_appraise_type, Opt_appraise_flag,
+	Opt_permit_directio, Opt_pcr, Opt_template, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -798,6 +798,7 @@ static const match_table_t policy_tokens = {
 	{Opt_euid_lt, "euid<%s"},
 	{Opt_fowner_lt, "fowner<%s"},
 	{Opt_appraise_type, "appraise_type=%s"},
+	{Opt_appraise_flag, "appraise_flag=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
 	{Opt_template, "template=%s"},
@@ -1172,6 +1173,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else
 				result = -EINVAL;
 			break;
+		case Opt_appraise_flag:
+			ima_log_string(ab, "appraise_flag", args[0].from);
+			if (strstr(args[0].from, "blacklist"))
+				entry->flags |= IMA_CHECK_BLACKLIST;
+			break;
 		case Opt_permit_directio:
 			entry->flags |= IMA_PERMIT_DIRECTIO;
 			break;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index d9323d31a3a8..73fc286834d7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -32,6 +32,7 @@
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_MODSIG_ALLOWED	0x20000000
+#define IMA_CHECK_BLACKLIST	0x40000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.20.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37D9EA9A1
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 04:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfJaDcD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 23:32:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbfJaDcC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 23:32:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3RhEG012981
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:32:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyhyx9yqa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:32:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:31:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:31:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3Vq3059769042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:31:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5BDFA405F;
        Thu, 31 Oct 2019 03:31:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A56A4054;
        Thu, 31 Oct 2019 03:31:51 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:31:50 +0000 (GMT)
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v10 7/9] ima: check against blacklisted hashes for files with modsig
Date:   Wed, 30 Oct 2019 23:31:32 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19103103-4275-0000-0000-000003796421
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-4276-0000-0000-0000388CA070
Message-Id: <1572492694-6520-8-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310031
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

Asymmetric private keys are used to sign multiple files.  The kernel
currently supports checking against blacklisted keys.  However, if the
public key is blacklisted, any file signed by the blacklisted key will
automatically fail signature verification.  Blacklisting the public
key is not fine enough granularity, as we might want to only blacklist
a particular file.

This patch adds support for checking against the blacklisted hash of
the file, without the appended signature, based on the IMA policy.  It
defines a new policy option "appraise_flag=check_blacklist".

In addition to the blacklisted binary hashes stored in the firmware "dbx"
variable, the Linux kernel may be configured to load blacklisted binary
hashes onto the .blacklist keyring as well.  The following example shows
how to blacklist a specific kernel module hash.

$ sha256sum kernel/kheaders.ko
77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3
kernel/kheaders.ko

$ grep BLACKLIST .config
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST="blacklist-hash-list"

$ cat certs/blacklist-hash-list
"bin:77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3"

Update the IMA custom measurement and appraisal policy rules
(/etc/ima-policy):

measure func=MODULE_CHECK template=ima-modsig
appraise func=MODULE_CHECK appraise_flag=check_blacklist
appraise_type=imasig|modsig

After building, installing, and rebooting the kernel:

 545660333 ---lswrv      0     0   \_ blacklist:
bin:77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3

measure func=MODULE_CHECK template=ima-modsig
appraise func=MODULE_CHECK appraise_flag=check_blacklist
appraise_type=imasig|modsig

modprobe: ERROR: could not insert 'kheaders': Permission denied

10 0c9834db5a0182c1fb0cdc5d3adcf11a11fd83dd ima-sig
sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
2 /usr/lib/modules/5.4.0-rc3+/kernel/kernel/kheaders.ko

10 82aad2bcc3fa8ed94762356b5c14838f3bcfa6a0 ima-modsig
sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
2 /usr/lib/modules/5.4.0rc3+/kernel/kernel/kheaders.ko  sha256:77fa889b3
5a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3
3082029a06092a864886f70d010702a082028b30820287020101310d300b0609608648
016503040201300b06092a864886f70d01070131820264....

10 25b72217cc1152b44b134ce2cd68f12dfb71acb3 ima-buf
sha256:8b58427fedcf8f4b20bc8dc007f2e232bf7285d7b93a66476321f9c2a3aa132
b blacklisted-hash
77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: David Howells <dhowells@redhat.com>
[zohar@linux.ibm.com: updated patch description]
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/ABI/testing/ima_policy  |  4 ++++
 security/integrity/ima/ima.h          |  8 ++++++++
 security/integrity/ima/ima_appraise.c | 33 +++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_main.c     | 12 ++++++++----
 security/integrity/ima/ima_policy.c   | 12 ++++++++++--
 security/integrity/integrity.h        |  1 +
 6 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 29ebe9afdac4..29aaedf33246 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,6 +25,7 @@ Description:
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [template=] [permit_directio]
+				[appraise_flag=]
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
@@ -38,6 +39,9 @@ Description:
 			fowner:= decimal value
 		lsm:  	are LSM specific
 		option:	appraise_type:= [imasig] [imasig|modsig]
+			appraise_flag:= [check_blacklist]
+			Currently, blacklist check is only for files signed with appended
+			signature.
 			template:= name of a defined IMA template type
 			(eg, ima-ng). Only valid when action is "measure".
 			pcr:= decimal value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a65772ffa427..df4ca482fb53 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -256,6 +256,8 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
+int ima_check_blacklist(struct integrity_iint_cache *iint,
+			const struct modsig *modsig, int pcr);
 int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
@@ -271,6 +273,12 @@ int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
 
 #else
+static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
+				      const struct modsig *modsig, int pcr)
+{
+	return 0;
+}
+
 static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct integrity_iint_cache *iint,
 					   struct file *file,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 136ae4e0ee92..300c8d2943c5 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -12,6 +12,7 @@
 #include <linux/magic.h>
 #include <linux/ima.h>
 #include <linux/evm.h>
+#include <keys/system_keyring.h>
 
 #include "ima.h"
 
@@ -304,6 +305,38 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
 }
 
 /*
+ * ima_check_blacklist - determine if the binary is blacklisted.
+ *
+ * Add the hash of the blacklisted binary to the measurement list, based
+ * on policy.
+ *
+ * Returns -EPERM if the hash is blacklisted.
+ */
+int ima_check_blacklist(struct integrity_iint_cache *iint,
+			const struct modsig *modsig, int pcr)
+{
+	enum hash_algo hash_algo;
+	const u8 *digest = NULL;
+	u32 digestsize = 0;
+	int rc = 0;
+
+	if (!(iint->flags & IMA_CHECK_BLACKLIST))
+		return 0;
+
+	if (iint->flags & IMA_MODSIG_ALLOWED && modsig) {
+		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
+
+		rc = is_binary_blacklisted(digest, digestsize);
+		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+			process_buffer_measurement(digest, digestsize,
+						   "blacklisted-hash", NONE,
+						   pcr);
+	}
+
+	return rc;
+}
+
+/*
  * ima_appraise_measurement - appraise file measurement
  *
  * Call evm_verifyxattr() to verify the integrity of 'security.ima'.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a26e3ad4e886..d7e987baf127 100644
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
+		rc = ima_check_blacklist(iint, modsig, pcr);
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
index 5380aca2b351..f19a895ad7cd 100644
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
@@ -1500,6 +1506,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		else
 			seq_puts(m, "appraise_type=imasig ");
 	}
+	if (entry->flags & IMA_CHECK_BLACKLIST)
+		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
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
2.7.5


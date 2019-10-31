Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97BEA9A7
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 04:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJaDcS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 23:32:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbfJaDb5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 23:31:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3ReXC024196
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyhyw9x3a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:31:54 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:31:50 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3VmAX49283176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:31:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4747A405C;
        Thu, 31 Oct 2019 03:31:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B11CA405B;
        Thu, 31 Oct 2019 03:31:47 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:31:47 +0000 (GMT)
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
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v10 5/9] ima: make process_buffer_measurement() generic
Date:   Wed, 30 Oct 2019 23:31:30 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19103103-0008-0000-0000-000003295393
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-0009-0000-0000-00004A489CB1
Message-Id: <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
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

process_buffer_measurement() is limited to measuring the kexec boot
command line. This patch makes process_buffer_measurement() more
generic, allowing it to measure other types of buffer data (e.g.
blacklisted binary hashes or key hashes).

process_buffer_measurement() may be called directly from an IMA
hook or as an auxiliary measurement record. In both cases the buffer
measurement is based on policy. This patch modifies the function to
conditionally retrieve the policy defined PCR and template for the IMA
hook case.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
[zohar@linux.ibm.com: added comment in process_buffer_measurement()]
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h      |  3 ++
 security/integrity/ima/ima_main.c | 58 +++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3689081aaf38..a65772ffa427 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -217,6 +217,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, enum ima_hooks func,
+				int pcr);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 60027c643ecd..a26e3ad4e886 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -626,14 +626,14 @@ int ima_load_data(enum kernel_load_data_id id)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
  * @eventname: event name to be used for the buffer entry.
- * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * @func: IMA hook
+ * @pcr: pcr to extend the measurement
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-static void process_buffer_measurement(const void *buf, int size,
-				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+void process_buffer_measurement(const void *buf, int size,
+				const char *eventname, enum ima_hooks func,
+				int pcr)
 {
 	int ret = 0;
 	struct ima_template_entry *entry = NULL;
@@ -642,19 +642,45 @@ static void process_buffer_measurement(const void *buf, int size,
 					    .filename = eventname,
 					    .buf = buf,
 					    .buf_len = size};
-	struct ima_template_desc *template_desc = NULL;
+	struct ima_template_desc *template = NULL;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
 	} hash = {};
 	int violation = 0;
-	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
+	u32 secid;
 
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
-				&template_desc);
-	if (!(action & IMA_MEASURE))
-		return;
+	/*
+	 * Both LSM hooks and auxilary based buffer measurements are
+	 * based on policy.  To avoid code duplication, differentiate
+	 * between the LSM hooks and auxilary buffer measurements,
+	 * retrieving the policy rule information only for the LSM hook
+	 * buffer measurements.
+	 */
+	if (func) {
+		security_task_getsecid(current, &secid);
+		action = ima_get_action(NULL, current_cred(), secid, 0, func,
+					&pcr, &template);
+		if (!(action & IMA_MEASURE))
+			return;
+	}
+
+	if (!pcr)
+		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+
+	if (!template) {
+		template = lookup_template_desc("ima-buf");
+		ret = template_desc_init_fields(template->fmt,
+						&(template->fields),
+						&(template->num_fields));
+		if (ret < 0) {
+			pr_err("template %s init failed, result: %d\n",
+			       (strlen(template->name) ?
+				template->name : template->fmt), ret);
+			return;
+		}
+	}
 
 	iint.ima_hash = &hash.hdr;
 	iint.ima_hash->algo = ima_hash_algo;
@@ -664,7 +690,7 @@ static void process_buffer_measurement(const void *buf, int size,
 	if (ret < 0)
 		goto out;
 
-	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0)
 		goto out;
 
@@ -686,13 +712,9 @@ static void process_buffer_measurement(const void *buf, int size,
  */
 void ima_kexec_cmdline(const void *buf, int size)
 {
-	u32 secid;
-
-	if (buf && size != 0) {
-		security_task_getsecid(current, &secid);
+	if (buf && size != 0)
 		process_buffer_measurement(buf, size, "kexec-cmdline",
-					   current_cred(), secid);
-	}
+					   KEXEC_CMDLINE, 0);
 }
 
 static int __init init_ima(void)
-- 
2.7.5


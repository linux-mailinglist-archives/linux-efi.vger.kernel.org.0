Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B3EA9A0
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 04:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJaDcA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 23:32:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbfJaDb7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Oct 2019 23:31:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V3RwGi101632
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vypg8t4hd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 23:31:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Oct 2019 03:31:56 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 03:31:52 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V3VGWx34406690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:31:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B09A4054;
        Thu, 31 Oct 2019 03:31:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E72BA405B;
        Thu, 31 Oct 2019 03:31:49 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.201.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 03:31:48 +0000 (GMT)
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
        David Howells <dhowells@redhat.com>
Subject: [PATCH v10 6/9] certs: add wrapper function to check blacklisted binary hash
Date:   Wed, 30 Oct 2019 23:31:31 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19103103-4275-0000-0000-000003796420
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103103-4276-0000-0000-0000388CA06F
Message-Id: <1572492694-6520-7-git-send-email-zohar@linux.ibm.com>
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

The -EKEYREJECTED error returned by existing is_hash_blacklisted() is
misleading when called for checking against blacklisted hash of a
binary.

This patch adds a wrapper function is_binary_blacklisted() to return
-EPERM error if binary is blacklisted.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 certs/blacklist.c             | 9 +++++++++
 include/keys/system_keyring.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index ec00bf337eb6..6514f9ebc943 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -135,6 +135,15 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_len, const char *type)
 }
 EXPORT_SYMBOL_GPL(is_hash_blacklisted);
 
+int is_binary_blacklisted(const u8 *hash, size_t hash_len)
+{
+	if (is_hash_blacklisted(hash, hash_len, "bin") == -EKEYREJECTED)
+		return -EPERM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(is_binary_blacklisted);
+
 /*
  * Initialise the blacklist
  */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..fb8b07daa9d1 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -35,12 +35,18 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 extern int mark_hash_blacklisted(const char *hash);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 			       const char *type);
+extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
 #else
 static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 				      const char *type)
 {
 	return 0;
 }
+
+static inline int is_binary_blacklisted(const u8 *hash, size_t hash_len)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_IMA_BLACKLIST_KEYRING
-- 
2.7.5


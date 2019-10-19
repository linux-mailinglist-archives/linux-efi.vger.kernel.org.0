Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90005DD9F6
	for <lists+linux-efi@lfdr.de>; Sat, 19 Oct 2019 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfJSSHC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 14:07:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfJSSHB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 14:07:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9JI6iRX113505
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:07:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vqxmdun1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 14:07:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 19 Oct 2019 19:06:58 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 19 Oct 2019 19:06:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9JI6pjk55377954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:06:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5340A52057;
        Sat, 19 Oct 2019 18:06:51 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.146.216])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C1D45204F;
        Sat, 19 Oct 2019 18:06:48 +0000 (GMT)
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
Subject: [PATCH v8 6/8] certs: add wrapper function to check blacklisted binary hash
Date:   Sat, 19 Oct 2019 14:06:15 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101918-0016-0000-0000-000002BA039A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101918-0017-0000-0000-0000331B3458
Message-Id: <1571508377-23603-7-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910190171
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The -EKEYREJECTED error returned by existing is_hash_blacklisted() is
misleading when called for checking against blacklisted hash of a
binary.

This patch adds a wrapper function is_binary_blacklisted() to return
-EPERM error if binary is blacklisted.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
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
2.20.1


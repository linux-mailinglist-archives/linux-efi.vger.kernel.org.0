Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697DB424D32
	for <lists+linux-efi@lfdr.de>; Thu,  7 Oct 2021 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhJGGVE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Oct 2021 02:21:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240216AbhJGGVC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Oct 2021 02:21:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1975dRF5008889;
        Thu, 7 Oct 2021 02:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VZIyRqthO6pl/kMcGKnVcZFJWGn3auCwdoSboG+e8xA=;
 b=kEOfxVEA3mRWYeNMpr4XeUnQc328vUwKZVqGjNYVxvwX2kcM8sTc27rioVpCirQPk143
 eP/qDoJ0IC6E8fEmmccLrs7vJrnt65H/YfZ1EmVgw2m+nvYaQh9SkcIwqwuM7y8Wmw2g
 p/qB8m8KSbwuyVMxFALXk5EKVpkGL1brturEJ5EaV0yPUrlwfaHY9Gx0dnwFqGEaqfg4
 dlCxMhmqNWOJ3e+Ds7I62eTvMBNQk7bKR3zyXlkeIjSTHEuyzNn2OC8D25zxOGxwGQG1
 17JAmzsvjma6oDOfSdF5qo56OlRQs6UcD6zjtJYXap5H/WXQbrCgmZstOMLPVxKiB+MA yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhkcx17mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 02:18:45 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1975mPqG007928;
        Thu, 7 Oct 2021 02:18:44 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhkcx17ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 02:18:44 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1976Hsq1032341;
        Thu, 7 Oct 2021 06:18:43 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3bef2bsuep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 06:18:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1976Ifpe42533262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 06:18:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76468AE063;
        Thu,  7 Oct 2021 06:18:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9FCAE066;
        Thu,  7 Oct 2021 06:18:41 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Oct 2021 06:18:41 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] x86: Export clean_cache_range()
Date:   Thu,  7 Oct 2021 06:18:35 +0000
Message-Id: <20211007061838.1381129-2-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
References: <20211007061838.1381129-1-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nS7OZlRa22gZYQdylIC3i34dfCSB_Jfc
X-Proofpoint-ORIG-GUID: c_LBawc6OxqucSbZGPuFu_Nd6JHtSM-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070039
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Export clean_cache_range() which is similar to the existing
clflush_cache_range() but uses the CLWB (cache line write back)
instruction instead of CLFLUSH.

Remove existing implementation of clean_cache_range() from
arch/x86/lib/usercopy_64.c .

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
---
 arch/x86/include/asm/cacheflush.h |  1 +
 arch/x86/lib/usercopy_64.c        | 21 ---------------------
 arch/x86/mm/pat/set_memory.c      | 30 ++++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index b192d917a6d0..76452ba1bafb 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -9,5 +9,6 @@
 #include <asm/special_insns.h>
 
 void clflush_cache_range(void *addr, unsigned int size);
+void clean_cache_range(void *vaddr, unsigned int size);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e97ab1..ffd39f1d4251 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -57,27 +57,6 @@ unsigned long clear_user(void __user *to, unsigned long n)
 EXPORT_SYMBOL(clear_user);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-/**
- * clean_cache_range - write back a cache range with CLWB
- * @vaddr:	virtual start address
- * @size:	number of bytes to write back
- *
- * Write back a cache range using the CLWB (cache line write back)
- * instruction. Note that @size is internally rounded up to be cache
- * line size aligned.
- */
-static void clean_cache_range(void *addr, size_t size)
-{
-	u16 x86_clflush_size = boot_cpu_data.x86_clflush_size;
-	unsigned long clflush_mask = x86_clflush_size - 1;
-	void *vend = addr + size;
-	void *p;
-
-	for (p = (void *)((unsigned long)addr & ~clflush_mask);
-	     p < vend; p += x86_clflush_size)
-		clwb(p);
-}
-
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
 	clean_cache_range(addr, size);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c586a35..8de029a21e03 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -319,6 +319,36 @@ void clflush_cache_range(void *vaddr, unsigned int size)
 }
 EXPORT_SYMBOL_GPL(clflush_cache_range);
 
+static void clean_cache_range_opt(void *vaddr, unsigned int size)
+{
+	const unsigned long clflush_size = boot_cpu_data.x86_clflush_size;
+	void *p = (void *)((unsigned long)vaddr & ~(clflush_size - 1));
+	void *vend = vaddr + size;
+
+	if (p >= vend)
+		return;
+
+	for (; p < vend; p += clflush_size)
+		clwb(p);
+}
+
+/**
+ * clean_cache_range - write back a cache range with CLWB
+ * @vaddr:	virtual start address
+ * @size:	number of bytes to write back
+ *
+ * CLWB (cache line write back) is an unordered instruction which needs fencing
+ * with MFENCE or SFENCE to avoid ordering issues. Note that @size is
+ * internally rounded up to be cache line size aligned.
+ */
+void clean_cache_range(void *vaddr, unsigned int size)
+{
+	mb();
+	clean_cache_range_opt(vaddr, size);
+	mb();
+}
+EXPORT_SYMBOL_GPL(clean_cache_range);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_invalidate_pmem(void *addr, size_t size)
 {
-- 
2.25.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F54D1AD5
	for <lists+linux-efi@lfdr.de>; Tue,  8 Mar 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbiCHOmS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Mar 2022 09:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347517AbiCHOmR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Mar 2022 09:42:17 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D1D39143;
        Tue,  8 Mar 2022 06:41:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V6f6D6h_1646750469;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V6f6D6h_1646750469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 22:41:16 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, rric@kernel.org
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        ardb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: [PATCH v7 1/3] efi/cper: add cper_mem_err_status_str to decode error description
Date:   Tue,  8 Mar 2022 22:40:51 +0800
Message-Id: <20220308144053.49090-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a new helper function cper_mem_err_status_str() which is used to
decode the description of error status, and the cper_print_mem() will call
it and report the details of error status.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/firmware/efi/cper.c | 30 +++++++++++++++++++++++++++++-
 include/linux/cper.h        |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 6ec8edec6329..34eeaa59f04a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -211,6 +211,32 @@ const char *cper_mem_err_type_str(unsigned int etype)
 }
 EXPORT_SYMBOL_GPL(cper_mem_err_type_str);
 
+const char *cper_mem_err_status_str(u64 status)
+{
+	switch ((status >> 8) & 0xff) {
+	case  1:	return "Error detected internal to the component";
+	case  4:	return "Storage error in DRAM memory";
+	case  5:	return "Storage error in TLB";
+	case  6:	return "Storage error in cache";
+	case  7:	return "Error in one or more functional units";
+	case  8:	return "Component failed self test";
+	case  9:	return "Overflow or undervalue of internal queue";
+	case 16:	return "Error detected in the bus";
+	case 17:	return "Virtual address not found on IO-TLB or IO-PDIR";
+	case 18:	return "Improper access error";
+	case 19:	return "Access to a memory address which is not mapped to any component";
+	case 20:	return "Loss of Lockstep";
+	case 21:	return "Response not associated with a request";
+	case 22:	return "Bus parity error - must also set the A, C, or D Bits";
+	case 23:	return "Detection of a protocol error";
+	case 24:	return "Detection of a PATH_ERROR";
+	case 25:	return "Bus operation timeout";
+	case 26:	return "A read was issued to data that has been poisoned";
+	default:	return "Reserved";
+	}
+}
+EXPORT_SYMBOL_GPL(cper_mem_err_status_str);
+
 static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
 	u32 len, n;
@@ -334,7 +360,9 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 		return;
 	}
 	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
-		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
+		printk("%s error_status: %s (0x%016llx)\n",
+		       pfx, cper_mem_err_status_str(mem->error_status),
+		       mem->error_status);
 	if (mem->validation_bits & CPER_MEM_VALID_PA)
 		printk("%s""physical_address: 0x%016llx\n",
 		       pfx, mem->physical_addr);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 6a511a1078ca..5b1dd27b317d 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -558,6 +558,7 @@ extern const char *const cper_proc_error_type_strs[4];
 u64 cper_next_record_id(void);
 const char *cper_severity_str(unsigned int);
 const char *cper_mem_err_type_str(unsigned int);
+const char *cper_mem_err_status_str(u64 status);
 void cper_print_bits(const char *prefix, unsigned int bits,
 		     const char * const strs[], unsigned int strs_size);
 void cper_mem_err_pack(const struct cper_sec_mem_err *,
-- 
2.20.1.12.g72788fdb


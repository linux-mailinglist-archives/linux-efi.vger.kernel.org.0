Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5A68A2EF
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 20:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBCT07 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBCT06 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 14:26:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E992C37;
        Fri,  3 Feb 2023 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675452418; x=1706988418;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Xhn4BfuGKeJQgOjm2zoh7q5guqibeqf62x6qjEYBLg=;
  b=DLeWToV2fT1JrFt0KfEJhkDBIR2q6j7guSCnVqIHSivHD1bpf7zyRD0R
   y0JzCwRiis767fnycmONhIgaKAeo2fnNvlmCG2X3/fXquvIHWfAqNVH3q
   88GgA6ubE8J/6pN28ndc5omldj0op0jk2Xdt0EWeRvNAtNlTqDZ1Xi391
   ZrJIShI3MO9hz7bDfhX5jrZpIWyWuJP1twsvte9C5Lcyd3bQAJImfpNbJ
   7O6hXVqhX8dPmoarcJzvr51v7FL5Yf8o9Wtbzm9qtyGG4FTUlwnhcDnDg
   UCwbQs48mbPh4n1Vdpd46Jeb2Wk4IqzL4qsl8tfI60khRgQdnfallE/SU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327470624"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="327470624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 11:26:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="659196289"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="659196289"
Received: from dvincent-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.163.211])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 11:26:49 -0800
Subject: [PATCH] efi/cper, cxl: Remove cxl_err.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     ardb@kernel.org
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org
Date:   Fri, 03 Feb 2023 11:26:49 -0800
Message-ID: <167545240944.3932004.13241445887801999410.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

While going to create include/linux/cxl.h for some cross-subsystem CXL
definitions I noticed that include/linux/cxl_err.h was already present.
That header has no reason to be global, and it duplicates the RAS
Capability Structure definitions in drivers/cxl/cxl.h. A follow-on patch
can consider unifying the CXL native error tracing with the CPER error
printing.

Also fixed up the spec reference as the latest released spec is v3.0.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/cper_cxl.c |   12 +++++++++++-
 include/linux/cxl_err.h         |   22 ----------------------
 2 files changed, 11 insertions(+), 23 deletions(-)
 delete mode 100644 include/linux/cxl_err.h

diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
index 53e435c4f310..a55771b99a97 100644
--- a/drivers/firmware/efi/cper_cxl.c
+++ b/drivers/firmware/efi/cper_cxl.c
@@ -9,7 +9,6 @@
 
 #include <linux/cper.h>
 #include "cper_cxl.h"
-#include <linux/cxl_err.h>
 
 #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
 #define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
@@ -19,6 +18,17 @@
 #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
 #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
 
+/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
+struct cxl_ras_capability_regs {
+	u32 uncor_status;
+	u32 uncor_mask;
+	u32 uncor_severity;
+	u32 cor_status;
+	u32 cor_mask;
+	u32 cap_control;
+	u32 header_log[16];
+};
+
 static const char * const prot_err_agent_type_strs[] = {
 	"Restricted CXL Device",
 	"Restricted CXL Host Downstream Port",
diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
deleted file mode 100644
index 629e1bdeda44..000000000000
--- a/include/linux/cxl_err.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2022 Advanced Micro Devices, Inc.
- *
- * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
- */
-
-#ifndef LINUX_CXL_ERR_H
-#define LINUX_CXL_ERR_H
-
-/* CXL RAS Capability Structure, CXL v3.1 sec 8.2.4.16 */
-struct cxl_ras_capability_regs {
-	u32 uncor_status;
-	u32 uncor_mask;
-	u32 uncor_severity;
-	u32 cor_status;
-	u32 cor_mask;
-	u32 cap_control;
-	u32 header_log[16];
-};
-
-#endif //__CXL_ERR_


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B186026C6
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJRI1X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJRI1U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 04:27:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BD5E9AC05;
        Tue, 18 Oct 2022 01:27:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19232175D;
        Tue, 18 Oct 2022 01:27:25 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 265D43F7D8;
        Tue, 18 Oct 2022 01:27:11 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Jia He <justin.he@arm.com>
Subject: [PATCH v10 1/7] efi/cper: export several helpers for ghes_edac to use
Date:   Tue, 18 Oct 2022 08:22:08 +0000
Message-Id: <20221018082214.569504-2-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018082214.569504-1-justin.he@arm.com>
References: <20221018082214.569504-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before ghes_edac can be turned back into a proper module again, export
several helpers which are going to be used by it.

Signed-off-by: Jia He <justin.he@arm.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e4e5ea7ce910..053eae13f409 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -290,6 +290,7 @@ int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_location);
 
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 {
@@ -310,6 +311,7 @@ int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(cper_dimm_err_location);
 
 void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 		       struct cper_mem_err_compact *cmem)
@@ -331,6 +333,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_pack);
 
 const char *cper_mem_err_unpack(struct trace_seq *p,
 				struct cper_mem_err_compact *cmem)
-- 
2.25.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF255AD65D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiIEPZg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiIEPZU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 11:25:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D2A1AF24;
        Mon,  5 Sep 2022 08:25:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AA11063;
        Mon,  5 Sep 2022 08:25:16 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (unknown [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 312763F534;
        Mon,  5 Sep 2022 08:25:03 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
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
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v5 1/8] efi/cper: export several helpers for ghes_edac to use
Date:   Mon,  5 Sep 2022 15:24:32 +0000
Message-Id: <20220905152439.77770-2-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905152439.77770-1-justin.he@arm.com>
References: <20220905152439.77770-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


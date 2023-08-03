Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E516E76DFDE
	for <lists+linux-efi@lfdr.de>; Thu,  3 Aug 2023 07:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHCFsc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Aug 2023 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjHCFsb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Aug 2023 01:48:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A82D43;
        Wed,  2 Aug 2023 22:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691041710; x=1722577710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fuHR5vlg0Pj/rQJGG+2yi4N34sEiicrfjR7PExpvW5w=;
  b=J9jsMy5OLyztTj41clc5neL0vtASw1NM5UePWSe6785DAMQJWyHuLbEb
   wTKp0YTVH0/nXdAMpdsPo+jum6nWvn1YgcwQz8FdCph8F1OfLwKHVofZn
   mquKS6QQPuKJZtXkg6EWBd3peXBnW6WTb75/PUquHFVyfH3gd0oHXIm6b
   sypy9EYzdj5eZD+lhjSXA4hdiJ3eK6oFPDD4NzYfHYsDJdlEQ3HesFvbz
   TVJZOpAw+eiGjz8gaJKZYACyHEO0PEMzHqrzGbngesu1UJzEcEXnJ+kYw
   xerAo6G9zeQ5SjbYFUFdYndtLuZI3glNn6wRLKxzxrQVUZ/jfwhKBfQB+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372510831"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="372510831"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732629455"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="732629455"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2023 22:48:25 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     ardb@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] efi/riscv: libstub: Fix comment about absolute relocation
Date:   Thu,  3 Aug 2023 13:56:11 +0800
Message-Id: <20230803055611.2343011-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't want absolute symbols references in the stub, so fix the double
negation in the comment.

Fixes: d7071743db31 ("RISC-V: Add EFI stub support.")
Cc: stable@vger.kernel.org
Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b0f8c495c10f..ed6e8ebd89b4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -146,7 +146,7 @@ STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
 
 # For RISC-V, we don't need anything special other than arm64. Keep all the
 # symbols in .init section and make sure that no absolute symbols references
-# doesn't exist.
+# exist.
 STUBCOPY_FLAGS-$(CONFIG_RISCV)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_RISCV)	:= R_RISCV_HI20
-- 
2.25.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73D1F88A6
	for <lists+linux-efi@lfdr.de>; Sun, 14 Jun 2020 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgFNLtn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Jun 2020 07:49:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:21271 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNLtm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 14 Jun 2020 07:49:42 -0400
IronPort-SDR: 6ZXQM/S8dL2y3SGVskeVEajm9bEEz92XA2BrsfH+WfPdGmeWCVOEkP6k59V3onHahQG5pCmo8x
 Sox2c655TOSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 04:49:42 -0700
IronPort-SDR: OXZJ3q/SBtVC0MPXOvbSwx4Uu8oCyCX2xv17f4rCQwxfEpcfO4OU1fHxvCt1owvnvhz7l0kPY5
 I1HopAg4Jb4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,511,1583222400"; 
   d="scan'208";a="420061986"
Received: from unknown (HELO localhost.localdomain.bj.intel.com) ([10.240.192.131])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2020 04:49:40 -0700
From:   Zhu Lingshan <lingshan.zhu@intel.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH] efi: fix errors in building: requires -maccumulate-outgoing-args
Date:   Sun, 14 Jun 2020 19:45:30 +0800
Message-Id: <1592135130-4013-1-git-send-email-lingshan.zhu@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

when build kernel with default config, efi/libstub won't build,
complain: sorry, unimplemented: ms_abi attribute
requires -maccumulate-outgoing-args or subtarget optimization
implying it

This commit intends to add -maccumulate-outgoing-args to Makefile
cflags, make builder happy.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf2..a4541b2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,7 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small -maccumulate-outgoing-args
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
-- 
1.8.3.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E447662792
	for <lists+linux-efi@lfdr.de>; Mon,  9 Jan 2023 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjAINq0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Jan 2023 08:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjAINoQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Jan 2023 08:44:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5E321B6
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 05:44:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42E80B80DE3
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 13:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFDCC433EF;
        Mon,  9 Jan 2023 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673271852;
        bh=HWuqgpyBMMyFQaBtxvp5rPBhFSpvCu5gDaP3GKtMO60=;
        h=From:To:Cc:Subject:Date:From;
        b=Z3co8LuQUi72+m0bzGE9V/zq4NQKAhrrXR8xsSL7R7pFAHnJUWZiAwQV13uFHsQeA
         AnAZ+D4SU3ee0/q4tDiJJN4MXwN7VU6Ta3gPP05UoG0rGhH6qkhdSzEHs26iNpqlkZ
         knXbMMTBuozoj912VKP/GdaHGKc9A07ltttMLOMll3Y7XjutgbKA8RBVPgr3jkilMe
         du3+HKfdbWK/Fmw2o9FJDCW6Zpa8/sbu3BaDlCG3FKswySktRBu/l8A9xQgeOhoVYS
         z9hWfhZCfVg7gw5K3dnYhknn18Zbr5Tr+o6yLVLThXeaNemotcyhf2j4hGaNqFD3r3
         BdFaiMBKB52WA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: rt-wrapper: Add missing include
Date:   Mon,  9 Jan 2023 14:44:04 +0100
Message-Id: <20230109134404.2485721-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=701; i=ardb@kernel.org; h=from:subject; bh=HWuqgpyBMMyFQaBtxvp5rPBhFSpvCu5gDaP3GKtMO60=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvBojjn4FaqrqIetl0MTva+rN/H2F3KOh6Pzrv4vd P6/ZeOCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7waIwAKCRDDTyI5ktmPJPRlDA Cb0ksGfTD6LyTt7BKNJXOBb7csWare6fyyTo1k12aJfs5uO7G3gHD49A55nzxrYSGNUux+xDHqHLOu gqDAH3AtHGUE4jUas6V/VJVZY77GaguQtLEZjiYZCxD/pLpLuQrVQ9VVqwYyHpbYvBri23KkLbcAGN uE42xA+vPlG+cT1H6yNFNWbnrNOmesKv6VsW7dkrVhBYjQqAesVL0pHAwRPrNdEGxoyh4eK749Mj91 aHJdEqCFX3xJchmg19Tx4YzcFgKkXqJ1/fhe+xiwPKfsdfdESneENRtF3U4jwliJMRBb+RAmRHkbwb 4FzEsPyYzcP0wzuF3EWPbsA3ek722RyMIHNoHKCVm1jq3kIyS0J5ELUHNrHyNcGz0lCLgZmhLTtiHT 9GWnIWoaYT87iJ+GJQB+73iVDlu/WdZUZRAh0w6jRib2HF1aEOuHMN7nMuDXbFLQkAX+g+oG6iipSr JHKsX1sDQywGw3OBfPTS4XTENfQvT5DM6d8xoWQLkZ3y0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the missing #include of asm/assembler.h, which is where the ldr_l
macro is defined.

Fixes: ff7a167961d1b97e ("arm64: efi: Execute runtime services from a dedicated stack")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index a00886410537d6a6..d872d18101d83750 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 SYM_FUNC_START(__efi_rt_asm_wrapper)
 	stp	x29, x30, [sp, #-112]!
-- 
2.39.0


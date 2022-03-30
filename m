Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280334EC897
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbiC3PoK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiC3PoJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7133E3E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 086F6B81D69
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AB7C340F0;
        Wed, 30 Mar 2022 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654941;
        bh=C6C0qQGA9jNONZmANfUf7mwnHxAXIQajunpYmEvB7yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4b5Ga789w3AGlqQYMf5WrUaz7b60GPwjU+YLWov+2FDFLfyEvian6UP3xFTDbvdS
         5cN122YtljDMQbOEF1lRzNv5pCWfMcLTq4XINNwajglsQ9esUC7X7eMS1WCPnNTi3h
         A4uBMwlsXX/xfcMpyPNcKL/O9UrVubq8E67ig+zL6S0+Qym6vGQyPgRTfJsp9A55VS
         NdSpcbV+e8UAisSzIifKoCm2hJqfgxjghh3B+GiAgg+F2H7HfP4xNLztPs5tvd3ttE
         j9jq8IiqIQyZ08GgpjY5q+Ve7ZouDgHdEahpsCm9JRexhxFMb4CdxRqSCYl0kYEVPg
         Kbdn0Tj02fSKA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 05/18] arm64: head: factor out TTBR1 assignment into a macro
Date:   Wed, 30 Mar 2022 17:41:52 +0200
Message-Id: <20220330154205.2483167-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; h=from:subject; bh=C6C0qQGA9jNONZmANfUf7mwnHxAXIQajunpYmEvB7yU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo2VzGldtY/dOXDs7D0e/ZC+4x1EHdDREJDvGZA ZrhHzPuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6NgAKCRDDTyI5ktmPJJp8DA C924FnzqpibCHGRKI/D7t5IAZ82m/aQehy3KiM+kxqzbRSLbUQ6P2Btsfmg2N5NfzNh6yEp2O+YQu/ NqbO+/KoldFnHkuqX8nti598X68JVDC7Z1tLZIyd6FoZiJBPMRfQ/uy5aBl4bYE3Va0uNNZ8OayvYi aYOPHIOQTa5rbkQRFw3AmqpXjDNpafc9l8ezLdfMalOQa96D7EpryS7bfWeHDspCH/fkTrjX8HRRn9 9uL3AJOGlzqbeXHX4+OHbShVYOr6XHYlGDA11EcGnMXkdx+kTf+RHzHzAVBaz73sgiwUDAisFdbU4O lGOlgaFHvp6KtOxGtaSdUIVr+fqxkwOR5E/CXT4xseJclrH2eOyCWrn+iHG35JFVqDY3rU4zL7DQSo xADcWXT0y6Jo55R+dKDJNRTfxrRkmfekazxUYXOzQM00FX1Pgf9VmmJbunY3SqI89BJCERfaaSgYmR 5Yi94FgXXFvlnNhRmDwKrIuNmZp2/eeOKOxrJwhNXFF5k=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Create a macro load_ttbr1 to avoid having to repeat the same instruction
sequence 3 times in a subsequent patch. No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 727561972e4a..7c4aefacf6c2 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -688,6 +688,13 @@ SYM_FUNC_END(__secondary_too_slow)
 	dc	ivac, \tmp1			// Invalidate potentially stale cache line
 	.endm
 
+	.macro		load_ttbr1, reg, tmp
+	phys_to_ttbr	\reg, \reg
+	offset_ttbr1 	\reg, \tmp
+	msr		ttbr1_el1, \reg
+	isb
+	.endm
+
 /*
  * Enable the MMU.
  *
@@ -709,12 +716,9 @@ SYM_FUNC_START(__enable_mmu)
 	b.gt    __no_granule_support
 	update_early_cpu_boot_status 0, x2, x3
 	adrp	x2, idmap_pg_dir
-	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
-	offset_ttbr1 x1, x3
-	msr	ttbr1_el1, x1			// load TTBR1
-	isb
+	load_ttbr1 x1, x3
 
 	set_sctlr_el1	x0
 
-- 
2.30.2


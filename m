Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754A6B8F7C
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCNKPy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCNKPx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:15:53 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C639AFE6;
        Tue, 14 Mar 2023 03:15:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9A36740755C6;
        Tue, 14 Mar 2023 10:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9A36740755C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788840;
        bh=J5zJSuuCzj+1C39z27zh+o9bfA57PDh8/CXoZdGgyyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZQowxWT7U+/gNyV66AeYgrHbuevv0qUoJikCUi0iBw2hO3m3mzHYKRw4xrYZhOn3
         yYznLBK481C3v9vNbtgGhKz46WcBd2mJdRi+4kQMkebhtK/Kb7ogwR061COdNJqPWY
         HCkDJkjGMp0phuVuhYI146H/uvO+ZQ0fpejPM9eU=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 01/27] x86/boot: Align vmlinuz sections on page size
Date:   Tue, 14 Mar 2023 13:13:28 +0300
Message-Id: <159597c484778da5e59c3a5728669f131f800b5a.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To protect sections on page table level each section needs to be
aligned on page size (4KB).

Set sections alignment in linker script for the kernel decompressor
(boot/compressed/vmlinux.lds.S).

Also introduce symbols that can be used to reference compressed
kernel blob section later in the later patches.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b22f34b8684a..a5015b958085 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -27,31 +27,32 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
-	.rodata..compressed : {
+	.rodata..compressed : ALIGN(PAGE_SIZE) {
+		_compressed = .;
 		*(.rodata..compressed)
+		_ecompressed = .;
 	}
-	.text :	{
+	.text :	ALIGN(PAGE_SIZE) {
 		_text = .; 	/* Text */
 		*(.text)
 		*(.text.*)
 		*(.noinstr.text)
 		_etext = . ;
 	}
-	.rodata : {
+	.rodata : ALIGN(PAGE_SIZE) {
 		_rodata = . ;
 		*(.rodata)	 /* read-only data */
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.data :	{
+	.data :	ALIGN(PAGE_SIZE) {
 		_data = . ;
 		*(.data)
 		*(.data.*)
 		*(.bss.efistub)
 		_edata = . ;
 	}
-	. = ALIGN(L1_CACHE_BYTES);
-	.bss : {
+	.bss : ALIGN(L1_CACHE_BYTES) {
 		_bss = . ;
 		*(.bss)
 		*(.bss.*)
@@ -60,8 +61,7 @@ SECTIONS
 		_ebss = .;
 	}
 #ifdef CONFIG_X86_64
-       . = ALIGN(PAGE_SIZE);
-       .pgtable : {
+       .pgtable : ALIGN(PAGE_SIZE) {
 		_pgtable = . ;
 		*(.pgtable)
 		_epgtable = . ;
-- 
2.39.2


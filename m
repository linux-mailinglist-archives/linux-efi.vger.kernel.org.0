Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFB633AD6
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiKVLM4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiKVLMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:12:47 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C81030;
        Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4CF12419E9F0;
        Tue, 22 Nov 2022 11:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4CF12419E9F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115560;
        bh=4ZeCfeL+Tv55vKbW3Vc1Ph6Cjl3WL9hmJicrinwykXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJ+J+4AHnuC2D2QMr1jHJSyjPXrNYVvD5P4BnmbIvK/cWY1vZJBkzMMOQB8GL/p17
         UpFi694ht927LmhYZA4meBb6AfGoTq9HdUGyglSFGnIxUCN2x+YtLmOyFi5Hcla056
         qEQVE5BwUH9rZ7DQwz54vwlIGTIId+iTIGi2Y1QA=
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
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 01/24] x86/boot: Align vmlinuz sections on page size
Date:   Tue, 22 Nov 2022 14:12:10 +0300
Message-Id: <a2cff4833c33a3493764c00794416ce6536e66ad.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To protect sections on page table level each section
needs to be aligned on page size (4KB).

Set sections alignment in linker script.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b2375d021..6be90f1a1198 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -27,21 +27,27 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
+	. = ALIGN(PAGE_SIZE);
 	.rodata..compressed : {
+		_compressed = .;
 		*(.rodata..compressed)
+		_ecompressed = .;
 	}
+	. = ALIGN(PAGE_SIZE);
 	.text :	{
 		_text = .; 	/* Text */
 		*(.text)
 		*(.text.*)
 		_etext = . ;
 	}
+	. = ALIGN(PAGE_SIZE);
 	.rodata : {
 		_rodata = . ;
 		*(.rodata)	 /* read-only data */
 		*(.rodata.*)
 		_erodata = . ;
 	}
+	. = ALIGN(PAGE_SIZE);
 	.data :	{
 		_data = . ;
 		*(.data)
-- 
2.37.4


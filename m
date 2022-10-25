Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F760CE8A
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiJYONV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiJYONU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:20 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F79C2EE;
        Tue, 25 Oct 2022 07:13:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id DF7AD419E9C1;
        Tue, 25 Oct 2022 14:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DF7AD419E9C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707196;
        bh=Q9fnWgrDqNAEfbyyDhr1NF2k/eQWdzIJiBg8GZcJcfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQzgIw4H4258IJy13u2s453qRvWd3gEaFSmUfhIfBnTcPR02DI6f4rRjsryOmM992
         bcEZElVn4CDB4tHTuSGZ2yjgnk32eHiZDlNZ37tmt0Y/qZ9ZouwvnnBAupdnDxiumv
         vEgb/WsHxuTS6TtCOpexu8QvN95m+L1RsHO4mbOM=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 01/23] x86/boot: Align vmlinuz sections on page size
Date:   Tue, 25 Oct 2022 17:12:39 +0300
Message-Id: <f71669e1847b03f1aa51305128fa1fa26bba1f91.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
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

To protect sections on page table level each section
needs to be aligned on page size (4KB).

Set sections alignment in linker script.

Add _compressed/_ecompressed symbols to access '.rodata..compressed'
section content in the same way other sections are accessed.
This is useful when applying memory attributes of the section.

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


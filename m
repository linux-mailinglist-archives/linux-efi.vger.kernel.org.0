Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C21161A7
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2019 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLHNdx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Dec 2019 08:33:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfLHNdx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 8 Dec 2019 08:33:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idwgp-0007gN-Gj; Sun, 08 Dec 2019 14:33:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 933761C287F;
        Sun,  8 Dec 2019 14:33:33 +0100 (CET)
Date:   Sun, 08 Dec 2019 13:33:33 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Fix efi_loaded_image_t::unload type
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191206165542.31469-6-ardb@kernel.org>
References: <20191206165542.31469-6-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157581201350.21853.6212874556450430437.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     9fa76ca7b8bdcdf51fc8c7b7b7a7bfc4eccceb58
Gitweb:        https://git.kernel.org/tip/9fa76ca7b8bdcdf51fc8c7b7b7a7bfc4eccceb58
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 06 Dec 2019 16:55:41 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 12:42:19 +01:00

efi: Fix efi_loaded_image_t::unload type

The ::unload field is a function pointer, so it should be u32 for 32-bit,
u64 for 64-bit. Add a prototype for it in the native efi_loaded_image_t
type. Also change type of parent_handle and device_handle from void * to
efi_handle_t for documentation purposes.

The unload method is not used, so no functional change.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191206165542.31469-6-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/efi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea5..aa54586 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -824,7 +824,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u32 unload;
 } efi_loaded_image_32_t;
 
 typedef struct {
@@ -840,14 +840,14 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u64 unload;
 } efi_loaded_image_64_t;
 
 typedef struct {
 	u32 revision;
-	void *parent_handle;
+	efi_handle_t parent_handle;
 	efi_system_table_t *system_table;
-	void *device_handle;
+	efi_handle_t device_handle;
 	void *file_path;
 	void *reserved;
 	u32 load_options_size;
@@ -856,7 +856,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	efi_status_t (*unload)(efi_handle_t image_handle);
 } efi_loaded_image_t;
 
 

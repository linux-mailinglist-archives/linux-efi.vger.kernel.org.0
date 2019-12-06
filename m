Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575301155E0
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2019 17:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLFQ4L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Dec 2019 11:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfLFQ4L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:56:11 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam5.arm.com [217.140.106.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD31206DF;
        Fri,  6 Dec 2019 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575651370;
        bh=UZGvL4jeZEg7v1KznTKj27qPrtUjbbX1pS2KQDwlrqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDWJxga79Vepr06y1ty8MERowKGtQ9+oa2cWgtNaYQbtcLQ/l2F1B4gfzPNvh5IXj
         AmsMOTcI8F2iXuXvgF1OHpIrLpFvO86OXvEIoO0SPfZb8yUaGwAP4s1P66BLh3vea/
         Qors0ex1FG1ZuQdM7HM4EhI/r/HLX3mZw0ztW2U0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 5/6] efi: fix type of unload field in efi_loaded_image_t
Date:   Fri,  6 Dec 2019 16:55:41 +0000
Message-Id: <20191206165542.31469-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165542.31469-1-ardb@kernel.org>
References: <20191206165542.31469-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

The unload field is a function pointer, so it should be u32 for 32-bit,
u64 for 64-bit. Add a prototype for it in the native efi_loaded_image_t
type. Also change type of parent_handle and device_handle from void* to
efi_handle_t for documentation purposes.

The unload method is not used, so no functional change.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea595c8c..aa54586db7a5 100644
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
 
 
-- 
2.17.1


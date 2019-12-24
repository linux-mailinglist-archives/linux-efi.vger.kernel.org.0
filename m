Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8333A12A2D3
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfLXPKs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfLXPKs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:10:48 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D6C2071A;
        Tue, 24 Dec 2019 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200247;
        bh=RoARWJOIPMJq0BHsAvsBc0tsIwOnvbk4j780//NXma8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjmTPw/d9Dt9NEaVl12fBgc9q0yR2fZTy+1P6A30rllMXhqAZDZ9GeltQUEMGO1b0
         gqRUF+SJoufGVp531AM+KHMxjtFBUr4MD/oA7F+jk6a9bj85CthWW6C+bQogtzturJ
         PXVXIIVoPsj8/GUjyKxk692N+7Hr+RcLceuHv5c4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 01/25] efi/gop: Remove bogus packed attribute from GOP structures
Date:   Tue, 24 Dec 2019 16:10:01 +0100
Message-Id: <20191224151025.32482-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

EFI structures are not packed, they follow natural alignment.

The packed attribute doesn't have any effect on the structure layout due
to the types and order of the members, and we only ever get these
structures as output from the EFI firmware so alignment issues have not
come up.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index aa54586db7a5..83a62f5c3fd7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1429,7 +1429,7 @@ struct efi_graphics_output_mode_info {
 	int pixel_format;
 	struct efi_pixel_bitmask pixel_information;
 	u32 pixels_per_scan_line;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode_32 {
 	u32 max_mode;
@@ -1438,7 +1438,7 @@ struct efi_graphics_output_protocol_mode_32 {
 	u32 size_of_info;
 	u64 frame_buffer_base;
 	u32 frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode_64 {
 	u32 max_mode;
@@ -1447,7 +1447,7 @@ struct efi_graphics_output_protocol_mode_64 {
 	u64 size_of_info;
 	u64 frame_buffer_base;
 	u64 frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_mode {
 	u32 max_mode;
@@ -1456,7 +1456,7 @@ struct efi_graphics_output_protocol_mode {
 	unsigned long size_of_info;
 	u64 frame_buffer_base;
 	unsigned long frame_buffer_size;
-} __packed;
+};
 
 struct efi_graphics_output_protocol_32 {
 	u32 query_mode;
-- 
2.20.1


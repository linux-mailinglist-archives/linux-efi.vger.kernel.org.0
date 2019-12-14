Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88F711F33D
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLNR5w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNR5w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:52 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDBB20724;
        Sat, 14 Dec 2019 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346271;
        bh=0FdOb95WPxtFQHWNIaAIxbfcnnzHGsWuZyBmH+zQG9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19TElmkwUcK9UiIn4J0fy2Md1rcgih15LaNi6GtxtcK5BkJsLCu8BgNIlj0LK0NBY
         W2IqgekW3WhBQG1bTxOX7OdkLLDVvvK9JEDMRZYjgtzs0Q8zG9dD6eXIHBVktpvd0k
         kGoHgPlVDFh5fBsaCz/qltoRL6RgmiWipTNuXHrA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 04/10] efi/libstub: add missing apple_properties_protocol_t definition
Date:   Sat, 14 Dec 2019 18:57:29 +0100
Message-Id: <20191214175735.22518-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As apple_properties_protocol_t is only used on x86, we never bothered
to define the native apple_properties_protocol_t struct, but only added
the explicit 32-bit and 64-bit ones. We'll need the native one for the
next patch so let's add it, based on the prototypes that can be found
in commit 58c5475aba67706b31d9237808d5d3d54074e5ea.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7ca0b85b2b5..735388ea7012 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -518,6 +518,22 @@ typedef struct {
 	u64 get_all;
 } apple_properties_protocol_64_t;
 
+struct efi_dev_path;
+
+typedef struct apple_properties_protocol {
+	unsigned long version;
+	efi_status_t (*get)(struct apple_properties_protocol *,
+			    struct efi_dev_path *, efi_char16_t *,
+			    void *, u32 *);
+	efi_status_t (*set)(struct apple_properties_protocol *,
+			    struct efi_dev_path *, efi_char16_t *,
+			    void *, u32);
+	efi_status_t (*del)(struct apple_properties_protocol *,
+			    struct efi_dev_path *, efi_char16_t *);
+	efi_status_t (*get_all)(struct apple_properties_protocol *,
+				void *buffer, u32 *);
+} apple_properties_protocol_t;
+
 typedef struct {
 	u32 get_capability;
 	u32 get_event_log;
-- 
2.17.1


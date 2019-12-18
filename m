Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBF124EBC
	for <lists+linux-efi@lfdr.de>; Wed, 18 Dec 2019 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLRRDb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Dec 2019 12:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfLRRDb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Dec 2019 12:03:31 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125672465E;
        Wed, 18 Dec 2019 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576688610;
        bh=PIp00WPRHvbloDPuzEb774tETSZbw49vdVPYjkj3L78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq2+L5Pgbx4ofzmd/47GsAfAvqVAhvBgIZoPB6SSZw7tgxAhv6VwCVAlnvc/FgdPL
         DIn0zMIvgZTLKU9VD73hqAg3nVnbbCNgNvFw46e3abED7K12Dsk9pspj84aRTn10/c
         rK6814vcyiRIhMN2EgHe5gzQaaIsXhlDBc+R3l90=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 20/21] efi/libstub: import type definitions for creating and signalling events
Date:   Wed, 18 Dec 2019 19:01:38 +0200
Message-Id: <20191218170139.9468-21-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
References: <20191218170139.9468-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We will use the EFI event handling infrastructure in a future patch to
register a notification function that executes at the very end of
ExitBootServices() to disable DMA on all PCI bridges in the system.

So import the missing macros and typedefs from the UEFI spec.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index f97f48a3dc81..81bd1e8c201f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -270,6 +270,23 @@ typedef struct {
 	u32 create_event_ex;
 } __packed efi_boot_services_32_t;
 
+typedef unsigned long efi_tpl_t;
+
+#define TPL_APPLICATION				4
+#define TPL_CALLBACK				8
+#define TPL_NOTIFY				16
+#define TPL_HIGH_LEVEL				31
+
+typedef void *efi_event_t;
+typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
+
+#define EVT_TIMER				0x80000000
+#define EVT_RUNTIME				0x40000000
+#define EVT_NOTIFY_WAIT				0x00000100
+#define EVT_NOTIFY_SIGNAL			0x00000200
+#define EVT_SIGNAL_EXIT_BOOT_SERVICES		0x00000201
+#define EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE	0x60000202
+
 /*
  * EFI Boot Services table
  */
@@ -288,10 +305,12 @@ typedef union {
 		efi_status_t (__efiapi *allocate_pool)(int, unsigned long,
 						       void **);
 		efi_status_t (__efiapi *free_pool)(void *);
-		void *create_event;
+		efi_status_t (__efiapi *create_event)(u32 type, efi_tpl_t,
+						      efi_event_notify_t,
+						      void *, efi_event_t *);
 		void *set_timer;
 		void *wait_for_event;
-		void *signal_event;
+		efi_status_t (__efiapi *signal_event)(efi_event_t);
 		void *close_event;
 		void *check_event;
 		void *install_protocol_interface;
-- 
2.17.1


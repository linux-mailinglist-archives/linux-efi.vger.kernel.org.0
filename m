Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399A43EA07
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1VOV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 17:14:21 -0400
Received: from smtp26.services.sfr.fr ([93.17.128.205]:22588 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1VOV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Oct 2021 17:14:21 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 17:14:21 EDT
X-mail-filterd: {"version":"1.3.4","queueID":"B8ED41C00043F","contextId":"b24eb595-3e85-4e1e-9472-0076e02e6a39"}
Received: from debian.numericable.fr (89-156-196-228.rev.numericable.fr [89.156.196.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2625.sfr.fr (SMTP Server) with ESMTPS id B8ED41C00043F;
        Thu, 28 Oct 2021 23:05:44 +0200 (CEST)
X-mail-filterd: {"version":"1.3.4","queueID":"9DE051C000407","contextId":"411325b9-9a4e-4a1a-ac67-3dad4b23fc6a"}
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noos.fr; s=202006;
 t=1635455144; h=From:To:Cc:Subject:Date; bh=JDOYQpKXCthaJH1zjM0JweVD26t6pd9pY
  UmIXQQDC34=; b=BL+2nrkw7HhrPASMhZGAz+xeBb7jgNRrTDWCDzfCg+YjtgRH1vy1bYQOLT0xq
  AzBI7fQwftcKPGRsqKvc8AYFemCC3IPEyUFqieru0CNd9CCFDFvmjKfhLeWkQTf4uJ/YJlrdbnQ+
  mIBLDgqPzgWd6P/Rcod9AWGbwq3CRM3GIoOwIcjn+ydONKQxKOR3MMyxlwGP1wxJ++as3s3OnEa+
  43+t8H5L5H1FJZiZ0EIU8acVGIi3b3DyMLG8qFvnOlIGFZS+JfGKNUGbzs1Na7zB7ill/DVVFsoL
  70fBQOgUAvEG8uYh8w7w/kn1dZ7tK1+wc5qX8E3ien+k2ULf4g7+A==
Received: from debian.numericable.fr (89-156-196-228.rev.numericable.fr [89.156.196.228])
        by msfrf2625.sfr.fr (SMTP Server) with ESMTP id 9DE051C000407;
        Thu, 28 Oct 2021 23:05:44 +0200 (CEST)
Received: from debian.numericable.fr (89-156-196-228.rev.numericable.fr [89.156.196.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2625.sfr.fr (SMTP Server) with ESMTPS;
        Thu, 28 Oct 2021 23:05:44 +0200 (CEST)
From:   Elyes HAOUAS <ehaouas@noos.fr>
To:     linux-efi@vger.kernel.org
Cc:     Elyes HAOUAS <ehaouas@noos.fr>
Subject: [PATCH] include/linux/efi.h: Remove unneeded whitespaces before tabs
Date:   Thu, 28 Oct 2021 23:05:17 +0200
Message-Id: <20211028210517.10881-1-ehaouas@noos.fr>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Signed-off-by: Elyes HAOUAS <ehaouas@noos.fr>
---
 include/linux/efi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..d009149df23c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -569,8 +569,8 @@ extern struct efi {
 	unsigned long			flags;
 } efi;
 
-#define EFI_RT_SUPPORTED_GET_TIME 				0x0001
-#define EFI_RT_SUPPORTED_SET_TIME 				0x0002
+#define EFI_RT_SUPPORTED_GET_TIME				0x0001
+#define EFI_RT_SUPPORTED_SET_TIME				0x0002
 #define EFI_RT_SUPPORTED_GET_WAKEUP_TIME			0x0004
 #define EFI_RT_SUPPORTED_SET_WAKEUP_TIME			0x0008
 #define EFI_RT_SUPPORTED_GET_VARIABLE				0x0010
@@ -837,7 +837,7 @@ extern int efi_status_to_err(efi_status_t status);
 #define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS 0x0000000000000020
 #define EFI_VARIABLE_APPEND_WRITE	0x0000000000000040
 
-#define EFI_VARIABLE_MASK 	(EFI_VARIABLE_NON_VOLATILE | \
+#define EFI_VARIABLE_MASK	(EFI_VARIABLE_NON_VOLATILE | \
 				EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 				EFI_VARIABLE_RUNTIME_ACCESS | \
 				EFI_VARIABLE_HARDWARE_ERROR_RECORD | \
-- 
2.33.0


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE51FFB94
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 21:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgFRTLE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Jun 2020 15:11:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41407 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRTLB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Jun 2020 15:11:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id n11so6679802qkn.8
        for <linux-efi@vger.kernel.org>; Thu, 18 Jun 2020 12:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XUbXsDH3ASN7WRqm+DVyysjKIJ4BxAXQcmKULK8sAzc=;
        b=MHGMEOI5P6MiMbCRMaohCerhKUBnAKR5K0PcFFbjpJqMQvQE2qK9Hbi96Qa7NpN67h
         0oHlGbXSUE4mqd2Ba7l/uSi6TT1WbS+07oSMIuEjSzRfKt9/w7axd7QHqZ6fQ+jNrOU9
         sDTxA68m0ByraDd8RAzHUD1Ws8iXUGj0W+H1NFMxivZrh57M1oWwAxsLfcTxaD91gzBT
         UkfJqKMFvhPKjReX8IM4SlsIiduymQzfxKxL0VUaPmp9B+q+0KRMlPB+zvowt63kcEoM
         JYm62rFkAEi1MYawKUtjxS1ocIez5WxzRyukqSWLoq82qW0QmbSBLyCIzTSRqD2Yy/BH
         8GJg==
X-Gm-Message-State: AOAM530NZtlEDfD2Qf3CwFt9v9EXjd4ZtjsorJullq62tGmkH6HxcV6n
        qYbihs7+J5lQDmfgC/AjVI0=
X-Google-Smtp-Source: ABdhPJyf93py5lFb6FJJgrSpHUg1zDK/5wgPhWgXCPUUd+zktbN4EVfST1XrrMmuHIwrTinXaamByw==
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr336934qkm.333.1592507460656;
        Thu, 18 Jun 2020 12:11:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a82sm4234397qkb.29.2020.06.18.12.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 12:11:00 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/x86: Remove unused variables
Date:   Thu, 18 Jun 2020 15:10:59 -0400
Message-Id: <20200618191059.3809491-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  987053a30016 ("efi/x86: Move command-line initrd loading to efi_main")
made the ramdisk_addr/ramdisk_size variables in efi_pe_entry unused, but
neglected to delete them.

Delete these unused variables.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5a48d996ed71..37e82bf397aa 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -361,8 +361,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	int options_size = 0;
 	efi_status_t status;
 	char *cmdline_ptr;
-	unsigned long ramdisk_addr;
-	unsigned long ramdisk_size;
 
 	efi_system_table = sys_table_arg;
 
-- 
2.26.2


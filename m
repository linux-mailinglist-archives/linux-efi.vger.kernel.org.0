Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C282981F2
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416428AbgJYNt5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 09:49:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416426AbgJYNt5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Oct 2020 09:49:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D2B1435;
        Sun, 25 Oct 2020 06:49:56 -0700 (PDT)
Received: from e123331-lin.nice.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754153F68F;
        Sun, 25 Oct 2020 06:49:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>, grub-devel@gnu.org,
        daniel.kiper@oracle.com, leif@nuviainc.com
Subject: [PATCH v2 2/8] loader/linux: permit NULL argument for argv[] in grub_initrd_load()
Date:   Sun, 25 Oct 2020 14:49:35 +0100
Message-Id: <20201025134941.4805-3-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201025134941.4805-1-ard.biesheuvel@arm.com>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

grub_initrd_load() takes a char *argv[] argument which is only used
when an error occurs, to print the name of the file that caused the
error. In order to be able to split initrd loading from handling the
initrd command, let's permit argv to be NULL, and fall back to the
file names recorded in the file handles.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 grub-core/loader/linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grub-core/loader/linux.c b/grub-core/loader/linux.c
index 3fe390f17ec6..8c01381778c6 100644
--- a/grub-core/loader/linux.c
+++ b/grub-core/loader/linux.c
@@ -317,7 +317,7 @@ grub_initrd_load (struct grub_linux_initrd_context *initrd_ctx,
 	{
 	  if (!grub_errno)
 	    grub_error (GRUB_ERR_FILE_READ_ERROR, N_("premature end of file %s"),
-			argv[i]);
+			argv ? argv[i] : initrd_ctx->components[i].file->name);
 	  grub_initrd_close (initrd_ctx);
 	  return grub_errno;
 	}
-- 
2.17.1


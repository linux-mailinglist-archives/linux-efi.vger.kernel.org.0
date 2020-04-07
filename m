Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAA1A10C7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Apr 2020 17:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDGP4b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Apr 2020 11:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgDGP4b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Apr 2020 11:56:31 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB1F2072A;
        Tue,  7 Apr 2020 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586274990;
        bh=zBZKI+9jb0HjHyKoJhQhGw3onl80w3zMTcWXoDvhaXU=;
        h=From:To:Cc:Subject:Date:From;
        b=lOuxJUTy81I8lkRSs+9nwpscfhBZj1Iop08Xl15LtSE7HHamtL49h/qk3A9OFFS1L
         mNl/pQCtzaVxCM0/dbQP7JbiMtCLb1W1u2FQGIhLI0StpvtrasdOkRhmHPFtwjYdYN
         tmejFplx8h2fsnt4HhMSVlGbDdvOzq3RWxFWQIT8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub/file: merge filename buffers to reduce stack usage
Date:   Tue,  7 Apr 2020 17:56:14 +0200
Message-Id: <20200407155614.20440-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Arnd reports that commit

  9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine")

reworks the file I/O routines in a way that triggers the following
warning:

  drivers/firmware/efi/libstub/file.c:240:1: warning: the frame size
            of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]

We can work around this issue by reusing the 'filename' field of the
file info struct that we use to obtain file information from EFI (which
contains the filename even though we already know it since we used it
to open the file in the first place)

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d4c7e5f59d2c..ea66b1f16a79 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -29,30 +29,31 @@
  */
 #define EFI_READ_CHUNK_SIZE	SZ_1M
 
+struct finfo {
+	efi_file_info_t info;
+	efi_char16_t	filename[MAX_FILENAME_SIZE];
+};
+
 static efi_status_t efi_open_file(efi_file_protocol_t *volume,
-				  efi_char16_t *filename_16,
+				  struct finfo *fi,
 				  efi_file_protocol_t **handle,
 				  unsigned long *file_size)
 {
-	struct {
-		efi_file_info_t info;
-		efi_char16_t	filename[MAX_FILENAME_SIZE];
-	} finfo;
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
 	efi_file_protocol_t *fh;
 	unsigned long info_sz;
 	efi_status_t status;
 
-	status = volume->open(volume, &fh, filename_16, EFI_FILE_MODE_READ, 0);
+	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to open file: ");
-		efi_char16_printk(filename_16);
+		efi_char16_printk(fi->filename);
 		efi_printk("\n");
 		return status;
 	}
 
-	info_sz = sizeof(finfo);
-	status = fh->get_info(fh, &info_guid, &info_sz, &finfo);
+	info_sz = sizeof(struct finfo);
+	status = fh->get_info(fh, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to get file info\n");
 		fh->close(fh);
@@ -60,7 +61,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	}
 
 	*handle = fh;
-	*file_size = finfo.info.file_size;
+	*file_size = fi->info.file_size;
 	return EFI_SUCCESS;
 }
 
@@ -146,13 +147,13 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 	alloc_addr = alloc_size = 0;
 	do {
-		efi_char16_t filename[MAX_FILENAME_SIZE];
+		struct finfo fi;
 		unsigned long size;
 		void *addr;
 
 		offset = find_file_option(cmdline, cmdline_len,
 					  optstr, optstr_size,
-					  filename, ARRAY_SIZE(filename));
+					  fi.filename, ARRAY_SIZE(fi.filename));
 
 		if (!offset)
 			break;
@@ -166,7 +167,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				return status;
 		}
 
-		status = efi_open_file(volume, filename, &file, &size);
+		status = efi_open_file(volume, &fi, &file, &size);
 		if (status != EFI_SUCCESS)
 			goto err_close_volume;
 
-- 
2.17.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D311F95C3
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgFOL6k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 07:58:40 -0400
Received: from mail-out1.in.tum.de ([131.159.0.8]:53344 "EHLO
        mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728510AbgFOL6k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 07:58:40 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 07:58:39 EDT
Received: by mail.in.tum.de (Postfix, from userid 107)
        id BC32D1C0A06; Mon, 15 Jun 2020 13:51:34 +0200 (CEST)
Received: (Authenticated sender: fent)
        by mail.in.tum.de (Postfix) with ESMTPSA id 797501C0A02;
        Mon, 15 Jun 2020 13:51:32 +0200 (CEST)
        (Extended-Queue-bit tech_zcjcr@fff.in.tum.de)
From:   Philipp Fent <fent@in.tum.de>
To:     linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, Philipp Fent <fent@in.tum.de>
Subject: [PATCH] efi/libstub: Fix path separator regression
Date:   Mon, 15 Jun 2020 13:51:09 +0200
Message-Id: <20200615115109.7823-1-fent@in.tum.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine") introduced a
regression that made a couple of (badly configured) systems fail to
boot [1]: Until 5.6, we silently accepted Unix-style file separators in
EFI paths, which might violate the EFI standard, but are an easy to make
mistake. This fix restores the pre-5.7 behaviour.

[1] https://bbs.archlinux.org/viewtopic.php?id=256273

Signed-off-by: Philipp Fent <fent@in.tum.de>
---
 drivers/firmware/efi/libstub/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 2005e33b33d5..f8a28a6e0bde 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -102,11 +102,21 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 	if (!found)
 		return 0;
 
+	/* Skip any leading slashes */
+	while (cmdline[i] == L'/' || cmdline[i] == L'\\')
+		i++;
+
 	while (--result_len > 0 && i < cmdline_len) {
 		if (cmdline[i] == L'\0' ||
 		    cmdline[i] == L'\n' ||
 		    cmdline[i] == L' ')
 			break;
+		/* Replace UNIX dir separators with EFI standard separators */
+		if (cmdline[i] == L'/') {
+			*result++ = L'\\';
+			i++;
+			continue;
+		}
 		*result++ = cmdline[i++];
 	}
 	*result = L'\0';
-- 
2.27.0


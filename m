Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B86674ADA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 05:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjATEht (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 23:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjATEhX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 23:37:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E91BBD16F;
        Thu, 19 Jan 2023 20:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69278B82628;
        Thu, 19 Jan 2023 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CD1C433F2;
        Thu, 19 Jan 2023 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146748;
        bh=asXttCr/Y7FiSRak2/8wvKzUociZdAqvkoeYDxDt7sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfk0eksC4hNa55RHiLox2lxfYRCDeDn2mcSCFdjcQ/iAfHWGd+Zwv5YjBhENhZRw3
         qez8I7DT0YGuK5DrXInDinkDxWgcJAkBhXc9gVBoRAgFT1QnJmoJvcpcWQqtTvvckj
         I1JbMNzCXihEJ64+/jh0iVfDV2k74zlOm4b7w12aeR5+LGFyhYeSYaiRIDqEhvlvsw
         SxyoDaV4seVGBENtVe+6rUEjpsF5iREA8AkGE1z6N7vsRharHF//xHZaPhDmqa4nxx
         zpdEjyttLq4yo3BunaxrIVPPDZ3wxqCoEmBbPqwmTmITwlvOrSDOAEeccKoFAminUB
         irrP5SBTNbTxQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pIY3M-0007Mt-5P; Thu, 19 Jan 2023 17:46:16 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] efivarfs: always register filesystem
Date:   Thu, 19 Jan 2023 17:42:53 +0100
Message-Id: <20230119164255.28091-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230119164255.28091-1-johan+linaro@kernel.org>
References: <20230119164255.28091-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efivar ops are typically registered at subsys init time so that
they are available when efivarfs is registered at module init time.

Other efivars implementations, such as Google SMI, exists and can
currently be build as modules which means that efivar may not be
available when efivarfs is initialised.

Move the efivar availability check from module init to when the
filesystem is mounted to allow late registration of efivars.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 fs/efivarfs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index f72c529c8ec3..b67d431c861a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -194,6 +194,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct dentry *root;
 	int err;
 
+	if (!efivar_is_available())
+		return -EOPNOTSUPP;
+
 	sb->s_maxbytes          = MAX_LFS_FILESIZE;
 	sb->s_blocksize         = PAGE_SIZE;
 	sb->s_blocksize_bits    = PAGE_SHIFT;
@@ -256,9 +259,6 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efivar_is_available())
-		return -ENODEV;
-
 	return register_filesystem(&efivarfs_type);
 }
 
-- 
2.38.2


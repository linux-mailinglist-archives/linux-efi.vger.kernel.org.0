Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B986D7387C9
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jun 2023 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFUOun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jun 2023 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFUOt5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jun 2023 10:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE32706;
        Wed, 21 Jun 2023 07:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9866159C;
        Wed, 21 Jun 2023 14:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB1C433C0;
        Wed, 21 Jun 2023 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358894;
        bh=mqQ1arKU3cdg9rGg/Z1TIJR7kMVhH2ovyEJKbePVSXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOFJnser1Q+dus0mWsxhIzZ0H/k73cm7qt8rrkxiTQY0UoppTPHpAgKLL+rUV+7zj
         N6OVSRRIVIGtutq/tyJ1yVl9FjRKm/KyrYhIX7MrkQ/v49/kRz4tMJ7qAZdK0t5ffD
         RPDVYxWzjY8FU0gF0xzYcnXwzMfY2B9gbcxQz6QFDB2OmJJ6AaYRZFsEE80msy+47+
         wFDw6KbG28DHTJuKPgGkhH9cghZW/HYIwkibJIqIx+ZwD8Fn7eNijfwRfpJN20Yrv3
         RLkFKsnvI32igZbgfjd0t3HNicUAsxDtkKZdaxdaulUww4tic52zmuypU/e8w7Nln2
         Zk60lE20C2V/w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/79] efivarfs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:37 -0400
Message-ID: <20230621144735.55953-23-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efivarfs/file.c  | 2 +-
 fs/efivarfs/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 375576111dc3..46b65dfca153 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_ctime_set_current(inode);
 		inode_unlock(inode);
 	}
 
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b973a2c03dde..a47dded39be8 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -25,7 +25,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
 		switch (mode & S_IFMT) {
 		case S_IFREG:
-- 
2.41.0


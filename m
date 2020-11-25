Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5952C3A5A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 08:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKYHxT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 02:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKYHxT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Nov 2020 02:53:19 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF4220857;
        Wed, 25 Nov 2020 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606290798;
        bh=zWaKhFGSMXCY/b+jLfMpt5Moxe0TRFeN///Em3HdlxU=;
        h=From:To:Cc:Subject:Date:From;
        b=V8hV5Vl+Gli0KSdSNUhK6CZIIdYDilT16Qu8EzxfiLLpwdnm59umKi3DZ0OdMHGd7
         8TJ5bzp2mYeqtXXN8KJBgIvCo/pB7r2cJ5CflRGpLTd60FSXMk+4cwUBqBdZCE4mGL
         O20VL2EYfg/qhNmlsQ9V5U7WfoXF74wFJFlkIgWM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     oleksandr@natalenko.name, jk@ozlabs.org, mjg59@google.com,
        David.Laight@aculab.com, Ard Biesheuvel <ardb@kernel.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: [PATCH] efivarfs: revert "fix memory leak in efivarfs_create()"
Date:   Wed, 25 Nov 2020 08:53:03 +0100
Message-Id: <20201125075303.3963-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory leak addressed by commit fe5186cf12e3 is a false positive:
all allocations are recorded in a linked list, and freed when the
filesystem is unmounted. This leads to double frees, and as reported
by David, leads to crashes if SLUB is configured to self destruct when
double frees occur.

So drop the redundant kfree() again, and instead, mark the offending
pointer variable so the allocation is ignored by kmemleak.

Cc: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Fixes: fe5186cf12e3 ("efivarfs: fix memory leak in efivarfs_create()")
Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/inode.c | 1 +
 fs/efivarfs/super.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 96c0c86f3fff..38324427a2b3 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -103,6 +103,7 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 	var->var.VariableName[i] = '\0';
 
 	inode->i_private = var;
+	kmemleak_ignore(var);
 
 	err = efivar_entry_add(var, &efivarfs_list);
 	if (err)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index f943fd0b0699..15880a68faad 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -21,7 +21,6 @@ LIST_HEAD(efivarfs_list);
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
-	kfree(inode->i_private);
 }
 
 static const struct super_operations efivarfs_ops = {
-- 
2.17.1


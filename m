Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6AF73CC54
	for <lists+linux-efi@lfdr.de>; Sat, 24 Jun 2023 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjFXSFD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Jun 2023 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFXSE6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Jun 2023 14:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D9C10D
        for <linux-efi@vger.kernel.org>; Sat, 24 Jun 2023 11:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015BD60A22
        for <linux-efi@vger.kernel.org>; Sat, 24 Jun 2023 18:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D5EC433C8;
        Sat, 24 Jun 2023 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687629891;
        bh=mqfNgHslXyCvQ1SOTzd4WnJh3riUH2bDIh4BBFhWoKc=;
        h=From:To:Cc:Subject:Date:From;
        b=ReCXrAljXXtCyDdD1xFGkcDn8xqUVAPYHMMvPQrY0CufQm4qy9c4xLDc86oRJcsMg
         iDVXKN7N3YnYIBpeVNK8LfklfeAvskZQ3SFyuop2yamuBXFE97ovBbc/NpZW2gHWqX
         3IdNTOKMQUGJUg/wj8BzARisWDQo/lFtXzDgYQmfOZ8/IPGWJ1hZCqIgh5gBtoy+6F
         JUxvJlrYgjopD12+7/4YpbyizttpSL+7Fgl4qrhN9Z+vDm0339KE+0rHOK9Z05qLz0
         DnSlhMN0Sc9cXaenhj37QrvJQQynyPIlsaDzI9IVLl1AqJTd6578mAopD4K3tNuF+U
         PhLyXkNrNxQcg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
Date:   Sat, 24 Jun 2023 20:04:46 +0200
Message-Id: <20230624180446.2048867-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392; i=ardb@kernel.org; h=from:subject; bh=mqfNgHslXyCvQ1SOTzd4WnJh3riUH2bDIh4BBFhWoKc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWW6gZ25O1f+T6H8z9puptoCs3LvTX2z6E0kT9q1dKO37 N8b1BU7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERCfjIy3KruW/B6asM5s6ju 561ZvA4WaxOn9N8MO7/anvF2sbF8JSPDnpSiXTtaqx8ca56beTax3XBNmPIp9pBaqXVp6cxu6R2 MAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efivarfs pseudo-filesystems exposes all EFI variables as
world-readable, and carries some logic to prevent accidental deletion
from bricking a system, by setting the immutable flag on all variables
whose purpose is unknown.

When the RandomSeed support was added, we decided not to expose this
variable via efivarfs at all, given that the kernel itself was intended
to both produce and consume it directly, without involvement from user
space. This removed the need to deal with the world-readable default
permissions (which would be undesirable for the random seed that will be
used on the next boot), as this would require special handling of the
RandomSeed variable, given that we cannot restrict those permissions for
all EFI variables without running the risk of breaking user space.

Now that the producer side of this mechanism has been reverted [0], it
is no longer possible to set the RandomSeed variable at all.  Whether
and how we will replace the in-kernel producer with something more
robust is still under discussion, but in the mean time, let's relax the
efivarfs restriction on any direct access of the variable, and instead,
ensure that it is created as user read-write only, both when the EFI
varstore is enumerated (at mount time) and when the file is created
explicitly by user space.

Also ensure that the file is not created with the immutable flag set so
that user space can manipulate the file as usual.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69cbeb61ff9093

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/inode.c | 4 ++--
 fs/efivarfs/super.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index b973a2c03dde825e..00cf368fb0ea7315 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -92,8 +92,8 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out;
 	if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
-		err = -EPERM;
-		goto out;
+		mode &= S_IFMT | S_IRUSR | S_IWUSR;
+		is_removable = true;
 	}
 
 	if (efivar_variable_is_removable(var->var.VendorGuid,
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 482d612b716bb1f0..f98597ec2105ffbb 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -115,9 +115,12 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	int len;
 	int err = -ENOMEM;
 	bool is_removable = false;
+	umode_t mode = S_IRUGO | S_IWUSR;
 
-	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
-		return 0;
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
+		mode = S_IRUSR | S_IWUSR;
+		is_removable = true;
+	}
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -147,7 +150,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
 	strreplace(name, '/', '!');
 
-	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
+	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | mode, 0,
 				   is_removable);
 	if (!inode)
 		goto fail_name;
-- 
2.39.2


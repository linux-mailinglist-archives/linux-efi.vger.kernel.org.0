Return-Path: <linux-efi+bounces-2318-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416259E8753
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 19:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4254618855D1
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E51187859;
	Sun,  8 Dec 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kH1wPd1d"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D5145324
	for <linux-efi@vger.kernel.org>; Sun,  8 Dec 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682915; cv=none; b=hvZniFMnSRzKyTUyeRU6n9wpu6iq+TGvZBr/uIowW5OHrjVriBNXs8YOYUJPhd0RK7gRk9p/yvCcG9bGHDkCjSJf1kC557BaMy69QrtyFjPh6BTtkRVdIOXycF0GvaHF7mhk4519bUfIMfnmjqaFcKPHj9Hco1llzaGQ3nL2wK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682915; c=relaxed/simple;
	bh=NKq3J5Pxbsfa6Pgv7I9k7oPyvdFWdaUofPaJD3gulr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/h/egAM7JrTxwIbio8c1el7TdyXvSvJY6SY4i69Nndu8sTd+z5w8HiVROC5fa5l6JFjXTakFn5X3kEJIjwseD1FCiedjQid138DeWEhBufkgY9n4kxn4sB2WYeC5scTDGml0GvmUJtDR0nGXK6axQECSQ+SQU0UZTfIejSEauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kH1wPd1d; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733682912;
	bh=NKq3J5Pxbsfa6Pgv7I9k7oPyvdFWdaUofPaJD3gulr4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=kH1wPd1d+tQldlINqaaTH6JxNA7FTGaGXg5v12ATBCoFFwq/fkBNjoKV/Tl7GrNGE
	 sPKcbFB7Dgf1rtLp8dK9SyGMcPCQmKk/3yyDXEjSa4JYCor6gF/eFF5vc+rApUe0h9
	 EYZc/sWS9Iy7MtI10kOnbw5FkgUT4xALOFtj+IGc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7C194128B0C2;
	Sun, 08 Dec 2024 13:35:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id mULsY8nTPwnT; Sun,  8 Dec 2024 13:35:12 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9266C128B0C1;
	Sun, 08 Dec 2024 13:35:11 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] efivarfs: fix memory leak on variable removal
Date: Sun,  8 Dec 2024 13:34:14 -0500
Message-Id: <20241208183415.21181-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efivar_entry_delete() doesn't free the entry, it merely removes it
from the list.  Neither efivarfs_unlink(), nor efivarfs_file_write()
free the variable entry meaning it remains as unreferenced but
allocated memory.  Fix by adding the correct kfree()'s.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/file.c  | 1 +
 fs/efivarfs/inode.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..41b2f5a7239c 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -48,6 +48,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 		drop_nlink(inode);
 		d_delete(file->f_path.dentry);
 		dput(file->f_path.dentry);
+		kfree(var);
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 586446e02ef7..37ff34fab9f7 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -143,6 +143,7 @@ static int efivarfs_unlink(struct inode *dir, struct dentry *dentry)
 
 	drop_nlink(d_inode(dentry));
 	dput(dentry);
+	kfree(var);
 	return 0;
 };
 
-- 
2.35.3



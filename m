Return-Path: <linux-efi+bounces-2319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBA9E8754
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 19:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC41885510
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D18189B83;
	Sun,  8 Dec 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ca+KBrEG"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30F145324
	for <linux-efi@vger.kernel.org>; Sun,  8 Dec 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682929; cv=none; b=VEF41Q7WZ1vJze4I/gCWWl66iOQSdZvQrYOaJ0hXtkBstPbBsjiNUe2q2SBij7UDeGTXwg5Nh0Ew8O7RFn39jyXcn/Jbi1RWVWSGiwrrBcxZjmQ3CestwHyF6NNhKJZG5HGBaYRbYQjy1v0f+FNXzEAaBuFE2exwURsZuA4PA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682929; c=relaxed/simple;
	bh=KOHlmiAFZTvd0H67ILWQv96xLNHHmTcIL27QVMw+bPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYk5IoOYQ6Kihtb0dFRWcrpRPGCMJqA/Ul/wdCRimNvy+DYlNucxuWPzwFJlX2RDM12ZIpNYCTwnGgTL77is6hrcUJ6RO6r215I8PTWPz+iG2mKM2FAHw5O3Ady34SBf361QHHA8zfFFzmRZH8s7Qn+KL8ZgmC1xpWK9dkFHQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ca+KBrEG; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733682925;
	bh=KOHlmiAFZTvd0H67ILWQv96xLNHHmTcIL27QVMw+bPE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=ca+KBrEG8nsiL5YzyEskA2UWOorpxGI1OiwNiCRrgjJ8/b1Gm9rmU/r+Gn2dJ6LFS
	 AdXlKi4PD4Z5OOz6rELMnvm0XAbEcoaDJPXsIYIFdgsZ+kMk3q1c9dAvgbucPAcv5a
	 MILW65qX+C2uX+z5oUxz3EY1WMJCFsJONKVYuaeE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D1A17128B0C3;
	Sun, 08 Dec 2024 13:35:25 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id MXR9ZRfW9bvX; Sun,  8 Dec 2024 13:35:25 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 50F0B128B0C1;
	Sun, 08 Dec 2024 13:35:25 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] efivarfs: fix incorrect variable creation
Date: Sun,  8 Dec 2024 13:34:15 -0500
Message-Id: <20241208183415.21181-4-James.Bottomley@HansenPartnership.com>
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

If an EFI variable is created by an open and write but returns an
error in set_variable, it isn't removed but hangs around in efivarfs
with invalid inode attributes.  This happens because the entry is
created in efivarfs_create but the EFI set_variable problem isn't
discovered until efivarfs_file_write().  Fix by having set_variable
failure in efivarfs_file_write() check if the variable existed before
or is newly created and remove it again on the latter.  The signal for
a newly created variable is that var.Attributes is empty.  This cannot
happen for a real variable because one of the flags in
EFI_VARIABLE_MASK must be set.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/file.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 41b2f5a7239c..5ef88c577e03 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -23,18 +23,23 @@ static ssize_t efivarfs_file_write(struct file *file,
 	ssize_t bytes;
 	bool set = false;
 
+	bytes = -EINVAL;
 	if (count < sizeof(attributes))
-		return -EINVAL;
+		goto err;
 
+	bytes = -EFAULT;
 	if (copy_from_user(&attributes, userbuf, sizeof(attributes)))
-		return -EFAULT;
+		goto err;
 
+	bytes = -EINVAL;
 	if (attributes & ~(EFI_VARIABLE_MASK))
-		return -EINVAL;
+		goto err;
 
 	data = memdup_user(userbuf + sizeof(attributes), datasize);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	if (IS_ERR(data)) {
+		bytes = PTR_ERR(data);
+		goto err;
+	}
 
 	bytes = efivar_entry_set_get_size(var, attributes, &datasize,
 					  data, &set);
@@ -45,10 +50,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	}
 
 	if (bytes == -ENOENT) {
-		drop_nlink(inode);
-		d_delete(file->f_path.dentry);
-		dput(file->f_path.dentry);
-		kfree(var);
+		var->var.Attributes = 0;
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
@@ -60,6 +62,17 @@ static ssize_t efivarfs_file_write(struct file *file,
 
 out:
 	kfree(data);
+err:
+	if (var->var.Attributes == 0) {
+		/*
+		 * variable got deleted or didn't exist before we
+		 *  tried to set it
+		 */
+		drop_nlink(inode);
+		d_delete(file->f_path.dentry);
+		dput(file->f_path.dentry);
+		kfree(var);
+	}
 
 	return bytes;
 }
-- 
2.35.3



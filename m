Return-Path: <linux-efi+bounces-2317-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423109E8752
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 19:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A39281152
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677D7187859;
	Sun,  8 Dec 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Yrrilq4s"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11F145324
	for <linux-efi@vger.kernel.org>; Sun,  8 Dec 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682896; cv=none; b=P/qRLaTjVfZMpXDKrH3vjYkqfBbJeu3trFQAmg6XMSBSXqsSQFQSt9l913oauloqIQI6vsSnyh7DL38DYXvfllGmM2AppvKv5MNNQjkY5KABCBiLjEom+gunTFbx3SzDLOgznfFsm7pzs0LITbvYiXiI604jEtMOJLIKM68528Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682896; c=relaxed/simple;
	bh=hYCB65UU3N49jOe4GHdnAsHY3QqHLJJXqzm1yAqJo38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUpYHTUL1mueh/J9v2U1NezYgy9M7/w6BT20bNl6Bmcdm8aS7cAXd9sw2bGooy6n5yw1hdf5NtjZhMtizxpZZcuFMhdJxkXaoEjcYp0Y38Rr/nSLX2cUbyvL2hUY0hTn9WVkt2GW8LMZA2h91mca64IgXF69xcl1uU1KFTeCjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Yrrilq4s; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733682892;
	bh=hYCB65UU3N49jOe4GHdnAsHY3QqHLJJXqzm1yAqJo38=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=Yrrilq4sml6jghzly3UkTBdhaqnaV9vRUyrCHfktRlZBL7vCU6Z2HpHNtq7sgdtKw
	 AEGKHuWcGnbdl+fnMEf3yBGKYEMQKUn+1ilOuQb6ODsREJyjJtTtFf8tsgoUx4jEeF
	 dNCOKyy5EPiAzCvk8P0UUhHdWIhrA8xgU7zfCN1o=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3ACD1286D5D;
	Sun, 08 Dec 2024 13:34:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id z1S70wOAEYtO; Sun,  8 Dec 2024 13:34:52 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2BDAE1286D4F;
	Sun, 08 Dec 2024 13:34:52 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/3] efivarfs: fix error on non-existent file
Date: Sun,  8 Dec 2024 13:34:13 -0500
Message-Id: <20241208183415.21181-2-James.Bottomley@HansenPartnership.com>
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

efivarfs returns -EINVAL if the non-existing file .doesn't conform to
the NAME-GUID format and -ENOENT if it does.  This is caused by
efivars_d_hash returning -EINVAL if the name isn't formatted
correctly.  This error is returned before simple_lookup returns a
negative dentry and is what the user sees.  Fix by removing this
check.  If the file doesn't exist, simple_lookup will return a
negative dentry leading to -ENOENT and efivarfs_create already has a
validity check before it creates an entry (and will correctly return
-EINVAL)

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index a929f1b613be..beba15673be8 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -144,9 +144,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	const unsigned char *s = qstr->name;
 	unsigned int len = qstr->len;
 
-	if (!efivarfs_valid_name(s, len))
-		return -EINVAL;
-
 	while (len-- > EFI_VARIABLE_GUID_LEN)
 		hash = partial_name_hash(*s++, hash);
 
-- 
2.35.3



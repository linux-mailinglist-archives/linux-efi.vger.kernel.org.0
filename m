Return-Path: <linux-efi+bounces-6012-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9DD38FD6
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jan 2026 17:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBEE3301C94E
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jan 2026 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDE198E91;
	Sat, 17 Jan 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="gz6qRtQ2"
X-Original-To: linux-efi@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E49475
	for <linux-efi@vger.kernel.org>; Sat, 17 Jan 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668468; cv=none; b=a6krtIqdl0VIhk6kIypWfEVXKhJtdrBv6eiM294pFY7gRYKHkUj5SMxglk4Ye+7yTdnxyWvjPOlcSCKfyy1KnxvvfmOAIMiQdq9PHjzzckYOW+q6oNatd3RvBzZN2vXX+7IlFFnikde1V9O4AuH1TH2pLGcZ/bI67Lo0Pha6lCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668468; c=relaxed/simple;
	bh=da7q0Z6SyJmHY9nK48Hy6ArJaEzfLCN2Te0uCYTo+tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLHC5yEgj39JiT7KDuIuBTW8tJcAe7GHq/tUWeJ3em212IyKomnRSKMlGUP1j2I36D1Cvzaw3+7Ww1N5OoNUMt8zXDh79sRhov8i3BLQGkPriOZimDZGcmaM0ExUiCRqTmtrWbWIN0Wo1wxhSHtS3H+r7SIBv1DdR9J1WVAvEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=gz6qRtQ2; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60HG0oXP078570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 18 Jan 2026 01:00:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=lkJIgWyKJctLtRMLFDMebGu1STus2qFG7b21R7Hm9Wk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1768665651; v=1;
        b=gz6qRtQ2dCnegXLJHUpzwKfp0BvHbvCcwBzK/uvusw2nnckch9m6emraRr8BfIs2
         0LkygG0jACXZWfSzF/OqxILOxXelonXKu1I87zvxSQSeS0EVH8yreiu0hnyaOZ9P
         VRHHHqfZKe9OBmVYTcCO6WGL045KCQoQx1O9Aa5AJp24jjn4OiahwkOFjpCBUD0v
         0APUaH/et0LO20FkBIyypDj3oqwVETHFpxaNVt6uIKwwERevS+iPXg9k881LxoHu
         u3ltrudZD/XE9wpDfr5q0tWHay851Emu8lqaMP0o2ltxXDJaE0+W1oOOFAfAtULA
         Zytw2kWnCu/Blv5glgx74A==
From: Kohei Enju <kohei@enjuk.jp>
To: linux-efi@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1] efivarfs: fix error propagation in efivar_entry_get()
Date: Sat, 17 Jan 2026 16:00:45 +0000
Message-ID: <20260117160048.370063-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efivar_entry_get() always returns success even if the underlying
__efivar_entry_get() fails, masking errors.

This may result in uninitialized heap memory being copied to userspace
in the efivarfs_file_read() path.

Fix it by returning the error from __efivar_entry_get().

Fixes: 2d82e6227ea1 ("efi: vars: Move efivar caching layer into efivarfs")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 fs/efivarfs/vars.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 6edc10958ecf..70e13db260db 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -552,7 +552,7 @@ int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 	err = __efivar_entry_get(entry, attributes, size, data);
 	efivar_unlock();
 
-	return 0;
+	return err;
 }
 
 /**
-- 
2.51.0



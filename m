Return-Path: <linux-efi+bounces-2994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF41A643B4
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 08:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61751891009
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A821A421;
	Mon, 17 Mar 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWCumc8i"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102971684AE
	for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196660; cv=none; b=aVHaJgbtFP+aNsa54o0PBtt91fy3wBAEs7PSXSjMvtsgeuveZ45UMjzAeDf/fFNGZmGYdg8Gg+PfQUsLf8iKzg3v0Xj8IxXqWcjTwUVo+pkPeZ18oDH+CJsJd39Yuxz1x8rMS4sYYL/DLNvhY/xhMmvFZXatEoD7JmtW97oXGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196660; c=relaxed/simple;
	bh=RXIoN0YIuLh8ZJIP2P/7k9AoSf+g25QzykzxbXN+Y9k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dlHbnxtmQwZi9ryz0rZkWVPQ37T2KF6miBrXJ0SfXDcNd+Zgq87/zcGQI1RFzC9qBtOEnDeLIf2i7QaQ9PJVu603P5cnjtlX2KPEQhjzKtu5tQsqWdPfXKASqJhzSdZmxFzvGf3J7t0JXw/ujifc4N7iU2ZnxblNpK2ZbolNTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWCumc8i; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so12085875e9.2
        for <linux-efi@vger.kernel.org>; Mon, 17 Mar 2025 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742196656; x=1742801456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8F5RDdY3ojxWB6NPwsbtyFcZ0YHjU9EDtqkLUrM/ag=;
        b=OWCumc8iBJmF1TTvebMIYFT2TWuJGWlYtiLVTj0aus1Pi857dyfu5cd8cxhLPok4Rq
         x+wpPM80kkfCGdpYlNmXs0DCqt5W0h08uYYYYW/sxg+DTL56/EaGSLPqcvQTbHZPDgZ/
         ozoIUZk+nAnREh9pukP+X+t9WuWtqRe+DvMh3fttAm5cKOlDEX/EEAwnnfJkRCybpStA
         VSGa+DzBMk7o6xJflMwnO1MPhOkBz+vjSpcnCmlFzjM71IaCDvF0oDkqcNKNgco++cdV
         Y68UlY5AH7d2TLtcv1nLCg/Igiz5t3JLIPRIIICB3H34oE/5hHQUPFgOmWQQezmNEGeY
         XRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742196656; x=1742801456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8F5RDdY3ojxWB6NPwsbtyFcZ0YHjU9EDtqkLUrM/ag=;
        b=X73InHcPehsl0ayUWrxrPEw31qVHio6L5TW7OpX7xcFVVnvocj1O4+A0Zvl90N4oq5
         zFxihwLDSFvVm/VhPYSs/qee2p0Ruj0Pi30I0vO5CBHyWepJ3dzTNKiiSnYtb0b3uj4w
         9+zPNpWZE/RxvLubmvqsshHOAaVMz+xf4wMnOfZyaN2RGmg+peGYtUrYhVvSfu7OcCoq
         0bjDaAtp6c8dH/UMt+xBa3YIjstEjD9yWPF0KDK23IVHCiB07yOB3PXEHjDh+qulRpBE
         FmC+lIYwf7eWX58KovFhUI7u4eYH7wmUkA/6ucREk7Wy0Cv2jl7K8iK1WA7vehZn4qbO
         +mHA==
X-Gm-Message-State: AOJu0YwCkNlxEiVyxgMcjBa92a2zbJ71TfhFMGnPUtIZULmxPfhilTU8
	CKg2RWzLF3kL/GJqXMR93RfzohjxxS1nMQR7f6vK/N7G2a5i+JyaeGcsDZloGgRFFErkczvg+9q
	zhR3LR3REElDwV8b2jCq5O2FkeSwdkuzuAHDttTUOMa62yZRALPKo9uvM2aA+n0o12Y/8UbUpVq
	Uwmd4Z2n/TDo24A9BPy/bsL/Ifrw==
X-Google-Smtp-Source: AGHT+IEjKxemIC+dzRpz86UJmjM44PUXQo47n1JfbnfCD0RYg2zugVsa+TJwYzo511LY6eX1jwnsrxfr
X-Received: from wmbgx11.prod.google.com ([2002:a05:600c:858b:b0:43d:557:d706])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c06:b0:43c:e8ca:5140
 with SMTP id 5b1f17b1804b1-43d2b48609amr29695535e9.23.1742196656403; Mon, 17
 Mar 2025 00:30:56 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:30:33 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=ardb@kernel.org;
 h=from:subject; bh=jkMEyQ1CFbo3isONEM6nl/Z6mpXYCofLSIBJf3vcQGQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf36+Zn5d7jLV/8xOemWfnPu5Ma0G7HuapdtHH977D2gP
 8taUX52RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI23OGv5Jb4lUqZu1o3HbS
 3FLYsvMH2231y+e/qW23tHLzPfQkKo6R4Zvb+jj9fu4FlpIHC4qtPH23Vtzpuv2nX3TuvKQ9glb G/AA=
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317073032.2665183-2-ardb+git@google.com>
Subject: [PATCH] efivarfs: use INODE_CHILD nested lock to traverse variables
 on resume
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: James.Bottomley@hansenpartnership.com, Ard Biesheuvel <ardb@kernel.org>, 
	syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

syzbot warns about a potential deadlock, but this is a false positive
resulting from a missing lockdep annotation: iterate_dir() locks the
parent whereas the inode_lock() it warns about locks the child, which is
guaranteed to be a different lock.

So use inode_lock_nested() instead with the appropriate lock class.

Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 6eae8cf655c1..642dff82f364 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -421,7 +421,7 @@ static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
 	if (err)
 		size = 0;
 
-	inode_lock(inode);
+	inode_lock_nested(inode, INODE_CHILD);
 	i_size_write(inode, size);
 	inode_unlock(inode);
 
-- 
2.49.0.rc1.451.g8f38331e32-goog



Return-Path: <linux-efi+bounces-148-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04E80A965
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8399B1F21131
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F838DE4;
	Fri,  8 Dec 2023 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekVRmTo+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA4198C
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 08:39:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so2741771276.1
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053574; x=1702658374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wdaG0HAwo9hiOZzzdnPuRYNNBA2AaG0L/eRDAcMYYM=;
        b=ekVRmTo+2mIDM6pa4WMNRtCdWXg3H2Vuy+0Jz79+DLAUzYKWg3DuTy7j+CUZkROAFm
         A7gIJDsZXuuNba4aM4Lo6FVjiDPvgUwCyss0ADS6koHXt6Od8vBVFCNwaaaw95TgSz9R
         l5dYVoo5ykeMRYCVB1cUk5ccmIgTKJ6PBXV03CBXlWOiUeW9mi1KhpsP5OTffQNJngPV
         eSOm6AUp5UejHbtVlkiaOYb47sg2EqsK2X3nHbwQdv5Sqb+mNch6x/NfMjWPFNOStmS6
         jCGfJLas8TVOICYzyTD3iu+CbjPfLhgrCzlinoeRSImuYnsElkzooBjTyOV2enn9dXS1
         sn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053574; x=1702658374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wdaG0HAwo9hiOZzzdnPuRYNNBA2AaG0L/eRDAcMYYM=;
        b=Bzdzb2qx6h+mmk6OWfF+Q8/gqPwKUKVxH4hO7KFKKeQ2g0yiTc6SLvMOP7DJXJo3hh
         UiOnWbaSO/0XRr6nZNaK3PkSJeS9PxzkrBU/hBm1U8HFjoBZ2AGRYXhcyT1KaoGHnIEL
         /u56V1VQqDs62tMpCCLQBdMzVqdXgHMCjhohmiCvaLKIOTiLg6T3E4t4jUhkxKoAFDDv
         F2iCGuFcsI3rx8Ko2IgcoXIlqOUyo9zY2D4G8mJsGZ9rbHKIbXpfntZqhUMMjYlfxjwj
         r8/US7+vYpdRaDIo+jyzk4xwPWj9tgFjOJnXlcrMCncRnARr5A69eXdACvkbmU/3gqpM
         djGw==
X-Gm-Message-State: AOJu0YwOwvYBXH953ktyKr/UdaefZrYqpbF7hf0eTsjU/5VkVGal45mO
	fqGkaP3muHZy1LcDHaEnoIdM1U6rpOFyTvTvUg3ndwKSRgHFcBt9JgNhOa3/mik+qxahRhbvcDX
	sBGyfrDHLHzv5w0Ltx2kbEHy3X7Ewe7xUvQfyJ+6D+6EHcxKdeVOFGNSyChmC
X-Google-Smtp-Source: AGHT+IFnGSrCwhQ87IoEicAZpfKrcJHRcQd36DEw5qrEIKu6aY/jiCZDH6Apz2sY8h0ZjLCE+u06EBc0
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:4c7:b0:da0:3a24:fe25 with SMTP id
 v7-20020a05690204c700b00da03a24fe25mr1917ybs.9.1702053574481; Fri, 08 Dec
 2023 08:39:34 -0800 (PST)
Date: Fri,  8 Dec 2023 17:39:27 +0100
In-Reply-To: <20231208163925.3225018-5-ardb@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208163925.3225018-5-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=ardb@kernel.org;
 h=from:subject; bh=uaLdEqbFi5L0XmHNhmMpPgt+M7CH0Eom/fpOtqgu+vE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbXYbf/Na4c8fL6p5T26crdv7ZfyaW66qqnW628e7gzVv
 TZ5x4d5HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi5VGMDNs86jw/3vl8uGzf
 bkfdxVv+bK9pnNnNeEx97/0mR1/Hn7cZ/un+jk0QYWY9u3G9+xPf5z8OiDeFTKnMrpm4dNe2tNk 3tjACAA==
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208163925.3225018-6-ardb@google.com>
Subject: [PATCH 1/3] efivarfs: Move efivar availability check into FS context init
From: Ard Biesheuvel <ardb@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jiao Zhou <jiaozhou@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of checking whether or not EFI variables are available when
creating the superblock, check it one step earlier, when initializing
the FS context for the mount. This way, no FS context will be created at
all, and we can drop the second check at .kill_sb() time entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 77240953a92e..72013125d7fa 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -295,9 +295,6 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct dentry *root;
 	int err;
 
-	if (!efivar_is_available())
-		return -EOPNOTSUPP;
-
 	sb->s_maxbytes          = MAX_LFS_FILESIZE;
 	sb->s_blocksize         = PAGE_SIZE;
 	sb->s_blocksize_bits    = PAGE_SHIFT;
@@ -342,6 +339,9 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 {
 	struct efivarfs_fs_info *sfi;
 
+	if (!efivar_is_available())
+		return -EOPNOTSUPP;
+
 	sfi = kzalloc(sizeof(*sfi), GFP_KERNEL);
 	if (!sfi)
 		return -ENOMEM;
@@ -358,9 +358,6 @@ static void efivarfs_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
 
-	if (!efivar_is_available())
-		return;
-
 	/* Remove all entries and destroy */
 	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 }
-- 
2.43.0.472.g3155946c3a-goog



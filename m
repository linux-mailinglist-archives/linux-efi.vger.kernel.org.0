Return-Path: <linux-efi+bounces-149-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570680A966
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377D81C209F5
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEEE38DEB;
	Fri,  8 Dec 2023 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEPMsF39"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A2122
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 08:39:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d988d69812so28360357b3.0
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053577; x=1702658377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5sYVt87FCYqBJLk7QyiQv6w5Gm0TLigzfPFRXhfBYg=;
        b=mEPMsF39zYvVVTG5v1HpBGNnL2/fnZhSVqNzlX+WcemmcI4TbIKF+q33Ez+QARJgOO
         eEnZ5TwhJhO5QjDw6oaw1ZwM9uKkmVwC9+VPb50+lOSW9K6ci4zZgTzJDvD1dn17StH7
         o2ymfZns+ownw4AzVAVx/OCuFt50R+HHnc1zK4u7WrVLLj+WGTZu+UF9btjQk8pYpw93
         6EMHEVV+uxy68CkgYeFOapqQ69xKh1g+pCq3nW8LaLrQhufJRUCMs8Jmsak7t+BAtW0O
         rGEoaziwb40J0TqPuGIgZkTm+5LbKwGudT4DWc66mWRTHXBIPhNITV3x0Mq/bPavsizY
         hYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053577; x=1702658377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5sYVt87FCYqBJLk7QyiQv6w5Gm0TLigzfPFRXhfBYg=;
        b=mmEX7sUTaQqjbRIoCMd66KJ3zH7dCecfC5nFUatqF0ZQlB/wl0Hqf9MZEODNvVzenM
         AW958ZHP1+hQU8blp4v9coQ1hrJf0wDhiTDtBGuV+DhjgK5t52KySgxrJzQ5fW7VwQdR
         3paMLTKb0P5ZklkIROGPMLOsfayiwuF9XyTrInNe0ZfEVT5i1mvrBh7ZHm+obBHFxhfw
         pzFokQRO3vDYIqH8FpRIBx3wpC+zjKnOle2IiQrRI6YEgIPKIvUddEUVcbmnWqRVza45
         1qdJcH7lKuWW3XUL4BHCNPkl07A7EnjrFXZfVZ5+stDsyjxrzPzVn157XyPXGBSRJHgZ
         mcfQ==
X-Gm-Message-State: AOJu0YwoRtHlCl9tHdYK77mkQgNAWq2hGRHoiXgXLZyCiXxH/21RI0Fm
	oA/W/5QWtBXDFxuIVphQmJrZPozj5LgF8/pdBZmq6FThp5iGXvkqCKUHDrhZ9w0P7VR2TISZb2I
	hBmdMyxQOyXueE1rnxTI0VZluXnm8sOcJwt0eVi/kAVwr6TaCQu8hfQ3KwmlW
X-Google-Smtp-Source: AGHT+IE16ieiGgEIn/3jtrMk8px3BwmCyFhn5oR22TU/JIsA0arGBbg0XjLaD7dd0FI/KrGr24XFCLlZ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:9:b0:db5:382f:3997 with SMTP id
 l9-20020a056902000900b00db5382f3997mr1556ybh.11.1702053576772; Fri, 08 Dec
 2023 08:39:36 -0800 (PST)
Date: Fri,  8 Dec 2023 17:39:28 +0100
In-Reply-To: <20231208163925.3225018-5-ardb@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208163925.3225018-5-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=ardb@kernel.org;
 h=from:subject; bh=haHcTZL+VZSQVeM26b57c5jTs7nqw/bCLK55UTSwFKg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIbXYbb+IjyyzSELHhbqgqGuOp2b9eLnthZrVJn9XAYNH8
 yedyfvfUcLCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayV4Hhf9qcLSqt2p+ZRP+1
 VvDdO5nQKXvF/lJAtK1QmdRayzzZaQzf605NkZ2Ykb/55MQAbqFbhycfNo0Qs+44fa41aAbLEhM OAA==
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208163925.3225018-7-ardb@google.com>
Subject: [PATCH 2/3] efivarfs: Free s_fs_info on unmount
From: Ard Biesheuvel <ardb@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jiao Zhou <jiaozhou@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that we allocate a s_fs_info struct on fs context creation, we
should ensure that we free it again when the superblock goes away.

Fixes: 5329aa5101f7 ("efivarfs: Add uid/gid mount options")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 72013125d7fa..891acf7b0903 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -356,10 +356,13 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 static void efivarfs_kill_sb(struct super_block *sb)
 {
+	struct efivarfs_fs_info *sfi = sb->s_fs_info;
+
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
 	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+	kfree(sfi);
 }
 
 static struct file_system_type efivarfs_type = {
-- 
2.43.0.472.g3155946c3a-goog



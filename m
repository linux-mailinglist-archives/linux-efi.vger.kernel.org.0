Return-Path: <linux-efi+bounces-2820-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC490A40FC0
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 17:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E31894A58
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37151804A;
	Sun, 23 Feb 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2iY0ZY1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED56EEA8
	for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328324; cv=none; b=iq8qFe4dpz7Evee0/M9hFB//jKb4+UyPOlLGVoLCURd605GRqKxFDUwlv0f6EVEpB1a3BjWcvonJ6DdKWbcWePIVX3ENcMrxO7T3EaVrS0AccOctY+/AYKj87icBAsOyFa/t2g00TO+koUNzLZv7KcuPHD3TpPPaZTvoo6JHoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328324; c=relaxed/simple;
	bh=KE1UiZumidYoqn3HFTNxS1QLve8izgGclr5cDZrwEh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejhEwmzkwmlpDIASQg05JVlaN0BxmCK5drQbRelalahYxw94F8T5ucH/G8MrUtH6Hbi2WJZ3jg/T8Ix3/fsAJYmdOLvQREdveHWfuPsdRnSshM+qB9kOAh9Ujb5dcv1+yuOabc+XAcZXMmcfdgJ0Vot2Yu5xkP/kHW20zzIJF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2iY0ZY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F9BC4CEDD;
	Sun, 23 Feb 2025 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740328324;
	bh=KE1UiZumidYoqn3HFTNxS1QLve8izgGclr5cDZrwEh8=;
	h=From:To:Cc:Subject:Date:From;
	b=D2iY0ZY1fOT4RGHAVC0uqJ8lDyuyOZOi367HTGGYjyXTrKjzQzZ0HB+mJLtOm27WB
	 hkVIaESlGudYD13jZISe7nmDEqW3UsAF5em/nmbFf5ksaL/Hb9ZTsK+yvklGplpufc
	 N/Qkajm8UWuTnIuIUVQ6PBHuo7JF+n0GWd9VA9ehEevglXhLEl0O391E5iA1286kxx
	 8aRfFd7VbIJmXdpjoF3VDSFo+NCnAuN01LrZq4YK5sF8aAkTFnyWv56OBFLAqYLGxj
	 3ZIGaV3WfGVCpCt9At+qne0dHXxv6HTaPwuVto1H1NuLA/XgOLSKaEjtxFSmAsd9Vj
	 LJllakaLSN3Xw==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Subject: [PATCH] efivarfs: Defer PM notifier registration until .fill_super
Date: Sun, 23 Feb 2025 17:31:44 +0100
Message-ID: <20250223163144.25540-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=ardb@kernel.org; h=from:subject; bh=KE1UiZumidYoqn3HFTNxS1QLve8izgGclr5cDZrwEh8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX23b8Gb9oZ9F3Nt3qmonlOUKDped+tKs09k1OFJ9w6F/ JGfb9/SUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby5iMjw8ZvS3/nLOQsTroa GZMQ++fUmn8Xvq6Y25LoUXfiT9/0s22MDK0PBSw116xMNPbvXu/R9Iy52PZi9ZYVYlIBfWaXkzg L2AE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

syzbot reports an issue that turns out to be caused by the fact that the
efivarfs PM notifier may be invoked before the efivarfs_fs_info::sb
field is populated, resulting in a NULL deference.

So defer the registration until efivarfs_fill_super() is invoked.

Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Reported-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Tested-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/efivarfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 09fcf731e65d..6eae8cf655c1 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -367,6 +367,8 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	register_pm_notifier(&sfi->pm_nb);
+
 	return efivar_init(efivarfs_callback, sb, true);
 }
 
@@ -552,7 +554,6 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 	sfi->pm_nb.notifier_call = efivarfs_pm_notify;
 	sfi->pm_nb.priority = 0;
-	register_pm_notifier(&sfi->pm_nb);
 
 	return 0;
 }
-- 
2.47.2



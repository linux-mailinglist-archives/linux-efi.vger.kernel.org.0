Return-Path: <linux-efi+bounces-3057-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B7A6C24E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A207177F0D
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB722FF55;
	Fri, 21 Mar 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Mzb0kVyL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7822FF41
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581320; cv=none; b=Ekul4i0Er3MbxQVQjRfBGpnJ5IWWx/suOXuDHalrEwxDYfH/+a5dK6Hoyl+LXIYFNGq8Fjtrjfr0N3OSUiMv5yZfGq49zP9vwu77xXNMCjlw7pJcAshyaKqfETidGtoPI/vtZZ3NqM7W0r5cUEVPWsvHeVZvCq9od6qHFKiyJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581320; c=relaxed/simple;
	bh=Km/lmJT7WXfeyoWCsjE3+40++PbnaxaMlPsWDIjYSO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh9SgeWFG46neQXvgHbloMwE1+gMmOjJxg8Vz78uBZGobPMhEa5fQuBknQcRXJT1W7sWnzjfeXtQNgXkx04/c2aUZrO6Gwop723lAvQzHwWi2EiU4DyFEFwXZt/qi0FzgKX9zFK7hJA+odVi6bW/XC4ZxZZ57Eou/vfbcqapHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Mzb0kVyL; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 5AA491C16F4
	for <linux-efi@vger.kernel.org>; Fri, 21 Mar 2025 21:21:54 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1742581309; x=1743445310; bh=Km/lmJT7WXfeyoWCsjE3+40++Pb
	naxaMlPsWDIjYSO4=; b=Mzb0kVyLlMdhNBD8shJWDo+K4QEPcYSwgTSqMtQrqXW
	eV4GnjTZg7OCrqm8uqE2jcMh73hS2fit/zrCu5mf+OECIOhQjMaazThG6R+/UgRl
	NPd/haUtD0xmmiv4s5n08xvXsd6oFkVHYiYwe3wavqFi+l1yDGXkdpdU60AFfPm0
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qYDiwjLdNp_p for <linux-efi@vger.kernel.org>;
	Fri, 21 Mar 2025 21:21:49 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 2E4521C0628;
	Fri, 21 Mar 2025 21:21:49 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Jeremy Kerr <jk@ozlabs.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Subject: [PATCH 5.10 2/2] efivarfs: Add efivars_lock to synchronize list operations
Date: Fri, 21 Mar 2025 18:21:25 +0000
Message-ID: <20250321182126.1716111-2-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321182126.1716111-1-sdl@nppct.ru>
References: <20250321182126.1716111-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.
    
The bug was fixed by upstream commit cdb46a8aefbf ("efivarfs: Move
efivarfs list into superblock s_fs_info") but it depends on major changes
done in the mainline kernel and 5.10.y needs its own patch.

Add locking around efivarfs_list operations to prevent race conditions
during processing of multiple filesystem superblock instances.

list_del corruption. prev->next should be ffff0000d86d6828, but was ffff800016216e60. (prev=ffff800016216e60)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4299 Comm: syz-executor237 Not tainted 6.1.119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0x13c/0x158 lib/list_debug.c:59
lr : __list_del_entry_valid+0x13c/0x158 lib/list_debug.c:59
Call trace:
__list_del_entry_valid+0x13c/0x158 lib/list_debug.c:59
__list_del_entry include/linux/list.h:134 [inline]
list_del include/linux/list.h:148 [inline]
efivar_entry_remove+0x38/0x110 fs/efivarfs/vars.c:493
efivarfs_destroy+0x20/0x3c fs/efivarfs/super.c:184
efivar_entry_iter+0x94/0xdc fs/efivarfs/vars.c:720
efivarfs_kill_sb+0x58/0x70 fs/efivarfs/super.c:258
deactivate_locked_super+0xac/0x124 fs/super.c:332
deactivate_super+0xf0/0x110 fs/super.c:363
cleanup_mnt+0x394/0x41c fs/namespace.c:1186
__cleanup_mnt+0x20/0x30 fs/namespace.c:1193

Reported-by: syzbot+246ea4feed277471958a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=246ea4feed277471958a
Fixes: e14ab23dde12 ("efivars: efivar_entry API")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/firmware/efi/vars.c | 11 +++++++----
 fs/efivarfs/super.c         |  4 ++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 010febd2ab6b..517bf886ba14 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -417,6 +417,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 	const struct efivar_operations *ops;
 	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
+	bool var_present = false;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
 	int err = 0;
@@ -451,8 +452,12 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 						&vendor_guid);
 		switch (status) {
 		case EFI_SUCCESS:
-			if (duplicates)
+			if (duplicates) {
+				var_present = variable_is_present(variable_name,
+									&vendor_guid,
+									head);
 				up(&efivars_lock);
+			}
 
 			variable_name_size = var_name_strnsize(variable_name,
 							       variable_name_size);
@@ -465,9 +470,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 			 * we'll ever see a different variable name,
 			 * and may end up looping here forever.
 			 */
-			if (duplicates &&
-			    variable_is_present(variable_name, &vendor_guid,
-						head)) {
+			if (duplicates && var_present) {
 				dup_variable_bug(variable_name, &vendor_guid,
 						 variable_name_size);
 				status = EFI_NOT_FOUND;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 24a0c5ef4169..7a6e2676b312 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -212,7 +212,11 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
 
+	err = efivar_entry_iter_begin();
+	if (err)
+		return err;
 	INIT_LIST_HEAD(&efivarfs_list);
+	efivar_entry_iter_end();
 
 	err = efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
 	if (err)
-- 
2.43.0



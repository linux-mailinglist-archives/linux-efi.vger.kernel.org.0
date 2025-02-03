Return-Path: <linux-efi+bounces-2737-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B9A25E21
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C783A5167
	for <lists+linux-efi@lfdr.de>; Mon,  3 Feb 2025 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80C2045A1;
	Mon,  3 Feb 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Im7x7fAh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C3208A7
	for <linux-efi@vger.kernel.org>; Mon,  3 Feb 2025 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595041; cv=none; b=AUla2I+KjAwV/U6hmRmn3tYJTJog0rGut+hPPZC9n8OfEGHt1HbtcLeuyTtvWirOR3vxAT93PjOXrs50US6wj2ON/Yq0ymVsdnQfark6X786WVCBmat/FOFsSwZ6N/vyb/BdkxZcW5oI8Q9biQ5un8XQaw54hxCEZh3VOXjyV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595041; c=relaxed/simple;
	bh=RQjGAj1IWyaNTRzxKQHHBrEelrAVESw3rl3VydV04Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nibOxrCMnWwePtle8isqePWWkZ01QzkGOebdRvQFO8pLfdz8gNXpH62nKOE9vTqjqeXlUnKJfBZTfBvCk3CGYsltF3/cjl2V1LE+rQBNDk6geNTVKFyJXc8W1skc2A1jaIlYshf/Bck0ASAmM2+kMzBekGWKzGyG+7mfrxbcRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Im7x7fAh; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id A287B1C241F
	for <linux-efi@vger.kernel.org>; Mon,  3 Feb 2025 18:03:45 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1738595024; x=
	1739459025; bh=RQjGAj1IWyaNTRzxKQHHBrEelrAVESw3rl3VydV04Js=; b=I
	m7x7fAhrG1fuLBZUihpWl2IfKvk9lAZyxCPK0r+XNiYPdvX7UYZFi2I0PcMjD9v7
	rxDJylmJNcOPa9u6rE/vNvx7iHCwBYzAff0b4wVlW5QGKbtc4eNlrF1xkfNP4PK0
	NrXkpdO8m1407Y4sv31RgT9hefJXGeIXypi30qaTr4=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4gVEb2GOpAiF for <linux-efi@vger.kernel.org>;
	Mon,  3 Feb 2025 18:03:44 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 19AE21C0E7A;
	Mon,  3 Feb 2025 18:03:43 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1] efivars: Fix "BUG: corrupted list in efivar_entry_remove"
Date: Mon,  3 Feb 2025 15:03:26 +0000
Message-ID: <20250203150336.2694569-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent list corruption in efivar_entry_remove() and efivar_entry_list_del_unlock() 
by verifying that an entry is still in the list (list_empty() == false) before calling 
list_del(). Also reset the list pointers with INIT_LIST_HEAD() to avoid potential double-removal issues. 
Ensure robust handling of entries and prevent the kernel BUG observed when list_del() was called on an 
already-removed entry.
Fix https://syzkaller.appspot.com/bug?extid=246ea4feed277471958a

Syzkaller report:
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
 task_work_run+0x240/0x2f0 kernel/task_work.c:203
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x2080/0x2cb8 arch/arm64/kernel/signal.c:1132
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x168 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:585

Reported-by: syzbot+75dc11...@syzkaller.appspotmail.com
Fixes: 2d82e6227ea1 ("efi: vars: Move efivar caching layer into efivarfs")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 fs/efivarfs/vars.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 13bc60698955..42977138e30b 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -490,7 +490,10 @@ void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
  */
 void efivar_entry_remove(struct efivar_entry *entry)
 {
-	list_del(&entry->list);
+	if (!list_empty(&entry->list)) {
+        list_del(&entry->list);
+        INIT_LIST_HEAD(&entry->list);
+	}
 }
 
 /*
@@ -506,7 +509,10 @@ void efivar_entry_remove(struct efivar_entry *entry)
  */
 static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
 {
-	list_del(&entry->list);
+	if (!list_empty(&entry->list)) {
+        list_del(&entry->list);
+        INIT_LIST_HEAD(&entry->list);
+    }
 	efivar_unlock();
 }
 
-- 
2.43.0



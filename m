Return-Path: <linux-efi+bounces-5807-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF6CA6ED0
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 10:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206DE30361E9
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5B26C3BC;
	Fri,  5 Dec 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMxF/Za3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E329BDAB
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927148; cv=none; b=utRA2mNXTS2mqDGqL9jtefMK2xDTVXkmCY8cafT6iumSbDDfeiVpU+AFYFI8suL/l45RlsGrN3VcHpRMic3yu8291XK2qqStesahmzW5LMmtHaaOTSysXOZpQHzt1KHkAaAKIwunx7Bf9GLl4BvYmXVH2Ckx9vJdl9lEjOJ7IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927148; c=relaxed/simple;
	bh=pxbbe2w2t6nlaaOhQDuTP4FSah4IvXjiHdsmk/+Rexs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6w3kBYGonD4R8+LcLyryoupDACvXY7j2KGjCCr5JN4zmKbfmwpS+KL9J60la31hakle13AyXm1tQ/G8LAq48VKNLFD76T1192DrNhiDRLxHd+Rq0r5OxKYyc4HZO+JiYfTBW0xWbod4Vz7kFeaboaxtsN6h/a4fVfsyzmMVLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMxF/Za3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D85C4CEF1;
	Fri,  5 Dec 2025 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764927147;
	bh=pxbbe2w2t6nlaaOhQDuTP4FSah4IvXjiHdsmk/+Rexs=;
	h=From:To:Cc:Subject:Date:From;
	b=LMxF/Za3fvL0JkagfSi+if9wGlCAaY3Wzet8DVLSt3mjAqira5fUSO+C3gOm6kjzf
	 eDnLFG5aZ2laSwjGvqSmF1aFSfdAiygsLFUfe76kS3rcSWwiHKdD0WCAYqNmcRhY99
	 VWrpaFP3osRdmPlB8x1OeF3VJNJUsZMP6S7BWIPewfq36NZeHmQkPzPLfeCT5ETPtz
	 LVxPDNa7LUBihlosYk/YoGJuaLJ+NGwgBZ9jvZf/cgQaTvKWuOlGo4vlCch2TLq3My
	 n3MAqX5mzMisHSgJwPpc7zT4eUJ/xzTSgOnIL7PNx1ShUzEmvErOMHhOHjuPSYi0Y2
	 zodsfWpwlCD2A==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	James Le Cuirot <chewi@gentoo.org>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH] efi: Wipe INITRD config table from memory after consumption
Date: Fri,  5 Dec 2025 10:32:16 +0100
Message-ID: <20251205093215.607858-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=ardb@kernel.org; h=from:subject; bh=pxbbe2w2t6nlaaOhQDuTP4FSah4IvXjiHdsmk/+Rexs=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdNo2YIZdeudslijFq+wNk1wPL2m0CcqpGLGjID3M8684 C3tXbWgo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkw0aGf1Y50ufeSkZMjJ9l 0fQq9/4G3nRW4S+5ib+/5Fze/yKmZyXD/4r/aU9sG9x7Nzow/MiRaZv8xzmZJyszUmB6zm4v9jh RBgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

When the EFI stub itself loads the initrd and puts it in memory (rather
than simply passing on a struct boot_params or device tree that already
carries initrd information), it exposes this information to the core
kernel via a INITRD configuration table.

Given that config tables are preserved across kexec, this means that
subsequent kexec boots will observe the same information, even though it
most likely has become stale by that point. On x86, this information is
usually superseded by the initrd info passed via bootparams, in which
case this stale information is simply ignored. However, when performing
a kexec boot without passing an initrd, the loader falls back to this
stale information and explodes.

So wipe the base and size from the INITRD config table as soon as it has
been consumed. This fixes the issue for kexec on all EFI architectures.

Reported-by: James Le Cuirot <chewi@gentoo.org>
Tested-by: James Le Cuirot <chewi@gentoo.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/all/20251126173209.374755-2-chewi@gentoo.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a9070d00b833..988198c36a63 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -818,6 +818,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		if (tbl) {
 			phys_initrd_start = tbl->base;
 			phys_initrd_size = tbl->size;
+			tbl->base = tbl->size = 0;
 			early_memunmap(tbl, sizeof(*tbl));
 		}
 	}
-- 
2.47.3



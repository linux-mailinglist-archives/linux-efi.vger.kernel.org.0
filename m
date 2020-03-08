Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D889B17D291
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgCHIKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgCHIKg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:36 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FCF20838;
        Sun,  8 Mar 2020 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655035;
        bh=VmjVz0cw0oHKZKPj5pJD4LBc61IdV08dBNK5VqEkJog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XF9F7kgtVpxBeH8aesqpMcrbxLL9+vG6VdHBCLe67i6C3nA8sWnI1bYqwYGwyAUN7
         uoUgVNx8YgXlDx0Cvp8wH5iolIJW3fSZ46W63famskBat5NucQaGyl26PPmaDBS9S9
         2cv4jHztwY2EuP9mw/VVckUULp/Mi16DXTl1gbcw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 25/28] efi: fix a mistype in comments mentioning efivar_entry_iter_begin()
Date:   Sun,  8 Mar 2020 09:08:56 +0100
Message-Id: <20200308080859.21568-26-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20200305084041.24053-4-vdronov@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c | 2 +-
 drivers/firmware/efi/vars.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index d2f6855d205b..c2f1d4e6630b 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_entry *pos,
  *
  * @record: pstore record to pass to callback
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  */
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 436d1776bc7b..5f2a4d162795 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
  * entry on the list. It is safe for @func to remove entries in the
  * list via efivar_entry_delete().
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  * It is possible to begin iteration from an arbitrary entry within
-- 
2.17.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE7799A57
	for <lists+linux-efi@lfdr.de>; Sat,  9 Sep 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjIISHW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Sep 2023 14:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjIISHW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Sep 2023 14:07:22 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3381B0;
        Sat,  9 Sep 2023 11:07:17 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D083D3F1FC;
        Sat,  9 Sep 2023 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694282833;
        bh=fWTy72WTsQkOBNAqUW3iczBOxfyhkjYvdgghJ2pL+w4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=V4RsD28+14GvCxryAv6TsOX9Vskos1gdUycALMT1qzXsN8r2BuFUf2EDe3l0mDUCZ
         ky6DQam3FAbMJDzso52PDRp4+tVU3E4QMWFdJ+nj6H5+gbFhalbZCSE6bup/BCg9n6
         MBtiXOixlul1SR1VOAx8Pu+FNsURzI+/VfxM/RNAeB4TSny1jNNySnHv9HXlvRAVN3
         xiRGPoX3R+6MApMacNEr5B37wtYjK31OEr2VEDAs9uRd5fsoGw3Db1VrAToTt8VYLy
         iiFQ19vt7uXLejf91kJ+CdfcYXeu9iO/d425v0BnUkV6z9YootgTpfm/KGZedxo/7a
         a1ANPQknkNIaA==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Anisse Astier <an.astier@criteo.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efivarfs: fix statfs() on efivarfs
Date:   Sat,  9 Sep 2023 20:08:12 +0200
Message-Id: <20230909180812.10904-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some firmware (notably U-Boot) provides GetVariable() and
GetNextVariableName() but not QueryVariableInfo().

With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
statfs syscall was broken for such firmware.

If QueryVariableInfo() does not exist or returns an error, just report the
file-system size as 0 as statfs_simple() previously did.

Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Tested on riscv64 StarFive VisionFive 2 with
Linux 6.5 and U-Boot v2023.10-rc4.
---
 fs/efivarfs/super.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..7f3064b948ab 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -32,11 +32,6 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 storage_space, remaining_space, max_variable_size;
 	efi_status_t status;
 
-	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
-					    &max_variable_size);
-	if (status != EFI_SUCCESS)
-		return efi_status_to_err(status);
-
 	/*
 	 * This is not a normal filesystem, so no point in pretending it has a block
 	 * size; we declare f_bsize to 1, so that we can then report the exact value
@@ -44,10 +39,19 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 */
 	buf->f_bsize	= 1;
 	buf->f_namelen	= NAME_MAX;
-	buf->f_blocks	= storage_space;
-	buf->f_bfree	= remaining_space;
 	buf->f_type	= dentry->d_sb->s_magic;
 
+	/* Some UEFI firmware does not implement QueryVariable() */
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
+		status = efivar_query_variable_info(attr, &storage_space,
+						    &remaining_space,
+						    &max_variable_size);
+		if (status == EFI_SUCCESS) {
+			buf->f_blocks	= storage_space;
+			buf->f_bfree	= remaining_space;
+		}
+	}
+
 	/*
 	 * In f_bavail we declare the free space that the kernel will allow writing
 	 * when the storage_paranoia x86 quirk is active. To use more, users
-- 
2.40.1


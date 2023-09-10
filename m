Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0DA799CAF
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 06:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjIJExw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Sep 2023 00:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbjIJExv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Sep 2023 00:53:51 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFB1A5;
        Sat,  9 Sep 2023 21:53:47 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7CC073F6E8;
        Sun, 10 Sep 2023 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694321622;
        bh=Tqi6lKwkCDtOSm6x+4nuXgIPF7Qwninbar0fNQ2vKfY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=a8YlhTj501jI9/1y5oLbYftPKHmKLTYZPOjSomNRsG6piPM8ucYUR15tv6p/28yV4
         0pg4pveFyFMliLWmKq9xocDFfHAU7ho6DEow0xZs7X1wObnvTkdpM1dsWkt8bmeKd6
         1RSpCWVEj8A/yDVpsipr7/pLDNqfX83Dg8JeUnAkjPh2YmMnomh7yNKBFAovSw+k3H
         /YnVmMThYRRP51apFHX8Ota3n/VwAwMNcl9OTRCvQvMjZZzaqhSEGuxwkIq/Uj7wiz
         KPGDXh+VGuLlMz5z8Aao5XFgbjP11CjmulcHgENWkgzBdRYVxT/i7T1jkMsM5wctdk
         A3IbPs6xKTRrg==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Anisse Astier <an.astier@criteo.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
Date:   Sun, 10 Sep 2023 06:54:45 +0200
Message-Id: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
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
v2:
	initialize remaining_space to 0
---
 fs/efivarfs/super.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..3893aae6a9be 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -29,14 +29,9 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	const u32 attr = EFI_VARIABLE_NON_VOLATILE |
 			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
 			 EFI_VARIABLE_RUNTIME_ACCESS;
-	u64 storage_space, remaining_space, max_variable_size;
+	u64 storage_space, remaining_space = 0, max_variable_size;
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


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45B167C9C9
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jan 2023 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjAZLXf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Jan 2023 06:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjAZLXf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Jan 2023 06:23:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676B62250;
        Thu, 26 Jan 2023 03:23:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40681B81D67;
        Thu, 26 Jan 2023 11:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF4C433EF;
        Thu, 26 Jan 2023 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674732211;
        bh=66CKXAS/9EP3h8TINvZYNEfbZEZC0fHykS1xCI4vhh0=;
        h=From:To:Cc:Subject:Date:From;
        b=uIXzC1Vzni8t9BXgZoq8o0afdj8AMuiS7eTtEUEHkjTslxW6Ve/37BP0lHiIcbDIB
         q/MtyscQCcpASrh6Ey5zWSm/Ys7josHMN6CuiJeHBmnhtNoWcdMjJcjkJXpcrnboLk
         tP4nQpjYLWm657VvkR4kh6yjFtPyxkpoRRnxN9x6cqtA1EdsyZ4ipOsgG7hSjhhHyv
         LDeOqR0v8wIDZf7alQC/5bXPlDLROFwE2dBFqZp2864+LmvQmX2e9WJ9V/72kiEZVe
         8NHbB7UBwO7rwkrYAt5nc6bdDNgs6utmzhlB7bW+hbB5/3cHkihmmMMqxlSlGh8fb+
         pD93stJBo7ZRA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL0Lx-0001Cy-8A; Thu, 26 Jan 2023 12:23:38 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
Date:   Thu, 26 Jan 2023 12:21:29 +0100
Message-Id: <20230126112129.4602-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The VFS calls kill_sb() also in case mount fails in get_tree().

Add the missing check to make sure that efivars has been registered also
to kill_sb() to avoid dereferencing a NULL pointer when trying to remove
efivar entries.

Fixes: c3fd71b428b8 ("efivarfs: always register filesystem")
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b67d431c861a..482d612b716b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -246,6 +246,9 @@ static void efivarfs_kill_sb(struct super_block *sb)
 {
 	kill_litter_super(sb);
 
+	if (!efivar_is_available())
+		return;
+
 	/* Remove all entries and destroy */
 	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
 }
-- 
2.39.1


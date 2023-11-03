Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BB7E0B68
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 23:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjKCW6q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Nov 2023 18:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCW6q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Nov 2023 18:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CFD50
        for <linux-efi@vger.kernel.org>; Fri,  3 Nov 2023 15:58:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CF2C433C7;
        Fri,  3 Nov 2023 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699052322;
        bh=AyxVpE/wYNI6pbf4HImX1P3REBkDBorADg+dXzFnWCA=;
        h=From:To:Cc:Subject:Date:From;
        b=moozylg1iIPhAyJ6A17f9CC3sgnzXNTA8Eosi2JtNa0Y6xrmI3yevzoJocbYUzlw4
         nochf+gjMfnjZubk89vubmaQTctIP/jKo/mRcrMQWe7GWnD/oa3psWWr5yWTHNWl7b
         7f3lC2kR/+W3Hlf1FCwqi8aVvwSp0F5QLxNz4pGZCKRDcCsr5nV1cQJLrx27pj37td
         326S3A96Gp3IY4Q4H71K3wlIOhqEJhBlgjr0HJF8TMCFxm+8Ed5pEQsi55IMyIbGPB
         e0Lqkzwn594C+BMuJ753akErSX2BZofZqLC8hsm+/b0DQ2HidaLex5+kfOIfutQtka
         /ifUGZxrAEttw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI update for v6.7
Date:   Fri,  3 Nov 2023 23:58:28 +0100
Message-ID: <20231103225829.427073-1-ardb@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull the EFI update below. This is the only remaining EFI change, as
everything else was taken via -tip this cycle.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.7

for you to fetch changes up to 5329aa5101f73c451bcd48deaf3f296685849d9c:

  efivarfs: Add uid/gid mount options (2023-10-20 00:47:18 +0200)

----------------------------------------------------------------
EFI update for v6.7

- implement uid/gid mount options for efivarfs

----------------------------------------------------------------
Jiao Zhou (1):
      efivarfs: Add uid/gid mount options

 fs/efivarfs/inode.c    |  4 +++
 fs/efivarfs/internal.h |  9 +++++++
 fs/efivarfs/super.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

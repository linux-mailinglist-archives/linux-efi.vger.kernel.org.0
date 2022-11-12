Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF16626C85
	for <lists+linux-efi@lfdr.de>; Sun, 13 Nov 2022 00:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiKLXAs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 18:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKLXAr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 18:00:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85CDE89
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 15:00:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A63609FB
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 23:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9147FC433D6;
        Sat, 12 Nov 2022 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668294045;
        bh=LgpWSeG9UA3417hE9CZR2D3yGYFqrUM+YwkB5dm/ej8=;
        h=From:To:Cc:Subject:Date:From;
        b=JcqpuFijbW7SNPox+2M5T2VSa3x8eTRBas6nVSVnJQZF85o8n9gPX5evFIxfnolbq
         x33pxg2zRa3WOdpbocS1AMMBNTLIbZGyUetx5/b5nAw96soAlL76aB+RqKnh3WZACm
         vd8G724d9C1MDyu+jcmAUi/xDQ2ozUwQifdP9i/zmVQWOH2+6N5bTM1oBSwjaeA7s/
         /5CF7cG7uyr6EEqomA9dDgQkACK0uHWU9s/IAay5s0V9CGq2CzKQZ99VUFmXQxqF43
         ggWzx0ii8a1gPFI5tUAAcwi4UZn2hTIPZswozD9XqtpCngqKAr4Nx8OPc+DsR4Z4ia
         +MRdYvCA/8b6w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.1 (#3)
Date:   Sun, 13 Nov 2022 00:00:30 +0100
Message-Id: <20221112230030.3248-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=ardb@kernel.org; h=from:subject; bh=LgpWSeG9UA3417hE9CZR2D3yGYFqrUM+YwkB5dm/ej8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjcCWNTPsY1RipmSiLVpDHiEr6YbNMoBt0vPcJ8x2K KqVSSGWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3AljQAKCRDDTyI5ktmPJMXdC/ 9nIEBmMicirdJ7JV/K47qosOFH8iLKQ+aiuJUJYS64xsFOakRt5HLCRUf0wzLGzDp8ucn4H1T7A6S4 v+TXdsEEDvsr7+xw5Yuk9irImo6ku0JT4A2eCwV+2ts6tUteBvKVdZzUCD8sktKZ4kTlLVLCB7n8OS Z1HZKu3W2eu5cfzZYDZcZsRnVDHwBgUq+yHQufylhAKMOXzJwSgm9YsrluFC9leovX94jUAsNUbxNK L6a+XuDSlWKnqzIO89ftPN/MbXWN1wXFUBaBaGmwMwsM83qTVFSzxgxsbKr56WJZil9CTIu3ugvyah +BPxuYAUyEeilklylnNaxeNtnXFiK35GigSi4+/gAvw48hxinb0KmN+cZRews3+aVhZTM6ZqmZhXfp BQy/bWjmvrn3j1zh8gfhaMh9nYeD9B5P6n/psJwAH/ah+gss+WW/ZGjl1ahOVTn9uZlGYy3vpswaxt 3orCAY6Ge/esH7Y0tDZGFTJJLZHG8Udt/vdiCziDVVYMQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Here's the PR with the patch that gets rid of the misalignment WARN().

The other patch adds an SMBIOS based quirk for Ampere Altra machines. This is
the first time we've added such a quirk on arm64, but fortunately, we can just
call a EFI protocol to grab the type #1 SMBIOS record when running in the stub,
so we don't need all the machinery we have in the kernel proper to parse SMBIOS
data.

Please pull.

The following changes since commit 23715a26c8d812912a70c6ac1ce67af649b95914:

  arm64: efi: Recover from synchronous exceptions occurring in firmware (2022-11-03 18:01:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-3

for you to fetch changes up to 9b9eaee9828fe98b030cf43ac50065a54a2f5d52:

  arm64: efi: Fix handling of misaligned runtime regions and drop warning (2022-11-10 23:14:15 +0100)

----------------------------------------------------------------
Third batch of EFI fixes for v6.1

- Force the use of SetVirtualAddressMap() on Ampera Altra arm64
  machines, which crash in SetTime() if no virtual remapping is used
- Drop a spurious warning on misaligned runtime regions when using 16k
  or 64k pages on arm64

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: efi: Force the use of SetVirtualAddressMap() on Altra machines
      arm64: efi: Fix handling of misaligned runtime regions and drop warning

 arch/arm64/kernel/efi.c                   | 52 ++++++++++++++++++++-----------
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 17 +++++++++-
 drivers/firmware/efi/libstub/efistub.h    | 28 +++++++++++++++++
 drivers/firmware/efi/libstub/smbios.c     | 48 ++++++++++++++++++++++++++++
 include/linux/efi.h                       |  1 +
 6 files changed, 128 insertions(+), 20 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/smbios.c

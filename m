Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F594DAAED
	for <lists+linux-efi@lfdr.de>; Wed, 16 Mar 2022 08:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbiCPHCR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Mar 2022 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiCPHCQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Mar 2022 03:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D65DA55
        for <linux-efi@vger.kernel.org>; Wed, 16 Mar 2022 00:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BEB61012
        for <linux-efi@vger.kernel.org>; Wed, 16 Mar 2022 07:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52BFC340E9;
        Wed, 16 Mar 2022 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414059;
        bh=/aDkPo63qsaZANvXaGj2dqASteDulfYKIpwRPgC1Nuo=;
        h=From:To:Cc:Subject:Date:From;
        b=fsCi3UN3q6spYCxJIk387J/bubgbHTu4ltlPGW3aH2tmb++HCYjVU5LpZWEealcvw
         Ih6gK91X0iafWF+BnAWG1LXQzUlXP1loJ0XXt+hzFIgrtGy0WLDClZscXLlyjAPfVR
         efmy8gxMFoWC7TLGUKSCDDyqGL/nu5yubY1w8/tFFNAlQyGPJNXSZnUmVJ5jJ0Kkkv
         7KFBb/SjqnwTO8n1NideGQgQisOg9C6nXYMMZ0Wm2StRXfxhLVbmP/U6wKgVUN75TK
         opHWhfkwwH1kV7NEWNu3Mpnd4A3nvJ11SS+yHWSkqxuovRfWhi9XK20ZiCvUd7vtf+
         ccqEseY1QQhKQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fix for v5.17
Date:   Wed, 16 Mar 2022 08:00:51 +0100
Message-Id: <20220316070051.3489932-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; h=from:subject; bh=/aDkPo63qsaZANvXaGj2dqASteDulfYKIpwRPgC1Nuo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiMYsjv49DT0V2poIbel8MuzbnzGO1VIboNQUbM7M2 tDPsOuuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYjGLIwAKCRDDTyI5ktmPJJUZC/ 97ObFePVDSJncG6GeYFJJ9d63C7am9fUson8m6gSCM7uiq6nTs0iwWWtszGlrXxF5RmOdDargFd9/0 TmONVnmXkuYwGJ6dIFtxssqfDXiCocIfZ8W4yw48da+FRpkqClOmB751EKeHqMd46CWAE0JuUwRCh3 d0XkNTv5BV8CCzELC9Mg6lQRqlAuZK2qmaheIbD0CkcLIW9zy916l1tt+BXnVt3VQfAQ80zF8KOVfG EVkqIMq1uR0LoCxUNgrKT+DDKwl9Ec5/VchxrlWT4hjhBNazJOonlQ6nD6XIcgAqJ6ASuAHBEsMRwe YsqiZmLYqmg25B0yAS+BrXvdU07k4FwhgmQHiFa0ZSoNqhuSd3KXEX+wtOF9XzlAaEF+uctAWZI4i2 yUbnL6sp/HCddu1LbxH7EmQ+SLLhlPKdu6665y4KG73+Vx3SKTIHUQrvmjl5yKQvaAkZnvM5JwjyvB EOUN2dwLwNn6NoZ5TqN5v4J49z92vposhZKVHs3OxkDAQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 258dd902022cb10c83671176688074879517fd21:

  efivars: Respect "block" flag in efivar_entry_set_safe() (2022-02-28 10:07:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-3

for you to fetch changes up to 9feaf8b387ee0ece9c1d7add308776b502a35d0c:

  efi: fix return value of __setup handlers (2022-03-01 09:02:21 +0100)

----------------------------------------------------------------
Final EFI fix for v5.17

- avoid spurious warnings about unknown boot parameters

----------------------------------------------------------------
Randy Dunlap (1):
      efi: fix return value of __setup handlers

 drivers/firmware/efi/apple-properties.c | 2 +-
 drivers/firmware/efi/efi.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

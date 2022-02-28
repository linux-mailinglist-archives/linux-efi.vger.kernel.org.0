Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87DB4C6582
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiB1JNt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiB1JNt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 04:13:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BE3A5F3
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 01:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9555C611E9
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 09:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBDAC340E7;
        Mon, 28 Feb 2022 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646039589;
        bh=MFaZdq3ahue5Rd0e+g2maoU/N36vY0rFJR5y4GTdSNU=;
        h=From:To:Cc:Subject:Date:From;
        b=DIMZ9fm4eELzUAfw4Om0me4aLlvVPj9yBm+7wWQImKWwlsVelJec6ePNmetXkpvzD
         hGIySDuCCLgvgcFX+7XOuK/Vzoye8/bFsXan3USOjgHEJlB58nWxfNX7b3zx23rUrS
         I5HIFZ1aIcc0Mfw2RuLEzHMTvnTEtO0Fp1ynntYR87uogVN8ATikEQaeLuWQ52ITSk
         JRKK+kD1HIWJ4fjulNyvB6Gx6dt+lIH2eqHnPpgx0VprFca7SwXB1POsPzw/VY830/
         yog9P47n1MSqcBJ2XOfrhe0G3bNazCxk7Id/61mHRbw/emg6KWzQkohClpAdbIyujc
         XRgDmWwpay5lA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] More EFI fixes for v5.17
Date:   Mon, 28 Feb 2022 10:12:56 +0100
Message-Id: <20220228091256.814321-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; h=from:subject; bh=MFaZdq3ahue5Rd0e+g2maoU/N36vY0rFJR5y4GTdSNU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiHJIYVv0Rvil+1FNXjTtlVLYZ3SOEs3zPhhb7JMSy uRc9ndWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYhySGAAKCRDDTyI5ktmPJP4zC/ 0cM2fT4bLSwdBhg0f9ND4JNx3qwJgogU2m8+CAf/+u3OVpaq30iJw2niu0UUC+XrRyq/sc/O7xjZ1d uIg25tShbdXA1H1Er/0UAiSi5tWTiekJxZCYyE212v8XIHXPeJT0srBwwQrl+sEv07iXZLMGK87a1X nBjlJEVT01usO+cG/OsjD9eTaCU0ZEIZeoDUyDqdE3X433LgATuxXmaSF/0KxryYhZpaQsayoOZy/S dOrliwvaAxlDDdNoNVHM06ke2j+YiYuzqCkzRZL8XG1wFv7jK9bT5xkBX97KKpuwHBh9Uk7aWhoq3O ppdns7Iq7y0Uu7vLLBMIpE/uz5VySFcXbIjm97kLoDl4d8bXVD2yUlqXC/NGc4TXm3o/Juaes2ek85 c5Lw6A+Sa/iYVdn4qAj6r7d+bIQWQ7cmxSJq/omvTmt+bWMhRYvAvtgLuj/56WWBVmzGGvvAa5XS+a 3JCYxRRF7k9RfFKgtkdP9sahTvycQfSP+g/vJRSsKAl80=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit f5390cd0b43c2e54c7cf5506c7da4a37c5cef746:

  efi: runtime: avoid EFIv2 runtime services on Apple x86 machines (2022-01-23 10:31:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-2

for you to fetch changes up to 258dd902022cb10c83671176688074879517fd21:

  efivars: Respect "block" flag in efivar_entry_set_safe() (2022-02-28 10:07:50 +0100)

----------------------------------------------------------------
More EFI fixes for v5.17:

- don't treat valid hartid U32_MAX as a failure return code (RISC-V)
- avoid blocking query_variable_info() call when blocking is not allowed

----------------------------------------------------------------
Jann Horn (1):
      efivars: Respect "block" flag in efivar_entry_set_safe()

Sunil V L (1):
      riscv/efi_stub: Fix get_boot_hartid_from_fdt() return value

 drivers/firmware/efi/libstub/riscv-stub.c | 17 ++++++++++-------
 drivers/firmware/efi/vars.c               |  5 ++++-
 2 files changed, 14 insertions(+), 8 deletions(-)

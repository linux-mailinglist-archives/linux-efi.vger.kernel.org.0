Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0D693745
	for <lists+linux-efi@lfdr.de>; Sun, 12 Feb 2023 13:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBLMTo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Feb 2023 07:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBLMTn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Feb 2023 07:19:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2F1717
        for <linux-efi@vger.kernel.org>; Sun, 12 Feb 2023 04:19:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C92E60C7E
        for <linux-efi@vger.kernel.org>; Sun, 12 Feb 2023 12:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F762C433D2;
        Sun, 12 Feb 2023 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676204381;
        bh=d1ZyXh6guM5Vk9gF551+H4W6CD9W8LUVcy3Ej/tJVOM=;
        h=From:To:Cc:Subject:Date:From;
        b=dF+CI//tBHx8nPowG95Pm7dJ1T/HHs7wIrRt5H3epe51EjHJhBtd9wnhyrVXYgZCk
         B/o+UW1iBRqS8m3ZZtQfIlE3DgASLBlTbLtDXM5aCfImaG8M11Ur/9qEG1hRo6ql/6
         7ZvpNYgrU+3uBcpyA1PdItxoxrqAJQjUSjt414o7ja2UsRcuHzyCfWYT9GlgLCH8Fn
         IurhrjlM6FgEs3MuJVQ4NSB08kuhoIBFEf9OfbQE9Wws6UOAFLKdpeGMbnsxyB0XG1
         Vi+PMYz6xMR+16d1lrr2c1mrNQ4cNykeSFfUtAQvpK7IIV7bWOI+8b0oN/uD+YHvFv
         jH2+E36e0RBlQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, darren@os.amperecomputing.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.2 #4
Date:   Sun, 12 Feb 2023 13:19:33 +0100
Message-Id: <20230212121933.2030597-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=ardb@kernel.org; h=from:subject; bh=d1ZyXh6guM5Vk9gF551+H4W6CD9W8LUVcy3Ej/tJVOM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj6NlUVUH9/WLhy2cxvZbleyZSO5oeyoCrT/LT8 bAYX46JL0yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+jZVAAKCRDDTyI5ktmP JOq6C/4mVb0QJ99UaT3qHFV0FgyMiy2zkfIJt9/bTiooV/AKdmWe1LFT2WKGhA2sreY4XBxralo nHu4oRlt8UZf3KlFCLmrHodM/8/F2oJ1NoJltBFjI5diw3TAVCNf5+FRG3CyehK2oVHh9p6VChg S4Ujr3ekT4ReUZ015o6SBdVOwDN3cgKv9+xrsJWOlqw2T/ajJCNUjLdUhsD3aVCZf+He23+9S4G 0zSvp1S843nBZkHk5c1GDc2JsBfriCEG549qtdhd5qMUP+TO9l7HkdIcYON71KACLALtK+C1b2r KrtOiXrT5bzqenOx3VKRI1tlniQtp2+8xyRazaY3vjdTb61HV/jIh0Eh5xyuKp+1hXo+QzJ/wzb fWMGBgPkxy89IX8I4OdHZF5dAogefFJPhANTaOHYOCX24+SZs8dafUUrRyyQFUpks+Ck6iHXJSj OQB+c19RnR/OlJRcsUuXyeEjAEG39Xpvsr/PONo++3VpF+ebcdfgtlcahXnnNDERNQjV4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

A final fix for Ampere Altra systems which is cc'ed to v6.1 stable. This is
getting a bit kludgy but we are collaborating with the Ampere firmware
engineers now to come up with a proper workaround.

Please pull.


The following changes since commit 966d47e1f27c45507c5df82b2a2157e5a4fd3909:

  efi: fix potential NULL deref in efi_mem_reserve_persistent (2023-02-03 14:52:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-4

for you to fetch changes up to 190233164cd77115f8dea718cbac561f557092c6:

  arm64: efi: Force the use of SetVirtualAddressMap() on eMAG and Altra Max machines (2023-02-09 12:38:35 +0100)

----------------------------------------------------------------
Final EFI fix for v6.2

A fix from Darren to widen the SMBIOS match for detecting Ampere Altra
machines with problematic firmware. In the mean time, we are working on
a more precise check, but this is still work in progress.

----------------------------------------------------------------
Darren Hart (1):
      arm64: efi: Force the use of SetVirtualAddressMap() on eMAG and Altra Max machines

 drivers/firmware/efi/libstub/arm64.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

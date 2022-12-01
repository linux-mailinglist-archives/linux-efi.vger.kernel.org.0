Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC063F71E
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 19:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiLASHt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLASHs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 13:07:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A329391F2
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 10:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA921620B1
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 18:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E30C433D6;
        Thu,  1 Dec 2022 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669918063;
        bh=dZpBWFrtFLaihC/1SCtPUM8T6FclTT9gBGEfPbK4k/I=;
        h=From:To:Cc:Subject:Date:From;
        b=Yhkbc2KKRJf7qpzJaix3moSyqlJQ54P1jIXu6DzlgbOfZlIeJ/1KdjJUKj5Q87JGq
         BLd+jpjujM8q2s/tISy8BMxj+zEGw90aRm/1+jep7YGOsOe9P6EMDlbiAtAo1UFK83
         keg/OD9UaM6NhHYlXSUYQpI9N+DMxVZBzt1G+77IecQNzCC/NIzHVpjtfQO2SmRI7a
         lt4DBhyPG8d77R5El8x7dECTf6GeR3Lr40TSwZeYSvExICM9aHkVmG0A8X4BEj8YxL
         3xNX5afLgMblmC6Gaw+zczJrXL9d5sV5OqEZ3JGEq3KcLxSx/4NI+jl4ERSnwdLcW6
         HUl7f5alo1dqg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fix for v6.1 (#4)
Date:   Thu,  1 Dec 2022 19:07:25 +0100
Message-Id: <20221201180725.3063485-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=ardb@kernel.org; h=from:subject; bh=dZpBWFrtFLaihC/1SCtPUM8T6FclTT9gBGEfPbK4k/I=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjiO1cc+WhJN24LpJ4U0wFMsLo26l99xJrEJ+7bhBK JeLhkoqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY4jtXAAKCRDDTyI5ktmPJECRC/ 9+cHevzPolor9nMZXo8+AcRCySiL4pcMsxfAOZ6SSUiER6Jak9GNVQ/H5FpeK5YhAIfQq6woVYpMnR BgdcfTeQuDGJDZzIv823bkCBjeBPkCj2oXCGAtxPzMSJmw5gk0/XRUPQyK+s8TkicmfTtpbw9G4E31 PtBw/AHyYsniyvZ9B724o8mKbir/cFk9TVqxkOy1f39uRJXJXHp4eoM4d0w7GuWmva/JI1xJ+aHuQo /RJPVcWGCHZlkLtDBbHD6Rx0Nj2/d4J1Ntjvv4jr3mmPC5Xx6LZLb90GNftKWtZviZPdW+JeXoN6+K 21Qgz0PGfWDRj7yHGVLqaOdlBGyW+9Pe31h9NKp10CCY5CUVnSTtnnQ18En9Ts7gKuhAFQzFx5mw3F zCnn/w74y5OSntlIe37WTZHIjRTvzURWlZ9hZ3KYOQlWJeHcqPKtQFqnRXCh1oJI6fdXI5wQmcD+4s gpzqrSl+HcpfPvVIs2qiqwWslo2EemZltQWBx45mUJMMw=
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

Please pull the below, which is a single revert for some code that I added
during this cycle. The code is not wrong, but it should be a bit more careful
about how to handle the shadow call stack pointer, so it is better to revert it
for now and bring it back later in improved form.

-- 
Ard.


The following changes since commit 9b9eaee9828fe98b030cf43ac50065a54a2f5d52:

  arm64: efi: Fix handling of misaligned runtime regions and drop warning (2022-11-10 23:14:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-4

for you to fetch changes up to 7572ac3c979d4d0fb42d73a72d2608656516ff4f:

  arm64: efi: Revert "Recover from synchronous exceptions ..." (2022-12-01 14:48:26 +0100)

----------------------------------------------------------------
Final EFI fix for v6.1

- Revert runtime service sync exception recovery on arm64

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: efi: Revert "Recover from synchronous exceptions ..."

 arch/arm64/include/asm/efi.h       |  8 --------
 arch/arm64/kernel/efi-rt-wrapper.S | 33 ++-------------------------------
 arch/arm64/kernel/efi.c            | 26 --------------------------
 arch/arm64/mm/fault.c              |  4 ----
 4 files changed, 2 insertions(+), 69 deletions(-)

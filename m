Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC31678216
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjAWQqA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjAWQp7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 11:45:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852412CC5D
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 08:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C51E460F7C
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 16:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA1FC433D2;
        Mon, 23 Jan 2023 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492326;
        bh=iTAqITF5KOrN5ZtC3HlQK8LIXkKrA2VIv/9cP8es4pE=;
        h=From:To:Cc:Subject:Date:From;
        b=F0Tv1Uwzk+N1r75yycP4kSGu79upjQCyLMq7bX+D5rCIhr5RPE7GIPhpNiCIyMxjL
         bmHlYoQvcKssP57Trv4AQfPclh7yyQ26OGrpU36O8CR6YIE5heaYl/M9nTO0V+QpFn
         xHqFQQipdj2a0GiQjQEjiYJXxeU+XkBebPxUnypbLw3Ug+YVDowkeaUC/5TRl9aZj+
         C/OB1JlVOB5dPGB8SNv27mR7N7EghlT8lrHsScY271+FGQXgdn438uqrsydrHsmG+m
         KDMvofvEGir+nvX6T6LpgCPLGb1jonuUK9EdXuijFMizGTR0zR1aSWKea/urmWN6nl
         8HI/Fs8th8nFw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.2 #2
Date:   Mon, 23 Jan 2023 17:45:18 +0100
Message-Id: <20230123164518.557152-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=ardb@kernel.org; h=from:subject; bh=iTAqITF5KOrN5ZtC3HlQK8LIXkKrA2VIv/9cP8es4pE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjzrmdJdroHTY9uCLp6QR3sk0QCg2IEWndZfEQDP8M Sq8h89GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY865nQAKCRDDTyI5ktmPJENbC/ 0XiRpfHDjytgkoXwzDEvsdYpd5Hl8So8vU+fuIin5A4DFQW4eYPlmE01OoC1S0rBfOSW9KFP4ThH6e Mp2j78ixUraks0lm946uHk/Sb/6faG6hbsEXmwmEKv3A6B0jaaPkVIP9PTI9E8VQMKwIA/5AFnYxV+ ePuAkmGfwx1Gnng5a0d/PnZmBAm9fBhSx1s+1fORF4aGtKmjqJHwqt/sAxOPP4SEnj55NPK3ja8Dma wBd85TuT96WWsWzcOt0nDc32XMKXrYioNZ+XBtfXBLoiCZBAHqWWtIFnA9/DtIr4QSd/OrUFvK/iWO 3/bScnUtJRPcVGos37W8Op1q3bW7OPppyr8gzt3wAkuew+kaDxMZr1mFcmOX5Nk7Nj3oEVPmY1OlcU FvUr+18VFLkLEkVz9W2x2Wx7fXy5YcobVrmkX/uH9BtIeG6uZZzO4svd6fVY/cBejFBmyl2yvbzwTO wH+L7T1APLO3qLq2u45FMjo9JaIQEZVx+E/8ipbN1txik=
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

Another couple of EFI fixes, of which the first two were already in -next when
I sent out the previous PR, but they caused some issues on non-EFI boots so I
let them simmer for a bit longer.

Please pull.



The following changes since commit d3f450533bbcb6dd4d7d59cadc9b61b7321e4ac1:

  efi: tpm: Avoid READ_ONCE() for accessing the event log (2023-01-13 17:15:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-2

for you to fetch changes up to e1fabbc83cb1dd4ba63932faa86c9cacb8bf791e:

  efi: Remove Matthew Garrett as efivarfs maintainer (2023-01-18 09:24:48 +0100)

----------------------------------------------------------------
Some more EFI fixes for v6.2:

- ensure the EFI ResetSystem and ACPI PRM calls are recognized as users
  of the EFI runtime, and therefore protected against exceptions

- account for the EFI runtime stack in the stacktrace code

- remove Matt Garrett's MAINTAINERS entry for efivarfs

----------------------------------------------------------------
Ard Biesheuvel (3):
      arm64: efi: Avoid workqueue to check whether EFI runtime is live
      arm64: efi: Account for the EFI runtime stack in stack unwinder
      efi: Remove Matthew Garrett as efivarfs maintainer

 MAINTAINERS                         |  1 -
 arch/arm64/include/asm/efi.h        |  9 +++++++++
 arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
 arch/arm64/kernel/efi-rt-wrapper.S  |  6 ++++++
 arch/arm64/kernel/efi.c             |  3 ++-
 arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
 6 files changed, 44 insertions(+), 2 deletions(-)

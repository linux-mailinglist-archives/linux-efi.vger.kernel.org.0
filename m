Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBE669E40
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAMQhS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 11:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjAMQgv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 11:36:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132088A33
        for <linux-efi@vger.kernel.org>; Fri, 13 Jan 2023 08:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CB61B82185
        for <linux-efi@vger.kernel.org>; Fri, 13 Jan 2023 16:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1EC433F1;
        Fri, 13 Jan 2023 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673627503;
        bh=p1llkU2dbsNszI525NeO5TtXSAZDKtFuI/9YMy0yJnE=;
        h=From:To:Cc:Subject:Date:From;
        b=Wy8Z5uK4VZ2taRMNXrEX9L/KCDZG1oKBlD+j0kyKZDuqFzEJPh5f0IeGe8iRuDoyu
         3Xmb27Y6siaTmEHLAzM8c2OZETaQUPXx1IEAYU8eJRtiul5JTsYmOkru2XDhEwZhfr
         0kVvGDhxldv/X5rKP6yvF75brT3KXUtyI3FdFmdoEJNWUFCv5PJK5rZOUP1jYo1wdT
         H6VbNmRXns4vHUqH48eQkxRoxWQ6aO04LxvGXhITiZfwj9TvIHf3P7tidGrfMdTDtt
         rPOlRn9tlx+mQUTWDukFm9iR8EdlgzE1SsTMhHF2/fAlAZvMVHbyrDhpllpe7RXOVO
         JGsJiCbkDfjPg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.2 #1
Date:   Fri, 13 Jan 2023 17:31:33 +0100
Message-Id: <20230113163133.4083780-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=ardb@kernel.org; h=from:subject; bh=p1llkU2dbsNszI525NeO5TtXSAZDKtFuI/9YMy0yJnE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjwYdkYP0lS+7Zw8UENoOX3VwEvqBSaS9tqqoBeGti Rxz0bruJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY8GHZAAKCRDDTyI5ktmPJA8bDA Ci9zWWYaY3X1VihCdbzcYx5fL4Sipg3bjvjkCUs6dpzzGWIMDzjTIeYhVBfGpsuBOdhBd16brFRt3M oUTQj6ZGLO3PJIguk1ryCqCIKYRjvy4vXvY5chZ+xyTBkt6fw6+PxSbR33J/JubfwkAPuDYfpeNdyo Gb391l4WFXodp4LNR71TaP/jMBPlps+kVUIlLUP0FTHR+i4rLIx9mTormi0Vv5p6Luw0/4ISw/zomp jZbO6OEhGNIO4BkPnrTD53rl0QIetxo0+zizdq1GQ4j40ApIZebInVAI8P89dx54yW4autOH+k4J5o bkVCn95IA6FhNLM0XV8K4wJt/g/7AEyBvaaOgdDo0ATHivepQbku1UnPSTZXrh3YQd5+k9lGrAlIFI 1AHRrfRZ+Fw646d3G/agJH9ZrzjEEdNrjbx1PTlovU2yItAfR+ICY43tvhDIhDnw8i8Sa51Pgzw8Xt YzCUjchuTHs/pu8JKII8yxGl+Kd//E9uzY/OEgyFWMoNA=
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

Hi Linus,

Please pull the changes below. Explanation in the tag.

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-1

for you to fetch changes up to d3f450533bbcb6dd4d7d59cadc9b61b7321e4ac1:

  efi: tpm: Avoid READ_ONCE() for accessing the event log (2023-01-13 17:15:17 +0100)

----------------------------------------------------------------
First batch of EFI fixes for v6.2:

- avoid a potential crash on the efi_subsys_init() error path
- use more appropriate error code for runtime services calls issued
  after a crash in the firmware occurred
- avoid READ_ONCE() for accessing firmware tables that may appear
  misaligned in memory

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: rt-wrapper: Add missing include
      efi: tpm: Avoid READ_ONCE() for accessing the event log

Ding Hui (1):
      efi: fix userspace infinite retry read efivars after EFI runtime services page fault

Johan Hovold (1):
      efi: fix NULL-deref in init error path

 arch/arm64/kernel/efi-rt-wrapper.S      | 1 +
 drivers/firmware/efi/efi.c              | 9 ++++++---
 drivers/firmware/efi/runtime-wrappers.c | 1 +
 include/linux/tpm_eventlog.h            | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0236C36C8
	for <lists+linux-efi@lfdr.de>; Tue, 21 Mar 2023 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCUQSW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Mar 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCUQSQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Mar 2023 12:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C950F94
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 09:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2F561D01
        for <linux-efi@vger.kernel.org>; Tue, 21 Mar 2023 16:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37721C433D2;
        Tue, 21 Mar 2023 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679415488;
        bh=JrdC+tSVV1GF0eMx8kixwiYxHHn6Ry1M8zdfV7mO38Q=;
        h=From:To:Cc:Subject:Date:From;
        b=rb8/t7VT+5rmOQV1aRzs5Dh9nKftDqdu8vWLY/sw3i945+ravdK4c9dS09oEao+oX
         4iHHZTJ5YhmrtM/gMWxAFYvzQPoPcYAHBvxwnN7+Qros93sNea9gdWrYNdpbJ2NVoP
         n9kYtlAuIqDvwa2P+y0cuIXQ5olknMUPyPIado3n64NxtaAE075HComuEqcggZ7S8/
         eDhR6Zas2aacv3/nTkvxXWF29syvXkBNAoTn6bSTkfvClq0YXWz7FLXS9fHMu6XPc4
         +MV8TaQTxq+HGHG+EhIHhxgzZjFfP6wvgrbQmFkQOkhggD/AbrxER/51neiu+x3DGd
         HqiJnreau/SAw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 0/3] efi: Allow initrd LoadFile2 proto on loaded image
Date:   Tue, 21 Mar 2023 17:18:00 +0100
Message-Id: <20230321161803.3289140-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=ardb@kernel.org; h=from:subject; bh=JrdC+tSVV1GF0eMx8kixwiYxHHn6Ry1M8zdfV7mO38Q=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXyxvYlR1bx2t31X615+nf/HetjDLtydxj1SBreX6Bsu OTmuT0WHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAirxkZGRZ9irzhUDzhSVjP ZaePnR7/0kPnx2szuHxV2vdaw0ZEdT4jw+1eqxU3t6zhWeYzZ0NW7BSBaefEvQ9tsvt8za2hv3f PYVYA
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

Rework the code that loads the initrd via LoadFile2 so that it looks for
the protocol on the loaded image handle first, and only if it doesn't
find it here, on the global singleton device path. This works around
reported issues where intermediate loader stages are providing an initrd
via this mechanism, and subsequently loading another intermediate boot
stage that does the same.

Changes since v1:
- pass 'end of device path' to LoadFile2() when grabbing the protocol
  from the loaded image instead of from the initrd global device path
- add Ilias's tags

Link: https://github.com/systemd/systemd/issues/26723

Cc: Michael Brown <mcb30@ipxe.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Ard Biesheuvel (3):
  efi/libstub: Use const qualified device path protocol pointers
  efi/libstub: Pass loaded image EFI handle to efi_load_initrd()
  efi/libstub: Look for initrd LoadFile2 protocol on image handle

 drivers/firmware/efi/libstub/efi-stub-helper.c | 56 ++++++++++++--------
 drivers/firmware/efi/libstub/efi-stub.c        |  4 +-
 drivers/firmware/efi/libstub/efistub.h         |  7 +--
 drivers/firmware/efi/libstub/file.c            |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  4 +-
 include/linux/efi.h                            |  1 +
 include/linux/pe.h                             |  2 +-
 7 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.39.2


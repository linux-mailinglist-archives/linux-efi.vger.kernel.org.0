Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC96B3920
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCJIsV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 03:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCJIrj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 03:47:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91A2DE43
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 00:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 565F6CE27CE
        for <linux-efi@vger.kernel.org>; Fri, 10 Mar 2023 08:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81AC433D2;
        Fri, 10 Mar 2023 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678437938;
        bh=FaNUKC1sqlTPN5IsjASLivbQwDJgMkNZwmRAzbiIl6o=;
        h=From:To:Cc:Subject:Date:From;
        b=gRC2URz5xxYmkO7m815/2I9xx2trSYmRMKt+YRNifGnv5EkVBFGbuhfwWrFRT3bT0
         Oy7hhhN1uSXd0gT/GefCP5o2naWCUEiM4f3JBwDJQDDKK2M/crBmBFcrF/IztL9xtl
         xe41hybEXMjJIzAauJsnbM6bslaNF532YoiZT/ZQC1HHTydpeYXB809ADtrGCobbNA
         EAhXjaYlN5OGpGzM//BDtAndrWZRfWFjkFh4nI+G82gNTY3EncD+n4cAG6NPaCpkL8
         4DIMl6nBKFyogvgsErdtc4uJL9udeC+ZaIEb1/OoiYt3tKqIUS9yJLyHGgQ5wl0vau
         vsLT2bSr3L3Lg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Michael Brown <mcb30@ipxe.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/2] efi: Allow initrd LoadFile2 proto on loaded image
Date:   Fri, 10 Mar 2023 09:45:27 +0100
Message-Id: <20230310084529.3229983-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=ardb@kernel.org; h=from:subject; bh=FaNUKC1sqlTPN5IsjASLivbQwDJgMkNZwmRAzbiIl6o=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXrnfrvOQ+1VlqnvpvW4mHb8cKAeWK1wcWWeCbOR9Xn/ R80nt/YUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaynIHhf6JOQsj3+7+EnHha tYMYlT3SQk1av7DO/vJjofO3c943Sxj+WWv+l/ybfeeDX+t0tw3TLypfff7ccOlF/ywRg4epOxr 3MgMA
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

Rework the code that loads the initrd via LoadFile2 so that it looks for
the protocol on the loaded image handle first, and only if it doesn't
find it here, on the global singleton device path. This works around
reported issues where intermediate loader stages are providing an initrd
via this mechanism, and subsequently loading another intermediate boot
stage that does the same.

Link: https://github.com/systemd/systemd/issues/26723

Cc: Michael Brown <mcb30@ipxe.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Ard Biesheuvel (2):
  efi: libstub: Pass loaded image EFI handle to efi_load_initrd()
  efi: libstub: Look for initrd LoadFile2 protocol on image handle

 drivers/firmware/efi/libstub/efi-stub-helper.c | 45 ++++++++++++--------
 drivers/firmware/efi/libstub/efi-stub.c        |  4 +-
 drivers/firmware/efi/libstub/efistub.h         |  3 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  4 +-
 include/linux/efi.h                            |  2 +-
 include/linux/pe.h                             |  2 +-
 6 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.39.2


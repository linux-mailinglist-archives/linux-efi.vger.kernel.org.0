Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C4598061
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiHRI4K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiHRI4J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:56:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D8985AD
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2409EB82140
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A87C433D7;
        Thu, 18 Aug 2022 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812965;
        bh=HJxKuoLDX+gus1QsZw0e5C3ucrkSADKgGdBh7ekO2I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPhn1ir9n3IUvtOpEdnoYPDnockJQVEbXE2cWaqc2RiuA9m0c8BvyDc331nObD56/
         lwxuGU+Rq85uTL/7q6YWgYFbipWfbK2+mAgSURHpFCjCan2cxESB+ZjF3Fut/5qJNd
         snPy2vlAKCSV5kIZVhclU3nnYOAOrehAxZZvf0OF9XKk9V2fH5Mhpc/LuWqcN7E0Gy
         uDXdYR1n/mN08abHu/l+tMqvXl/MOFrltKxAZl9q4b+vBjOazr5g20su3YFsy8XvA9
         vds6/BPGxAoe8ITp4ZPM2s2A7/3rAb4WlKsob5se/mUu0/SO+vMvE+AwQdP4fFkRcE
         PuwXH0h3XKd8g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: [PATCH resend 7/9] efi/efinet: Don't close connections at fini_hw() time
Date:   Thu, 18 Aug 2022 10:55:37 +0200
Message-Id: <20220818085540.2075028-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263; i=ardb@kernel.org; h=from:subject; bh=HJxKuoLDX+gus1QsZw0e5C3ucrkSADKgGdBh7ekO2I0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f6FMJQNAk7wnyHw01tA11+4wUmXwt63+lKRx7AO iHW6zJ+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+hQAKCRDDTyI5ktmPJNk+C/ 9PVgYLFVaLhpPmXYa9PjoKNArXeCQHde4X4iP1dI8U+oJCqB17M3zbXy7Y3QAR4eMVuSIlC1vmrMJW IUFCfdFa3BAR5ZFnPwZrNwbgkoEWpAkdr9anbp2SfRrNdxuSGB5Niv8dBBa3qYFb7ZwuQoYa6y48x6 FKMf5on3bKk4weGdLS2PFEd2phUqa0nT5b2JmiiYMsrwT4lvUEgDEYdLZ/XDJaWZn/J9kpnZG/YGN3 1PX+w0LHb/J5YX81XQjd2kLyrWn6Lb7vYatZ7KzT/QbB2hLlCHpVWsaDb1OGDQxqbmwrRxaLghAJzc Othj6S9rqj9mvEyORv5v5kYSAOOtIkZoDpqczcrd3kKmQYkfPSfP5HpReEXVtb0CenXriScRQfsd0n ktr4j47e2HSwtZ0lc1MvnCsyYJ1olbMx2lIk9w65MIHQ/Ln7+Ned+el7F+kfdVGz4scxnTa2NttKww aId2BY65kEbk9udcSJpU8phWnj2GvpGdZLrTkmPocwAM8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When GRUB runs on top of EFI firmware, it only has access to block and
network device abstractions exposed by the firmware, and it is up to the
firmware to quiesce the underlying hardware when handing over to the OS.

This is especially important for network devices, to prevent incoming
packets from being DMA'd straight into memory after the OS has taken
over but before it has managed to reconfigure the network hardware.

GRUB handles this by means of the grub_net_fini_hw() preboot hook, which
is executed before calling into the booted image. This means that all
network devices disappear or become inoperable before the EFI stub
executes on EFI targeted builds. This is problematic as it prevents the
EFI stub from calling back into GRUB provided protocols such as
LoadFile2 for the initrd, which we will provide in a subsequent patch.

So add a flag that indicates to the network core that EFI network
devices should not be closed when grub_net_fini_hw() is called.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/net/drivers/efi/efinet.c | 10 +++++++++-
 grub-core/net/net.c                |  2 +-
 include/grub/net.h                 |  3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/grub-core/net/drivers/efi/efinet.c b/grub-core/net/drivers/efi/efinet.c
index 73343d26d9e1..5adf5f40f492 100644
--- a/grub-core/net/drivers/efi/efinet.c
+++ b/grub-core/net/drivers/efi/efinet.c
@@ -320,7 +320,15 @@ grub_efinet_findcards (void)
 
       card->name = grub_xasprintf ("efinet%d", i++);
       card->driver = &efidriver;
-      card->flags = 0;
+      /*
+       * EFI network devices are abstract SNP protocol instances, and the
+       * firmware is in charge of ensuring that they will be torn down when the
+       * OS loader hands off to the OS proper. Closing them as part of the
+       * preboot cleanup is therefore unnecessary, and undesirable, as it
+       * prevents us from using the network connection in a protocal callback
+       * such as LoadFile2 for initrd loading.
+       */
+      card->flags = GRUB_NET_CARD_NO_CLOSE_ON_FINI_HW;
       card->default_address.type = GRUB_NET_LINK_LEVEL_PROTOCOL_ETHERNET;
       grub_memcpy (card->default_address.mac,
 		   net->mode->current_address,
diff --git a/grub-core/net/net.c b/grub-core/net/net.c
index 064e7114e012..7046dc57890a 100644
--- a/grub-core/net/net.c
+++ b/grub-core/net/net.c
@@ -1787,7 +1787,7 @@ grub_net_fini_hw (int noreturn __attribute__ ((unused)))
 {
   struct grub_net_card *card;
   FOR_NET_CARDS (card)
-    if (card->opened)
+    if (card->opened && !(card->flags & GRUB_NET_CARD_NO_CLOSE_ON_FINI_HW))
       {
 	if (card->driver->close)
 	  card->driver->close (card);
diff --git a/include/grub/net.h b/include/grub/net.h
index a64a04cc80b1..79cba357ae6a 100644
--- a/include/grub/net.h
+++ b/include/grub/net.h
@@ -64,7 +64,8 @@ typedef enum grub_net_interface_flags
 typedef enum grub_net_card_flags
   {
     GRUB_NET_CARD_HWADDRESS_IMMUTABLE = 1,
-    GRUB_NET_CARD_NO_MANUAL_INTERFACES = 2
+    GRUB_NET_CARD_NO_MANUAL_INTERFACES = 2,
+    GRUB_NET_CARD_NO_CLOSE_ON_FINI_HW = 4
   } grub_net_card_flags_t;
 
 struct grub_net_card;
-- 
2.35.1


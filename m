Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBA54376F
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jun 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiFHPc2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jun 2022 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiFHPc1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jun 2022 11:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C43E0F3
        for <linux-efi@vger.kernel.org>; Wed,  8 Jun 2022 08:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16BEA6150F
        for <linux-efi@vger.kernel.org>; Wed,  8 Jun 2022 15:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CAFC34116;
        Wed,  8 Jun 2022 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654702341;
        bh=C3ueUCzlHUTWj8mWOVipy4/erVn4YI/Pup+HBZUB6wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=o845C7TyV9IUBAupYQBsLApIVwd0hz0xGWN2h9FUMC4uzp46w+Jb0TZU27SZHxHDq
         /z0k/f13WO46G1Z9CQrydX2ay2QxQ49xLzGcnDQ42SLy81ztp4sz06Oggn5lLcEzKK
         0smRxEDnJY1UoDb7waTobUb+cv6M+9CMHTW/fFvT/J3tSMc+i1NB1XKLXdjNdhCsOM
         8+W4hp6hjs5qxkgRdIPYRNYM82gv2Q6iy3p3EIQlSs+OD0e/UoLChaiBjA5jhiOG7+
         BHPPzGHZBhXnGbzWv71M6n7dbN4klSKjdHEWSNwJPo++1Z07keQDrZukBJsYg4QwN9
         AYZ4a5qABuGpQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Jason@zx2c4.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: random: wait for CRNG to become ready before refreshing the seed
Date:   Wed,  8 Jun 2022 17:32:15 +0200
Message-Id: <20220608153216.1480073-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; h=from:subject; bh=C3ueUCzlHUTWj8mWOVipy4/erVn4YI/Pup+HBZUB6wQ=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBioMD/lZ42fSBt9AwnuQUtm/FIkHkejm30QNjzdbRk B6XKja2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqDA/wAKCRDDTyI5ktmPJLhxC/ 4soXHQG9IVx5cTaqQ7jqs3C3ba2vZ64GCilRgJ71h1Q1MAS9ZmtApw40o9MwgaLZrXbydgAAAjDWb4 ZQIhApBidZxOE4RlxbORFXnLGVI0ETHKNHW0XAnWBQpbUKqYeOgG8kMpyq5tbfef3N74lxEJimxuxl 91GnDZX3YMMwYMWNCPxJVlD7TEsZYtdo7VTHwAoehRSj8lTQKaNno61oW5PFcxjNQJMclUWX8ZVtjD we93sNjsyAmPaNbKXp8T3/u7zWKYyt9PA/OUr2RBukF7E/22Cuj3KSmeqsgaJaZZ3oaYsycYZrqISv +wly60jm+u7l0EVE9QVXz8Z/tjuZEgMa1NaslrpoXGDBLKfgw9zb90r4ODi0Cc8P0ssB96u595871h 4OyaHeGKdGXzzPDso442QtKoAUTeEHB/fEMh0bBKLKQK+GVMe55lCHtmz5KeU8DHaK+POaq8CwWvca Alku9OuJMRsRRU/m+c4hmWRoM3GIYv3kGbN6fhi18zfcs=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stub executes only once after boot, and kexec'd kernels reuse
the firmware context created on the first boot. This is intentional: we
preserve as much of the original firmware provided context as we can,
and pass it on unmodified, making kexec mostly idempotent.

However, there is one piece of firmware context that we should not
reuse, which is the EFI random seed, especially in cases where the
kexec'ed kernel trusts the bootloader, and we declare the CRNG ready as
soon as the firmware seed is mixed in. So in kexec capable kernels, we
refresh the EFI random seed before passing it on.

Currently, we refresh the seed without taking into account whether or
not the RNG subsystem is fully initialized, which means we may end up
passing on a seed that is weaker than desired. To avoid this, switch to
get_random_bytes_wait(), which will wait for the CRNG init to complete.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 860534bcfdac..7da49c783c01 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1035,7 +1035,7 @@ static int update_efi_random_seed(struct notifier_block *nb,
 				MEMREMAP_WB);
 		if (seed != NULL) {
 			seed->size = size;
-			get_random_bytes(seed->bits, seed->size);
+			get_random_bytes_wait(seed->bits, seed->size);
 			memunmap(seed);
 		} else {
 			pr_err("Could not map UEFI random seed!\n");
-- 
2.30.2


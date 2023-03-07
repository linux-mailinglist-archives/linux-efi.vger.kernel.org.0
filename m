Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013A6AFA32
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCGXVw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCGXVt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 18:21:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C1A17DC
        for <linux-efi@vger.kernel.org>; Tue,  7 Mar 2023 15:21:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDD94B81ADA
        for <linux-efi@vger.kernel.org>; Tue,  7 Mar 2023 23:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F6AC433EF;
        Tue,  7 Mar 2023 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678231301;
        bh=mBqDvTFmUeiIpDBghVPDmYbcyFxUDfJOnz94UYoy/pc=;
        h=From:To:Cc:Subject:Date:From;
        b=Q04xB2MOvtt/hMxn7EraHiJXwsSbcJ07pLsAtTBUliTe9b4hImi/lCb/x0taM/8Tp
         LG7SAAurRU+v2wNK6PRINxNGB2Nj7gxMWrvZdE9n5vCiK38HfUsUfPlB82R6+O4/xw
         H5iCp1S5DShfpc7TIbamexIT+wk73vbmu9RpFRTutUcLQBJs+Rt6NlA6QhR7fagWws
         aLZnwAAMTSajGWhmZwzl1SbolHRPv4EwmP7z/a8OeiURW4toseLbdO3eJQo/YD2/7B
         vUC6kOewahXg102yMHEIaQJOW7dFF7J2VK4aM89rG7xd3ouHfPgxUyo07ir/8unN4E
         KQ+A5zIqn5qSQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/libstub: randomalloc: Return EFI_OUT_OF_RESOURCES on failure
Date:   Wed,  8 Mar 2023 00:21:34 +0100
Message-Id: <20230307232134.2580510-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=ardb@kernel.org; h=from:subject; bh=mBqDvTFmUeiIpDBghVPDmYbcyFxUDfJOnz94UYoy/pc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYX92D/zFTMTph5v6PoQP3XB5r218+eIu8769Dam/bhYw w+uj/zqHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiEpMZ/gqftItNXrdMVlQh YZHpz76Z76UrtmzP8vOPnbOsct6X98cYfjF/k/1z3Im/X5TbaHZic+6GXtkTRpMf1M5axupjNoG ljRkA
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

The logic in efi_random_alloc() will iterate over the memory map twice,
once to count the number of candidate slots, and another time to locate
the chosen slot after randomization.

If there is insufficient memory to do the allocation, the second loop
will run to completion without actually having located a slot, but we
currently return EFI_SUCCESS in this case, as we fail to initialize
status to the appropriate error value of EFI_OUT_OF_RESOURCES.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 1692d19ae80f0065..32c7a54923b4c127 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -101,6 +101,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 	 * to calculate the randomly chosen address, and allocate it directly
 	 * using EFI_ALLOCATE_ADDRESS.
 	 */
+	status = EFI_OUT_OF_RESOURCES;
 	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		efi_physical_addr_t target;
-- 
2.39.2


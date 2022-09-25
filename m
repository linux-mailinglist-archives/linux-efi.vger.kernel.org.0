Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446095E9458
	for <lists+linux-efi@lfdr.de>; Sun, 25 Sep 2022 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiIYQWo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Sep 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIYQWn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Sep 2022 12:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835F13CE8
        for <linux-efi@vger.kernel.org>; Sun, 25 Sep 2022 09:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7388C61550
        for <linux-efi@vger.kernel.org>; Sun, 25 Sep 2022 16:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0A2C433C1;
        Sun, 25 Sep 2022 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664122961;
        bh=cGFfe/duOosABoyGaZvcekgI9oQ8/2PYEABaS76CZmI=;
        h=From:To:Cc:Subject:Date:From;
        b=G+HFoGnpBkaIuXha3I0dSyf+Bz6eqbHR02txcY9y4azp2UXf3P2PZwfNKrK4y2xVN
         ga/2kS82jssfahrmVaB3wjrgwHp8Pfn+u9g3L8kTPNkT0XEZVhkz0jOT+aHhAwOgri
         xZUHx97dA9xfzKSz6PION82yvF/Knf+Q7nOsC71FjDimZaJVyqIrh0Ky7uQBdUgswZ
         Vkd+IA6D+9+s9mGiYsqzgO5Dg9ee2ayYlAPRQ98dULBeSbfUlyogLNeOLFd+a/um26
         lL5N+rrZYufl3JxVINBsJo2xFzI1PDBghlwegvweYsJD2uv4cjhDSovT1qEihfz4x5
         SjrRSuO7A40uw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: libstub: reinstate efi_get_virtmap() call even for efi_novamap
Date:   Sun, 25 Sep 2022 18:22:23 +0200
Message-Id: <20220925162223.2067277-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=ardb@kernel.org; h=from:subject; bh=cGFfe/duOosABoyGaZvcekgI9oQ8/2PYEABaS76CZmI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjMIA+YEmB0Fr2Q9kAHE2P3tJuiPFw51SjUYTcJxLy drgM4oWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYzCAPgAKCRDDTyI5ktmPJBRbC/ 9vlT2pWZ/Jjt5AgjG0sRTSLoASXGeNz3t/0VdBdPPCycv9iY7PP7mgArZBvBy/jM67+LOOBGDfCSZz s02JDyvQ5AcdrCHLeZn6yxMHCWYmzbFi59mF+AInPtOJHSZaDgpv5KElCYAAWobgdHryoiNw+awQBr SJHf9nM2etZALUy9qHLXekxLs9hCp37/dPosAmComsE2cJCNK4k2r7a8c/kbWt3FA0tywIENbQ67gw XGcCcobLZNdNTQakn58c37WruVTLY4C8zXirbtazyMSeRzpZGBrWr3irqJb6Kw0mt2gI9hw5HEz9mm 8KhHP9MnGG/RRYpkdfaYk3aLG94zBoA0BwqIH38cvxKjIG7P+JNNRsz38VvoMnjWfrCrfBVYJiBYhz wfLMheVAHUfmo6gzPw9BK6/d3wJtTn2D0eKRWxJyQbu1e+QiWVtcZ/32ecBftb2O3SIEetPzwPaw6r dqNnnEisAO2+p5K+BYayKPpmd1kiQpFY2UIDJVOc+ivqk=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Omitting the call to efi_get_virtmap() results in a memory map with
missing virtual addresses for the runtime regions, and this results in
the core EFI kernel code deciding that runtime regions cannot be mapped.
So add back the call to efi_get_virtmap().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/fdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index dbea887b9956..82b8c286ddfe 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -199,9 +199,8 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	 * populate @runtime_map with copies of just the EFI_MEMORY_RUNTIME
 	 * entries so that we can pass it straight to SetVirtualAddressMap()
 	 */
-	if (!efi_novamap)
-		efi_get_virtmap(map->map, map->map_size, map->desc_size,
-				p->runtime_map, &p->runtime_entry_count);
+	efi_get_virtmap(map->map, map->map_size, map->desc_size,
+			p->runtime_map, &p->runtime_entry_count);
 
 	return update_fdt_memmap(p->new_fdt_addr, map);
 }
-- 
2.35.1


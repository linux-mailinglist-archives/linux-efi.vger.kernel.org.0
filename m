Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7166E474
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjAQRIU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 12:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjAQRIR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 12:08:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4A442CB
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 09:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FFC4B8164B
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 17:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7778C433EF;
        Tue, 17 Jan 2023 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673975293;
        bh=Cu3jnZnUeNOJXOL7G5TAH6yVLCdVC15To3bKdBMoMxc=;
        h=From:To:Cc:Subject:Date:From;
        b=D742v4aporToiIs2GS5hYMKZdOL73xiyQWyy8UWogUVL3UmPlpDwGNOXCTOnr8cvb
         T/imcc1oO8CG6UGMT2XTgks6ejqAjeFSm0rRkFEPa87vbsdgScevAh4Zlfu0+Tl1/p
         ZpCDNJAPYhONeP6FPB8qnYYXC7ef4xoOiV8ufhuJIYgquZfVagU68l7dN1IlGXWYFU
         Gx413IiFeTYxbFBLksHAqJVyuWrI40tbl/AIhazd4LjuLIIR4F78mqGie5+Vlovjq9
         eEEouNlzwGAM2GD5Wxu2ZZ7mOugdRH7dCDiWMyv1wtPR+IXbimUGwrleXrMNZjIxyB
         xB/rgH+YrzeUg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] efi: Remove Matthew Garrett as efivarfs maintainer
Date:   Tue, 17 Jan 2023 18:07:42 +0100
Message-Id: <20230117170742.1461185-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=ardb@kernel.org; h=from:subject; bh=Cu3jnZnUeNOJXOL7G5TAH6yVLCdVC15To3bKdBMoMxc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjxtXdLDoMe/LKNENUMtbrNHotEmFGH93x5TP/rh62 LSd4wTCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY8bV3QAKCRDDTyI5ktmPJNI6C/ 4pAfqcxZaRoCTKohpLyMT2dMKbHrbPcDyUpxGrUVDJIbgFNoI4Dgdb+hK2NXb7Q3y6nDohI2Ifkl5u X/PzWfKwHpHFHVt74+jLmH5N4TvAi5vle0zFwR66bbnswfi8Ewy2/vDPlCYPswwGFSHzA9sS5tkZFF nOpuh74n1ydJtM5xbqvviMbNmBS3R23oMei53/Y9UgDj5AMCZK71gSeX28PBVteu/mi+k2N+8y0ikW 0x3z3V+Un7eK+dA1lphTGgUoPshhuf3hcpRBeaF/+/r1zyZvex6qPavDusmi48wLYn8k/JyMotAdtO aP941njtIzGaYM83ACmhtWYC7dPPtte4OVr8z6apEJSYLUM4VXWoC6qLEq6Bv35st9dzWtWAd63Oap 9v2kug6utrqs+l+46EBpSoHMaAes4sXIynGxaVMbODoIzSOsf03AI/xowZ6sWp+AbzHrgsUHcj49e3 bd4x9peBlhlwKTj3ThtuJ6BRNhh5xJcYhM950C1z9z4HI=
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

Matthew Garrett is still listed as a efivarfs co-maintainer, but the
email address bounces, and Matt is no longer involved in maintaining
this code.

So let's remove Matt as a efivarfs co-maintainer from MAINTAINERS.
Thanks for all the hard work!

Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427ab3b..08f75b87f03c29d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7616,7 +7616,6 @@ S:	Maintained
 F:	drivers/firmware/efi/test/
 
 EFI VARIABLE FILESYSTEM
-M:	Matthew Garrett <matthew.garrett@nebula.com>
 M:	Jeremy Kerr <jk@ozlabs.org>
 M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-efi@vger.kernel.org
-- 
2.39.0


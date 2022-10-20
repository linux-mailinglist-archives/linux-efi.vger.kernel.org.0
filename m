Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68706605B23
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJTJac (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJTJaD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 05:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9787E015
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 02:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C4F61A78
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 09:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48DCC433C1;
        Thu, 20 Oct 2022 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666258201;
        bh=3W9QPW5KF1fQepWi9EgSwfrqMzwaLloYaM+QWD7N5Cs=;
        h=From:To:Cc:Subject:Date:From;
        b=rzjjfcApVSKxXNXwQNoCnRplBWkv4heDR/lg+2bz9/xHjulp2rf2GmDloNNaCpjzC
         bfo3XOsCKN7dOapAcxnK45EgaWOFn+1UGQPm+1bVSQZ3ODg4mE3yl+BdgBRvTyqtnA
         pNprS0PNnfOpb9bV5Gc59/i7cjMPBa04Tz479bs5o3S/SUj47m0JZrx3YeDcgOXkSL
         P2KJ3RCD04kqazaYplrUsq68jkbcQxsPdRGYhdbTWSEj+du7l91lemguIwyn+Dy/KK
         vknsL5YeR5/dLfvgXgQPnS2JXdrfxoSZvFMoSADwlD/ERWD4xoCd0p3HmVV6fehTut
         mXt1njN13qP6A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: libstub: Fix incorrect payload size in zboot header
Date:   Thu, 20 Oct 2022 11:29:55 +0200
Message-Id: <20221020092955.1919627-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=ardb@kernel.org; h=from:subject; bh=3W9QPW5KF1fQepWi9EgSwfrqMzwaLloYaM+QWD7N5Cs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjURUSPNEB0DXFPpeY1n2zpqHnvxLx54L1KUZU5NiV 9+kX2UWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1EVEgAKCRDDTyI5ktmPJKGnC/ 4qxoI7yazlNr3knGK6vc2v59yGphQ1xC60DbYUjrxVei+iesgIg9EtFEuM7BStgCLuMpW47wc4DIjc u6v9ri8zozaiHg4qT9Tz0VqAobe3Mt52Ik0GnfyYuzKop5ullYdquFZ5Culz4nknmlt9A+d9nzaU7H YEs5gPKezA0fsX+oQA9G2DXPWCPq+99mL3/LVlzkwzqPxBPCJwospUt1AbdvKKCUnmS7wYw4yRrQCF JuLA9Rd/+gTIMC8Wb1w10WRvPtwvJQXepvegrbSzjnyjwZgtdfQAZjAc2gT5Z4/+YBsAjZN8gXu4cp EN+VYuzyuFHaMQf/lcPXPtZul4tJxmCXc9QX9iciM2It7qdmORSgDXGG/BrZantqUFdOgqDk7fYD9u 1/8TbqGtjCYkyAbCQcObBxFe+CBVzAEWhqRMWdtHmbr5hQdt/N85uFX1wDysEs/kfH+a8SFPuMHrUe FVnvANa4kH+pymeWs72dUbO6OdwMEOf4mtPYH4sTD3/A0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The linker script symbol definition that captures the size of the
compressed payload inside the zboot decompressor (which is exposed via
the image header) refers to '.' for the end of the region, which does
not give the correct result as the expression is not placed at the end
of the payload. So use the symbol name explicitly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/zboot.lds | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
index 87a62765bafd..93d33f68333b 100644
--- a/drivers/firmware/efi/libstub/zboot.lds
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -38,7 +38,8 @@ SECTIONS
 	}
 }
 
-PROVIDE(__efistub__gzdata_size = ABSOLUTE(. - __efistub__gzdata_start));
+PROVIDE(__efistub__gzdata_size =
+		ABSOLUTE(__efistub__gzdata_end - __efistub__gzdata_start));
 
 PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
 PROVIDE(__data_size = ABSOLUTE(_end - _etext));
-- 
2.35.1


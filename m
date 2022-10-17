Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E051601493
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJQRSC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiJQRSA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EFF71BF2
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7B1B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB724C43143;
        Mon, 17 Oct 2022 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027074;
        bh=VLKfLDHqsU8OgHWnk+gT6JFgwMHcgD+0QLFcrqgQ9yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVXiJ9F4ns/r1ohmq7iwGAOqMaYC915Ktw0/CjtcrmScZ0OzYnioU1qhXc3aQOYIH
         IpYfRFf6yxmLjyJQDnOtoYlDbuhSYyYtQx+UE9nNiDxKvcVgsSWDIaGO2Z2CryuXa7
         zAYaXJTBcUVgU8Nd4qdYDcb6YFq8qHRSmgTlv4tW90xC85KQeLppM0oREp3zbJZDHD
         rV+cTlBUj4fggFWLHyuoqV/NUXqNGljHdQWe9Gf5cVjaeP1DNlFuOLT3ASoKBvSLKX
         FKojeCMOAMLcUYdWVe3fovNzMd25Jc9YvcVCpma2r2ODJWTumRbx1baBh2GZ1C7lkb
         Ldj6so0TFiJjw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 11/21] efi: loongarch: Drop exports of unused string routines
Date:   Mon, 17 Oct 2022 19:16:50 +0200
Message-Id: <20221017171700.3736890-12-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=ardb@kernel.org; h=from:subject; bh=VLKfLDHqsU8OgHWnk+gT6JFgwMHcgD+0QLFcrqgQ9yk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY36rBDxcDnTw22boWGyq+L3AoFUhoPET77vsPdy DLiBDFKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N+gAKCRDDTyI5ktmPJBH0C/ 9NH711cylI2tliDUK/9xYzxUtEBCcu5byVBRXI3CurlOAFJNIRngMvrE9piJS4m1eQ43gdN4YtIN87 qjs9PLHmePbLUKxJIWi5pZAoBG/caLqcO6v1IJLf9jvX2sOhtG65TP8P+VBynZyfDpU+ZMCU9Rujlh Bbf+eseiYqF1tavEx94OqI8lysDGqiaHk1mhdkvXXvBHbadjvqelWlOVHb49ZxzDVgFgc55LOAcDAe BrLx+DPZO8/DG+UX8d7509X62vQ/FKMOPQxWL1BCUmF8dKvstHEWUTsAYV1tsC/Zy9+68FWIHRzdo8 hXktyO7uGJgQx82vTinKVTcJsQ9uJe6VURHVyrJsSjiti3gOk725EtQdc8H1u9JzQMSOijGPCX2WWP Vd3D4h4qf66D3h7QvZGRwnUYCMdehZfZBgkvc2yFQQVgEBuB5jjKgI460yODCjEmg5t6HWLNjQoxZ3 Kyta/2Mdrsp0NHRmZthISTa7Ez05G0gq+rQm8RiBn8xss=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop the __efistub_ prefixed exports of various routines that the EFI
stub on LoongArch does not even use.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/kernel/image-vars.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index 28bc632ec296..e561989d02de 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -7,12 +7,7 @@
 
 #ifdef CONFIG_EFI_STUB
 
-__efistub_memchr		= memchr;
-__efistub_strcat		= strcat;
 __efistub_strcmp		= strcmp;
-__efistub_strncat		= strncat;
-__efistub_strnstr		= strnstr;
-__efistub_strrchr		= strrchr;
 __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
 __efistub_kernel_fsize		= kernel_fsize;
-- 
2.35.1


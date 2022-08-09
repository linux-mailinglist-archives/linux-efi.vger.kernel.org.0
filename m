Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B858D530
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiHIILE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiHIILD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820FB7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98A7612E4
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414FAC43141;
        Tue,  9 Aug 2022 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032662;
        bh=0wxGhJZU/zdWw8HRNTrsKFaHxjI9/9W09E4vTFt5wZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLmJQIjlAU4BGGQPvb3EUi7CBXdI2iILDNp/6i9x5BrSVVk3cHZYoXSqGEsQTghxN
         U+lbpoJBFJPwzM1zj6sojAJ0rUPxzyCgCaHNFU2b892yJxC2gUubFC5P5U+rGklW4I
         Ra7KA0fL5LwYlponAsO9dufsvVDcC8CvCF9ZBtFgay70qc4hXgre7gZz8oBZTKExB1
         Sbqja4naiP0JmaRS6yxMB2fSqwQhcdMU5ZzpwvpM75mwlmGWQCULkwsFHOxkT5LnQJ
         31HAh1+TKOzMocp4IFj+C0w1SKJD4xFcAjX7zWwJtUCjwBxJrtwTbjjD/aXgeLGTPA
         ZgQeKmPBJaNlg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v2 5/6] arm64: efi: enable generic EFI compressed boot
Date:   Tue,  9 Aug 2022 10:09:43 +0200
Message-Id: <20220809080944.1119654-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=ardb@kernel.org; h=from:subject; bh=0wxGhJZU/zdWw8HRNTrsKFaHxjI9/9W09E4vTFt5wZs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hZE/pHyMam6oID6jHufFqjjsmWunFFPL94BweIA 9ln0bC+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWRAAKCRDDTyI5ktmPJOyNC/ 9PD51wW5EkYDZ55n7btMX7VIe2eu42yvHbXO+QUvmE0obi5LTdu4ZIbX6FHg4Ts7H+MOsWRSsyNNB2 eY8vENrnJnkJ3UC8Prb5OeJUKroOkrSCFoLkOBzQ8LEPSNR0yHC7DS0av770nVYVPvvozmWtcQtT4p y6eG4OMjVNuhwN14J0eAaD+GJ0P58SFlUDa/54lnEVhJGWiT8f9tBYJr5eh6sjoN+sa1xvNt5bCzNm YXMQgfpxnbKkWCj2zQJrxChGZirD7kO5nift7S8+KRYc5A4Jkx9tIvAxdpfDLTsHY+KmP1uFCUuJCS rPoqxpZvwF/1JpjHmzvFR2u0ZqVeqAokVz+CBxmN83dAmHST2vyevjcdlFAnAxvaNP5R61zknKxhLB 3j1KZrKZWq8VcTiQWDg7Z4D3ujGsp3JoGX8wotx+0+/OEsgd415yqYTjPTLlv0t5moJe0afylkPfSE d00j56B+kkWwr8S3Li8Q/4EQBDLvPChhHaW+HH7inFffw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Wire up the generic EFI zboot support for arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Makefile      |  5 +++++
 arch/arm64/boot/Makefile | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6d9d4a58b898..ad4f849b91e8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -162,6 +162,11 @@ Image: vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+ifneq ($(CONFIG_EFI_ZBOOT),)
+zImage.efi: Image
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+endif
+
 install: KBUILD_IMAGE := $(boot)/Image
 install zinstall:
 	$(call cmd,install)
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index a0e3dedd2883..08fcd39ae808 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -38,3 +38,15 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
+
+ZBOOT_PAYLOAD		:= $(obj)/Image
+ZBOOT_BFD_TARGET	:= elf64-littleaarch64
+ZBOOT_LD_FLAGS		:= --defsym=__efistub_strnlen=__pi_strnlen \
+			   --defsym=__efistub_memmove=__pi_memmove \
+			   --defsym=__efistub_memcpy=__pi_memcpy \
+			   --defsym=__efistub_memset=__pi_memset
+
+ZBOOT_EXTRA_OBJS	:= memcpy.o memset.o strnlen.o
+ZBOOT_EXTRA_DEPS	:= $(addprefix $(objtree)/arch/arm64/lib/,$(ZBOOT_EXTRA_OBJS))
+
+include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
-- 
2.35.1


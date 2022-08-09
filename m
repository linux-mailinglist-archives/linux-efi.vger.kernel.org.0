Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8058D52C
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiHIIKv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIKu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA6B7D1
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39211612EC
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A61C43470;
        Tue,  9 Aug 2022 08:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660032648;
        bh=oPI34RZJsbqu67SVjCqjTm3yri4pEDmQ8oGlXGswDt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2BgEpnEHRCBU6deIy1tTjY3gDOtzcuHGehaArf0vSVWkk0KVOFB8zVsdHz3HHwdp
         cCtNY8XfQ+ZuCydfs/xq9meoa06ODEbJHb0W8cqf40Go2Ky0W3aIe5Ir76DpQDOqqw
         VImjEXS7dRLl5ptHZSRmEOvGorJ8e3HQo8nqK8KkdB/LQ+YMLieQ+YJcZyd+KbV5O3
         eH33Ny+Ua7jdM41RgzNNhv8S0z3h22eKVdpfsnAeNV6Din2RISEfBEhet6cuNj883V
         HguWcbcZ01QJaZndHAm3I7JL6HOnEwcSYRobj4Mz6HOZMyAxy/8T+BC0jyjkQn1CpZ
         LwdQ8nSDltqZQ==
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
Subject: [PATCH v2 1/6] efi: stub: add some missing boot service prototypes
Date:   Tue,  9 Aug 2022 10:09:39 +0200
Message-Id: <20220809080944.1119654-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
References: <20220809080944.1119654-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=ardb@kernel.org; h=from:subject; bh=oPI34RZJsbqu67SVjCqjTm3yri4pEDmQ8oGlXGswDt4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi8hY7ATzyeS13+RsJEB0BDPtDvOIVLLRn/Pnv5naG 1XmCPxCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvIWOwAKCRDDTyI5ktmPJLgFDA CbwpnyvgWvP2EVFScqm776+NayZniECezqggB0s1jyWwAhQDx9rODPCeYuJKSXizzQxHM/dVB80/24 DJsjWABXdwy1Kbj5qE7GYpnOT6Xiwuysr8bJolDEuSffE2lOZGFTajxJqjeWBEhieUH9vZQqO2Kta7 YaVtpzwJ70OKdSZ3hFubVVkRWSv1bUN8g8RyZFv4+uAHkYKMU7mx6r35lEYkSbRA0KmULbYSVbHHmC blddw2R6ufT00XGwNbcDQCNwIi5sMWGEKTBn/dOVDDIak029mDtKSUOYy5Ha5IW/FyNeLbsTUVkucn AVpMRdrgUBDM24gUKBskm42zKBHX20HZBI4UNRvXX1bhGl7NM7sJbKvj9XhXH99pJSpdClsGo1VBUP KFalSIwFRn+LOOWtOaEPFCqDz5OOxcPC3UExQPlGb9HDcRRV6xadKVWa87bhU/dPqUX0LbbJosYkyI rIL+yZAQBfmcGuHFnaiwURxpGrPkyIZV+4QbUfFgUogz0=
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

Define the correct prototypes for the load_image/start_image and
install_multiple_protocol_interfaces boot service pointers so we can
call them from the EFI zboot code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index ab9e990447d3..33215d7bd276 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -254,8 +254,12 @@ union efi_boot_services {
 							    efi_handle_t *);
 		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
 								     void *);
-		void *load_image;
-		void *start_image;
+		efi_status_t (__efiapi *load_image)(bool, efi_handle_t,
+						    efi_device_path_protocol_t *,
+						    void *, unsigned long,
+						    efi_handle_t *);
+		efi_status_t (__efiapi *start_image)(efi_handle_t, unsigned long *,
+						     efi_char16_t **);
 		efi_status_t __noreturn (__efiapi *exit)(efi_handle_t,
 							 efi_status_t,
 							 unsigned long,
@@ -277,8 +281,8 @@ union efi_boot_services {
 		void *locate_handle_buffer;
 		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
 							 void **);
-		void *install_multiple_protocol_interfaces;
-		void *uninstall_multiple_protocol_interfaces;
+		efi_status_t (__efiapi *install_multiple_protocol_interfaces)(efi_handle_t *, ...);
+		efi_status_t (__efiapi *uninstall_multiple_protocol_interfaces)(efi_handle_t, ...);
 		void *calculate_crc32;
 		void *copy_mem;
 		void *set_mem;
-- 
2.35.1


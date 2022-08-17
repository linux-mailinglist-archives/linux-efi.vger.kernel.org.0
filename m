Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB6596D40
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiHQLEN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiHQLEI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 07:04:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCE543F4
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 04:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6742CE1B46
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 11:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B975C433D7;
        Wed, 17 Aug 2022 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660734241;
        bh=PVzMuYMI51jPWnC5qPoxg799IuTEnko1dKe+EJ+Curs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=syAaBCmrl327HE06N9F+iRwUCjV+ulvgpIqGKRIlMRlnMqxHOeFqF7YS2E8EJon3d
         zhu2YGtK95B0QoKV4YghCuus7TRMNl2yqf6leFk8MF2zvJZjKwwrrPzY2/AGN3QWAY
         FvfYqRE5/tz7OmrVJLjPNGtf6n/RKpL9PM+qavE90sDqIXJhvfs8b0NWqscVpAf7aw
         hJmobmQvpM1wn/yqvNHQuYo3+cY2VDQKUjG6ns3oiNxZ3TEreVohEpwUvg8S//hX8p
         ZqnylMaOHgJsLVjr4NU05k9IRd73jlHyZ0kpGTVCrQMLoThAKkGkAa2GG+vGQ8H7XO
         dFaX5h9AJ3kQA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 2/6] efi/libstub: add some missing boot service prototypes
Date:   Wed, 17 Aug 2022 13:03:41 +0200
Message-Id: <20220817110345.1771267-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817110345.1771267-1-ardb@kernel.org>
References: <20220817110345.1771267-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=ardb@kernel.org; h=from:subject; bh=PVzMuYMI51jPWnC5qPoxg799IuTEnko1dKe+EJ+Curs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/MsGGgLjshKD1C5PpWI3wmvxJsJfUnGCpsiuzzds WA/wrAOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvzLBgAKCRDDTyI5ktmPJAhtC/ 9dcpcTTXz4brbpsYjihM/bLDysewlJU07M9ezz6SYjuRoC4dARvLgLD44EjoTdElzFw0Xa2dHHHlK4 k/GO4QqUv1UZfKKRyaIeoY1qmf9FpSWWAST2b94iiGnx0TuVVilUYbWr9JwZLMwEqP3f+hV51CjexI qGj27Ro5xusQqll5P6rsJqF4UCNGJ4n2WbEPbPFIoRkmDZb1g8DJnU1DbNZXN+Ex3KsK7j0i0EmTHw fSsGhHhD4rhc9rbqGzN6F0dT3UEItPEPHhX+CFWaFqLv633t/r5PwK+tZ+aP4WtCt0tpMTsU0Jh1vo 6Giz0Nl6h5Hdd28wfQLLwsoeSXurm2doy+tXi7vfq3zRLsiexKp62DezLIsZl8qvGCiqjFsErlyYGM op4nzzJ1dBd7zqVbgAZZghB2g3BiJiwYfevytdMch3ws89xyql8h3KmZmFDulro+giaFpTrAO+IFq4 GoOa7RlO0CeIhST8hWEVNSc/Bo92tnogpy8fAcBg1Od5A=
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

Define the correct prototypes for the load_image/start_image boot
service pointers so we can call them from the EFI zboot code.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a3377f0b1251..fbf2c83d6bf8 100644
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
-- 
2.35.1


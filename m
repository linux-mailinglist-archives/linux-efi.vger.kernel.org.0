Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D716C4D96
	for <lists+linux-efi@lfdr.de>; Wed, 22 Mar 2023 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCVO0m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Mar 2023 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCVO0l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Mar 2023 10:26:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EA58B70
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 07:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C99BB81D09
        for <linux-efi@vger.kernel.org>; Wed, 22 Mar 2023 14:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16655C4339B;
        Wed, 22 Mar 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495194;
        bh=6MMyawK3cuIV7u8JeTYNZqikb/f8vmsPIr1K+3RBRFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z72X9xlk4EjMWDlKIxQ4vWUXJ/1DffqbFdJnm1cblCGuojcGuhDi2oms3g1ltElJC
         kHqAO4A2hPndgLVgP6bjoqnEiFvzShJFkEpFr3ZYZ+vEug8WeC7lkeXGshKuYgATTh
         5/Aw4Fj2Y1fDH8czqFFNu7+VV9IieJMr5nMyX7UKHsCJ42IP+NHb1XJm7jAIFe5do5
         mazkflleRh6pvL597lL7A/ew843BinCNTQkBuHiqQ59sfMGgF2fXrgH3M5RffltR1Y
         4wI8zMig7xBWF6TX2XgNo43ANUSQBOBJmtOPbE1oqtSujDVix+/q0HxGXPJxV4filL
         N4r0grBNklIRg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 3/3] efi/libstub: smbios: Drop unused 'recsize' parameter
Date:   Wed, 22 Mar 2023 15:26:21 +0100
Message-Id: <20230322142621.3685058-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322142621.3685058-1-ardb@kernel.org>
References: <20230322142621.3685058-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=ardb@kernel.org; h=from:subject; bh=6MMyawK3cuIV7u8JeTYNZqikb/f8vmsPIr1K+3RBRFg=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUVagNdnz6RVvJeW5QU9cU8LOp/CcntS4a1NK/x27O58m B98U/d7RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIPEGG/xmXE/YsMGw2f7D4 1w/9lifKhSvc9tvNF4xZzbg8y3j/7gsM/9MCOvQmPpi97z3bC93aoOYU7U9Lixvct4o/LRF+vnh 5Ph8A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We no longer use the recsize argument for locating the string table in
an SMBIOS record, so we can drop it from the internal API.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 5 ++---
 drivers/firmware/efi/libstub/smbios.c  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 330565b9263a6b01..bd9c38a93bbce09c 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1122,14 +1122,13 @@ struct efi_smbios_type4_record {
 };
 
 #define efi_get_smbios_string(__record, __type, __name) ({		\
-	int size = sizeof(struct efi_smbios_type ## __type ## _record);	\
 	int off = offsetof(struct efi_smbios_type ## __type ## _record,	\
 			   __name);					\
-	__efi_get_smbios_string((__record), __type, off, size);		\
+	__efi_get_smbios_string((__record), __type, off);		\
 })
 
 const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
-				  u8 type, int offset, int recsize);
+				  u8 type, int offset);
 
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index f9c159c28f4613f8..c217de2cc8d56dc2 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -38,7 +38,7 @@ const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 }
 
 const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
-				  u8 type, int offset, int recsize)
+				  u8 type, int offset)
 {
 	const u8 *strtable;
 
-- 
2.39.2


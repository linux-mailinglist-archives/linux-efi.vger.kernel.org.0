Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A544256E
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 03:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKBCGj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 22:06:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13997 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBCGi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Nov 2021 22:06:38 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HjtSR4p5dzZch4;
        Tue,  2 Nov 2021 10:01:59 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 10:04:02 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <ardb@kernel.org>, <cuigaosheng1@huawei.com>
CC:     <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next,v2] efi/libstub: arm32: Use "align" for the size alignment
Date:   Tue, 2 Nov 2021 10:05:45 +0800
Message-ID: <20211102020545.145840-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We are doing page-based allocations, and both the address
and size must meet alignment constraints, so using "align"
for the size alignment is a better choice.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 drivers/firmware/efi/libstub/relocate.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 724155b9e10d..7b7159bb035d 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -76,7 +76,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
-	size = round_up(size, EFI_ALLOC_ALIGN);
+	size = round_up(size, align);
 
 	/* count the suitable slots in each memory map entry */
 	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 8ee9eb2b9039..d6d27e8c23f8 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -50,7 +50,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
-	size = round_up(size, EFI_ALLOC_ALIGN);
+	size = round_up(size, align);
 	nr_pages = size / EFI_PAGE_SIZE;
 	for (i = 0; i < map_size / desc_size; i++) {
 		efi_memory_desc_t *desc;
-- 
2.30.0


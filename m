Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E772769499
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jul 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGaLUs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jul 2023 07:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGaLUr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 31 Jul 2023 07:20:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CB3E52;
        Mon, 31 Jul 2023 04:20:34 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDwhJ12HqzLnsC;
        Mon, 31 Jul 2023 19:17:52 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:20:32 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <ardb@kernel.org>, <dvhart@infradead.org>, <andy@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] efi: memmap: Remove kernel-doc warnings
Date:   Mon, 31 Jul 2023 19:20:01 +0800
Message-ID: <20230731112001.212982-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove kernel-doc warnings:

arch/x86/platform/efi/memmap.c:94: warning: Function parameter or member
'data' not described in 'efi_memmap_install'
arch/x86/platform/efi/memmap.c:94: warning: Excess function parameter
'ctx' description in 'efi_memmap_install'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 arch/x86/platform/efi/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index c69f8471e6d0..4ef20b49eb5e 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -82,7 +82,7 @@ int __init efi_memmap_alloc(unsigned int num_entries,
 
 /**
  * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
+ * @data: efi memmap installation parameters
  *
  * Unlike efi_memmap_init_*(), this function does not allow the caller
  * to switch from early to late mappings. It simply uses the existing
-- 
2.17.1


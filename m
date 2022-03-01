Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBD4C845A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Mar 2022 07:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiCAGui (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Mar 2022 01:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiCAGuh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Mar 2022 01:50:37 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA21C930
        for <linux-efi@vger.kernel.org>; Mon, 28 Feb 2022 22:49:56 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K777d4gNRz9sSK;
        Tue,  1 Mar 2022 14:46:21 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 14:49:54 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 14:49:53 +0800
Message-ID: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
Date:   Tue, 1 Mar 2022 14:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [Question] Should retain 2M alignment if kernel image is bad aligned
 at entry or BSS overlaps?
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard，Will and all maintainer，

As commit 3a262423755b ("efi/libstub: arm64: Relax 2M alignment again
for relocatable kernels") saids, a relocatable image does not need to
be copied to a 2M aligned offset if it was loaded on a 64k boundary
(for a 4 KB granule kernel) by EFI. But if there is some FIRMWARE BUG,

1) kernel image not aligned on 64k boundary
or
2) Image BSS overlaps adjacent EFI memory region

When kaslr is disabled(eg, EFI_RNG_PROTOCOL unavailable), it will leads
KPTI forced ON after kernel image relocated, message shown below,

   CPU features: kernel page table isolation forced ON by KASLR
   ...
   KASLR disabled due to lack of seed

The KASLR don't enabled actually, and KPTI is forced enabled which could
affect performance.

I found commit 7c116db24d94 ("efi/libstub/arm64: Retain 2MB kernel Image
alignment if !KASLR") in v5.8, should we retain 2M alignment if kernel image
is bad aligned at entry or BSS overlaps?


diff --git a/drivers/firmware/efi/libstub/arm64-stub.c 
b/drivers/firmware/efi/libstub/arm64-stub.c
index 9cc556013d08..47ecd9b80db3 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -87,6 +87,7 @@ efi_status_t handle_kernel_image(unsigned long 
*image_addr,
  {
         efi_status_t status;
         unsigned long kernel_size, kernel_memsize = 0;
+       bool need_2m_aligned = false;
         u32 phys_seed = 0;

         /*
@@ -119,9 +120,11 @@ efi_status_t handle_kernel_image(unsigned long 
*image_addr,
         if (image->image_base != _text)
                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base 
has bogus value\n");

-       if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN))
+       if (!IS_ALIGNED((u64)_text, SEGMENT_ALIGN)) {
+               need_2m_aligned = true;
                 efi_err("FIRMWARE BUG: kernel image not aligned on %dk 
boundary\n",
                         SEGMENT_ALIGN >> 10);
+       }

         kernel_size = _edata - _text;
         kernel_memsize = kernel_size + (_end - _edata);
@@ -142,6 +145,7 @@ efi_status_t handle_kernel_image(unsigned long 
*image_addr,

         if (status != EFI_SUCCESS) {
                 if (!check_image_region((u64)_text, kernel_memsize)) {
+                       need_2m_aligned = true;
                         efi_err("FIRMWARE BUG: Image BSS overlaps 
adjacent EFI memory region\n");
                 } else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
                         /*
@@ -152,7 +156,8 @@ efi_status_t handle_kernel_image(unsigned long 
*image_addr,
                         *reserve_size = 0;
                         return EFI_SUCCESS;
                 }
-
+               if (efi_nokaslr & need_2m_aligned)
+                       min_kimg_align = MIN_KIMG_ALIGN;
                 status = efi_allocate_pages_aligned(*reserve_size, 
reserve_addr,
                                                     ULONG_MAX, 
min_kimg_align);

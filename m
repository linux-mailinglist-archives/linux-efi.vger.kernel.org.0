Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22487BDAD5
	for <lists+linux-efi@lfdr.de>; Wed, 25 Sep 2019 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfIYJUb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Sep 2019 05:20:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbfIYJUW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Sep 2019 05:20:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C68EDA07C1C298F7F10;
        Wed, 25 Sep 2019 17:20:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 17:20:17 +0800
Subject: [PATCH 2/2] x86/efi: Fix memory leak for EFI memmap reservations
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <775bcf46-0f4e-a1a9-5a40-05f833cd7a1a@huawei.com>
Message-ID: <26d637af-480b-e874-ee84-9b2abe43630b@huawei.com>
Date:   Wed, 25 Sep 2019 17:20:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <775bcf46-0f4e-a1a9-5a40-05f833cd7a1a@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are some memory leaks in failure path after efi_memmap_alloc().
add efi_memmap_free() for this situation.

Fixes: 816e76129ed5 ("efi: Allow drivers to reserve boot services forever")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/x86/platform/efi/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd67..a755f35 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -285,6 +285,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)

 	new = early_memremap(new_phys, new_size);
 	if (!new) {
+		efi_memmap_free(new_phys, num_entries);
 		pr_err("Failed to map new boot services memmap\n");
 		return;
 	}
@@ -470,6 +471,7 @@ void __init efi_free_boot_services(void)

 	new = memremap(new_phys, new_size, MEMREMAP_WB);
 	if (!new) {
+		efi_memmap_free(new_phys, num_entries);
 		pr_err("Failed to map new EFI memmap\n");
 		return;
 	}
@@ -493,6 +495,7 @@ void __init efi_free_boot_services(void)
 	memunmap(new);

 	if (efi_memmap_install(new_phys, num_entries)) {
+		efi_memmap_free(new_phys, num_entries);
 		pr_err("Could not install new EFI memmap\n");
 		return;
 	}
-- 
1.8.3.1


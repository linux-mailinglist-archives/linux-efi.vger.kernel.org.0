Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E845CE21
	for <lists+linux-efi@lfdr.de>; Wed, 24 Nov 2021 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhKXUj1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Nov 2021 15:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhKXUj0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Nov 2021 15:39:26 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8931DC06173E
        for <linux-efi@vger.kernel.org>; Wed, 24 Nov 2021 12:36:16 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 70so2400391vkx.7
        for <linux-efi@vger.kernel.org>; Wed, 24 Nov 2021 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jY0dy/d5c8YPxh7NXvxGcRPu0/DQhp2j75dR0lO6H7o=;
        b=YKP1iGwN3dXHjgMjYuAi+DHERVJy5yD4KnnKwrrB8Vw3N9k95iuo+Uf6w1JpvVRCKO
         ypKQBdwzMGajAa/dYvxHesztyscRflbsqWDCEEDVSvuk3jaiGSCyU7Ndc3B9oVGs8KVL
         oJuaCHLwPOAtE4iy7/Rwet/lvfXVqiwfXn84SrBZTMEgDrzrfVjRejCi9zFZAHjBrAv/
         p43qJ+VwLr2gPe5XzhN5cqiqGcvM1QqM5h38aFAyI17GjiItGVs+l4IteLsLN+q6DHWM
         026avAx6elQMgxDoM+7TO2JzlYy567x3+N8gxH0MRR5EFU9UVTgrourfXEYlL7XZxMDA
         ZKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jY0dy/d5c8YPxh7NXvxGcRPu0/DQhp2j75dR0lO6H7o=;
        b=q3w022+F+rFIAQx99MvA92QDXR7aOvbXtj4BjKXADKpjX2FU4gWA+tbmASdIkPNzRb
         U/79uCyJ3l3lSE9lOtIiBun8NlCMcOBs0fkxiau9qzq1b4zGmr8BCZUfZ8SaGDhihvJd
         yWHlGQd+ZwWhQoP4CysK+L4mM3nVCeSzhbv+xDlszA/nPjVWIlHbNuDwKtJemHMTAqiw
         Z9LVPv48Pasu9I8TJ7WHJ2J3PktMwUYANwtsuEG93BWuU9z4ZXOC7F49fRoWdqzVArAH
         toQc8rinrjcMrdCAUvOGRZweYhimFzlsuiU/pUTpZdeSGFUPwILiR9H7JSAnpbZ/7ugd
         +vMw==
X-Gm-Message-State: AOAM533RZIAuxSaTST/DzjSrvtv3a1A6BclLjQnvJ9uoESr9pKPIiiI2
        OaRS36GAkHi4n6jgZG8VGXQSA5MNWuwfgrtUJt4ET1Z2twjmrO0esaS2SbTC+vW3ELb93b+ndE3
        ZOnAQodYDrPSr0xMAWkCBw+lTZ9oLKOhlCP0yP3pAAKm0ehn6ImtrxmCl7RvncPv0JuSyDxhkyp
        ODHnyrQZUduku1+po=
X-Google-Smtp-Source: ABdhPJzR0bwHzxnrsklT2ho3w5z0D589l6rvGmOY2zbPVUFKORG+kRx9hLglmOnTJtr7RU8cnD8Qdg==
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr4918531vke.33.1637786175500;
        Wed, 24 Nov 2021 12:36:15 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id c9sm601971uaf.12.2021.11.24.12.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:36:15 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v2 4/5] x86/efi: Tag e820_entries as crypto capable from EFI memmap
Date:   Wed, 24 Nov 2021 17:34:58 -0300
Message-Id: <20211124203459.4578-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
References: <20211124203459.4578-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a function to iterate over the EFI Memory Map and mark the regions
tagged with EFI_MEMORY_CPU_CRYPTO in the e820_table; and call it from
efi_init if add_efi_memmap is disabled.

Also modify do_add_efi_memmap to mark the regions there.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/platform/efi/efi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..8f52cde61688 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -184,6 +184,8 @@ static void __init do_add_efi_memmap(void)
 		}
 
 		e820__range_add(start, size, e820_type);
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_mark_as_crypto(start, size);
 	}
 	e820__update_table(e820_table);
 }
@@ -441,6 +443,22 @@ static int __init efi_config_init(const efi_config_table_type_t *arch_tables)
 	return ret;
 }
 
+static void __init efi_mark_e820_regions_as_crypto_capable(void)
+{
+	efi_memory_desc_t *md;
+
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_mark_as_crypto(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT);
+	}
+
+	/*
+	 * We added and modified regions so it's good to update the
+	 * table to merge/sort
+	 */
+	e820__update_table(e820_table);
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
@@ -494,6 +512,13 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	/*
+	 * If add_efi_memmap then there is no need to mark the regions
+	 * again
+	 */
+	if (!add_efi_memmap)
+		efi_mark_e820_regions_as_crypto_capable();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.30.2


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA7473BDE
	for <lists+linux-efi@lfdr.de>; Tue, 14 Dec 2021 05:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhLNECX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Dec 2021 23:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhLNECV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Dec 2021 23:02:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866AAC061574;
        Mon, 13 Dec 2021 20:02:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so12628643plf.13;
        Mon, 13 Dec 2021 20:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1+djJMlZ7n2qxxv7yXym5jnIajGvYDCjOTZbw2nAd4=;
        b=deJIZPNPT8dLz6IgTJHEvbCmjPWUuIr+Pcof8ayGAsF4xseivB9Zb7+sVX5nbxr/Ml
         KwjpOPAn+XN/jKJPRUAQ8RMxvuEWUKu/sChDJWxIYLeMhwZsUN6T9OdE2COIsuTQS++A
         Va99kC/Z7ipjuN1jnmfh+1f0+IZOsVwCOjO/Qjy7CTf1KRd35lUtkgI7Uo9Wdffpo943
         qRQ0MEuD5LDkgpsrs3vA4jvBWxCf/y+5vp3lii7+8iOTT74Ke5MebbuWLagEGUrj5pJf
         6LbG97AfY7Dx4QyB24VWfa62z+myDSgjaSVbn9vO3soIwa5fLupVqaOagDcWstuTFmSq
         PCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1+djJMlZ7n2qxxv7yXym5jnIajGvYDCjOTZbw2nAd4=;
        b=rK+VftgCAb6s77vci1Y2rqAi+sjTVAXKUwJaeL4HfYXvMdWXDqnFOKQi3J9uWvqGhc
         EiGVjQLdQysdnixBBT0sMNGoqdeGwX5cSz4AYuQWK6IU9mjOE+PCl4gkUbx2fmEHeVnL
         dRAgKz4/y5N1OM0AkWpqhZt2tApR1QlqAMCCOx7KC0LbRrP5k8uwiOXA0iB4/Fr48YFr
         O4sNP0P9hrLgLwsGZ3XZd+BKEh4Yqmsod9VaEXPS4hYO3F6rkoO8Ij43bF53njjfpPPR
         h7ZVDURycb1RNdEggi+Mso2G09+1UixSCR7y20AJbYj8MLJ1dGfAxUKgeGNHFu0v0Ul2
         DY3Q==
X-Gm-Message-State: AOAM530b1D2VM9fp9fLuW7MiOU4Z16OGDlOuWfRRenmvbnV/ARz33C8s
        KM1PA/m63p9tcDhPHaFU3M3hFKbZKg==
X-Google-Smtp-Source: ABdhPJzDiWY9h/ohKq/TP2XkaHBMlbGlPmFMRgViUggytXflnex5k/qt1KbxtHRvD1NjQCcL2EZ+fA==
X-Received: by 2002:a17:90b:2249:: with SMTP id hk9mr2845560pjb.245.1639454540817;
        Mon, 13 Dec 2021 20:02:20 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v63sm11538777pgv.71.2021.12.13.20.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:02:20 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     devicetree@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 1/2] of: fdt: Aggregate the processing of "linux,usable-memory-range"
Date:   Tue, 14 Dec 2021 12:01:56 +0800
Message-Id: <20211214040157.27443-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211214040157.27443-1-kernelfans@gmail.com>
References: <20211214040157.27443-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Currently, we parse the "linux,usable-memory-range" property in
early_init_dt_scan_chosen(), to obtain the specified memory range of the
crash kernel. We then reserve the required memory after
early_init_dt_scan_memory() has identified all available physical memory.
Because the two pieces of code are separated far, the readability and
maintainability are reduced. So bring them together.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
(change the prototype of early_init_dt_check_for_usable_mem_range(), in
order to use it outside)
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Acked-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
To: devicetree@vger.kernel.org
To: linux-efi@vger.kernel.org
---
I keep the Signed-off-by, Tested-by, Acked-by and Reviewed-by, since I
think that the prototype change is not significant.
early_init_dt_check_for_usable_mem_range() only handle chosen node, and
it is fine to isolate this info inside the function itself so later
easier to be used outside.

Sorry if you disagree, please let me know.

 drivers/of/fdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284ceb..18a2df431bfd 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -965,18 +965,23 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
-static phys_addr_t cap_mem_addr;
-static phys_addr_t cap_mem_size;
+static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
  * location from flat tree
  * @node: reference to node containing usable memory range location ('chosen')
  */
-static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
+static void __init early_init_dt_check_for_usable_mem_range(void)
 {
 	const __be32 *prop;
 	int len;
+	phys_addr_t cap_mem_addr;
+	phys_addr_t cap_mem_size;
+	unsigned long node = chosen_node_offset;
+
+	if ((long)node < 0)
+		return;
 
 	pr_debug("Looking for usable-memory-range property... ");
 
@@ -989,6 +994,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 
 	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
 		 &cap_mem_size);
+
+	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
 }
 
 #ifdef CONFIG_SERIAL_EARLYCON
@@ -1137,9 +1144,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
 		return 0;
 
+	chosen_node_offset = node;
+
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
-	early_init_dt_check_for_usable_mem_range(node);
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
@@ -1275,7 +1283,7 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Handle linux,usable-memory-range property */
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	early_init_dt_check_for_usable_mem_range();
 }
 
 bool __init early_init_dt_scan(void *params)
-- 
2.31.1


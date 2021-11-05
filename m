Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1D446A90
	for <lists+linux-efi@lfdr.de>; Fri,  5 Nov 2021 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhKEVas (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Nov 2021 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhKEVas (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Nov 2021 17:30:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D868C061714
        for <linux-efi@vger.kernel.org>; Fri,  5 Nov 2021 14:28:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w9so3328633qtk.13
        for <linux-efi@vger.kernel.org>; Fri, 05 Nov 2021 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mf7MHrsfS1iznKNhSHLhi/OpB4abwQRglzu/1XEi4uw=;
        b=V0MpLc5bxq9jyycWaapncy8o78khSMcJkNqaJP4YUDCUip6H1wln3UZpGJS8K2Y1NK
         LIcD+DVhZKKBflP4Kx3GrCWIbbh8HvTntvLFC+wtuw1/r9sUn0rRGUXatl8pNjtUzUqg
         9SG9IA96WDI3Mu4E5imNL8Cx07DXFaFIkgHd/SZsuwcL8PPzPk+uBYHkS4e319E4p9uF
         NbBiVvgAoo1t/C02lWAayBYoMslW+epimWkBJ+O4gfCpqZWVKMdxpYwhGDLXDlqh3Nlu
         7NoFsf6xGuSy8Or1Z+dSxW1Yi786wKJqD2O94MOX235631exm52YHVjHOa++tjlakU2l
         v74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mf7MHrsfS1iznKNhSHLhi/OpB4abwQRglzu/1XEi4uw=;
        b=3ZVZrA18TZH8jpTkNeofjUqTBzpFWQQGvoP4njpEqqSa4reSx+NSa21Ozc26ixQuhg
         /cvvtK/RWKt5PEGqCfjaNgf2urYWBH0e2TnUMtNBfpVD6TFex1F79G6Jm6caac7CsCcT
         TnCe3BPRlnKKxDzInk2QzFIBrkJMILO1MotP8ZjWEBJNWqf1xcl/vetG0tMcAWWuSSDf
         779PnIVKzez7lkXdRuGIc+WM37+p5Ct7kXHR0EsJoHmNL91tWHQh78rXLWUKyaxk03AV
         smgK7Nt3YPLot1mZsV5ZsZbk/nWdq/Ugj3yK5ibX0La5HmYCw14KcWYTD/2kh4La2vWL
         /LZw==
X-Gm-Message-State: AOAM531iGF7OIevm6Q6f46+zky0r+YF7Km1i6HhR+qnkzSt8lNuMhgUW
        ZTyLkkieSvbQ5GUz5QdLgdlKVhXBE+VxZYJ3+X+cBTIRUtf7m6IlkoeffWKbWjJpJjLO7Y4ssTC
        /P3DIXYKa2ISN021K3Rv12NCzEzqOuGzRxN5kezaYP9a0uubODX5LUCZbqizNzzvgaaDNLTq4cW
        NxI+zg3oQqmF/Cdcnc+w==
X-Google-Smtp-Source: ABdhPJxlcHhAWto6prVmhWvyfsnasrRCaK9FwrVQq2OOh+uD88o9xTgbkMg4DnSo9gDYedjt6jYmuw==
X-Received: by 2002:a05:622a:1392:: with SMTP id o18mr65981668qtk.107.1636147687070;
        Fri, 05 Nov 2021 14:28:07 -0700 (PDT)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id o5sm5793503qkl.50.2021.11.05.14.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 14:28:06 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alison.schofield@intel.com, alex@eclypsium.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH 2/5] Extend pg_data_t to hold information about memory encryption
Date:   Fri,  5 Nov 2021 18:27:21 -0300
Message-Id: <20211105212724.2640-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
References: <20211105212724.2640-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new member in the pg_data_t struct to tell whether the node
corresponding to that pg_data_t is able to do hardware memory encryption.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/mmzone.h | 2 ++
 mm/page_alloc.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d84675..998fbe371a81 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -869,6 +869,8 @@ typedef struct pglist_data {
 	unsigned long		min_slab_pages;
 #endif /* CONFIG_NUMA */

+	bool crypto_capable;
+
 	/* Write-intensive fields used by page reclaim */
 	ZONE_PADDING(_pad1_)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..a19d95bb5c0f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7575,6 +7575,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);

 	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
 		(u64)start_pfn << PAGE_SHIFT,
--
2.30.2


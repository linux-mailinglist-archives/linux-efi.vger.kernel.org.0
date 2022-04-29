Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D680515561
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 22:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380512AbiD2UVM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 16:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380484AbiD2UVL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 16:21:11 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F4AA0BE7
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:17:51 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e5ca5c580fso9219719fac.3
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuoU1kSVf8VEBS5kxyG+ti9eeLYydPT4J1CXt5LwLhU=;
        b=Ca5CpkEdAGoDq4Rv1TW6+hSfJvX+bFxVgDxtp2Me/AhtkYKBKy7HDq9kO20qbFkCU/
         oD5DMChdyFmU3n3DgPNgqCCNm7kr+52q5L9Hs/atSrY+4iP2qvhY/q2YA44Z2lv4tRjd
         v+qrNTH6cIBZ9Su9FBIIHdnb4f7y2STK1hcq14DBBiSA+1dXsvH5vR9SgVQv5TpKV515
         6JTZ+l5RXQFB1Sq+ZHqkQs2djzOBE2pbg+fG2kXx5gpAKt3GP7C7mx5AJDZr8JYHBth7
         TYSaK6qQeMoDiSKDnXRZLJRvuIFFmoFjKEfYjUbHtaeI2RjnrZIYZSMrNqd1ZoT95Xiv
         ckjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuoU1kSVf8VEBS5kxyG+ti9eeLYydPT4J1CXt5LwLhU=;
        b=2vTyqrJlphwy/1W2ChFN9O10q0EWxpoqOVSmayYD+j6rHEiVkUBC4pbI5VZJZrQpFF
         YtsWqnkzrabOp/LDcuUgazuDMP7vSLe68+VxroQugmhlFAxldTG2ANctf572kqa8vXK4
         AbbB2aKQA7qxsdFjR2F8kTlzrno/LaoW4nelgm6N33TxDhABG+0VcXh7yZZR/4+lm1it
         7hPOhKfwbyZwd6W1Hv0GzF7t/A9GMIPX3HqStnIi4vthhaczuYN8GvJTIZ1hhNaUBN53
         g2qt1S6MYi7jd56KhYkCJFs6LKpSAUdoFdUCXRyD+Ak5TNTrwEusKE4EfbN1kDm5r0nL
         oyqw==
X-Gm-Message-State: AOAM532TUY9hqgG150K9zUSI9GYOqQR8FfNXdbaSqOz/dtJywEYS+8cf
        +GkJ9w5XC9xyzIBQ+nVI1ANP7Q==
X-Google-Smtp-Source: ABdhPJxIe/y2ZbNmKFx3Owc3D12ozpXuX/TsxcZP+iWHDA2M91qfr82Tlpg84wHwV/O7VsilCNZp4w==
X-Received: by 2002:a05:6870:14d5:b0:ec:ab0e:d106 with SMTP id l21-20020a05687014d500b000ecab0ed106mr469524oab.65.1651263471218;
        Fri, 29 Apr 2022 13:17:51 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ad02c000000b0035eb4e5a6aesm1130791oor.4.2022.04.29.13.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:17:50 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v8 2/8] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Fri, 29 Apr 2022 17:17:11 -0300
Message-Id: <20220429201717.1946178-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add a new member in the pg_data_t struct to tell whether the node
corresponding to that pg_data_t is able to do hardware memory
encryption.

This will be read from sysfs.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/mmzone.h | 3 +++
 mm/page_alloc.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 46ffab808f03..89054af9e599 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -886,6 +886,9 @@ typedef struct pglist_data {
 	struct task_struct *kcompactd;
 	bool proactive_compact_trigger;
 #endif
+
+	bool crypto_capable;
+
 	/*
 	 * This is a per-node reserve of pages that are not available
 	 * to userspace allocations.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..a244151045b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7699,6 +7699,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
 
 	if (start_pfn != end_pfn) {
 		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-- 
2.30.2


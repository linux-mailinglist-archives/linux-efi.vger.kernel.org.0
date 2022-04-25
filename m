Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08450E6E0
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbiDYRTM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiDYRTA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:19:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6CBE0B
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r85so17828349oie.7
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuoU1kSVf8VEBS5kxyG+ti9eeLYydPT4J1CXt5LwLhU=;
        b=WVNRKEKob2y9lFrXgNElxa26Uxh1XvllzgMqrT+R70+SAvu/khzVJ0sFW9Kny0Qa7N
         jLVQLq9bTQ71s6VakMPFRKCHzlO8ZQ8mMVLzhNDI47Tsc6K6t3zkkwCNQe76Hs/qU+h5
         pff6FNHYBVqwtXfDT2vS4howEmhCTaodjYQw7fzcHX4fgvsmvS2MLEoXGEWf8QrHMsop
         kGxt72nAdiuqmo2bcyzM+I4DRQjwsBtp+Is15HwL9rka8zB2koeqRTkw+HAsvAlcMyfK
         u6R0LRV4pUi4IWR8NROkxZ2EmmJAi1skJ5sO/+YxWmwC+pZ4xs3as8lXszeFy8RS3TMf
         tmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuoU1kSVf8VEBS5kxyG+ti9eeLYydPT4J1CXt5LwLhU=;
        b=jlsKfo2cfV2XEQqb1qVy0SYA+es6uLHWMkyx1H2ASMqq8ftASWJSkPc9crgs25QpQ7
         n/my7dQcuDnouGHTeIsaHJOWsg2qrmrwx/rtdEPpewnnvYydRMrY/+/I2NdpUl+zA3Th
         lsx+ZgETXW08ARTLruJ9oJGlbbYp6unVZv2xTnzTV1F7d7fsTo0JHYWCf7Be/GYKh77e
         oCIp5f+NGm/1xmc31/GWufO8OnRDB1TgqfEfG4EVUAHWE+wJdj2yCs/DBsIiaAvyahmO
         W1GGwZhUjGbfdILPxzHDRqkoGOJ7oAwNhYXr4BrkVQCsXSTFuxK/RWv4tHgRPLjknDBI
         fCbA==
X-Gm-Message-State: AOAM532VSpmSX3VUBO3LarMUFKZ/rlemtqM4DDfBSZ1oPckbc6BOK7lm
        7u4LNnGgYz88W4zoYHqvqK43Qw==
X-Google-Smtp-Source: ABdhPJwJqrLz4LvPdbpxTti+gZ2zpgNv7oGdv4vd7aYab8Kx1ulj4m3IkrTedE0A5L9UCyT5RbSlZA==
X-Received: by 2002:a05:6808:1805:b0:323:a81:bdff with SMTP id bh5-20020a056808180500b003230a81bdffmr8671177oib.7.1650906954532;
        Mon, 25 Apr 2022 10:15:54 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id j9-20020a056808056900b0032252797ea4sm4007238oig.6.2022.04.25.10.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:15:54 -0700 (PDT)
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
Subject: [PATCH v7 2/8] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Mon, 25 Apr 2022 14:15:20 -0300
Message-Id: <20220425171526.44925-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
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


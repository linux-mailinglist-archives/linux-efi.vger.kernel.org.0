Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AEC565809
	for <lists+linux-efi@lfdr.de>; Mon,  4 Jul 2022 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiGDN7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Jul 2022 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiGDN7E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Jul 2022 09:59:04 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A3DEE6
        for <linux-efi@vger.kernel.org>; Mon,  4 Jul 2022 06:59:01 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o190so9103559vsc.5
        for <linux-efi@vger.kernel.org>; Mon, 04 Jul 2022 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/5GR/KX7teTknQriuvUZb8IVKxvs7e03/RMVm9+BQI=;
        b=GLaHhFySQ9gOLZrKKeJvwwMHsWCWM3q5PzByQA9CXY12npsM3Osv/S1W71q725TU13
         H5NgkCeE2bqltfg5cRYAP4bll17byyhwEuYP2oQvTfgEY8qwK7/IU098iZXMhug19osr
         ZVHqSxQ9/UM+9k0N0DjOiIDLRQUJrp4S0oIyi3G8Ex4p6qAXsybjVeMBv4Dbh9566/GV
         A83eDRvuXPThAtIIG2X0ViUECgwh1c0F7AZNRLFNCik5k/6jdzoHzuKZiGlJ6RaoZy2B
         YaEZhCfWYPzaUbYiNoV+pDcaYkqv3AlFGu8AyC1alTFvHvP1W/TLvNOxjNOHCeYvPNML
         BAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/5GR/KX7teTknQriuvUZb8IVKxvs7e03/RMVm9+BQI=;
        b=5BXDsZo8gXTsbF7XVhaSiODddtblfk/m2XkYAo+yWj3qcSJXLO0hj0Ul9Chy+htsFq
         1UWGwackzR1iD7gIg4+eSokoAffqohMcbbbhQdj0kClQJJCUUkWx+sPh4vv0agX/DyPA
         PnIJoUVrlwz07GGHR4q+dK7L1r0kxsrF+60gWRpbq1kMN7f0KvNP4TIUe/NSNpWzNpan
         EnAwJ/+qwYJAeAf+Cn/lTklQb81FEHatrJlFWbDzoopJV/9nfd/QjGiSFf500R/C1vxz
         JjRMJh3bswPFw4ybRm1Qn6oTJjRHw6Xajb1Z8Sz2yLv6iXNNgCNWG/64HipUD1DQq1GK
         TuxA==
X-Gm-Message-State: AJIora9prX0qmb4jOf0bIichMgGyqiYCj48YescG3+ckhoblsjL5joGd
        d0g977+260DfYt5G+pFUchc0jg==
X-Google-Smtp-Source: AGRyM1t9iMJScGmHX08KEczn8L5RecJYqWxEG84yc3pB37kCvlZO6ibtfKtkmWCmJt0mxLsO9yKhOQ==
X-Received: by 2002:a67:ac0d:0:b0:356:a09d:b063 with SMTP id v13-20020a67ac0d000000b00356a09db063mr6746100vse.69.1656943140208;
        Mon, 04 Jul 2022 06:59:00 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id p2-20020ab01ec2000000b003828ebf6b49sm722929uak.4.2022.07.04.06.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:58:59 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v9 2/9] mm/mmzone: Tag pg_data_t with crypto capabilities
Date:   Mon,  4 Jul 2022 10:58:26 -0300
Message-Id: <20220704135833.1496303-3-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index aab70355d64f..6fd4785f1d05 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -883,6 +883,9 @@ typedef struct pglist_data {
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
index e008a3df0485..147437329ac7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7729,6 +7729,7 @@ static void __init free_area_init_node(int nid)
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
+	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
 
 	if (start_pfn != end_pfn) {
 		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-- 
2.30.2


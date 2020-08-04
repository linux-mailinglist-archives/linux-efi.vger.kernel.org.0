Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19323BA91
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHDMmc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgHDMlr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Aug 2020 08:41:47 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD1C0617A0
        for <linux-efi@vger.kernel.org>; Tue,  4 Aug 2020 05:41:42 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id t12so12675297wrp.0
        for <linux-efi@vger.kernel.org>; Tue, 04 Aug 2020 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KTaExCeIbMBtrg6f3KaFtKJ9kXln1IxZOo4x1K8ywoo=;
        b=epaWaJlt64ntx42FNABLMyLva14SlmdYcoGzzYGyrXWUnAJnxMu5GEZgilr7YOjQyg
         rwN+m322Ym4K72DntPYQLTQpUlUsvtp9hOED35dktAjWzCeoMAdqgWFu+8q67qvVGdd0
         ASSvypkGepo2fVM74GawP/zGW8ARgykh7GWGHusAgWS8l/UBxb0pdkO0TYQ7EmgRfqVS
         +AhohRsPKYfLCyuszVYf5jaiW3P7HKDO0xMW0AxuHSElSjjWJ6UveE2t2MgCnIL+ItDv
         /1ed6bLGDRty9mFhZhCq6dEUtquKavGW9+Vz9/sId52Rf88V2RXw/k9gqiVHbxbaBWtN
         +9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KTaExCeIbMBtrg6f3KaFtKJ9kXln1IxZOo4x1K8ywoo=;
        b=Ab8VLR06G6B05Vs+YOpJHU2FSOUU3EyYk1FDCpw44nR9QRzOC/aOgbyVQy74Q/to9b
         0ZBXe5B/HnTdDUkjzUf5qPrGwPoa0hvs6v4A145dgZI43YuCcOu8OKbtWhgQYo+HLTql
         geIKnKNfW5wq9AFzytarGOuzbeoJljrZITi+OGtx7uFKGL5hFtRJyy8k4RT6ioZ33bss
         IgurJcDc/KCc8s5XslccJGdLodzzrNPTnVhfjvyfS0b3V4RsMUmSCFTjE/ZedB57o1O5
         Yuta+4AxO0gD4WEy0ufpDIW+xCr6uBxn3vPa47o1tbOI+tv71O158xu5gRMz2Mp5REYn
         0cng==
X-Gm-Message-State: AOAM530SpJHylOYHuZ3naSvmThoGiSoFgK4mumdLzGYH7wjd1mmMARxd
        BFbL+3WMDhKw80494fq1Mzt9tvDyDMwrYTPr
X-Google-Smtp-Source: ABdhPJwWjosW9Y2ZD4qtR2i07CuuW2KOWsc+Y1P+/2KrTNBkB6pCcdGVRsu0tHMa3wVdBR/M1mpyQCpyke7nl0k9
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr492659wmj.0.1596544900281;
 Tue, 04 Aug 2020 05:41:40 -0700 (PDT)
Date:   Tue,  4 Aug 2020 14:41:26 +0200
In-Reply-To: <cover.1596544734.git.andreyknvl@google.com>
Message-Id: <26fb6165a17abcf61222eda5184c030fb6b133d1.1596544734.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596544734.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 3/5] kasan, arm64: don't instrument functions that enable kasan
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch prepares Software Tag-Based KASAN for stack tagging support.

With stack tagging enabled, KASAN tags stack variable in each function
in its prologue. In start_kernel() stack variables get tagged before KASAN
is enabled via setup_arch()->kasan_init(). As the result the tags for
start_kernel()'s stack variables end up in the temporary shadow memory.
Later when KASAN gets enabled, switched to normal shadow, and starts
checking tags, this leads to false-positive reports, as proper tags are
missing in normal shadow.

Disable KASAN instrumentation for start_kernel(). Also disable it for
arm64's setup_arch() as a precaution (it doesn't have any stack variables
right now).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/setup.c | 2 +-
 init/main.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..575da075a2b9 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -276,7 +276,7 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
-void __init setup_arch(char **cmdline_p)
+void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..7e5e25d9fe42 100644
--- a/init/main.c
+++ b/init/main.c
@@ -827,7 +827,7 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
-asmlinkage __visible void __init start_kernel(void)
+asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;
-- 
2.28.0.163.g6104cc2f0b6-goog


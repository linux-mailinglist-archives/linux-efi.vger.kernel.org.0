Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31C61DDDE
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKETtd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKETtd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 15:49:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDEC10571
        for <linux-efi@vger.kernel.org>; Sat,  5 Nov 2022 12:49:29 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c8so5611949qvn.10
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+aQ4KvtSgbziv3y1jOmicvGW9ncWBT5T5hSqEGaM0yw=;
        b=Zml9TDfR0H9lMMwGa4DOYtFE9OWPCOzqAzU4V1ffeR0asut6c3XLSKmTPQmR11Gq6z
         yLYWFGqqWOFg3toO+BjwgtdZimjbJF6BAk7j4FGVCJzvVSgKZ4eNcLTrxNSsN+XGJo3S
         EfLz8e6OGQf6l670eWCulpaF2ckhvTuY18pgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aQ4KvtSgbziv3y1jOmicvGW9ncWBT5T5hSqEGaM0yw=;
        b=pki8SmIsgkS2SeppPC+5AqH1T6FgoN9YDJLhovTeeuD2hkBPoK1JK7/RRbBvLLsZ27
         8CTdqmxCBqx4nxgyABf+XYMIK7NU/0NOvNJKQrv7zebhouux938alJS/a+dba6YQlQTo
         pnKG6pPAuiLQoHA64VN3JOaH+1U5em7ONBnr/vBL6Yip0LLDZ6aLcfN/XezaWSPUPGut
         +KCB46bOQGZne8if6ptvJsWGMZpTXj51Yrqyuv5nZZmGXaYTzArGM62hAfgkXLXukDH6
         BgTndVFX4jZzI3MUb2WXJqRZXWLQKpMjxx0TzFdfYB0Of5wxbz6/nAFcfT8QyJVnvRx6
         xquQ==
X-Gm-Message-State: ACrzQf17gzcgPigZx40k5Z/N2ZiZwYQrR/nl2wMFW5prfqgAVuCehl+k
        3GE82TeBtcjHY7oki1oHxr9QFyLGc75EPQ==
X-Google-Smtp-Source: AMsMyM4lakE9WyRu0eil2YZ1ymAne1SPhEQKZCHsykPIpDLvuW4qrwicEMN39UV0fHB9WzZc20Dmvw==
X-Received: by 2002:a05:6214:e84:b0:4bc:2094:2ef0 with SMTP id hf4-20020a0562140e8400b004bc20942ef0mr18970600qvb.78.1667677768467;
        Sat, 05 Nov 2022 12:49:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id b23-20020ac86797000000b003a526675c07sm2337212qtp.52.2022.11.05.12.49.27
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 12:49:27 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o70so9410031yba.7
        for <linux-efi@vger.kernel.org>; Sat, 05 Nov 2022 12:49:27 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr38056548ybu.101.1667677767216; Sat, 05
 Nov 2022 12:49:27 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Nov 2022 12:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
Message-ID: <CAHk-=whPRmHQ=KV9B3_jeOG4ydj8gkMwQKnde7BJ4wJjveyMDQ@mail.gmail.com>
Subject: Remove WARN_ONCE for unaligned UEFI region?
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

So this has been going on since I got my M2 laptop, but I finally
decided it's really annoying and would like it removed..

The arm64 EFI code does that

        if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
                      "UEFI Runtime regions are not aligned to 64 KB
-- buggy firmware?"))

for unaligned UEFI data, and that most definitely triggers on the M2.

Yet I can't really see the point of the stack trace and register dump
for something like this.

IOW, why isn't it just a

        if (!PAGE_ALIGNED(md->phys_addr)) {
                pr_warn_once("UEFI Runtime regions are not aligned to
64 KB -- buggy firmware?");
                return pgprot_val(PAGE_KERNEL_EXEC);
        }

instead?

As it is, it's just annoying, and doesn't actually even tell anything
interesting. The stack trace points to arm_enable_runtime_services(),
which isn't a surprise, and it's obviously just that
efi_virtmap_init() got inlined.

Now, if it actually mentioned which mapping it was that was unaligned,
maybe that would be interesting, but it doesn't even do that. So it's
just noise with no actual information in it.

I get a number of other warnings on the M2 ("Unable to detect cache
hierarchy for CPU X"), but hey, that's normal. My regular Threadripper
workstation also has ACPI warnings ("Failure creating named object")
due to duplicate objects etc. Firmware is buggy - what else is new?
That's just how life is.

But using WARN_ON() instead of "pr_warn()" for it seems a bit excessive.

I can do that change myself, or take a patch the usual ways, but let's
get rid of this annoyance, ok? Just let me know.

               Linus

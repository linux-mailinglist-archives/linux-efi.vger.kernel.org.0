Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD706B04EC
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCHKrq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 05:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCHKrj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 05:47:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567A5F6E4;
        Wed,  8 Mar 2023 02:47:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6139CB81B29;
        Wed,  8 Mar 2023 10:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286B3C433EF;
        Wed,  8 Mar 2023 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272454;
        bh=vah1HKDBJppZCaU2t+guMzVDffwctWHUIjYOBY1sVNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGBQDLQ5ZCr4+kRitfXk/qnrEk20jryY3RogODYnKM2j58Dug8KO+Mw7lYF8Ilukz
         K7OO1nFwqMcdoOsxDdECYygp7kmq3LG2YQqBK8RDhZXOs7RKEJQiHQo4hpe5ZosYL/
         huGd935oP7r4AywCT79OAIVtQ+vfa/0Dp5Nl6f9w3v+QpmOXtuimNJvJ4TatL3efgS
         sQNjP4xIGCU90xpgz4jtTdyj1L9v6zBdBn3iehb8GPKcWs7YOj6NiOrFl/gjjGGsgs
         17x4j9Dkr1DapdH6tJCFcO9x3r5IwCsVaF89v+SIToOHcI+cT12zp9b9BHN8I8pxwo
         RDdYozzKS488g==
Received: by mail-lj1-f177.google.com with SMTP id t14so16107817ljd.5;
        Wed, 08 Mar 2023 02:47:34 -0800 (PST)
X-Gm-Message-State: AO0yUKX9XXJszNak45DyAb+wWP6SmMfl612g4rwOqrSLKJ2fd5rvMn+m
        fLMFwsbJCtXRCTfMddj7WqbY6T6gmujXF7hLiCU=
X-Google-Smtp-Source: AK7set+LDFxTNqmWQ/j2CsKSjRJ2Sw1MqBSEQ6/z8ex3z4eJ2/cmts3ofUKx6SeQkqaMH5VT+LJ6YoLqSNhHqGWFY4M=
X-Received: by 2002:a05:651c:169a:b0:28e:d4ae:90ab with SMTP id
 bd26-20020a05651c169a00b0028ed4ae90abmr5303546ljb.2.1678272452210; Wed, 08
 Mar 2023 02:47:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <63ea4796323a734c061ad774a68c88a47f5669a4.1671098103.git.baskov@ispras.ru>
In-Reply-To: <63ea4796323a734c061ad774a68c88a47f5669a4.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 11:47:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFjQemVpHph2K+ysNO44uH3E7mjfc0o+JPV+gzi+mtoZA@mail.gmail.com>
Message-ID: <CAMj1kXFjQemVpHph2K+ysNO44uH3E7mjfc0o+JPV+gzi+mtoZA@mail.gmail.com>
Subject: Re: [PATCH v4 06/26] x86/boot: Setup memory protection for bzImage code
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Use previously added code to use 4KB pages for mapping. Map compressed
> and uncompressed kernel with appropriate memory protection attributes.
> For compressed kernel set them up manually. For uncompressed kernel
> used flags specified in ELF header.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>

This patch breaks the 'nokaslr' command line option (at least with
SeaBIOS) unless I apply the hunk below:


--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -329,7 +329,8 @@ static size_t parse_elf(void *output, unsigned
long output_len,

        handle_relocations(output, output_len, virt_addr);

-       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE) ||
+           cmdline_find_option_bool("nokaslr"))
                goto skip_protect;

        for (i = 0; i < ehdr.e_phnum; i++) {
@@ -481,8 +482,10 @@ asmlinkage __visible void *extract_kernel(void
*rmode, memptr heap,
         * If KASLR is disabled input and output regions may overlap.
         * In this case we need to map region excutable as well.
         */
-       unsigned long map_flags = MAP_ALLOC | MAP_WRITE |
-                       (IS_ENABLED(CONFIG_RANDOMIZE_BASE) ? 0 : MAP_EXEC);
+       unsigned long map_flags = MAP_ALLOC | MAP_WRITE;
+       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE) ||
+           cmdline_find_option_bool("nokaslr"))
+               map_flags |= MAP_EXEC;
        phys_addr = kernel_add_identity_map(phys_addr,
                                            phys_addr + needed_size,
                                            map_flags);

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C06B0455
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCHKaO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 05:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCHK3x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 05:29:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B21867F8;
        Wed,  8 Mar 2023 02:29:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585CA61726;
        Wed,  8 Mar 2023 10:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A8CC433D2;
        Wed,  8 Mar 2023 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678271348;
        bh=b4wPxZcXc5NvC0huy+pK8EHSXW3crKOJLq3RK/jZufM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jnIhJ+W5VUKhDbN7yhZEQcEon2TvYytNV7UsUpg3+TYk1DkI0pwnVZD7f6AteKiZW
         nt+XBsI6W4xNehu85Y6qlRzSBkTnSbcWr7L2Ryhd9m6c4DC27pygS3t93qq3XsEZ7p
         rJcR/QW8yqEldXBJbX8zEqHmZWyv7ckw/ikLvvGdTQvdhJN8paiype+JkKsb44Qo3j
         i0/IiiiTtZbPtBDR0ObJXe3GJD3Jt1RjxQu5oe5cQ7P/yG2VBG8XN9OflWpNZWPpeb
         kKghw26S38wPcUJg5dkFhoR0nyz8kuttEaIxU7VyvY3DdUn508tVXpMtB1CDKk622A
         YXVd1uSsRoqLQ==
Received: by mail-lf1-f53.google.com with SMTP id g17so20706755lfv.4;
        Wed, 08 Mar 2023 02:29:08 -0800 (PST)
X-Gm-Message-State: AO0yUKWSWRbgA+jb2Wb2e5Xb45vyGVKBkfE1IL6OabtZ4WsAVFc5msH9
        pXkE6XZp9Swqu0V7W+29D79OEj7u8U0SluFigXI=
X-Google-Smtp-Source: AK7set8C+Iab5z1DBdOhjcn6roaZUfnP830gj7PUcu9E35S/hzNa3WZDjTkxVQaAsOyo8xaz4yEn9kKOim/Pe9ukIfw=
X-Received: by 2002:ac2:54b9:0:b0:4d8:62e5:4f66 with SMTP id
 w25-20020ac254b9000000b004d862e54f66mr5421189lfk.7.1678271346796; Wed, 08 Mar
 2023 02:29:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <760c19466ac26c09edb76e64d8c4812ff4aa7365.1671098103.git.baskov@ispras.ru>
 <CAMj1kXFtEZtso0Gcuj-PhGiK1QRhp9SDFLwouX3qdgSha=ACjA@mail.gmail.com>
In-Reply-To: <CAMj1kXFtEZtso0Gcuj-PhGiK1QRhp9SDFLwouX3qdgSha=ACjA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 11:28:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGP1k-FoG6GQ2u9ZRiGnxogO=3bLWPfcyOEUOfZG3TRJw@mail.gmail.com>
Message-ID: <CAMj1kXGP1k-FoG6GQ2u9ZRiGnxogO=3bLWPfcyOEUOfZG3TRJw@mail.gmail.com>
Subject: Re: [PATCH v4 08/26] x86/boot: Map memory explicitly
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

On Wed, 8 Mar 2023 at 10:38, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >
> > Implicit mappings hide possible memory errors, e.g. allocations for
> > ACPI tables were not included in boot page table size.
> >
> > Replace all implicit mappings from page fault handler with
> > explicit mappings.
> >
>
> I agree with the motivation but this patch seems to break the boot
> under SeaBIOS/QEMU, and I imagine other legacy BIOS boot scenarios as
> well.
>
> Naively, I would assume that there is simply a legacy BIOS region that
> we fail to map here, but I am fairly clueless when it comes to non-EFI
> x86 boot so take this with a grain of salt.
>

The below seems to help - not sure why exactly, but apparently legacy
BIOS needs the bootparams struct to be mapped writable?

--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,6 +31,7 @@
 #include <linux/ctype.h>
 #include <generated/utsversion.h>
 #include <generated/utsrelease.h>
+#include <asm/shared/pgtable.h>

 #define _SETUP
 #include <asm/setup.h> /* For COMMAND_LINE_SIZE */
@@ -688,7 +689,7 @@ process_efi_entries(unsigned long minimum,
unsigned long image_size)
        u32 nr_desc;
        int i;

-       kernel_add_identity_map((unsigned long)e, (unsigned long)(e + 1), 0);
+       kernel_add_identity_map((unsigned long)e, (unsigned long)(e +
1), MAP_WRITE);

        signature = (char *)&e->efi_loader_signature;
        if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&

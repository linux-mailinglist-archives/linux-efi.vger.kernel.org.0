Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8709B634991
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 22:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiKVVno (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 16:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiKVVnY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 16:43:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899911446;
        Tue, 22 Nov 2022 13:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FE3618EE;
        Tue, 22 Nov 2022 21:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD0AC433B5;
        Tue, 22 Nov 2022 21:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669153389;
        bh=Us36PTZHvI11zr97GUDhlESW/qDe06eNQv+kgcGZ7hw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cn52BcXR2eRR5iYnzWMd7jMC+FPriDPeGS+qQMHqbyrbPJQsMRaa5fRTdFzBDFroU
         gvp2oZit0j1hjurttMDmLMamdhPlvjUhELicWkQ28iwBv3ZW+HqzBxG8YqNbNZtmNy
         7sQjU2zOn69+XRpNjnKqt+n2Y6JvreSAfNOXNmQJamclcEwjcUoYqhNrTeP0IrkJ4a
         xEUEBehW0SlDirBBnLvjunXryZUqHshaDOZ7lpUr4w7NL8nj4h/vpuND6k4zTKq9W3
         XaTCA95oa/Gqc3yrh4GJM3w0QQbKnm5lkSIWY0UFZcDyZiyRztcQzS1ZpZnO1cjmtG
         B27GR5gbHSRFA==
Received: by mail-lf1-f50.google.com with SMTP id c1so25487048lfi.7;
        Tue, 22 Nov 2022 13:43:09 -0800 (PST)
X-Gm-Message-State: ANoB5pl6E+ELxq0jLHXC4yxe0TJFJTNq2yRXSNWIeQR3eYwVxdbJcZmD
        K0N4zdWT5BicP/HUalEHDw0msI0VgJ70ZhjU2XI=
X-Google-Smtp-Source: AA0mqf7scteqcIYLXwi5rWvAgaAyNNSA69LziUV6JQP2iw0ZWMY8BQ5LgaUuEmf0PhjW2ZTnvtzUZ7YwDGu4H9qKD40=
X-Received: by 2002:a05:6512:15a8:b0:4a6:3ed2:3717 with SMTP id
 bp40-20020a05651215a800b004a63ed23717mr2797186lfb.637.1669153387377; Tue, 22
 Nov 2022 13:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
In-Reply-To: <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 22 Nov 2022 22:42:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFX3df00cv5hwij396jS2AOgVGavDM-8hRii49Omn5=pw@mail.gmail.com>
Message-ID: <CAMj1kXFX3df00cv5hwij396jS2AOgVGavDM-8hRii49Omn5=pw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Nov 2022 at 22:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 22 Nov 2022 at 21:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 11/22/22 10:10, Ard Biesheuvel wrote:
> > > After doing some cleanup work on the EFI code in head_64.S, the mixed
> > > mode code in particular, I noticed that the memory encryption pieces
> > > could use some attention as well, so I cleaned that up too.
> > >
> > > Changes since v2:
> > > - add some clarifying comments to the EFI mixed mode changes
> > > - include patch to make the EFI handover protocol optional that was sent
> > >    out separately before
> > > - rebase onto tip/master
> > >
> > > Changes since v1:
> > > - at Boris's request, split the patches into smaller ones that are
> > >    easier to review
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Michael Roth <michael.roth@amd.com>
> >
> > This causes an SEV guest to blow up on boot in the early boot code. It
> > looks like the stack pointer is not valid and it triple faults on a pushq
> > instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
> > startup_64).
> >
>
> Thanks for the report.
>
> So the mystery here (at least to me) is that all the changes are to
> the 32-bit code, and startup_64 reloads the stack pointer from the
> symbol
>
> Does your config have CONFIG_EFI_MIXED enabled?
>
> Can I reproduce this fully emulated with QEMU? Or do I need a SEV host?
>

Also, mind giving this a quick spin?

diff --git a/drivers/firmware/efi/libstub/x86-stub.c
b/drivers/firmware/efi/libstub/x86-stub.c
index cb5f0befee57..1af11d34bc6c 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,7 @@

 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-u32 image_offset;
+u32 __section(".data") image_offset;
 static efi_loaded_image_t *image = NULL;

 static efi_status_t

Thanks,
Ard.

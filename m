Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A07A678B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjISPEj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Sep 2023 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjISPEi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Sep 2023 11:04:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FCBE
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 08:04:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3DDC433CB
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695135872;
        bh=ekljs49SuR3y08C0vcGHHL0QZO0+GmigR5ZNIrWmyY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ry3PILl/4QjsS5juIUlO6Za0YnyswIr9C2y2RyLgFQ65z/U59xmIhyOtIciQRDs34
         SNE854QbZVsu9T8wTTipLxSps4j7c2Znc330g7s3SoD5sgOIfkVfVyZ9FykLByhyyS
         RFK+PHsgmaibXK55HMVPIgk7zTuEJwLgyjvURXPcxeeZPx9VPRrN3o+oIraPxWJI6b
         ihWj20CqVfaoDSzZANTSe37xDzF3CUWLifOe5IpEM8xsoG+8aNtJsBYlMvfZthahED
         IK0gpMjexmxGMUL0UVxJYCYPEd/odc/05rhtDi2BuXXdg+7U6cxrPXS6sLDYVSVcpJ
         45d7ADHeExxRQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-503012f4e71so3782424e87.0
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 08:04:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1/5nyvW4MAZbzyfAL5mWs3z1CM8pYXKzPG0RwBKeLMobYwLh9
        iijw5jhTbUo3T5vjMf2XmyevTfxE90wPIfzUnjU=
X-Google-Smtp-Source: AGHT+IFvOsukJCRz+9AWOFsiGpbB7Ylgq2nRZUo481xkg2M1vat2zmpsNDoa72lM8zpj3foxMpV+dax4x0xrxWg41L8=
X-Received: by 2002:a05:6512:6d6:b0:502:df19:83b3 with SMTP id
 u22-20020a05651206d600b00502df1983b3mr1281361lff.10.1695135870891; Tue, 19
 Sep 2023 08:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
 <20230918221054.nugkvobvfo6islsb@box.shutemov.name> <fd3f7247-093e-37ad-36d5-58c7e0d92a5f@amd.com>
 <CAMj1kXH9LvNMKRjtefxL=jZLXiD1mc9WhB83s21y_GsfpJhOLw@mail.gmail.com>
In-Reply-To: <CAMj1kXH9LvNMKRjtefxL=jZLXiD1mc9WhB83s21y_GsfpJhOLw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Sep 2023 15:04:19 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHOCexDit0GGmFdeaGDviVtkp5eE=KwObdCua7TOs4kJA@mail.gmail.com>
Message-ID: <CAMj1kXHOCexDit0GGmFdeaGDviVtkp5eE=KwObdCua7TOs4kJA@mail.gmail.com>
Subject: Re: [PATCH] efi/unaccepted: Use ACPI reclaim memory for unaccepted
 memory table
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Sept 2023 at 13:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 19 Sept 2023 at 15:28, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >
> > On 9/18/23 17:10, Kirill A . Shutemov wrote:
> > > On Mon, Sep 18, 2023 at 05:03:59PM -0500, Tom Lendacky wrote:
> > >> On 8/16/23 14:05, Ard Biesheuvel wrote:
> > >>> Kyril reports that crashkernels fail to work on confidential VMs that
> > >>> rely on the unaccepted memory table, and this appears to be caused by
> > >>> the fact that it is not considered part of the set of firmware tables
> > >>> that the crashkernel needs to map.
> > >>>
> > >>> This is an oversight, and a result of the use of the EFI_LOADER_DATA
> > >>> memory type for this table. The correct memory type to use for any
> > >>> firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
> > >>> EFI stub), even though the name suggests that is it specific to ACPI.
> > >>> ACPI reclaim means that the memory is used by the firmware to expose
> > >>> information to the operating system, but that the memory region has no
> > >>> special significance to the firmware itself, and the OS is free to
> > >>> reclaim the memory and use it as ordinary memory if it is not interested
> > >>> in the contents, or if it has already consumed them. In Linux, this
> > >>> memory is never reclaimed, but it is always covered by the kernel direct
> > >>> map and generally made accessible as ordinary memory.
> > >>>
> > >>> On x86, ACPI reclaim memory is translated into E820_ACPI, which the
> > >>> kexec logic already recognizes as memory that the crashkernel may need
> > >>> to to access, and so it will be mapped and accessible to the booting
> > >>> crash kernel.
> > >>>
> > >>> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >>> ---
> > >>>    drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> > >>> index ca61f4733ea58693..9a655f30ba47db01 100644
> > >>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> > >>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> > >>> @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> > >>>     bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
> > >>>                                EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
> > >>> -   status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > >>> +   status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> > >>
> > >> I bisected an SNP guest crash when using the tip tree to this commit. When
> > >> the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
> > >> unaccepted table is no longer mapped. Here's a copy of the stack trace:
> > >
> > > Could you try this patch:
> > >   https://lore.kernel.org/all/20230917170629.d35gnwb6o54bdrhl@box.shutemov.name
> >
> > Yes, that fixes the issue for me.
> >
>
> Thanks for confirming. I've queued it up already, I will send it out
> later this week.

Tom,

Could you confirm whether or not this is related to loading a crashkernel?

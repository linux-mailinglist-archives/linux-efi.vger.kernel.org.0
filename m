Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7ED7A6557
	for <lists+linux-efi@lfdr.de>; Tue, 19 Sep 2023 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjISNhi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Sep 2023 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNhh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Sep 2023 09:37:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57FF3
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 06:37:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B30C433C7
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695130651;
        bh=r0AmxkR2m82iOulFdTzmwtD5nYs62pLVssV0VGasnqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IssF+98dARh7hIudqvfJ/MfXl65665aNmWznND+gq+uGj2H6fMqpaiEIIlMVsJj4V
         VfqiysRkfUfHJlD1Spd6Q4yYWuw0Z3ZjPllqPCE/LySckmJOwPxXXx6cVf7aN7zx3D
         4SA4bs0CrQQPS3XtLsEhW7eOwj9gNSk4sf7uOz2Fo5leE+WRqXq3gNlv0UXDVG88dY
         ipaOMftg/yx1vIQZkJNKK2GsCkCFYb4BQj6wEof5FczcG+Z9J7FIfmwKhtizJK+3qi
         HHWhM6k1uEgQKg36DXXlT0P8K+avZmgxZjkuKJm2wcfXOURUEm1ZNjIwbTQUtnnbAD
         oriRh9Ee/uFTg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bffc55af02so39932271fa.2
        for <linux-efi@vger.kernel.org>; Tue, 19 Sep 2023 06:37:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzX7xX10nrMv5TOWtDcdkYhyGnNaVtpKLS4kaYxJ1qtT/WetjRG
        0h6eHXqXfk/KhC1NmiUf+FhvKD3If0IoDn2BcJQ=
X-Google-Smtp-Source: AGHT+IHYX/iSDBJW6u573Iyg6u4Jr+2j3RdzGYafJHKobXiR7z+OL8vS3tJMvQlrNFiP+R9NexylnjuoB+pxumcOc8g=
X-Received: by 2002:a2e:968b:0:b0:2bd:16e6:f07c with SMTP id
 q11-20020a2e968b000000b002bd16e6f07cmr10612846lji.17.1695130649716; Tue, 19
 Sep 2023 06:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <b3b32a74-553a-a175-47ea-3233bb59c5f4@amd.com>
 <20230918221054.nugkvobvfo6islsb@box.shutemov.name> <fd3f7247-093e-37ad-36d5-58c7e0d92a5f@amd.com>
In-Reply-To: <fd3f7247-093e-37ad-36d5-58c7e0d92a5f@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Sep 2023 15:37:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH9LvNMKRjtefxL=jZLXiD1mc9WhB83s21y_GsfpJhOLw@mail.gmail.com>
Message-ID: <CAMj1kXH9LvNMKRjtefxL=jZLXiD1mc9WhB83s21y_GsfpJhOLw@mail.gmail.com>
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

On Tue, 19 Sept 2023 at 15:28, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 9/18/23 17:10, Kirill A . Shutemov wrote:
> > On Mon, Sep 18, 2023 at 05:03:59PM -0500, Tom Lendacky wrote:
> >> On 8/16/23 14:05, Ard Biesheuvel wrote:
> >>> Kyril reports that crashkernels fail to work on confidential VMs that
> >>> rely on the unaccepted memory table, and this appears to be caused by
> >>> the fact that it is not considered part of the set of firmware tables
> >>> that the crashkernel needs to map.
> >>>
> >>> This is an oversight, and a result of the use of the EFI_LOADER_DATA
> >>> memory type for this table. The correct memory type to use for any
> >>> firmware table is EFI_ACPI_RECLAIM_MEMORY (including ones created by the
> >>> EFI stub), even though the name suggests that is it specific to ACPI.
> >>> ACPI reclaim means that the memory is used by the firmware to expose
> >>> information to the operating system, but that the memory region has no
> >>> special significance to the firmware itself, and the OS is free to
> >>> reclaim the memory and use it as ordinary memory if it is not interested
> >>> in the contents, or if it has already consumed them. In Linux, this
> >>> memory is never reclaimed, but it is always covered by the kernel direct
> >>> map and generally made accessible as ordinary memory.
> >>>
> >>> On x86, ACPI reclaim memory is translated into E820_ACPI, which the
> >>> kexec logic already recognizes as memory that the crashkernel may need
> >>> to to access, and so it will be mapped and accessible to the booting
> >>> crash kernel.
> >>>
> >>> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>    drivers/firmware/efi/libstub/unaccepted_memory.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> >>> index ca61f4733ea58693..9a655f30ba47db01 100644
> >>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> >>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> >>> @@ -62,7 +62,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
> >>>     bitmap_size = DIV_ROUND_UP(unaccepted_end - unaccepted_start,
> >>>                                EFI_UNACCEPTED_UNIT_SIZE * BITS_PER_BYTE);
> >>> -   status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> >>> +   status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> >>
> >> I bisected an SNP guest crash when using the tip tree to this commit. When
> >> the kernel switches over to the swapper_pg_dir in init_mem_mapping(), the
> >> unaccepted table is no longer mapped. Here's a copy of the stack trace:
> >
> > Could you try this patch:
> >   https://lore.kernel.org/all/20230917170629.d35gnwb6o54bdrhl@box.shutemov.name
>
> Yes, that fixes the issue for me.
>

Thanks for confirming. I've queued it up already, I will send it out
later this week.

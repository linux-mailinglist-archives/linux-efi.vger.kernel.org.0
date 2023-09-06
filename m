Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F87937DB
	for <lists+linux-efi@lfdr.de>; Wed,  6 Sep 2023 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjIFJR3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Sep 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjIFJR3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Sep 2023 05:17:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD316CE2
        for <linux-efi@vger.kernel.org>; Wed,  6 Sep 2023 02:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7012FC433C8
        for <linux-efi@vger.kernel.org>; Wed,  6 Sep 2023 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693991845;
        bh=hsAt3zt1moW5fuC0YMBIsM0lvnrcdFAmLTGRMUka1OI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mG5Ko7h5ZtTSQ1N/84HmexU5G4wPrhn34Uu3PLJL0WRhXAsi8zANc7aXLtUdOTYUd
         EHF50gENxiKHP8+syjk7YHwD7kwylIHlZ9NRFcVb+eDoc5ekvAE+wi27y1IWDHNY6c
         RfUtaI0gYZfZLMjFs3FS0LuhPu8ONAzso1NOqSaNhdMFnJapDtsrePZ2FjAk7MubPz
         yQnU2aZczFeHKc0TOQp85E9ESWn2jivLM6FAnqGDFq+R5TY1ITy7J9s6llrABubeYv
         qAKf2LHLBOQFvuZzJs7PZ77g0Dzn/+SiOuXSEqbqOQY9o8vGml0BSVt42rkuXs4Oqv
         RFYIt7rEGpLHw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso5361739e87.0
        for <linux-efi@vger.kernel.org>; Wed, 06 Sep 2023 02:17:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIhEVDS26U0BQQSyz5M9nyKscJ54LhrURh1Tck05HmxWFfpnnS
        TRH/ULxkfDnFAgd/Xt4aNuaYQN4FNrAEX9ocODI=
X-Google-Smtp-Source: AGHT+IFAOZ7LA12dZVOeW1uQWQlrV8z4tO2kgSe3H86yulfv/gICByEWaa3/K5YDMmMgCm3IjRJ+Des6043vt5I+yVs=
X-Received: by 2002:a05:6512:613:b0:500:ba5d:e750 with SMTP id
 b19-20020a056512061300b00500ba5de750mr1584817lfe.52.1693991843407; Wed, 06
 Sep 2023 02:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190557.3738-1-ardb@kernel.org> <20230816212418.25069-1-kirill.shutemov@linux.intel.com>
 <CAMj1kXHQh7HEuZMiJ5zQtVre1vY+Q1xAHfQSDh1-WibAL02mXA@mail.gmail.com> <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
In-Reply-To: <20230818151628.d7srn5k73vms7dcf@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Sep 2023 11:17:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
Message-ID: <CAMj1kXHrqaB7GbXuT5O6DOeOLBv+DX_8+wKNK8oh7a9U814YGg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, linux-efi@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Aug 2023 at 17:16, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 10:25:56PM +0200, Ard Biesheuvel wrote:
> > On Wed, 16 Aug 2023 at 23:24, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
> > > things, guides where direct mapping ends. Any memory above max_pfn is
> > > not going to be present in the direct mapping.
> > >
> > > e820__end_of_ram_pfn() finds the end of the ram based on the highest
> > > E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
> > > calculation.
> > >
> > > Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
> > > tables and might be required by kernel to function properly.
> > >
> > > Usually the problem is hidden because there is some E820_TYPE_RAM memory
> > > above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
> > > memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
> > > can fit under the last E820_TYPE_ACPI range.
> > >
> > > Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
> > > E820_TYPE_ACPI memory.
> > >
> > > The problem was discovered during debugging kexec for TDX guest. TDX
> > > guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
> > > it between the kernels on kexec.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >
> > No objections to this, but we might also simply drop E820_TYPE_ACPI
> > altogether: it is only used for EFI_ACPI_RECLAIM_MEMORY, which is
> > memory that can be used by the OS as ordinary RAM if it is not
> > interested in the contents (or has already consumed them). So this
> > could arguably be classified as E820_TYPE_RAM too.
>
> Hm. I'm not sure about this. E820_TYPE_ACPI also get tracked as
> IORES_DESC_ACPI_TABLES resource and get passed to the next kernel on
> kexec, regardless if it is crash kernel or not. I'm not sure we would not
> break anything.
>

Yeah, you're right. So this patch is necessary in any case.

Do we also need the EFI side patch then?

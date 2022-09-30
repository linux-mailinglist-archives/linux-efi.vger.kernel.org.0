Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34D5F1007
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiI3Qbc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiI3QbQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 12:31:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149015AB54;
        Fri, 30 Sep 2022 09:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83064B8297A;
        Fri, 30 Sep 2022 16:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFB7C43142;
        Fri, 30 Sep 2022 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664555470;
        bh=942mhlsPgXt/goX0aW+X613nTk5Qs5Pp3COTvOdUwZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQaItIyYxi0HLaL4oqDkDYh05o8FbZWsbNU2Y0NT8kfZub1XP2IlO80nVvphwfoss
         Gj/++qo/ntHKK12oR+56pq5jRBesGpWCKimqBXV8vwP9toEB8f0gCD38Es5z/EU7VT
         VsqktOXdiERPDC+Vii8DyivL3vp4liDmw58t3AvpGteE+STVh8QvyYD1SXoaoPUTAB
         Fu50V06BvneE1AOB9NyhkkhHe3/KhprXgrGip/9zei+PqUoLPuLy7E+fmvvnGtPaun
         2I+F1ZtSPJ7krbco6i4pnvW/YoXrVynpr0OLtnnO+B4XC40hn8SKW9Iq797zMlxH3b
         Yd/7X7L1ncJRw==
Received: by mail-lf1-f54.google.com with SMTP id z4so7683992lft.2;
        Fri, 30 Sep 2022 09:31:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf28I8JSTfqpK/hFKNkmk8MqO44pSsMZjRazo5XogBKVGtI5b0wa
        MedJzy8Oj3+/YTRxjJqUwzthVz+138AR320jU44=
X-Google-Smtp-Source: AMsMyM7t5cQJ9hJx6xjrAJTWEfjKbUDevZQY6USEnBYzXwQs0wF27IzFulILlj/o9uw7ykYh3FpqgxTj+d47/dk/PFQ=
X-Received: by 2002:a05:6512:3691:b0:4a1:f82a:9067 with SMTP id
 d17-20020a056512369100b004a1f82a9067mr3981182lfs.110.1664555468264; Fri, 30
 Sep 2022 09:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <f3b624e99adfdbbfc1976a60a73a6b5950e1840d.1664298147.git.demi@invisiblethingslab.com>
 <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
In-Reply-To: <282a225d-8782-0321-6f0e-19dd4510dc42@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Sep 2022 18:30:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
Message-ID: <CAMj1kXFQNqsW5RfHGac-eGbosJHBybu6+-Fap_bi_kVxWNpGeg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 30 Sept 2022 at 08:44, Jan Beulich <jbeulich@suse.com> wrote:
>
> On 30.09.2022 01:02, Demi Marie Obenour wrote:
> > Memory of type EFI_CONVENTIONAL_MEMORY, EFI_LOADER_CODE, EFI_LOADER_DATA,
> > EFI_BOOT_SERVICES_CODE, and EFI_BOOT_SERVICES_DATA may be clobbered by
> > Xen before Linux gets to start using it.  Therefore, Linux under Xen
> > must not use EFI tables from such memory.  Most of the remaining EFI
> > memory types are not suitable for EFI tables, leaving only
> > EFI_ACPI_RECLAIM_MEMORY, EFI_RUNTIME_SERVICES_DATA, and
> > EFI_RUNTIME_SERVICES_CODE.  When running under Xen, Linux should only
> > use tables that are located in one of these types of memory.
> >
> > This patch ensures this, and also adds a function
> > (xen_config_table_memory_region_max()) that will be used later to
> > replace the usage of the EFI memory map in esrt.c when running under
> > Xen.  This function can also be used in mokvar-table.c and efi-bgrt.c,
> > but I have not implemented this.
> >
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
>
> In Xen we don't clobber EfiBootServices{Code,Data} when xen.efi was passed
> "-mapbs". Should we perhaps extend the interface such that Dom0 can then
> also use tables located in such regions, perhaps by faking
> EFI_MEMORY_RUNTIME in the attributes returned by XEN_FW_EFI_MEM_INFO?
>

I know this ship has sailed for x86, but for the sake of other
architectures, I'd strongly recommend leaving the EFI_MEMORY_RUNTIME
bits alone, for the same reasons I gave earlier. (Runtime mappings for
the firmware code itself, page table fragmentation etc etc)

I know very little about Xen, but based on the context you provided in
this thread, I'd say that the best approach from the Xen side is to
convert all EfiBootServicesData regions that have configuration tables
pointing into them into EfiAcpiReclaimMemory.

I take it XEN_FW_EFI_MEM_INFO is an existing interface? If so, you
might do the same for the returned type - EfiBootServicesData ->
EfiAcpiReclaimMemory, and not muck about with the EFI_MEMORY_RUNTIME
attribute.

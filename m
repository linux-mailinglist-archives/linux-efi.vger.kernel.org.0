Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6F5F6B67
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJFQT4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiJFQTw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 12:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47BA440;
        Thu,  6 Oct 2022 09:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DF7561A25;
        Thu,  6 Oct 2022 16:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B92C43470;
        Thu,  6 Oct 2022 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665073189;
        bh=Pld45Z4CvZ++lrOaJAma6PphMOkb0rHF45RNmYeXg10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UldnsAG4GNAIf3bSaBgda3uTevViDMdSSwclyZxwkqmgQnRVyLusdJP9LFmQjQgPL
         6dc2ARIw+4qhmVft10VEiQxS4WjjjpS7eEdNFITa2Y6weVWFQlwfltXCOjB5Kx/X2D
         lNCiuw7/chMSMBwwCq+u8niyobby8oFZDrFVytzozRs2abSVgosb+OAmKyke28YcFF
         S/hQ8y6GdVTIkkj9pEuuUsSbei47zrqjuab0cZohdZJyVU9QpAWJihH8FJXDc4z8+D
         5YQLd5f8HOyxE8/tgmNcxoN8SeberFpSx9nWGH5SEg7UN+Rgca1fyH/dCzviVQ1nqd
         Sc2XcdsSjVHjA==
Received: by mail-lf1-f48.google.com with SMTP id g1so3433925lfu.12;
        Thu, 06 Oct 2022 09:19:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf2iEmW3FcbOhksFQvwkvmpODRunECi9rU/gD5sp8X7otIgh8VFC
        fKmAKWJVQ/7hv1KomfdWKB8SLoActW1+GYIPhUk=
X-Google-Smtp-Source: AMsMyM45oIBVZ07KF4ltMC+pidQt3Gbgah5PxR0JOD8znHmV8tQ+3YrjKDTYs/dwhYptFQFjBeeEIiXK8BPuXFstRGo=
X-Received: by 2002:ac2:4d1c:0:b0:4a2:4119:f647 with SMTP id
 r28-20020ac24d1c000000b004a24119f647mr270568lfi.426.1665073187373; Thu, 06
 Oct 2022 09:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <YzcjeiOW8+i2Zxsd@itl-email> <CAMj1kXHBBbCNV3CLesqZi7ttmmi8y4tZ1KO5vievy_CJrU2o3Q@mail.gmail.com>
 <YzeaKjmls1YI/3ox@itl-email> <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email> <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
 <Yz3I2qwl243h9ZfZ@itl-email> <CAMj1kXHFi71SKQAQHEjZTLyp-YooRTYZ2-nqydRZA5hys7tkKw@mail.gmail.com>
 <Yz4yLyvX6un1rrqC@itl-email> <CAMj1kXFO9_yMw=_Fn2DBGgdYXgiK_OqafG5+TbJv1UKO1uQiJQ@mail.gmail.com>
 <Yz7polT2R2OlT1aT@itl-email>
In-Reply-To: <Yz7polT2R2OlT1aT@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 18:19:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGe77iwnYXWR=Hjn8eL8-1hMZbprjU8bnYaFWJnRZfdfw@mail.gmail.com>
Message-ID: <CAMj1kXGe77iwnYXWR=Hjn8eL8-1hMZbprjU8bnYaFWJnRZfdfw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Oct 2022 at 16:43, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Thu, Oct 06, 2022 at 09:31:47AM +0200, Ard Biesheuvel wrote:
> > On Thu, 6 Oct 2022 at 03:41, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > On Wed, Oct 05, 2022 at 11:28:29PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 5 Oct 2022 at 20:11, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
> > > > > > On 04.10.2022 17:46, Demi Marie Obenour wrote:
> > > > > > > Linux has a function called efi_mem_reserve() that is used to reserve
> > > > > > > EfiBootServicesData memory that contains e.g. EFI configuration tables.
> > > > > > > This function does not work under Xen because Xen could have already
> > > > > > > clobbered the memory.  efi_mem_reserve() not working is the whole reason
> > > > > > > for this thread, as it prevents EFI tables that are in
> > > > > > > EfiBootServicesData from being used under Xen.
> > > > > > >
> > > > > > > A much nicer approach would be for Xen to reserve boot services memory
> > > > > > > unconditionally, but provide a hypercall that dom0 could used to free
> > > > > > > the parts of EfiBootServicesData memory that are no longer needed.  This
> > > > > > > would allow efi_mem_reserve() to work normally.
> > > > > >
> > > > > > efi_mem_reserve() actually working would be a layering violation;
> > > > > > controlling the EFI memory map is entirely Xen's job.
> > > > >
> > > > > Doing this properly would require Xen to understand all of the EFI
> > > > > tables that could validly be in EfiBootServices* and which could be of
> > > > > interest to dom0.  It might (at least on some very buggy firmware)
> > > > > require a partial ACPI and/or SMBIOS implementation too, if the firmware
> > > > > decided to put an ACPI or SMBIOS table in EfiBootServices*.
> > > > >
> > > > > > As to the hypercall you suggest - I wouldn't mind its addition, but only
> > > > > > for the case when -mapbs is used. As I've indicated before, I'm of the
> > > > > > opinion that default behavior should be matching the intentions of the
> > > > > > spec, and the intention of EfiBootServices* is for the space to be
> > > > > > reclaimed. Plus I'm sure you realize there's a caveat with Dom0 using
> > > > > > that hypercall: It might use it for regions where data lives which it
> > > > > > wouldn't care about itself, but which an eventual kexec-ed (or alike)
> > > > > > entity would later want to consume. Code/data potentially usable by
> > > > > > _anyone_ between two resets of the system cannot legitimately be freed
> > > > > > (and hence imo is wrong to live in EfiBootServices* regions).
> > > > >
> > > > > I agree, but currently some such data *is* in EfiBootServices* regions,
> > > > > sadly.  When -mapbs is *not* used, I recommend uninstalling all of the
> > > > > configuration tables that point to EfiBootServicesData memory before
> > > > > freeing that memory.
> > > > >
> > > >
> > > > That seems like a reasonable approach to me. Tables like MEMATTR or
> > > > RT_PROP are mostly relevant for bare metal where the host kernel maps
> > > > the runtime services, and in general, passing on these tables without
> > > > knowing what they do is kind of fishy anyway. You might even argue
> > > > that only known table types should be forwarded in the first place,
> > > > regardless of the memory type.
> > >
> > > Which tables are worth handling in Xen?  I know about ACPI, SMBIOS, and
> > > ESRT, but I am curious which others Xen should preserve.  Currently, Xen
> > > does not know about RT_PROP or MEMATTR; could this be a cause of
> > > problems?
> >
> > dom0 only has access to paravirtualized EFI runtime services, so
> > consuming RT_PROP or MEMATTR should be up to Xen (they describe which
> > runtime services remain available at runtime, and which permission
> > attributes to use for the runtime services memory regions,
> > respectively)
>
> Xen does not do this right now.  I wonder if this could be the cause of
> compatibility issues with various firmware implementations.
>
> > Looking through the kernel code, I don't think there are any that dom0
> > should care about beyond ACPI, SMBIOS and ESRT. But as you suggest,
> > that means Xen should just mask them in the view of the EFI system
> > table it exposes so dom0. Otherwise, the kernel may still try to map
> > and parse them.
>
> What about the BGRT and MOKvar?  I agree that Xen should not expose the
> others.  Should it just hide the tables, or should it actually uninstall
> them?  My intuition is that the second would be technically more
> correct, but also more likely to trigger bugs in various firmware
> implementations.

BGRT is a ACPI table not a EFI configuration table, so I'd assume it
is treated the same way as other ACPI tables

MOKvar is a fallback for systems where it doesn't fit into a volatile
variable IIRC but I am not sure if it is actually implemented
anywhere, and what type of memory region it is expected to use.

However, I'm not sure if it even matters, given that Xen loads the
dom0 kernel not the firmware, right?

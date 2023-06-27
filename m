Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4C73F787
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jun 2023 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjF0Iiq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jun 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjF0Iib (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jun 2023 04:38:31 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C332D73
        for <linux-efi@vger.kernel.org>; Tue, 27 Jun 2023 01:37:48 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id DBB7240A40; Tue, 27 Jun 2023 09:37:46 +0100 (BST)
Date:   Tue, 27 Jun 2023 09:37:46 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>,
        Glenn Washburn <development@efficientek.com>
Subject: Re: [PATCH] efi/libstub: Disable PCI DMA before grabbing the EFI
 memory map
Message-ID: <20230627083746.GA21374@srcf.ucam.org>
References: <20230627074132.1016795-1-ardb@kernel.org>
 <20230627080039.GA20512@srcf.ucam.org>
 <CAMj1kXF7g92VqnjWwbp0Y9hKXfMc2iZSmvtT2B6ZEHQ3c478bA@mail.gmail.com>
 <20230627081706.GA20814@srcf.ucam.org>
 <CAMj1kXEO6x_UcwtGE774h04kXKDYn_m34V9tNTQd0oWxw-UR0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEO6x_UcwtGE774h04kXKDYn_m34V9tNTQd0oWxw-UR0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 27, 2023 at 10:32:36AM +0200, Ard Biesheuvel wrote:
> On Tue, 27 Jun 2023 at 10:17, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > On Tue, Jun 27, 2023 at 10:14:16AM +0200, Ard Biesheuvel wrote:
> >
> > > Not quite. It should only fail the first time if the memory map
> > > changed since the last call to GetMemoryMap(), and normally, this will
> > > only happen if some kind of asynchronous event was triggered after
> > > GetMemoryMap() but before ExitBootServices(). (This is why calling
> > > ExitBootServices() at most twice should always suffice: the first call
> > > disables the timer interrupt, so the second time around, no events
> > > will fire in the mean time)
> >
> > Can't driver shutdown code also end up altering it?
> 
> Yes, but doing so violates the UEFI spec:
> EVT_SIGNAL_EXIT_BOOT_SERVICES is documented as not permitting the use
> of memory allocation services, either directly or indirectly (via the
> use of other external code that might use them)

Maybe people have become better at observing that restriction! Anyway, 
feel free to ignore my nit in that case.

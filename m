Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27609626BC4
	for <lists+linux-efi@lfdr.de>; Sat, 12 Nov 2022 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiKLVKC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Nov 2022 16:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLVKB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 12 Nov 2022 16:10:01 -0500
Received: from mailsrv.ikr.uni-stuttgart.de (mailsrv.ikr.uni-stuttgart.de [129.69.170.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFE101E
        for <linux-efi@vger.kernel.org>; Sat, 12 Nov 2022 13:10:00 -0800 (PST)
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1-c [10.11.12.12])
        by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id 6FCDEF9B328;
        Sat, 12 Nov 2022 22:09:56 +0100 (CET)
Received: from ikr.uni-stuttgart.de (ingress2-c [10.11.14.11])
        by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id 1316DF9B327;
        Sat, 12 Nov 2022 22:09:55 +0100 (CET)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Sat, 12 Nov 2022 22:09:54 +0100
From:   Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To:     Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Regression in Linux 6.0.8 in Lenovo T14 Gen 3 when adding EFI boot entries
Date:   Sat, 12 Nov 2022 22:09:54 +0100
User-Agent: KMail/1.9.10
References: <202211121437.39938.ulrich.gemkow@ikr.uni-stuttgart.de> <202211121755.13372.ulrich.gemkow@ikr.uni-stuttgart.de> <CAMj1kXGJGW9Bt3MWcxQVsPnWWm2HQRo_T=atjwvt8zoaQfp5fQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGJGW9Bt3MWcxQVsPnWWm2HQRo_T=atjwvt8zoaQfp5fQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
Cc:     linux-efi@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202211122209.54371.ulrich.gemkow@ikr.uni-stuttgart.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hallo Ard,

On Saturday 12 November 2022, you wrote:
> On Sat, 12 Nov 2022 at 17:55, Ulrich Gemkow
> <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> >
> > Hello Ard,
> >
> > On Saturday 12 November 2022, you wrote:
> > > On Sat, 12 Nov 2022 at 16:26, Ulrich Gemkow
> > > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > > >
> > > > Hello Ard,
> > > >
> > > > thanks for looking into this!
> > > >
> > > > On Saturday 12 November 2022, you wrote:
> > > > > On Sat, 12 Nov 2022 at 14:42, Ulrich Gemkow
> > > > > <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > calling efibootmgr for adding EFI boot entries with Linux 6.0.8 does
> > > > > > not work on our Lenovo T14 Gen 3 (intel). The error is "EFI variables
> > > > > > are not supported on this system". The directory /sys/firmware/efi/efivars/
> > > > > > exists but is empty.
> > > > > >
> > > > > > This worked fine with the latest 5.19 kernel. The config was transferred
> > > > > > from 5.19 to 6.0 with "make oldconfig". All kernels are self-compiled
> > > > > > and without changes from the kernel.org downloads.
> > > > > >
> > > > > > I saw earlier messages about bugs in this area, the fixes applied
> > > > > > seem to be not complete.
> > > > > >
> > > > > > Please let me know when additional information would help to debug.
> > > > > >
> > > > >
> > > > > Hello Ulrich,
> > > > >
> > > > > Can you please share the complete kernel boot log when booting with
> > > > > efi=debug, and the .config used to build the kernel? Thanks.
> > > > >
> > > >
> > > > please find attached the two files. Please do not get confused about
> > > > the kernel uname, the used kernel is 6.0.8. I use my own automated
> > > > setup and build environment which requires a different naming.
> > > >
> > >
> > > Does it work if you enable CONFIG_EFI_STUB?
> > >
> >
> > Enabling CONFIG_EFI_STUB does not help, the problem remains.
> >
> > I digged around and found that mounting the efivarfs solves the
> > problem. This was not required with 5.19. Is this an expected
> > or wanted change of behavior?
> >
> 
> That is surprising. It is entirely up to user space whether and when
> efivarfs gets mounted - the kernel just provides the facilities but
> does not decide if they get used.
> 
> Which distro are you using?

In principle this is Debian 11 but the whole base (init, kernel, ...)
is self-made. So the distro is maybe not really relevant.

I understand the problem as follows: With 5.19 mounting the efivarfs was
not required to change EFI boot entries. In 6.0 it seems to be required
for efibootmgr to change boot entries.

I created a standard Debian 11 install and efivarfs is mounted. So maybe
in current distros the efivarfs is normally mounted.

So while the changed behavior is formally a regression it may not be relevant
because most users of todays distros may not notice the change because of
the always mounted efivarfs. I cannot judge whether this is relevant.

Thanks again for your efforts and Best regards

Ulrich

-- 
Ulrich Gemkow
University of Stuttgart
Institute of Communication Networks and Computer Engineering (IKR)

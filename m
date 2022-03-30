Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D804EC4DE
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbiC3MtP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbiC3Msc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 08:48:32 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766ACDE0BF;
        Wed, 30 Mar 2022 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648644405;
        bh=KAfrZgKEul9aSsbZ36kPU6Tj18oRXB0dM4HC3xvmmXw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nn8AAgM02CcbhIpBEc+LRzvcURan3/dQ3hkEigyO4ktwhNb3MknZmgEA8v2ISWf66
         eMqota5PANQaFP/P2ctxTAmBUX9sLJc1dq/gRo/1HQUgIMF279FtC6TlvXRsw0DFby
         WoqCIRieFcgtb4AgBtxbYQp5x+DKFfwU8NjJNOfI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 55C651288359;
        Wed, 30 Mar 2022 08:46:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nDP9QrI8rjHM; Wed, 30 Mar 2022 08:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648644405;
        bh=KAfrZgKEul9aSsbZ36kPU6Tj18oRXB0dM4HC3xvmmXw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nn8AAgM02CcbhIpBEc+LRzvcURan3/dQ3hkEigyO4ktwhNb3MknZmgEA8v2ISWf66
         eMqota5PANQaFP/P2ctxTAmBUX9sLJc1dq/gRo/1HQUgIMF279FtC6TlvXRsw0DFby
         WoqCIRieFcgtb4AgBtxbYQp5x+DKFfwU8NjJNOfI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A54551288358;
        Wed, 30 Mar 2022 08:46:43 -0400 (EDT)
Message-ID: <41521e8ecd2876327cd8dd929b32aa3b7e9daca8.camel@HansenPartnership.com>
Subject: Re: Linux DRTM on UEFI platforms
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Kees Cook <keescook@chromium.org>
Date:   Wed, 30 Mar 2022 08:46:41 -0400
In-Reply-To: <CAMj1kXHJxmdLie1JE=k3O4zne8tHED7g63rj42q-sL_JQUpvNw@mail.gmail.com>
References: <20220329174057.GA17778@srcf.ucam.org>
         <CAMj1kXE-7yPTBgQQKXRnQbdvLMv6D7=CowtQ38PdpPVa3SW-Ag@mail.gmail.com>
         <20220330071103.GA809@srcf.ucam.org>
         <CAMj1kXE9WrBOUG6MRQ90cMH_NvvCw_jVCar5Dsj+gkZr1AA0MQ@mail.gmail.com>
         <20220330071859.GA992@srcf.ucam.org>
         <CAMj1kXHfw75GphiewQzbA-swsMD3AGunyhc9HSue_xqrHt9GhQ@mail.gmail.com>
         <20220330072755.GA1169@srcf.ucam.org>
         <CAMj1kXHJxmdLie1JE=k3O4zne8tHED7g63rj42q-sL_JQUpvNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-03-30 at 09:39 +0200, Ard Biesheuvel wrote:
> On Wed, 30 Mar 2022 at 09:27, Matthew Garrett <mjg59@srcf.ucam.org>
> wrote:
> > On Wed, Mar 30, 2022 at 09:23:17AM +0200, Ard Biesheuvel wrote:
> > > On Wed, 30 Mar 2022 at 09:19, Matthew Garrett <
> > > mjg59@srcf.ucam.org> wrote:
> > > > From a conceptual perspective we've thought of the EFI stub as
> > > > being logically part of the bootloader rather than the early
> > > > kernel, and the bootloader is a point where the line is drawn.
> > > > My guy feeling is that jumping into the secure kernel
> > > > environment before EBS has been called is likely to end badly.
> > > 
> > > If you jump back into the system firmware, sure.
> > > 
> > > But the point I was trying to make is that you can replace that
> > > with your own minimal implementation of EFI that just exposes a
> > > memory map and some protocols and nothing else, and then the
> > > secure launch kernel would be entirely in charge of the execution
> > > environment.
> > 
> > We can't just replace system firmware with an imitation of the same
> > - for instance, configuring the cold boot prevention memory
> > overwrite requires us to pass a variable through to the real
> > firmware, and that's something that we do in the stub.
> > 
> 
> But these are exactly the kinds of things the secure launch kernel
> wants to be made aware of, no? The secure launch kernel could just
> MITM the calls that it chooses to allow, and serve other calls
> itself.

The problem would become that the MITM firmware has to be evolved in
lockstep with the boot stub.  The problem isn't really a point in time,
figure out what config the boot stub extracts from EFI now and measure
it, it's an ongoing one: given an evolving kernel and UEFI subsystem
means that over time what configuration the kernel extracts from EFI
changes, how do we make sure it's all correctly measured before secure
launch?

If the MITM doesn't support a capability a newer kernel acquires, that
MITM must fail secure launch ... which becomes a nightmare for the
user.

One possibility might be that the MITM actually does nothing at all
except record Boot Service requests and responses up to exit boot
services (EBS).  We could call that record the boot configuration and
measure it, plus we could then intercept EBS, and do the DRTM secure
launch to the return point.  It's conceptually similar Matthew's idea
of a callback except it won't require modification of the boot
parameters.

James



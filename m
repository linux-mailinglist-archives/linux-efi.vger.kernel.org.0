Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA24A6CE3
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiBBIZS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiBBIZR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:25:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B7C061714;
        Wed,  2 Feb 2022 00:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5392B8302E;
        Wed,  2 Feb 2022 08:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF9C340EC;
        Wed,  2 Feb 2022 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643790313;
        bh=4q6q3iHhl8AMzcgm69qjAxOanc/whgNSTPJ78AIutWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIOfWJFr6miaUIIklgbMjhXDGeYaX9aY382BbldQohTE6cdC3pB7AoOz+8SniwnUK
         Y9JNGdK73XWnCQROBLp0oC1Rns7ZmBRsNneJWLFFjh3jj8amQDPJSmnyGSLZieKSXa
         9pTcUtXRqddWQdGFXWyM4To8wWv8InsanJdv43h8=
Date:   Wed, 2 Feb 2022 09:25:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>, dougmill@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@ibm.com,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <Yfo/5gYgb9Sv24YB@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
 <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org>
 <YfotMyQiQ66xfCOQ@kroah.com>
 <20220202071023.GA9489@srcf.ucam.org>
 <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
 <20220202080401.GA9861@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202080401.GA9861@srcf.ucam.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 08:04:01AM +0000, Matthew Garrett wrote:
> On Wed, Feb 02, 2022 at 08:22:03AM +0100, Ard Biesheuvel wrote:
> > On Wed, 2 Feb 2022 at 08:10, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > Which other examples are you thinking of? I think this conversation may
> > > have accidentally become conflated with a different prior one and now
> > > we're talking at cross purposes.
> > 
> > This came up a while ago during review of one of the earlier revisions
> > of this patch set.
> > 
> > https://lore.kernel.org/linux-efi/YRZuIIVIzMfgjtEl@google.com/
> > 
> > which describes another two variations on the theme, for pKVM guests
> > as well as Android bare metal.
> 
> Oh, I see! That makes much more sense - sorry, I wasn't Cc:ed on that, 
> so thought this was related to the efivars/Power secure boot. My 
> apologies, sorry for the noise. In that case, given the apparent 
> agreement between the patch owners that a consistent interface would 
> work for them, I think I agree with Greg that we should strive for that. 
> Given the described behaviour of the Google implementation, it feels 
> like the semantics in this implementation would be sufficient for them 
> as well, but having confirmation of that would be helpful.
> 
> On the other hand, I also agree that a new filesystem for this is 
> overkill. I did that for efivarfs and I think the primary lesson from 
> that is that people who aren't familiar with the vfs shouldn't be 
> writing filesystems. Securityfs seems entirely reasonable, and it's 
> consistent with other cases where we expose firmware-provided data 
> that's security relevant.
> 
> The only thing I personally struggle with here is whether "coco" is the 
> best name for it, and whether there are reasonable use cases that 
> wouldn't be directly related to confidential computing (eg, if the 
> firmware on a bare-metal platform had a mechanism for exposing secrets 
> to the OS based on some specific platform security state, it would seem 
> reasonable to expose it via this mechanism but it may not be what we'd 
> normally think of as Confidential Computing).
> 
> But I'd also say that while we only have one implementation currently 
> sending patches, it's fine for the code to live in that implementation 
> and then be abstracted out once we have another.

Well right now the Android code looks the cleanest and should be about
ready to be merged into my tree.

But I can almost guarantee that that interface is not what anyone else
wants to use, so if you think somehow that everyone else is going to
want to deal with a char device node and a simple mmap, with a DT
description of the thing, hey, I'm all for it :)

Seriously, people need to come up with something sane or this is going
to be a total mess.

thanks,

greg k-h

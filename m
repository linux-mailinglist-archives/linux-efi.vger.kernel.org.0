Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9764A6C97
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiBBIEE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:04:04 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:50648 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBBIED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:04:03 -0500
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id A3FF540A51; Wed,  2 Feb 2022 08:04:01 +0000 (GMT)
Date:   Wed, 2 Feb 2022 08:04:01 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20220202080401.GA9861@srcf.ucam.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
 <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org>
 <YfotMyQiQ66xfCOQ@kroah.com>
 <20220202071023.GA9489@srcf.ucam.org>
 <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 08:22:03AM +0100, Ard Biesheuvel wrote:
> On Wed, 2 Feb 2022 at 08:10, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > Which other examples are you thinking of? I think this conversation may
> > have accidentally become conflated with a different prior one and now
> > we're talking at cross purposes.
> 
> This came up a while ago during review of one of the earlier revisions
> of this patch set.
> 
> https://lore.kernel.org/linux-efi/YRZuIIVIzMfgjtEl@google.com/
> 
> which describes another two variations on the theme, for pKVM guests
> as well as Android bare metal.

Oh, I see! That makes much more sense - sorry, I wasn't Cc:ed on that, 
so thought this was related to the efivars/Power secure boot. My 
apologies, sorry for the noise. In that case, given the apparent 
agreement between the patch owners that a consistent interface would 
work for them, I think I agree with Greg that we should strive for that. 
Given the described behaviour of the Google implementation, it feels 
like the semantics in this implementation would be sufficient for them 
as well, but having confirmation of that would be helpful.

On the other hand, I also agree that a new filesystem for this is 
overkill. I did that for efivarfs and I think the primary lesson from 
that is that people who aren't familiar with the vfs shouldn't be 
writing filesystems. Securityfs seems entirely reasonable, and it's 
consistent with other cases where we expose firmware-provided data 
that's security relevant.

The only thing I personally struggle with here is whether "coco" is the 
best name for it, and whether there are reasonable use cases that 
wouldn't be directly related to confidential computing (eg, if the 
firmware on a bare-metal platform had a mechanism for exposing secrets 
to the OS based on some specific platform security state, it would seem 
reasonable to expose it via this mechanism but it may not be what we'd 
normally think of as Confidential Computing).

But I'd also say that while we only have one implementation currently 
sending patches, it's fine for the code to live in that implementation 
and then be abstracted out once we have another.

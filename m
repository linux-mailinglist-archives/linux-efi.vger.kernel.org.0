Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F04A6D20
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 09:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiBBIph (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 03:45:37 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:50858 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiBBIpg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 03:45:36 -0500
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 8C04C40A51; Wed,  2 Feb 2022 08:45:34 +0000 (GMT)
Date:   Wed, 2 Feb 2022 08:45:34 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20220202084534.GA10247@srcf.ucam.org>
References: <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
 <YfogOurPZb7+Yelo@kroah.com>
 <20220202065443.GA9249@srcf.ucam.org>
 <YfotMyQiQ66xfCOQ@kroah.com>
 <20220202071023.GA9489@srcf.ucam.org>
 <CAMj1kXFTyc9KnMsnvs+mt80DbJL8VGKKcQ0J=4NrGYGSAG8sRw@mail.gmail.com>
 <20220202080401.GA9861@srcf.ucam.org>
 <20220202083653.p3cb4w3qdud4e33t@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202083653.p3cb4w3qdud4e33t@sirius.home.kraxel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 09:36:53AM +0100, Gerd Hoffmann wrote:

> Having a "secrets/" directory looks good to me.  Then the individual
> implementations can either add files to the directory, i.e. efi_secrets
> would create "secrets/<guid>" files.  Or each implementation creates a
> subdirectory with the secrets, i.e. "secrets/coco/" and
> "secrets/coco/<guid>".

I prefer a subdirectory, on the basis that we could conceivably end up 
with more than one implementation on a single device at some point, and 
also because it makes it trivial for userland to determine what the 
source is which may make a semantic difference under certain 
circumstances.
 
> Longer-term (i.e once we have more than one implementation) we probably
> need a separate module which owns and manages the "secrets/" directory,
> and possibly provides some common helper functions too.

Agree.

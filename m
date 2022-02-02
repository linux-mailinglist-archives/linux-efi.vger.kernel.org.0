Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81064A6BF5
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbiBBGzc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 01:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiBBGzO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 01:55:14 -0500
X-Greylist: delayed 10365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Feb 2022 22:54:44 PST
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B9C061398;
        Tue,  1 Feb 2022 22:54:44 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 87B0840A4A; Wed,  2 Feb 2022 06:54:43 +0000 (GMT)
Date:   Wed, 2 Feb 2022 06:54:43 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        dougmill@linux.vnet.ibm.com, gcwilson@linux.ibm.com,
        gjoyce@ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        dja@axtens.net
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <20220202065443.GA9249@srcf.ucam.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
 <YfogOurPZb7+Yelo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfogOurPZb7+Yelo@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 07:10:02AM +0100, Greg KH wrote:
> On Wed, Feb 02, 2022 at 04:01:57AM +0000, Matthew Garrett wrote:
> > We're talking about things that have massively different semantics.
> 
> I see lots of different platforms trying to provide access to their
> "secure" firmware data to userspace in different ways.  That feels to me
> like they are the same thing that userspace would care about in a
> unified way.

EFI variables are largely for the OS to provide information to the 
firmware, while this patchset is to provide information from the 
firmware to the OS. I don't see why we'd expect to use the same userland 
tooling for both.

In the broader case - I don't think we *can* use the same userland
tooling for everything. For example, the patches to add support for 
manipulating the Power secure boot keys originally attempted to make it 
look like efivars, but the underlying firmware semantics are 
sufficiently different that even exposing the same kernel interface 
wouldn't be a sufficient abstraction and userland would still need to 
behave differently. Exposing an interface that looks consistent but 
isn't is arguably worse for userland than exposing explicitly distinct 
interfaces.

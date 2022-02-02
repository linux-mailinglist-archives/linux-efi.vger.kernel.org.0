Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AEF4A6BD0
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiBBGxI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 01:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiBBGwh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 01:52:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB9C061758;
        Tue,  1 Feb 2022 22:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7898B6172A;
        Wed,  2 Feb 2022 06:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2098FC004E1;
        Wed,  2 Feb 2022 06:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643782204;
        bh=o9OIrNJyZoJDYTVkKluL49dvJyVfEvgp3uWhpxsqSmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ld+tSCVMYvFZDbuSb+SfbwOFsGI+9nN9mO4Xs6IEK+rExQGRHD3EcKPX+8kNRKwX/
         7WqbwZzDUrH4ElEfoNwbTPZO6+2veEg1IygbQyrLDAq7iaDX3oLWPzMoMfer+TBUyn
         jOjhBdeAk6RyCCnKbDyYnrMNwmdV4EOuYY4dJyos=
Date:   Wed, 2 Feb 2022 07:10:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
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
Message-ID: <YfogOurPZb7+Yelo@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
 <20220202040157.GA8019@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202040157.GA8019@srcf.ucam.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 02, 2022 at 04:01:57AM +0000, Matthew Garrett wrote:
> On Tue, Feb 01, 2022 at 09:24:50AM -0500, James Bottomley wrote:
> > On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
> > > You all need to work together to come up with a unified place for
> > > this and stop making it platform-specific.
> 
> We're talking about things that have massively different semantics.

I see lots of different platforms trying to provide access to their
"secure" firmware data to userspace in different ways.  That feels to me
like they are the same thing that userspace would care about in a
unified way.

Unless we expeect userspace tools to have to be platform-specific for
all of this?  That does not seem wise.

what am I missing here?

thanks,

greg k-h

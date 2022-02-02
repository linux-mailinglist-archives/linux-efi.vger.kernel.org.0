Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A74A6AD1
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiBBEP5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 23:15:57 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:50118 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiBBEP4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 23:15:56 -0500
X-Greylist: delayed 836 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 23:15:56 EST
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 394B740A4A; Wed,  2 Feb 2022 04:01:57 +0000 (GMT)
Date:   Wed, 2 Feb 2022 04:01:57 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20220202040157.GA8019@srcf.ucam.org>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 09:24:50AM -0500, James Bottomley wrote:
> On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
> > You all need to work together to come up with a unified place for
> > this and stop making it platform-specific.

We're talking about things that have massively different semantics. How 
do we expose that without an unwieldy API that has to try to be a 
superset of everything implemented, which then has to be extended when 
yet another implementation shows up with another behavioural quirk? EFI 
variables already need extremely careful handling to avoid rm -rf /sys 
bricking the system - should we impose that on everything, or should we 
allow the underlying implementation to leak through in some ways?

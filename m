Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D31703F8D
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 23:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbjEOVWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbjEOVWS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 17:22:18 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB9DDA7;
        Mon, 15 May 2023 14:22:08 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id AA4624252A; Mon, 15 May 2023 22:22:06 +0100 (BST)
Date:   Mon, 15 May 2023 22:22:06 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <20230515212206.GA2162@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 15, 2023 at 05:15:15PM -0400, Daniel P. Smith wrote:
> On 5/12/23 06:55, Matthew Garrett wrote:
> > On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
> > 
> > > +#define SLR_TABLE_MAGIC		0x4452544d
> > 
> >  From convention I'd expect this to be 0x534c5254, but not really an
> > issue.
> 
> Apologies, but which convention?

Tables in ACPI and UEFI tend to have magic that corresponds to their 
name, so a table called SLRT would tend to have magic that matches the 
ASCII values for that. In this case the SLRT has DRTM as its magic, 
which is a touch unexpected.

> > Oof. Having the kernel know about bootloaders has not worked out super
> > well for us in the past. If someone writes a new bootloader, are they
> > unable to Secure Launch any existing kernels? The pragmatic thing for
> > them to do would be to just pretend they're grub, which kind of defeats
> > the point of having this definition...
> 
> Actually, this is not for making the kernel know about bootloaders. This is
> dealing with the challenge created when the preamble was split for efi-stub,
> and similar use cases, where what sets up the preamble, ie. the bootloader,
> is separate from what invokes the dynamic launch, ie. the DLE handler. The
> reality is that even in the simplest implementation of the DLE handler, a
> remnant of GRUB for call back from efi-stub, there is information that is
> needed to cross the gap.

What if I don't use grub, but use something that behaves equivalently? 
Which value should be used here?

> We wrote the TrenchBoot Secure Launch general spec [1] with as much
> forethought as possible for the target environments. Specifically, the
> desire is to have a common approach for x86 (Intel and AMD), Arm, and
> perhaps down the road the POWER arch. In particular, I do not believe there
> is anything in the Arm DRTM beta spec that prohibits a mixed 32/64 bit
> environment. In the end it is better to for the spec to be safe for those
> environments then having to make changes to the spec later down the road.

Ok.

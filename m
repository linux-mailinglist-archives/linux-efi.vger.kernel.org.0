Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC37336CD
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jun 2023 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbjFPQ4R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jun 2023 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjFPQ4D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jun 2023 12:56:03 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D573590;
        Fri, 16 Jun 2023 09:54:25 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 5E29440A72; Fri, 16 Jun 2023 17:54:15 +0100 (BST)
Date:   Fri, 16 Jun 2023 17:54:15 +0100
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
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <20230616165415.GA28537@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <20230512104753.GA14461@srcf.ucam.org>
 <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7dcb85b-25bb-8d5a-3758-e4243bc6ffec@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 16, 2023 at 12:44:27PM -0400, Daniel P. Smith wrote:
> 
> On 5/12/23 06:47, Matthew Garrett wrote:
> > On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> > > +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> > > +built with KASLR disabled::
> > 
> > Why does Secure Launch not interoperate with KASLR?
> > 
> > Re: IOMMUs
> 
> Until the IOMMU driver comes online, memory is protected by the PMRs regions
> requested by the Preamble (pre-launch code) in accordance with Intel TXT
> specifications and configured by the ACM. The KASLR randomizer will run
> before the IOMMU driver is able to come online and ensure frames used by the
> kernel are protected as well as frames that a driver may registered in a BAR
> are not blocked.

This seems unfortunate. Presumably we're not able to modify the PMRs at 
this point? This also seems like a potential issue for IOMMU config in 
general - the presumption is that the firmware should be configuring the 
IOMMU in such a way that DMA-capable devices can't attack the firmware 
while we're in the boot environment, and if KASLR is leaving a window 
there then it seems like we'd need to fix that?
 
> > > +It is recommended that no other command line options should be set to override
> > > +the defaults above.
> > 
> > What happens if they are? Does doing so change the security posture of
> > the system? If so, will the measurements be different in a way that
> > demonstrates the system is in an insecure state?
> > 
> 
> In an early version of the patch series this was enforced when turning on
> Secure Launch, but concerns were raised over this approach and was asked to
> allow the user to be able to shoot themselves in the foot. Overriding these
> values could render either an insecure state and/or an unstable system.

If we're in an insecure state, is that something that would show up in 
the form of different measurements?

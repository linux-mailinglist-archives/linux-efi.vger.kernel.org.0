Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B8700CAD
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjELQNW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELQNV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 12:13:21 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CC0EE;
        Fri, 12 May 2023 09:13:19 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 438EA40A6F; Fri, 12 May 2023 17:13:18 +0100 (BST)
Date:   Fri, 12 May 2023 17:13:18 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230512161318.GA18400@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <87pm75bs3v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm75bs3v.ffs@tglx>
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

On Fri, May 12, 2023 at 03:24:04PM +0200, Thomas Gleixner wrote:
> On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
> > Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
> > to force a policy on people who have both banks enabled. People with 
> > mixed fleets are potentially going to be dealing with SHA-1 measurements 
> > for a while yet, and while there's obviously a security benefit in using 
> > SHA-2 instead it'd be irritating to have to maintain two attestation 
> > policies.
> 
> Why?
> 
> If you have a mixed fleet then it's not too much asked to provide two
> data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
> SHA-1 on TPM 1.2 hardware. No?

No, beause having TPM2 hardware doesn't guarantee that your firmware 
enables SHA-2 (which also means this is something that could change with 
firmware updates, which means that refusing to support SHA-1 if the 
SHA-2 banks are enabled could result in an entirely different policy 
being required (and plausibly one that isn't implemented in their 
existing tooling)

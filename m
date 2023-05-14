Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC32701F2A
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjENTL6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 May 2023 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENTL5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 May 2023 15:11:57 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A61984;
        Sun, 14 May 2023 12:11:53 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 9869140A84; Sun, 14 May 2023 20:11:50 +0100 (BST)
Date:   Sun, 14 May 2023 20:11:50 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230514191150.GA17168@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
 <4acf414e-67e7-c964-566b-a5e657e9d1bb@citrix.com>
 <20230514181817.GA9528@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514181817.GA9528@sol.localdomain>
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

On Sun, May 14, 2023 at 11:18:17AM -0700, Eric Biggers wrote:
> On Fri, May 12, 2023 at 01:24:22PM +0100, Andrew Cooper wrote:
> > You're suggesting that because Linux has been slow to take D-RTM over
> > the past decade, you're going to intentionally break people with older
> > hardware just because you don't feel like using an older algorithm?
> > 
> > That's about the worst possible reason to not take support.
> > 
> > There really are people in the world with older TPM 1.2 systems where
> > this D-RTM using SHA1 only is an improvement over using the incumbent tboot.
> > 
> > ~Andrew
> 
> This patchset is proposing a new kernel feature.  So by definition, there are no
> existing users of it that can be broken.

The patchset reimplements a more extensible version of an existing 
feature which people already consume, and presumably people will be 
encouraged to transition to it. There is plenty of hardware that 
supports this feature that only implements SHA-1. If you want to propose 
that the kernel not implement any functionality that uses deprecated 
hash algorithms then that seems like a larger conversation rather than 
one that should focus on a single pachset.

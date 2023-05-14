Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1932C701EE0
	for <lists+linux-efi@lfdr.de>; Sun, 14 May 2023 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjENSSX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 May 2023 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENSSW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 May 2023 14:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59234E7D;
        Sun, 14 May 2023 11:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D834A60C83;
        Sun, 14 May 2023 18:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EC5C433EF;
        Sun, 14 May 2023 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684088300;
        bh=leEo7DBXpmphECdPPoj0UYJDLVxQHZKhN4OhIJt82Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oq8zPLuE2w26xouGORoxbM5b+qODTBQZmAW/0NB3Q31JGa62q+YXAH+9bP6AXzw80
         odeYEnGouTCPxcSP06EXzfOL5KHK2EqDVpOT2EtEPY4Im3TymWh06oaSA6n8+ZDhe9
         2AkIJAe4NctKvB8iFfRt/L9WLWEh2kTVyNHDY6YEDE88EXof5ns9O6juvD5zL+1v0p
         kcXK6VEIWsetUOc3SQlySKITnqKT+5qB0s1iCW91jyN+qIzHCYFzt1JWnxhw9uUtXZ
         vbJgcVdAW7t9K64vE/PutJqVsw5RUR6pIAoLqZmWZeVDRvXobXfjGvDN1OvDTJ1zs3
         226vaowByReJQ==
Date:   Sun, 14 May 2023 11:18:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
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
Message-ID: <20230514181817.GA9528@sol.localdomain>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
 <4acf414e-67e7-c964-566b-a5e657e9d1bb@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4acf414e-67e7-c964-566b-a5e657e9d1bb@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 12, 2023 at 01:24:22PM +0100, Andrew Cooper wrote:
> On 12/05/2023 12:58 pm, Ard Biesheuvel wrote:
> > On Fri, 12 May 2023 at 13:28, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
> >>> On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >>>> On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
> >>>>
> >>>>> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> >>>>> now?
> >>>> TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> >>>> at the whim of the firmware in terms of whether the SHA-2 banks are
> >>>> enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> >>>> extending the SHA-1 banks, a malicious actor can later turn up and
> >>>> extend whatever they want into them and present a SHA-1-only
> >>>> attestation. Ideally whatever is handling that attestation should know
> >>>> whether or not to expect an attestation with SHA-2, but the easiest way
> >>>> to maintain security is to always extend all banks.
> >>>>
> >>> Wouldn't it make more sense to measure some terminating event into the
> >>> SHA-1 banks instead?
> >> Unless we assert that SHA-1 events are unsupported, it seems a bit odd
> >> to force a policy on people who have both banks enabled. People with
> >> mixed fleets are potentially going to be dealing with SHA-1 measurements
> >> for a while yet, and while there's obviously a security benefit in using
> >> SHA-2 instead it'd be irritating to have to maintain two attestation
> >> policies.
> > I understand why that matters from an operational perspective.
> >
> > However, we are dealing with brand new code being proposed for Linux
> > mainline, and so this is our only chance to push back on this, as
> > otherwise, we will have to maintain it for a very long time.
> >
> > IOW, D-RTM does not exist today in Linux, and it is up to us to define
> > what it will look like. From that perspective, it is downright
> > preposterous to even consider supporting SHA-1, given that SHA-1 by
> > itself gives none of the guarantees that D-RTM aims to provide. If
> > reducing your TCB is important enough to warrant switching to this
> > implementation of D-RTM, surely you can upgrade your attestation
> > policies as well.
> 
> You're suggesting that because Linux has been slow to take D-RTM over
> the past decade, you're going to intentionally break people with older
> hardware just because you don't feel like using an older algorithm?
> 
> That's about the worst possible reason to not take support.
> 
> There really are people in the world with older TPM 1.2 systems where
> this D-RTM using SHA1 only is an improvement over using the incumbent tboot.
> 
> ~Andrew

This patchset is proposing a new kernel feature.  So by definition, there are no
existing users of it that can be broken.

The fact is, SHA-1 is cryptographically broken.  It isn't actually about how
"old" the algorithm is, or what anyone's "feelings" are.

Maybe a renaming from Secure Launch to simply Launch is in order?

- Eric

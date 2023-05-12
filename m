Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B1700763
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 13:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjELL6y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 07:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjELL6x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 07:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E871435C;
        Fri, 12 May 2023 04:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8CB655D8;
        Fri, 12 May 2023 11:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AE7C433EF;
        Fri, 12 May 2023 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683892712;
        bh=kBhJdbyF6NKdOXxRSKL9gtjCpg8g2as7soVqRjtDJis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WIQ4MS7o0Hqbi+1MvcqYhXbhBRPuD8I/plsTbVMLgMyq/fwWG1/cxYKX8JqskFdH0
         3d1pox/z3YlrpEX0Fn7gDOiw4fBdxxsEPo5CYjDGr6oz8D0TU6+hIGnJ99JQpbdt5r
         hwG/bjBfaph2oFB82BAuNQ4mhtfWYQnHvSYnXgew1tQQavYHG8twGfMI5LdyHg0e5l
         SG8PthdYX6PLxq/F6G2VLSjFWF37KrS0OzjQp8oD+cUXLcxSjNmSe8NvCCElWe8m5K
         hi5JmDxMFALwra/9HPthOJ2ZJX2UfBVIGOz4PqEbS1FMmEvoa5glDKGMpb7sgCFLfk
         qoHgzEC7dn6vQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f13c577e36so11015285e87.1;
        Fri, 12 May 2023 04:58:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDy5n8RP9FHZfDFfGGn/AAaNkksZaxUMgN5cXKZFwY6g2fM1KTFN
        kTHJhhMxOpXO1PWqcT+hhj3G2a3tm5Kv02Cu2AY=
X-Google-Smtp-Source: ACHHUZ4lN3kGWU0INu3Ag5oHbIJY8Yq+UgbBBSxtAi2XEj4awDEsVBTTDIqxI0QgVndMh10ixrl6vNC24Nn+1nyHsx8=
X-Received: by 2002:ac2:5ecc:0:b0:4f0:2e3:740f with SMTP id
 d12-20020ac25ecc000000b004f002e3740fmr4072413lfq.54.1683892710012; Fri, 12
 May 2023 04:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com> <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org> <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
In-Reply-To: <20230512112847.GF14461@srcf.ucam.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 13:58:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
Message-ID: <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 12 May 2023 at 13:28, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
> > On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > >
> > > On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
> > >
> > > > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
> > > > now?
> > >
> > > TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
> > > at the whim of the firmware in terms of whether the SHA-2 banks are
> > > enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
> > > extending the SHA-1 banks, a malicious actor can later turn up and
> > > extend whatever they want into them and present a SHA-1-only
> > > attestation. Ideally whatever is handling that attestation should know
> > > whether or not to expect an attestation with SHA-2, but the easiest way
> > > to maintain security is to always extend all banks.
> > >
> >
> > Wouldn't it make more sense to measure some terminating event into the
> > SHA-1 banks instead?
>
> Unless we assert that SHA-1 events are unsupported, it seems a bit odd
> to force a policy on people who have both banks enabled. People with
> mixed fleets are potentially going to be dealing with SHA-1 measurements
> for a while yet, and while there's obviously a security benefit in using
> SHA-2 instead it'd be irritating to have to maintain two attestation
> policies.

I understand why that matters from an operational perspective.

However, we are dealing with brand new code being proposed for Linux
mainline, and so this is our only chance to push back on this, as
otherwise, we will have to maintain it for a very long time.

IOW, D-RTM does not exist today in Linux, and it is up to us to define
what it will look like. From that perspective, it is downright
preposterous to even consider supporting SHA-1, given that SHA-1 by
itself gives none of the guarantees that D-RTM aims to provide. If
reducing your TCB is important enough to warrant switching to this
implementation of D-RTM, surely you can upgrade your attestation
policies as well.

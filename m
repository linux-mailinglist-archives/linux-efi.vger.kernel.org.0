Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52B7700923
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbjELNYJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbjELNYH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 09:24:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F231715;
        Fri, 12 May 2023 06:24:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683897845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGpiykIbZrzhClWEawyzh/+46DdyV3m0l/aogql4GLM=;
        b=t4zuosmBFyYyCvcFt4CogxekyLnafjtx8UdgZrID9B7MkOZFFbFZUGHMqQ4w/49f+dprnT
        PlH4xsuf9SnZUOj7+doXTmxlro1g3dwnvALxgbiT8zqrKR4AJUen8DhiEMHG4VUhgD4slv
        C9X56nGsqINm+67cMkF7EU6EiQxHU/23YN7VvK9EXvyfvLTW68S7L4dUwXmA35Ei9TL036
        gu+4asg1Taks0CJq2S+2OB9lkYShGaLJrhnbaqnWk9mEnRuWFWa0Oz6nGQs8cOSPyCJwEi
        c2jvlBPs3mnLU2prsZbpx8tLhNGXy5wbGzwLrxlQo7WZLAontnM3cRvFOEMokA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683897845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGpiykIbZrzhClWEawyzh/+46DdyV3m0l/aogql4GLM=;
        b=R8wbDPOZoeZXva36wF885TESy/aZyCr3jMp5vxQyYINiluGTuOY4gRqy+MdP5jxH24QHtN
        tWf4/obwdQJm8xBQ==
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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
In-Reply-To: <20230512112847.GF14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
Date:   Fri, 12 May 2023 15:24:04 +0200
Message-ID: <87pm75bs3v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
>> On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> >
>> > On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
>> >
>> > > SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
>> > > now?
>> >
>> > TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
>> > at the whim of the firmware in terms of whether the SHA-2 banks are
>> > enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
>> > extending the SHA-1 banks, a malicious actor can later turn up and
>> > extend whatever they want into them and present a SHA-1-only
>> > attestation. Ideally whatever is handling that attestation should know
>> > whether or not to expect an attestation with SHA-2, but the easiest way
>> > to maintain security is to always extend all banks.
>> >
>> 
>> Wouldn't it make more sense to measure some terminating event into the
>> SHA-1 banks instead?
>
> Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
> to force a policy on people who have both banks enabled. People with 
> mixed fleets are potentially going to be dealing with SHA-1 measurements 
> for a while yet, and while there's obviously a security benefit in using 
> SHA-2 instead it'd be irritating to have to maintain two attestation 
> policies.

Why?

If you have a mixed fleet then it's not too much asked to provide two
data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
SHA-1 on TPM 1.2 hardware. No?

Thanks,

        tglx

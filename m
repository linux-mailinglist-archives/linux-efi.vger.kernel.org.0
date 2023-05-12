Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF15700E7E
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbjELSR0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjELSRZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 14:17:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262BAE50;
        Fri, 12 May 2023 11:17:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683915442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrXy+JN0FIVOyWDkqWfN4fNFGJKhfjsBfYB8oPd1Irc=;
        b=Y1yV+uoB6fx9Yhns9dAWVlJGWQcpCyKUdFqEJpQFLS+uZwOmtwgY1IB7cCtCgtxfmPGM1E
        RHrqBI7OIhWNpaJ+CT1K/m6a4VffRvAuFtfHtrg7DktrfeG+F9YVJHF7UonTQXVwvcsBl6
        fwWaMINw9X4exjYSkh7wAm8lwsDrh0WOQX+mbJOdD265nOu21snUkPIxGI0rNIX+vxZ0tL
        X+l8YlFUwQAgRpK9HF7mCTycfV9zp1QIHWgo2bUoyfvj1OMI4jvyn6K01GFgbQtASecGVq
        79hQECeceglkJFJGCFpuG4MjTbxbTos+68fX3FuBrYHE2tg11v8+D1uwq2vfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683915442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrXy+JN0FIVOyWDkqWfN4fNFGJKhfjsBfYB8oPd1Irc=;
        b=jDQpibUvU/KTnZJH0KZt1sWuLoNTBcIE9OnnjHaZumYLz9yLuYhZiNO6B97Xnp9pWJX6Gc
        vTJozK43qwl7qIBw==
To:     Matthew Garrett <mjg59@srcf.ucam.org>
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
In-Reply-To: <20230512161318.GA18400@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org> <87pm75bs3v.ffs@tglx>
 <20230512161318.GA18400@srcf.ucam.org>
Date:   Fri, 12 May 2023 20:17:21 +0200
Message-ID: <873541bej2.ffs@tglx>
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

On Fri, May 12 2023 at 17:13, Matthew Garrett wrote:
> On Fri, May 12, 2023 at 03:24:04PM +0200, Thomas Gleixner wrote:
>> On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
>> > Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
>> > to force a policy on people who have both banks enabled. People with 
>> > mixed fleets are potentially going to be dealing with SHA-1 measurements 
>> > for a while yet, and while there's obviously a security benefit in using 
>> > SHA-2 instead it'd be irritating to have to maintain two attestation 
>> > policies.
>> 
>> Why?
>> 
>> If you have a mixed fleet then it's not too much asked to provide two
>> data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
>> SHA-1 on TPM 1.2 hardware. No?
>
> No, beause having TPM2 hardware doesn't guarantee that your firmware 
> enables SHA-2 (which also means this is something that could change with 
> firmware updates, which means that refusing to support SHA-1 if the 
> SHA-2 banks are enabled could result in an entirely different policy 
> being required (and plausibly one that isn't implemented in their 
> existing tooling)

It's not rocket science to have both variants supported in tooling,
really.

What a mess.


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A362C91B
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 20:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPTmR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 14:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPTmP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 14:42:15 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB1183B8;
        Wed, 16 Nov 2022 11:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668627734;
        bh=Zbt4bXsEqR2aVAoTn7u+yGScVtBmIodkQzBGeRdnpVM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=V3cGyN4K0AiD6bOxqkjUqJNUhK1L8GMZGyqs4PCMK0Mj4snSszY06U8CT75PluqEf
         0O+pGiv4D8Es4UlEPxrm1UijaaRZMR6mYwAgL/HqY5YIsyZheuusZUvGeTB45JACqV
         0y4JG8rVBJQNtpiSRqtrkVToqzwG5aAJNFOy5pBc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2D5421285D4F;
        Wed, 16 Nov 2022 14:42:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JDKSsTIXis9k; Wed, 16 Nov 2022 14:42:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668627733;
        bh=Zbt4bXsEqR2aVAoTn7u+yGScVtBmIodkQzBGeRdnpVM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Nh3qVTLayYjtlgQk09cclwsItcUBhWDU0GPrd8VvtmiKN5JtGhB61zB93RSkxa10Q
         Iq7A/cXM7FNwb+mQDe60Uqw6RLbVSQh0dWfqEnv/OvggoeQ4OP6sfJwP1OVToOL/S+
         7/p1xC533cLxyAgwLElMLeVqz76CXNPIUZk3qcoI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 73ADD12813D0;
        Wed, 16 Nov 2022 14:42:13 -0500 (EST)
Message-ID: <7837b12a39b1d6721387ca95554c79003bd16c4e.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed
 variables
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Date:   Wed, 16 Nov 2022 14:42:11 -0500
In-Reply-To: <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
         <20221116161642.1670235-6-Jason@zx2c4.com>
         <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-11-16 at 18:04 +0100, Ard Biesheuvel wrote:
> On Wed, 16 Nov 2022 at 17:17, Jason A. Donenfeld <Jason@zx2c4.com>
> wrote:
> > 
> > Variables in the random seed GUID must remain secret, so deny all
> > reads
> > to them.
> > 
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  fs/efivarfs/file.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> > index d57ee15874f9..08996ba3a373 100644
> > --- a/fs/efivarfs/file.c
> > +++ b/fs/efivarfs/file.c
> > @@ -76,6 +76,9 @@ static ssize_t efivarfs_file_read(struct file
> > *file, char __user *userbuf,
> >         while (!__ratelimit(&file->f_cred->user->ratelimit))
> >                 msleep(50);
> > 
> > +       if (guid_equal(&var->var.VendorGuid,
> > &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
> > +               return -EPERM;
> > +
> >         err = efivar_entry_size(var, &datasize);
> > 
> >         /*
> 
> I'd prefer it if we could just disregard them entirely, i.e., never
> enumerate them so that they don't appear in the file system.

It would be nice if they could be boot services only ... then they
disappear naturally, but that would mean the rng would have to
initialize and save in the EFI stub before ExitBootServices, which
doesn't seem practical.

James


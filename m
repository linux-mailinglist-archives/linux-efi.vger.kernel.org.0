Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE862C889
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 19:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiKPS5w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 13:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbiKPS5c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 13:57:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4A49B50;
        Wed, 16 Nov 2022 10:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18082B81E7B;
        Wed, 16 Nov 2022 18:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F8C433D7;
        Wed, 16 Nov 2022 18:56:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ICJ6Y7iB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668624984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGKWCAEtW5YFu3Lu8UqRmbAiVCpc891NJNOFhixnzhI=;
        b=ICJ6Y7iB98sLgRIt5Dxwc8HohQKTHYulDmw4ZUAO9j7z0UclVFS6ajKtWgOqrBuG5G4zvk
        G5TafNJ6kU3TEyCXCr7crf2B4Mwjf/JAu4zPey4CU2UGu4u3htEEdj6+M5kKY72yPRJXM6
        aOY4AVlMe6DpM/9Z5bvxXYkXz6bSe/E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id de4634d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 18:56:23 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id i2so14464517vsc.1;
        Wed, 16 Nov 2022 10:56:23 -0800 (PST)
X-Gm-Message-State: ANoB5pk/gSrr8a9+4GGz366/cVloWrafoFybqZOxEzHY/HElp1jSlycV
        fyg6WIpFwz3ucNnBejK+NR1EnEH6LT6MTWyScuA=
X-Google-Smtp-Source: AA0mqf7E97aDHEGVr7KHMDNfm0EduBwcCP05UtuwK1kNWx71sCzYiVIiMSJYhyIDzYXGvliUhpLjgJ3htCOGx7xp+pY=
X-Received: by 2002:a67:dd8c:0:b0:3aa:3310:174 with SMTP id
 i12-20020a67dd8c000000b003aa33100174mr12528608vsk.70.1668624983090; Wed, 16
 Nov 2022 10:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20221116161642.1670235-1-Jason@zx2c4.com> <20221116161642.1670235-6-Jason@zx2c4.com>
 <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 16 Nov 2022 19:56:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9os4tUqKbz7jdj6goA-SukqTmGEKxi36A97LTtv-QE+bA@mail.gmail.com>
Message-ID: <CAHmME9os4tUqKbz7jdj6goA-SukqTmGEKxi36A97LTtv-QE+bA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed variables
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 16, 2022 at 6:05 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 16 Nov 2022 at 17:17, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Variables in the random seed GUID must remain secret, so deny all reads
> > to them.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  fs/efivarfs/file.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> > index d57ee15874f9..08996ba3a373 100644
> > --- a/fs/efivarfs/file.c
> > +++ b/fs/efivarfs/file.c
> > @@ -76,6 +76,9 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
> >         while (!__ratelimit(&file->f_cred->user->ratelimit))
> >                 msleep(50);
> >
> > +       if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
> > +               return -EPERM;
> > +
> >         err = efivar_entry_size(var, &datasize);
> >
> >         /*
>
> I'd prefer it if we could just disregard them entirely, i.e., never
> enumerate them so that they don't appear in the file system.

Okay, sure, I can make that happen I think.

And then I suppose that if you try to create anything under that GUID,
it should just fail.

Jason

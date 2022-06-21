Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49243553DD6
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiFUVdn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356617AbiFUVdn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 17:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11C6473;
        Tue, 21 Jun 2022 14:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF18E615DA;
        Tue, 21 Jun 2022 21:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CE2C3411D;
        Tue, 21 Jun 2022 21:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655847221;
        bh=hXRncMsrqiLvREP2ZMBHVkrScXAp7TSUS+jzQ5pUVhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZNWMWL+LmB9fKts8AsUhpwYSXlckyv4TM0q41ac+SLTneE+iBS6A4PVgHjHlntJkd
         tr0AqWTaFEyjzUnH+g3VdJaH+yY/6HdvjSem+wFyBgYx/3MO5UrVG/QhNRU1ZgMRCd
         Px6mgW/X2b/eNm8OCfVu7bD8h5kQJnMNKoKmQdeXZ3CpdpHgCJOeYbc/IoWYKfZoXJ
         P471nRjhxTlwm8Erh5Siis8flYCnKdlA1ZeAVBey3GI4diRa2Mbq8ATGSQNPBqwIN5
         V+btjki66ZAT6q/0MKuGv+4K0FUvNJyRGHaidUUZM5lY5+YJsYL4kVhb2QEzAMBs1X
         H/mEVoterbCcw==
Received: by mail-oo1-f51.google.com with SMTP id w3-20020a4ab6c3000000b0041c1e737283so2945655ooo.12;
        Tue, 21 Jun 2022 14:33:41 -0700 (PDT)
X-Gm-Message-State: AJIora/9Xt7SZVZWCbc8o1/4MH1/nmZl+uWQy06+e0Z5OnW3Jaz0T8cP
        cIdKzmKnrdeK45UsSvx7xor7tPToudIgnuusLUI=
X-Google-Smtp-Source: AGRyM1tKuOo25ay6VClI3AdUcIFB8V3Jh9agSiNy3WCVFItbUgzdqwxNCUP52L5OkU20g5ZlJq4ejmR44/SVifqEMmI=
X-Received: by 2002:a4a:c983:0:b0:41b:9e6f:44ab with SMTP id
 u3-20020a4ac983000000b0041b9e6f44abmr24659ooq.98.1655847220275; Tue, 21 Jun
 2022 14:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220621153623.3786960-1-ardb@kernel.org> <20220621153623.3786960-5-ardb@kernel.org>
 <202206211357.C66CD742E5@keescook> <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
 <202206211419.014C341BE@keescook>
In-Reply-To: <202206211419.014C341BE@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Jun 2022 23:33:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWnXd3CyygbQpB8n1srqVA+vTOztevcYTQnDAWZ6-HiA@mail.gmail.com>
Message-ID: <CAMj1kXEWnXd3CyygbQpB8n1srqVA+vTOztevcYTQnDAWZ6-HiA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore
 access layer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 Jun 2022 at 23:21, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 21, 2022 at 11:12:17PM +0200, Ard Biesheuvel wrote:
> > On Tue, 21 Jun 2022 at 23:00, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> > > > Avoid the efivars layer and simply call the newly introduced EFI
> > > > varstore helpers instead. This simplifies the code substantially, and
> > > > also allows us to remove some hacks in the shared efivars layer that
> > > > were added for efi-pstore specifically.
> > > >
> > > > Since we don't store the name of the associated EFI variable into each
> > > > pstore record when enumerating them, we have to guess the variable name
> > > > it was constructed from at deletion time, since we no longer keep a
> > > > shadow copy of the variable store. To make this a bit more exact, store
> > > > the CRC-32 of the ASCII name into the pstore record's ECC region so we
> > > > can use it later to make an educated guess regarding the name of the EFI
> > > > variable.
> > >
> > > I wonder if pstore_record should have a "private" field for backends to
> > > use? That seems like it solve the need for overloading the ecc field,
> > > and allow for arbitrarily more information to be stored (i.e. store full
> > > efi var name instead of an easily-colliding crc32?)
> > >
> >
> > We could easily add that - we'd just have to decide how to free the
> > memory it points to.
>
> I assume the pstore core could do that since it manages the record
> lifetime already?
>

So if priv is non-NULL when it frees the record, it passes it to kfree() ?

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFD7A22E9
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjIOPtA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjIOPsz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 11:48:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7110F7;
        Fri, 15 Sep 2023 08:48:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F8FC433D9;
        Fri, 15 Sep 2023 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694792898;
        bh=Z61xtoWqmH9MMOZnqhompMyXKPGpcuIfhAUGhJsHcN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bptqq1Y8BsLoJbmlgR+oaSZaEDrHkM+uzv9aMlU2pUOufR92+HifwY56Mj+/h5NlX
         zlQBnytcPiO8VvtC/LAoW1XOVGhaTNCPu6rmb3O6EGdyAB4fzGkdJuJ97l1Uq/BHZg
         z5xI7JoKkiYwkNwUqwgstCG+I/sYfFHRgeOc6XKYFRO2vwF0f3JvhqUT8v8lCE1ra7
         0RWTaDqkf4mcTL1bNSBLUztYIrwsMO3j4wWsTsN5kvqAUuLyvRPXt//7CXmrZ/h6ZM
         1zJ4VMf4YwLfALoCvI9MsleraWREFsvfy6Ww3tAK8bLPV+QH/ZlH8Uba78j+QAreet
         SrUBPW7wMYHnw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50091b91a83so3783226e87.3;
        Fri, 15 Sep 2023 08:48:18 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxob4n7kKHrSiBIseoyDYCGnvH1U9Px65+Zvyb/Dpb9BaukfrHC
        P3+vXFnbh6jc8J3FKUryAQnZE2ZjrwJYA0/u0Pc=
X-Google-Smtp-Source: AGHT+IEtikRXVmtm422PGOEGHecyMJit8Pyo+R/HlKrmRS+reE3aE+y2M0KUOmPY40ZP4W7L7tZE7Sn9tvkYReXD/Ec=
X-Received: by 2002:ac2:4183:0:b0:500:9214:b308 with SMTP id
 z3-20020ac24183000000b005009214b308mr1921878lfh.65.1694792896665; Fri, 15 Sep
 2023 08:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <20230912090051.4014114-25-ardb@google.com>
 <ZQQgv7VWUa3VGqbb@gmail.com> <CAMj1kXGxv_Nt4__ETG-e0vXC7z8SyirCw5NO0p6gsWRbLfbNAQ@mail.gmail.com>
 <ZQR66uQOGCaVQlNu@gmail.com> <ZQR8FptFJ+8Ht7Y3@gmail.com>
In-Reply-To: <ZQR8FptFJ+8Ht7Y3@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Sep 2023 17:48:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmEfngtuyEkYuzgif14E-338z1XNdRpGizK8TvywGX6g@mail.gmail.com>
Message-ID: <CAMj1kXEmEfngtuyEkYuzgif14E-338z1XNdRpGizK8TvywGX6g@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] x86/boot: Drop references to startup_64
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 15 Sept 2023 at 17:45, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > Very weird - could it have gotten lost in the sending process, on your
> > side?
>


Lore does have them but I have no idea whose end caused this - I
recently switched to Google's internal infrastructure for outgoing GIT
email as our network does not permit outgoing SMTP to kernel.org but
this is the first time I heard of a potential issue of this nature.

https://lore.kernel.org/linux-efi/20230912090051.4014114-24-ardb@google.com/T/#u
https://lore.kernel.org/linux-efi/20230912090051.4014114-26-ardb@google.com/T/#u


> In any case I've dropped patch #8 from tip:x86/boot as well - the first 6
> patches arrived fine and are in the intended order.
>
> Once the boot problem has been resolved, mind resending the rest?
>
> There are no changes in -tip that should be interfering: tip:x86/boot has
> an upstream base.
>

Yeah I'll respin and resend. Thanks.

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF974E07C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jul 2023 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGJV4G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jul 2023 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGJV4F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jul 2023 17:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFCD2;
        Mon, 10 Jul 2023 14:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C2761219;
        Mon, 10 Jul 2023 21:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81ACC433C8;
        Mon, 10 Jul 2023 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689026163;
        bh=urUMvcqIHSx44e1CLXIt+y4lPoaxzNCVYEBO64LKrtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CDThmcbcHASAfk2VyXGM5XYnw6xuTJhgaGL9h53i/ZaKq/TKcX3ai1c3/20QBzUA4
         7A2Ozb5nBEeK1H/mzH27jKpoywTSLx/H8/KNZDoItdXaZjmWBKLSIxn8uZeH4Y/NQd
         YzCH7yo5B91USbLjNXlJkDp6HJDzSL7Al8v1WN2+2SY6/rzWjQ2JDCtqCLvi0LSS5q
         6hppfuUaEuyb4mjNk4lBO5V+b8cU20Ho/IxyblOLHhT/XxO3N0+X2L/1dy6kFHSNd2
         LUJXp3JiBAkGiZ1qxsfhbhLdBLJTtrDI2AISaswHte9wSVs7qo7zPgSdI3cfGcoMCo
         ClZSpuF4N0VWQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so7980189e87.2;
        Mon, 10 Jul 2023 14:56:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLbyp7TjrPOhVhwqTA6leuLtrRWncm9Iv6IUAaziEWF1dsLZbttR
        kQBv/WSB76WiauP2Sk2POQ5CpOo+6W4D85OVp0o=
X-Google-Smtp-Source: APBJJlEz2AlQPaxY8fa7D8go97IXDSjkxf0l3ev+QQpgPy724kTPemHsnt7WgY8N+2M65jKY0OOXyX9aqIBrk7urOc0=
X-Received: by 2002:a05:6512:3a96:b0:4f8:554f:36aa with SMTP id
 q22-20020a0565123a9600b004f8554f36aamr12455800lfu.29.1689026161679; Mon, 10
 Jul 2023 14:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-7-ardb@kernel.org>
 <20230710090654.GCZKvKLh44tzlNzPcq@fat_crate.local>
In-Reply-To: <20230710090654.GCZKvKLh44tzlNzPcq@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Jul 2023 23:55:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUtm2unrpwLWCXQhoE1wEYuFgvz3u_SXDFE=SJHJdYmQ@mail.gmail.com>
Message-ID: <CAMj1kXGUtm2unrpwLWCXQhoE1wEYuFgvz3u_SXDFE=SJHJdYmQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/20] x86/decompressor: Store boot_params pointer in
 callee save register
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 10 Jul 2023 at 11:07, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 07, 2023 at 09:23:28AM +0200, Ard Biesheuvel wrote:
> > Instead of pushing and popping %RSI several times to preserve the struct
> > boot_params pointer across the execution of the startup code, move it
> > into a callee save register before the first call into C, and copy it
> > back when needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S | 34 +++++++-------------
> >  1 file changed, 11 insertions(+), 23 deletions(-)
>
> I like that.
>
> We do a similar dance in arch/x86/kernel/head_64.S. Care to fix that
> too, in a separate patch?
>

I already did, actually, but I dropped it from this series because it
was getting too long, and not essential for the overall goal of the
changes.

https://lore.kernel.org/all/20230602101313.3557775-19-ardb@kernel.org/

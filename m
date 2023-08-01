Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD66776B4FD
	for <lists+linux-efi@lfdr.de>; Tue,  1 Aug 2023 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHAMqd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Aug 2023 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHAMqc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Aug 2023 08:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E921FD0;
        Tue,  1 Aug 2023 05:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA44361592;
        Tue,  1 Aug 2023 12:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536A5C433CD;
        Tue,  1 Aug 2023 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690893990;
        bh=MXlho9S16+OyJ4ljrjOtHzGNyOHL4ff+oBclsUhFYpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e5ukiVqCooJhtidM1Shc5l4sovqkC/PocssFvwu6KOF4hmjjF0QwlD6fEhk8BnkbM
         fIFVpVDsbJSSdXPXZYwLz3M3/zurjeBF4znqHO5SIiLMP+wgEUR0RWP0vPZFJAnJck
         a/CevTRiaj/ljXpsOuul9Y31DKVeya63l9/hdxy5IZ2MgtvjopLA+SfvM0d7tBzFou
         DNN84+2gGFBF+l43U5nG5fFfaDJGRNZ2MnlhXkqsH/hnWFAOWE0cyh5iDfnFRPCinr
         2YpVx0HTjW+J9Zw/c2f/dGrHRs8XbbJGwSt2nFVVvrlaFhfsck0XYv1UShYOBB/K2g
         6xx2Iq71SPhGg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8880439e87.2;
        Tue, 01 Aug 2023 05:46:30 -0700 (PDT)
X-Gm-Message-State: ABy/qLZpd4nlGbjpoHlER5koRwXjyT02xWHD4g3xgggl9UAUQII3Q4Vt
        G9PoD1reaiMSvJq0zRR2ge+uoOoSXKSmTlzVRZI=
X-Google-Smtp-Source: APBJJlFmF6d0IfZK5B6FMUVZXZ6E2XEzl7+tVo3DUR2cG/2bigstQ32NISDKiQpIzShzf8r8Co56f0lI8stEcneUssg=
X-Received: by 2002:a19:e01d:0:b0:4fd:bd94:e6cb with SMTP id
 x29-20020a19e01d000000b004fdbd94e6cbmr2340331lfg.35.1690893988342; Tue, 01
 Aug 2023 05:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230728090916.1538550-1-ardb@kernel.org> <20230728090916.1538550-15-ardb@kernel.org>
 <20230801120827.GFZMj1uzNMDs2gIi1f@fat_crate.local> <CAMj1kXF+=W_oe7MS87rWdJ_z555iz2A8iR42fJ1mwZ+bgCgjmw@mail.gmail.com>
 <20230801124054.GGZMj9VrrB+4a4NiZs@fat_crate.local>
In-Reply-To: <20230801124054.GGZMj9VrrB+4a4NiZs@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Aug 2023 14:46:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGN6DAhWk647=jHW5wBMP0y4p9wzPBz3R7h=Gh1v6VEA@mail.gmail.com>
Message-ID: <CAMj1kXFGN6DAhWk647=jHW5wBMP0y4p9wzPBz3R7h=Gh1v6VEA@mail.gmail.com>
Subject: Re: [PATCH v7 14/22] x86/decompressor: Merge trampoline cleanup with
 switching code
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 1 Aug 2023 at 14:41, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Aug 01, 2023 at 02:11:21PM +0200, Ard Biesheuvel wrote:
> > Removing it breaks the build for !CONFIG_X86_5LEVEL
>
> How come?
>

Because a label cannot be at the end of a block. There needs to be at
least one statement.

> $ grep 5LEVEL .config
> # CONFIG_X86_5LEVEL is not set
>
> and it builds fine here.
>

I guess it depends on the compiler version. GCC 10 gives me this

<source>: In function 'foo':
<source>:4:5: error: label at end of compound statement
    4 |     bar:
      |     ^~~

but GCC 13 seems to be fine with it.

https://godbolt.org/z/KnWbY8vEY

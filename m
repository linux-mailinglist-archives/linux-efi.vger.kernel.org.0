Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2570556E
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjEPRvK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEPRvJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 13:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CB1BC3;
        Tue, 16 May 2023 10:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5DC63D80;
        Tue, 16 May 2023 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB57C433A0;
        Tue, 16 May 2023 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259467;
        bh=hjdexXXjV7B9byc2g6Pbp2Bf3qgKgg1T8OV/JHfislQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IbADfA5uDXYuQn7LGt+pOvo1nT2wVVW+US3Jxz0C14NpoRYUevGlU2vrra6glSOD1
         HzImWEXtbVQ6yDv1CEWUlEyC2L8g2r1vx3NYmYeIYelkURQFbwD668PKmSv9V/mFMh
         tBjuBCA8tpmCzqtLrGkKl3q8bzVXG7SsFOuAQFF07LMXEFcrV2haRHQHUW89Lu3l4j
         92S3uPhzKW4cq3eVkD7MQIb4y3dYksFTXWt9Fi1jr2i+/iS6VN0c+yB9LR0WJKeidK
         ilzJw/YkDhPcPDT+MVbjYtT3fKs0DUoD9QI3VO0nV8nvvY5+wszwJF2U1bhi1WB/p6
         MXEFZwiFi+ySQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so16732674e87.3;
        Tue, 16 May 2023 10:51:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDy+C3rZ4/kzFwbKGXfsyYLlzcQ9WcH/reC4diG2cAgMW7LZ4aPM
        w/7mBdppQTYOwa3nJ4KBP3qexc9f5vNRKtgbpvg=
X-Google-Smtp-Source: ACHHUZ6NpkvI1SBtpZ34z3AZyWz2c3/LJcFHzg9+YRlkiPgBi+Uqvvx6RHHKGU2eEWV9kO0UJbEA8EPzn66JIOoicn4=
X-Received: by 2002:ac2:484e:0:b0:4eb:c85:bdc2 with SMTP id
 14-20020ac2484e000000b004eb0c85bdc2mr8530129lfy.2.1684259465451; Tue, 16 May
 2023 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-9-ardb@kernel.org>
 <20230515140955.d4adbstv6gtnshp2@box.shutemov.name>
In-Reply-To: <20230515140955.d4adbstv6gtnshp2@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 May 2023 19:50:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZtA9n4cpzkq4f4mitB4jWOKKf40Hf3mS4-zCB1eW=JA@mail.gmail.com>
Message-ID: <CAMj1kXGZtA9n4cpzkq4f4mitB4jWOKKf40Hf3mS4-zCB1eW=JA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] x86: decompressor: Merge trampoline cleanup with
 switching code
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
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
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 May 2023 at 16:10, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, May 08, 2023 at 09:03:18AM +0200, Ard Biesheuvel wrote:
> > @@ -215,4 +208,5 @@ void cleanup_trampoline(void *pgtable)
> >               ptrs_per_p4d = 512;
> >       }
> >  #endif
> > +     return;
> >  }
>
> Return is redundant here.

The return (or at least just a semicolon) is needed here because of
the goto label right before the #ifdef block, as otherwise, the
function would end with a label and the compiler does not like that.

> Otherwise:
>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>

Thanks.

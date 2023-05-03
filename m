Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B456F5E10
	for <lists+linux-efi@lfdr.de>; Wed,  3 May 2023 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECSkM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 May 2023 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECSkL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 May 2023 14:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97E768A;
        Wed,  3 May 2023 11:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F6662F53;
        Wed,  3 May 2023 18:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2635C433A1;
        Wed,  3 May 2023 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683139206;
        bh=cm76H1e596g6zBEKzoV3JH1wAtwXZ3vz7kKlt5bQlEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hVjxHsmwY3joEHA86eJkgM2j21OIUrZsEcIhlGlb5Wfwgn//Abz7J9qppoZs+VOet
         Wm+0upecxPq6+9D+Oaq0EPpY161Jq2fLlmnfEV49OLVwjqpHWAMlPr+3X5yohT2D4w
         82MrIkGARchZmHhaKpU5Qsa8h6rqVjXt0Z00+16ZjOA3E37xNQyq0bPm7Jcx/dXQ7s
         P02vj/JQ1zVvZaWjVsPoGgH3hrmdETDglEiWicR4j7xk3ZTjjybqCvEBrnGKzbd9XM
         oQVkfGWVo/y8spqPvl6e/Ei90LD1Llx/c9OfRDMJMakgC9w6uSJb8Y8KHSslgJyuC9
         zarvc19ItZiiA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ac7847839eso6740761fa.2;
        Wed, 03 May 2023 11:40:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDzc9o7daXyBktapteg4UBzyxVA25RlHpxQ4MwEUHv9/xgSTov7w
        lcMOKGDHfM+oBklzJ6aB1U9XO0qHBZColvYIXhY=
X-Google-Smtp-Source: ACHHUZ42l1IMkEtuT4rp9vWqm5QdjomFmTc/BolNA0wpxB/RYD3L4h8/EsWZlO50/tic1SmlNLulr95mb7qDFP9xm78=
X-Received: by 2002:a2e:95c2:0:b0:2a7:a2cf:3c03 with SMTP id
 y2-20020a2e95c2000000b002a7a2cf3c03mr300157ljh.25.1683139204889; Wed, 03 May
 2023 11:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230424165726.2245548-1-ardb@kernel.org> <ecbcc066-3636-9620-8db9-2c066d16e717@amd.com>
 <CAMj1kXG8ZrdEUNTiSCet+aT+1ZyrbguFsGtNhVV+XgCssZgj9w@mail.gmail.com>
 <a6846282-95c8-274a-accc-ffa54205489c@amd.com> <8f85787a-1fa5-8f59-6047-b3a791291bfd@amd.com>
 <CAMj1kXFfHJDXW2xWTjT5xy_-8MdeS9HhcMh3=DKFZ3+vhaUFcA@mail.gmail.com> <20230503182433.GFZFKm4QAiqXRBYM0s@fat_crate.local>
In-Reply-To: <20230503182433.GFZFKm4QAiqXRBYM0s@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 May 2023 20:39:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFX0bEyE_Wr8j0Vexqc+sNcZWto5jy=t+g+43UpgDa2tA@mail.gmail.com>
Message-ID: <CAMj1kXFX0bEyE_Wr8j0Vexqc+sNcZWto5jy=t+g+43UpgDa2tA@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi/x86: Avoid legacy decompressor during EFI boot
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 3 May 2023 at 20:24, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, May 03, 2023 at 08:17:28PM +0200, Ard Biesheuvel wrote:
> > (There is some 32-bit SEV code in the decompressor as well that
> > obviously never gets called when booting in long mode, but I hadn't
> > quite grasped how much other SEV code there actually is)
>
> If you mean the thing in startup_32 which does get_sev_encryption_bit()
> etc, that is going away.
>

OK, good to know.

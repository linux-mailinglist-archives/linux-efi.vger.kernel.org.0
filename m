Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE47712D7
	for <lists+linux-efi@lfdr.de>; Sun,  6 Aug 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHEWUD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHEWUC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 18:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41838E78;
        Sat,  5 Aug 2023 15:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA73060C1A;
        Sat,  5 Aug 2023 22:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42CC433CB;
        Sat,  5 Aug 2023 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691274000;
        bh=8L00r6W/hg8NEpCDkD6zSDjERcppNOkTBRzJM/gOKMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AtwV08PK9m+WcQVTR6LRg44HgLboaXqB8xx0nkr/Hb+tRtMmKzn6z0A6/7J9wDMC5
         R6l4uMs5Ak4YZ2/NFoZwY4+m6kY7TRxUi3jPhEZ53OGp8cFuczbQSW/HpjRHJqb1kn
         HnNwUirsiU0Az6Hf903EZAyseYdY5WQU7Klm9q9AfmWtL9Pfnnzw30iySTqY5amulB
         ZMQVjudvhnP+aI9almUnfFNZ0Hw4InpjVXsydBSrMzEKcXme5uibby/pwSJIQfRuuC
         4ks6hV1xyz+eYrNQpz+ozA7RgmQPvPvRhlvX8fZdX1v/aaUDgaYKEuc80UWp+cX9QJ
         IOB7dm+gU2L1Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so5356075e87.0;
        Sat, 05 Aug 2023 15:20:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4u4fnkJAZLTmVfo3yGQd4YVylAnqB6t9yMpAhWSABjDH5ckoz
        gfre9adcHVAfzBGEyVhedr+LRCpI1qBQiIr5n5I=
X-Google-Smtp-Source: AGHT+IGSgV8YMR6QPR7Wu5TwqGk1KrnDuE5jip62/F3+Dh0wEoveWU/uXp0eWOXIe+hmzobenmoCG7NsctYViaeat6A=
X-Received: by 2002:a05:6512:159c:b0:4fe:8be:6065 with SMTP id
 bp28-20020a056512159c00b004fe08be6065mr1032701lfb.5.1691273998150; Sat, 05
 Aug 2023 15:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154831.2147855-1-ardb@kernel.org> <20230805144030.GDZM5fXvaqXBLxwXfj@fat_crate.local>
 <CAMj1kXEFC6LwNiWrGGsXot4SO0wivqN_3Yi=T9OS0XJ4=MeNew@mail.gmail.com> <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local>
In-Reply-To: <20230805210631.GEZM6518W3qOCYYgNK@fat_crate.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 6 Aug 2023 00:19:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
Message-ID: <CAMj1kXE+jgLztL1mQ6VDkJWfAjSJnxapoUAsvqaSQmfi=kr=hg@mail.gmail.com>
Subject: Re: [PATCH v8 00/23] efi/x86: Avoid bare metal decompressor during
 EFI boot
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 5 Aug 2023 at 23:07, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Aug 05, 2023 at 07:37:17PM +0200, Ard Biesheuvel wrote:
> > So this is the host booting, right?
>
> Yes.
>
> > So is the position of the C bit perhaps getting detect incorrectly?
>
> I don't know yet. But the evildoer is someone else:
>
> 02d47ce2ae02 ("x86/head_64: Store boot_params pointer in callee save register")
>
> after bisection. More staring later as to why...
>

How bizarre.

But that was a bonus patch anyway, so we could just drop it for now.

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA057899A
	for <lists+linux-efi@lfdr.de>; Mon, 18 Jul 2022 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiGRSeX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Jul 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbiGRSeX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Jul 2022 14:34:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135262D5
        for <linux-efi@vger.kernel.org>; Mon, 18 Jul 2022 11:34:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so22844950ejc.11
        for <linux-efi@vger.kernel.org>; Mon, 18 Jul 2022 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKNO/2jKtYxtHpiKjjZWFyfX1vgvMagozZ10mRTcyRY=;
        b=IBilH2yk53/8G11w0puh2eRVbRH56qZC4Tjg3Pq7xlpPa17Nee9c7J7l1O2yx6UVN0
         z3xxHnOh5QjU9uN/l6evyV0y+yYqZOk6RJ/fGPflrU720VaN8nL55cKT5RMTIrXLfAFu
         hmXxGCVcHQ+wDwrb4zsbvFrKF9iDVqdEu3NLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKNO/2jKtYxtHpiKjjZWFyfX1vgvMagozZ10mRTcyRY=;
        b=4YpcjPIj/XhqcB1v50LsZROP3p8j2S608dPl76ksvoucluVc4KDyia+UohPXktZqNH
         wuqkEPWiiQE2s8a8xUb7tANs2J47kWNFGtyKBiZqLEw5u34cVVIsNaDn1eebYPakAEqi
         FN47KWJDOSS5VQ1sViiEiB1x147+7aXttrPo/oE7vTC8tRddxs50392BW7JiW5Kth0CB
         Dq3xnL2nehSIx/IYxY9RfZmwtQTWdQx4KWC/i4P0s/3MMAPQTee+hyByKJuqDBbNFoBT
         R5JVH8eHnwwCqzjdcG9o5r97UmwzKPmafmwgjbLdYrTWq7Vq/WqWaBwfc4RBCghQlq1y
         FW1A==
X-Gm-Message-State: AJIora+XJriKo29Lx+naYIleoCyMz8zyLpI+RM1hBkYy8oHFVmysFJo3
        1njWx7k54fw66Wq+E6eD6/yJfsvZE6Eqs1qa
X-Google-Smtp-Source: AGRyM1tO/1EEgFihWEnR0tjDClVWPqfiRVE8zmG3xpHLQE3Ag9EqBXr57a+Ieaiu3/qjEFXWZBTWZw==
X-Received: by 2002:a17:907:a061:b0:72f:1dde:fac0 with SMTP id ia1-20020a170907a06100b0072f1ddefac0mr9773513ejc.310.1658169260555;
        Mon, 18 Jul 2022 11:34:20 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id fs4-20020a170907600400b0072af3deb944sm5807567ejc.223.2022.07.18.11.34.19
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:34:19 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n12so5475677wrc.8
        for <linux-efi@vger.kernel.org>; Mon, 18 Jul 2022 11:34:19 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr23607916wrv.281.1658169258764; Mon, 18
 Jul 2022 11:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715194550.793957-1-cascardo@canonical.com>
 <YtVG8VBmFikS6GMn@worktop.programming.kicks-ass.net> <YtWKK2ZLib1R7itI@zn.tnic>
In-Reply-To: <YtWKK2ZLib1R7itI@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:34:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWQOsxqE+tvZi_MjzGaqfG6Xo5AhbYXtiLWcKVVvbycQ@mail.gmail.com>
Message-ID: <CAHk-=wiWQOsxqE+tvZi_MjzGaqfG6Xo5AhbYXtiLWcKVVvbycQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: use naked RET on mixed mode call wrapper
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 18, 2022 at 9:28 AM Borislav Petkov <bp@suse.de> wrote:
>
> So I'm being told we need to untrain on return from EFI to protect the
> kernel from it.

Why would we have to protect the kernel from EFI?

If we can't trust EFI, then the machine is already compromised. We
just *called* an EFI routine, if EFI is untrusted, it did something
random.

I mean, it could have already done something bad at boot time when it
loaded the kernel.

So no, let's not "protect ourselves from EFI".

             Linus

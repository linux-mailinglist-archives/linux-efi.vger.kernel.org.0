Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094A473D346
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jun 2023 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFYTWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Jun 2023 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYTWL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Jun 2023 15:22:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737711B
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 12:22:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e1b1d1698so137236666b.2
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687720925; x=1690312925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcRPbOq0HXbzuhPOK4Z27s+NNduUVsTcr+pW/8xdJWU=;
        b=ISCgFlh2cA1kYD6A3A8Df/XnHobPOULSmHYKMc+1bSOWeMI0RAa75P6JsgdaHeHZJK
         vgQnXCNRRm3PPsZBXNh98F7BogDeBjaaSVUqM3ziHLJcwIXM2OQMisdbkIgV+AEx8zku
         GYREBAMLRdleKHWEZ94BAw9mdkNZQ0TG6wlCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687720925; x=1690312925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcRPbOq0HXbzuhPOK4Z27s+NNduUVsTcr+pW/8xdJWU=;
        b=Y6wB0VnfvXKwR2aBerw/81In+/hBeNVLzXGFd+fbTjLV3Gg3LsVSG1W9eOUN40gAfM
         c/Xc1hY2DDMdz+vEBGOKMEDrPz8aeyFaIxU+GXECO2FKyk71Zw69T5xZYt8k9eJxmDha
         420sK5ewMm87j7jRkR4otlchiqKqmgbkRI3li7OVxwNEPXYC9vI/48WVT5gSVA8U2gj5
         5cx+bM7pPAtNG3z8HpWhFcXMPCFequUV/WUpU1jOf0VYZZLF5q5AkvT7jRdNVnuS0qKi
         ZHmzqmpwaUQxKlymt5JKspssYMmpEjgWgbs8GNWA2yYIHunwMkRauMy1SQfW71sIA/gx
         iJBw==
X-Gm-Message-State: AC+VfDyoYOroMJ78huSjJ1GeoEmNlDFUPHx/MNDMbiXIqt9s1IwAuifs
        Hziw28tFpldi3KHNVmVu0MOEWonFcrKcEF4w7UL33X9J
X-Google-Smtp-Source: ACHHUZ5lV/HHa3ucJxDSjG/mMvyEuhjHvvtmJ2FuwjSopgP3SwWs7cxPOi0KvhWw31KeiD3Lve5tuA==
X-Received: by 2002:a17:907:368c:b0:982:2586:f85 with SMTP id bi12-20020a170907368c00b0098225860f85mr22744463ejc.65.1687720925414;
        Sun, 25 Jun 2023 12:22:05 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b009828e26e519sm2339521ejs.122.2023.06.25.12.22.04
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 12:22:04 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98df3dea907so177811466b.3
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 12:22:04 -0700 (PDT)
X-Received: by 2002:a17:907:26cc:b0:98a:29ca:c58e with SMTP id
 bp12-20020a17090726cc00b0098a29cac58emr12271035ejc.27.1687720924413; Sun, 25
 Jun 2023 12:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230624180446.2048867-1-ardb@kernel.org> <ZJhSysqUcxOqh37n@zx2c4.com>
In-Reply-To: <ZJhSysqUcxOqh37n@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jun 2023 12:21:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
Message-ID: <CAHk-=witNP7Ejgdk8YBZs5ujdxbjqYOVLdbtAsZC1NWoiPWkvA@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited permissions
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 25 Jun 2023 at 07:44, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hm, I'm still not so sure we want to open the pandora's box of having to
> deal with userspaces writing this. Maybe we can keep it in the kernel
> but delay it until a little later in boot so it doesn't cause an
> outright bootup hang?

I don't know a good point to do it at, which would be after the system
is clearly up and running.

The obvious "just delay it by a X amount" might not even work, because
you have things like "the system is still waiting for the user to type
the DM password" or something like that.

That said, it might be enough to at least see if Sami gets more information.

Sami - can you try to revert the revert:

        git revert 69cbeb61ff9093a9155cb19a36d633033f71093a

but then additionally in drivers/firmware/efi/efi.c, just change the

        static DECLARE_WORK(work, refresh_nv_rng_seed);
        schedule_work(&work);

in refresh_nv_rng_seed_notification() to be something like

        static DECLARE_DELAYED_WORK(work, refresh_nv_rng_seed);
        schedule_delayed_work(&work, 120*HZ);

to make the work fire two minutes after boot?

The question then being:

 (a) does that fix the boot for you (maybe it's the schedule_work
itself that confused things, however unlikely that sounds)

 (b) if it does boot, do you notice something happening two minutes
after booting?

But see all the craziness (for example) in efi_query_variable_store()
and the whole 'efi_no_storage_paranoia' thing etc. Messing with EFI
variables has always been painful.

Or just look at efi_crash_gracefully_on_page_fault() and the whole efi
runtime services garbage with efi_rts_work etc.

Yes, those are presumably mostly old EFI setups, but that is kind of
the basic problem here. Many of these EFI calls are much more tested
and reliable in the context of EFI boot services, and *much* less
reliable in the context of "runtime services".

EFI runtime services have been a major PITA over the years. And it's
possible that it's just entirely broken on Sami's laptop.

I'm not entirely sure which laptop it is, with laptop manufacturers
often re-using model names over several years, but "HP 6730b" seems to
be basically from July 2008 (going by the service manual I found). So
we're talking 15 years ago, and yes, EFI was likely *much* less
reliable back then.

              Linus

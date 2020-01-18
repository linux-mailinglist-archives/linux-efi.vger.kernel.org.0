Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC41417B0
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 14:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgARNfJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 08:35:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35698 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgARNfJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 08:35:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so10332726wmb.0
        for <linux-efi@vger.kernel.org>; Sat, 18 Jan 2020 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4hcChVlh2NTB+J9TajvHQFod1mYK/8qvcaZx/KVPww=;
        b=WgOpWoDsUFi+t6oIKOLerTjgdRcFzr0CSjp1eXnLilPlzS3hlcoFW6mmln/ZzjmiZM
         dsVcR7pQ8lnefiCk44p2s24wEfme3C+0dXmTWel4GV83DFjB3Df+ancuXUz/GR09XvDy
         fPZ2JVY0d9b1f0HCYudCPZjMGi2kVsAPTcI+UqUX3fHnODCcokUvDUJd24j8suA8bgTq
         /aymsnnkbtfTFhrTOFgnXusv2GxORzhZDCB5HvKDFPJ9nmN1Fi76bKwgAjKfRqIP8m59
         isrj25fEjee+I9OwhLCCut/AS0krpp9zdYfBEjoE98SDzP5J0Xh0CmQJJLpLYs2OJfNg
         XxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4hcChVlh2NTB+J9TajvHQFod1mYK/8qvcaZx/KVPww=;
        b=oPNPWvCtRhm/N6RTjDQrNNXWPeB0ynbOu3UnMUeSC/rdiHJZkw1Uj90Pzghv7ZvqlT
         zbMqobglg4lVKjFtiDjx9ay4OZsDQBcIKg2aVaft/H6/d0jI2uM5Nvx+LKDA/uJks1Fx
         cM7ErJJwrtjGhxo6gccvvbocm092WeAZh3Fsv7GsV0bZVHmMDyG4clxz58DOexPD81xR
         ZusvE6oadffasDE1tYn/ZaUyMeRJ5flJMQAUaQMAN0CQUgBQSACUDKik/ByV7n2mKyar
         RFO2g0PttD/zNUZSxTGWxBFuYjSaeL90sKHAU6QmPqG201itqsczHyVbuCRrvNL23gEQ
         wEPg==
X-Gm-Message-State: APjAAAUbbLRzwWg7oupMurj2gu3m1C6LLrgbcfNZpgPZ18Sro5X29eYb
        BhelWJWM0FieE5FV5/CPC7LYp479EYkbfKJPVz74rg==
X-Google-Smtp-Source: APXvYqyaoy2vU3Qze84uWGDV1JxToGEVTuxW8nks5DiBJxtsMUOnFnAPiE5XvI3fBz+4/RH6sm4kz+HQlWa4We4ckhQ=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr10152522wmf.133.1579354507256;
 Sat, 18 Jan 2020 05:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu8WBSsG2e8bVpARcwNBrGtMLzUA+bbikHymrZsNQE6wvw@mail.gmail.com>
 <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
In-Reply-To: <934E6F23-96FE-4C59-9387-9ABA2959DBBB@lca.pw>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 18 Jan 2020 14:34:55 +0100
Message-ID: <CAKv+Gu9PfAHP4_Xaj3_PHFGQCsZRk2oXGbh8oTt22y3aCJBFTg@mail.gmail.com>
Subject: Re: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 18 Jan 2020 at 12:04, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 18, 2020, at 3:00 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > Can't we just use READ_ONCE_NOCHECK() instead?
>
> My understanding is that KASAN actually want to make sure there is a no dereference of user memory because it has security implications. Does that make no sense here?

Not really. This code runs extremely early in the boot, with a
temporary 1:1 memory mapping installed so that the EFI firmware can
transition into virtually remapped mode.

Furthermore, the same issue exists for mixed mode, so we'll need to
fix that as well. I'll spin a patch and credit you as the reporter.

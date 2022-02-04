Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76184A9941
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358688AbiBDM1o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 07:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358545AbiBDM1o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Feb 2022 07:27:44 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB81C06173E
        for <linux-efi@vger.kernel.org>; Fri,  4 Feb 2022 04:27:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id p5so18041286ybd.13
        for <linux-efi@vger.kernel.org>; Fri, 04 Feb 2022 04:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E3CkuQfRDLa6yHQhfPXnQaFzdcsQFUeKCKzEBzUj/zQ=;
        b=TLYrEShYRf1FgVk7hHjObf4x7nd8odacHjXXRpq7yKoaHl2d4cJ8VON/yE+OgjlACN
         Deh2m4l0lPgbHURrAba9Ro14SwwCHOG+0Nv/hlUJcn2mcThUbfxE1IEO+W36tUg3MKW8
         n9FacUSOrGV/A/mXTq2Us80gIm1AwkidrArvgQCcxcpwcOfU251m8g9w7lWjvl5mpD4u
         SfanAQlOPlFgouyo1XEy0iTabqHr8/mV6qhVD2e86dRrwMGK8LqcKRLW9ShW+qjxuzZP
         Qoqi5BjNrLiMA0YsO4/3q0qFyxsOyT2LoygR0q9mALUNNnZ+Tl4jGIva6c7WrbMUHXYo
         vjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E3CkuQfRDLa6yHQhfPXnQaFzdcsQFUeKCKzEBzUj/zQ=;
        b=KRhTsVsUFEWL0S1rol7wy9iO6NFq8S8nSlJCYcn1V2F5aw94p+DXVuZlrLmFaLp+Gm
         /EYYrGVERd41JEEgeELp6YmN3Tt9oFL4MBW2qGwaEB23PYvRF/c0BQ+ntIjimbXeVQK8
         gbshk+rD32GSn6+1NNPvPFsEyJjgYzT/TQWN6b9HnxNOjwLJf0r3WF9yHAVF13jvRWRB
         iPbz51BQExXO6BZpbzwtq1m2C5KRaErnCJQG9TE0HVBlhJDApT5nMGv82mtPiHANjB53
         nUHL5XYAeFMEsHUOEfBbjJQWVxiIrh4THcAyHBfhF+VCnO8F30+tQwJnD4eHGUJBe1yC
         V4QQ==
X-Gm-Message-State: AOAM531vRTekDs1owZAg5I8g7IsDnOfBj/Vcy5uq6twnWSa6985KG32J
        sO2AVFqc9hTCnANX80gkJUa8RZ5XSoBtcU2h6P6Vww==
X-Google-Smtp-Source: ABdhPJy0uUYEV/PGiz45GMg1qGGeLJ0gKE2zXBEUciykyjrQIx6iwM/SZFE1OhdU1ZXjgjR2rQwIB4Km1IhUiy5ChGA=
X-Received: by 2002:a81:6605:: with SMTP id a5mr2526438ywc.510.1643977662982;
 Fri, 04 Feb 2022 04:27:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1756:0:0:0:0:0 with HTTP; Fri, 4 Feb 2022 04:27:42 -0800 (PST)
In-Reply-To: <Yfyx8s9n+CZ6TPgg@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com> <Yfyx8s9n+CZ6TPgg@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Fri, 4 Feb 2022 09:27:42 -0300
Message-ID: <CAKgze5YZF09F3FTwD6kODd2RrWATutcmM5J7-wcLTK32C6aptg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto capabilities
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:28PM -0300, Martin Fernandez wrote:
>> +Description:
>> +		This value is 1 if all system memory in this node is
>> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
>
> It didn't jump at me at previous postings, but other architectures won't
> necessary have EFI_MEMORY_CPU_CRYPTO marking crypto-capable memory.
>
> How about
>
>   This value is 1 if all system memory in this node is capable of being
>   protected with the CPU's memory cryptographic capabilities. It is 0
>   otherwise.
>   On EFI architectures with value corresponds to EFI_MEMORY_CPU_CRYPTO.
>
>

Yes, sounds good to me.

Is there other architecture with something similar to this? Or are you
thinking on the possibility of such architecture?

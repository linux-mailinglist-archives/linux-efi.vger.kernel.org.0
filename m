Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE77129FD5
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLXJvX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 04:51:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLXJvX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 04:51:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so19335601wrn.7
        for <linux-efi@vger.kernel.org>; Tue, 24 Dec 2019 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDQYVJqwKy9VrlC0fN44xu7g3oqePLWya4mj982q/t4=;
        b=Mvr4fmpiYrB+0nQxpkrmFTOnyzLDm840DZitghmn7r7y7CSSt7X1vRiUo5L2xBup/6
         +EyhBuGG6GLwXTdN3CiDjOktiOf78SK0fEUhKSO8l7/JDkdleUySM72uJph3VC2cJMuw
         PgSWE+B0Sn8oNhssbI5Ap2ToUa7Hq9zdKNVlBkZxTsKQ4Xc/pwAavtDBYNPq+FE9nvTf
         Tv2+NVLe9D459gaDmlO30F9cB1am0spqDov+c0rs79iaRpzZQ3nClKjyF0xdXCyyOyab
         SlaYHUg1jl3MyPim8SsrzIRMTXN40WDNcyysvb8LzTitvBMgSxIdaqYA/OZOuXcW2NTy
         vYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDQYVJqwKy9VrlC0fN44xu7g3oqePLWya4mj982q/t4=;
        b=LnhgvKgERp6D2TJhe2dB9dqAiSSfaaoQxgKAVVkLWqA5PjCyBNrjYm74IvcDaVeeKb
         oz7SvQA4wMGs9LtNQZNAn7BK0Rl69Wo7SAakCqn+Hi3X33vK9yCJW+j6FG6uwaWrBT9I
         S0wXwr5uAhuWig6J1ScbX6CALbZFOaThNtKWMqsk8hzAqxK7Dow3pxh/E1nKz8EFqgcr
         9yhx3M+X3VKjvQB4YFPhmqzIIdl9uhMXNb2n++ZBbzSbb1K0FnTqGV9iiriN2m1aOKdv
         VGy3J4sAuCBAZ5qFVeFcMqySI5z9EkVek8O/kxSnZaKmNS/Ik6U2r7+SdXGGE0qhTwVc
         oRRA==
X-Gm-Message-State: APjAAAVwQ2VeMii4kVuaxgNGwRy2sFKa9285bOfL5OxaDyzC/nf6yrz/
        8x3aBbpVpIdDBUV9XADtI3Q5XUxRH0NXriveNYcULw==
X-Google-Smtp-Source: APXvYqxwVWMpONljWnw5EGgAx/SITMEkK8kI+qNjb4UjMbNV3rRBVY5jpt3EBnJ8E32ORKOp8R4zVpp/fkJ0PumOA5U=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr32288671wrr.32.1577181080636;
 Tue, 24 Dec 2019 01:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20181124162123.21300-1-n.merinov@inango-systems.com> <20191224092119.4581-1-n.merinov@inango-systems.com>
In-Reply-To: <20191224092119.4581-1-n.merinov@inango-systems.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Dec 2019 10:51:19 +0100
Message-ID: <CAKv+Gu98Gi5Uvz7AZw4ky_-sxOZxJ4687jxyQsJU6d3TGkem1g@mail.gmail.com>
Subject: Re: [PATCH v2] partitions/efi: Fix partition name parsing in GUID
 partition entry
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Dec 2019 at 10:29, Nikolai Merinov
<n.merinov@inango-systems.com> wrote:
>
> GUID partition entry defined to have a partition name as 36 UTF-16LE
> code units. This means that on big-endian platforms ASCII symbols
> would be read with 0xXX00 efi_char16_t character code. In order to
> correctly extract ASCII characters from a partition name field we
> should be converted from 16LE to CPU architecture.
>
> The problem exists on all big endian platforms.
>
> Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index db2fef7dfc47..51287a8a3bea 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -715,7 +715,7 @@ int efi_partition(struct parsed_partitions *state)
>                                 ARRAY_SIZE(ptes[i].partition_name));
>                 info->volname[label_max] = 0;
>                 while (label_count < label_max) {
> -                       u8 c = ptes[i].partition_name[label_count] & 0xff;
> +                       u8 c = le16_to_cpu(ptes[i].partition_name[label_count]) & 0xff;
>                         if (c && !isprint(c))
>                                 c = '!';
>                         info->volname[label_count] = c;
> diff --git a/block/partitions/efi.h b/block/partitions/efi.h
> index 3e8576157575..0b6d5b7be111 100644
> --- a/block/partitions/efi.h
> +++ b/block/partitions/efi.h
> @@ -88,7 +88,7 @@ typedef struct _gpt_entry {
>         __le64 starting_lba;
>         __le64 ending_lba;
>         gpt_entry_attributes attributes;
> -       efi_char16_t partition_name[72 / sizeof (efi_char16_t)];
> +       __le16 partition_name[72 / sizeof (__le16)];
>  } __packed gpt_entry;
>
>  typedef struct _gpt_mbr_record {
> --
> 2.17.1
>

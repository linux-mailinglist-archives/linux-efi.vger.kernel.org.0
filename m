Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1953065E944
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 11:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjAEKsi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 05:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjAEKsY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 05:48:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4A4FD69;
        Thu,  5 Jan 2023 02:48:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c17so52240394edj.13;
        Thu, 05 Jan 2023 02:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qLrWDP8UxJVLXXHnMyGiQx4P9YZKALZZuu63FSiH6E=;
        b=E9K3NJxE30vOeMc0DOcQs6pSTojhjB7VLiWumrWgtVBlynfouL2iOIIZjBQlA011se
         3PvotfAYQx0uvyVsV3uk2OY3h3brtmDIxPl0L48Xy8zFsV6malBcnPUYTgNZrdVinMNX
         F6nb6b7Kjjw6m4lsrqnpiUNq4ILqGBfJvKObH6L0rUNZm18rkzP4w2xGkHzp1FHa9Rvm
         BLtL0upydoAO/nkIVsz/9wUmDjnhGBIRLg1YpwRWuJ5aGyCVTrjf2bD6lUHK6fvkyEB+
         S2B3dOJ/J6rg9ekk6KoVGdA+Qi0yaOxNng0aL9zuTM2bJBEByO6xvhdLSifOUP6wEZKk
         klYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qLrWDP8UxJVLXXHnMyGiQx4P9YZKALZZuu63FSiH6E=;
        b=EHCTtM3BcMG3gt34KEZ8rUD8DMMBgtgohm1NjoYp3tYX3sG0qBfh6d19jdEi4gdSbr
         Y+1XpesdR+Nr7dW94vji0NjMjpXV85VMNtZUXbbxhDUdX4w0Mq5bjHsmpqAa8IR67jrh
         RafNEZy6lv3baO0jnQJbu14iRuORLJyotjbh6Kf3pQuZEj1SHOXS9NRk/X0XnkPbqBBo
         4dz+kI7l7SnnjBLAvr5CXivuVcmVW4Zhl61UU5/9hDL+FmHRUtrvwhn+sZCcjXP4m0uv
         LbyFSpu3uNXarNn1ku+oKsLYz6j348f1zNsi906SdHOr0Xr4wb4yZ9fjHE9juofhAqgc
         Eyng==
X-Gm-Message-State: AFqh2kqCiEdBm8+hvPu8IGQCDTK1UcopyszB0Pb+QaQbsjyvxAnccbNc
        95nYCsbmw7xaVJEYdULTZSI=
X-Google-Smtp-Source: AMrXdXuJWhyrmy1YZjk6sB1ll1kMT60CGgwsH2fEDRfVrLmdIwzKXMnsgcamI+al2donwj3dOaq/aw==
X-Received: by 2002:a05:6402:3784:b0:46d:cead:4eab with SMTP id et4-20020a056402378400b0046dcead4eabmr46314439edb.6.1672915696661;
        Thu, 05 Jan 2023 02:48:16 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16297503ejy.127.2023.01.05.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:48:15 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Jan 2023 11:48:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Aaron Thompson <dev@aaront.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/1] mm: Always release pages to the buddy allocator
 in memblock_free_late().
Message-ID: <Y7aq7fzKZ/EdLVp3@gmail.com>
References: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
 <20230105041650.1485-1-dev@aaront.org>
 <010001858025fc22-e619988e-c0a5-4545-bd93-783890b9ad14-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001858025fc22-e619988e-c0a5-4545-bd93-783890b9ad14-000000@email.amazonses.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Aaron Thompson <dev@aaront.org> wrote:

> For example, on an Amazon EC2 t3.micro VM (1 GB) booting via EFI:
> 
> v6.2-rc2:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  178867
> 
> v6.2-rc2 + patch:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  222816   # +43,949 pages

[ Note the annotation I added to the output - might be useful in the changelog too. ]

So this patch adds around +17% of RAM to this 1 GB virtual system? That 
looks rather significant ...

Thanks,

	Ingo

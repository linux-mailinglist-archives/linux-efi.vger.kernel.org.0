Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC565F9F9
	for <lists+linux-efi@lfdr.de>; Fri,  6 Jan 2023 04:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjAFDM5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 22:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjAFDMz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 22:12:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903A625D5;
        Thu,  5 Jan 2023 19:12:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso269927wms.5;
        Thu, 05 Jan 2023 19:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21zf54EYWZhDQm73m3HRBf5o2in9eTbBIqduSXeMgk8=;
        b=aZ44bH1sYnQ5JsJWaicvpGtsRM5DotnzGw9qrWsN9MnkMjhlFHk9hWepiejOwWgRZW
         I8+mM2CLp5LlUZq6i32263xTMJQTPcu/SgYfC9R9cJDmcdv15YWgzye+5pUh7P3kGzR1
         smiEj2VLf+hZihLytPT/8uetBwjhUmOMYidBUfo7Tu64fYNKfVPY86KAP/gNW/BxLlwl
         KhQWSsRSPSOqyhETLgGquudZuGX15ZU4wRo4NRoL15UxxsF6SFkzk4erKklymtLyc11J
         anAL4L64j3wSDaoWKinZc3dxZnRhWRGMhuIG0pYMQR2OKw13141Wd7SNtBHhJk5aDhEY
         TTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21zf54EYWZhDQm73m3HRBf5o2in9eTbBIqduSXeMgk8=;
        b=J4YuNaCcH13Ipi77kpmCrckUzRVgqDNrJACULrVcYmp0YhqICBCYzKZwIy+qjuQSdo
         iE6V7nlppWR1Qfx21gL0JJCRScZ55dkE+6VhgByZkqgqyJllFpvzXRTzEmtn2XZC6wVg
         KDXMLqN2B0qXvY6b2Upiz/M1RF2CFS1vGM/P+SAOh2DpYzXx/VzSAQu9RVuUMycTL0uM
         jysxPGznFVANfeq9ugC+Lm2r9UmaUzU7vJT4ZWgj+3++uMewBBCWaDrYroPiGsVK1vVZ
         UrpIn5F6vpnxOF7GUfHqev7jBd3N/gGpkW1xGMTS+pCZT/SK8/v/VfPoxvm9xD4hF/tG
         rPSw==
X-Gm-Message-State: AFqh2kr9S9t9R7zRYEzU16qOC99R/1ceVPu7y53OlDcItrp3aaKWk+n3
        b7xHRoydvGhoGjvcc4edoGMvydfChW4=
X-Google-Smtp-Source: AMrXdXtR5P+Ujt2kAioRpWXKR1dGUjAnz9UesBoywCFrbsEvTlyXCnKGra1fH0QuZVVUrzDHHyt8yw==
X-Received: by 2002:a05:600c:3ca2:b0:3d9:da3a:ef9b with SMTP id bg34-20020a05600c3ca200b003d9da3aef9bmr639110wmb.31.1672974772270;
        Thu, 05 Jan 2023 19:12:52 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003d99a39b846sm65434wmg.5.2023.01.05.19.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:12:51 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 04:12:49 +0100
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
Message-ID: <Y7eRsWuu8jZgZtUt@gmail.com>
References: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
 <20230105041650.1485-1-dev@aaront.org>
 <010001858025fc22-e619988e-c0a5-4545-bd93-783890b9ad14-000000@email.amazonses.com>
 <Y7aq7fzKZ/EdLVp3@gmail.com>
 <0101018584d0b5a3-ea0e4d67-b00f-4254-8e1c-767fcafbec31-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101018584d0b5a3-ea0e4d67-b00f-4254-8e1c-767fcafbec31-000000@us-west-2.amazonses.com>
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

> 
> On 2023-01-05 02:48, Ingo Molnar wrote:
> > * Aaron Thompson <dev@aaront.org> wrote:
> > 
> > > For example, on an Amazon EC2 t3.micro VM (1 GB) booting via EFI:
> > > 
> > > v6.2-rc2:
> > >   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
> > >   Node 0, zone      DMA
> > >           spanned  4095
> > >           present  3999
> > >           managed  3840
> > >   Node 0, zone    DMA32
> > >           spanned  246652
> > >           present  245868
> > >           managed  178867
> > > 
> > > v6.2-rc2 + patch:
> > >   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
> > >   Node 0, zone      DMA
> > >           spanned  4095
> > >           present  3999
> > >           managed  3840
> > >   Node 0, zone    DMA32
> > >           spanned  246652
> > >           present  245868
> > >           managed  222816   # +43,949 pages
> > 
> > [ Note the annotation I added to the output - might be useful in the
> > changelog too. ]
> > 
> > So this patch adds around +17% of RAM to this 1 GB virtual system? That
> > looks rather significant ...
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> It is significant, but I wouldn't describe it as being added. I would say
> that the system is currently losing 17% of RAM due to a bug, and this patch
> fixes that bug.

To the end-user gaining +17% [or +3%] extra usable RAM compared to what 
they had before is what matters, and it's a big deal. :-)

Thanks,

	Ingo

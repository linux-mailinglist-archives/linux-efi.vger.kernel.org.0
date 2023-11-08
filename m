Return-Path: <linux-efi+bounces-9-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034017E5513
	for <lists+linux-efi@lfdr.de>; Wed,  8 Nov 2023 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A8CB20C66
	for <lists+linux-efi@lfdr.de>; Wed,  8 Nov 2023 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C7FC05;
	Wed,  8 Nov 2023 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWlcNiqS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7B15E8F
	for <linux-efi@vger.kernel.org>; Wed,  8 Nov 2023 11:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23FC433CA;
	Wed,  8 Nov 2023 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699442498;
	bh=QvsTGBMyqYpxG6wP7fIuna1QJ2h+U8Zr4q9TDrPobzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gWlcNiqSDq4qFVyFdJfl776u13v1D3lGiyXuHJFmCgwKAgfldkN6uhd82YmHop11n
	 ZEarMs8JL6qSsl42zZIzZTJU1/8sGKMavpJESNw8NzDgKSU+l77sm9gAX5vXmOe1XU
	 OgJKpF3GiYvn4tnDoNJVI81qZuCgCcJ5BICEMhJ5Ne55F6KpbBSyA8va+wkU7zfa+O
	 KH/t10/9RZnvi9LxpfO20JL9kQaZVd3dcssNOKSt8HA3TzSGip+jPDVl3sh6ORcczj
	 5mUR9TxtbBWl51iP4IsxeO5J4LYC+Q2DTN5ihLDIGVMpaCyQ4h1CAVej0dwivDr3Am
	 B73P5g3RoDlBw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so92527471fa.3;
        Wed, 08 Nov 2023 03:21:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yzs7TwPMygzYUJc6/Bv+zW6dib99Aaf079cZhtHngYZtbWNbS2u
	aSOEVC+JigNEkf1+f9ekRzcZ/gXKDA6nU4iJ1u0=
X-Google-Smtp-Source: AGHT+IHKnW94kmpfk41V+VUBlyb5MZkNOu6rsHPRwJbnCNLDFUUTlJmQcw/1/mXOa4hPXI6dgkL15ag2oOUH+v6SQfo=
X-Received: by 2002:a2e:9c50:0:b0:2c5:32b:28ea with SMTP id
 t16-20020a2e9c50000000b002c5032b28eamr1380107ljj.32.1699442496753; Wed, 08
 Nov 2023 03:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103151354.110636-1-michael.roth@amd.com> <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
In-Reply-To: <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 8 Nov 2023 12:21:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Message-ID: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	stable@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/3/23 16:13, Michael Roth wrote:
> > When a task needs to accept memory it will scan the accepting_list
> > to see if any ranges already being processed by other tasks overlap
> > with its range. Due to an off-by-one in the range comparisons, a task
> > might falsely determine that an overlapping range is being accepted,
> > leading to an unnecessary delay before it begins processing the range.
> >
> > Fix the off-by-one in the range comparison to prevent this and slightly
> > improve performance.
> >
> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> More justification for introducing a common ranges_overlap() helper somewhere :)
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks, I'll take this as a fix.


> > ---
> > v2:
> >  * Improve commit message terminology (Kirill)
> > ---
> >  drivers/firmware/efi/unaccepted_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> > index 135278ddaf62..79fb687bb90f 100644
> > --- a/drivers/firmware/efi/unaccepted_memory.c
> > +++ b/drivers/firmware/efi/unaccepted_memory.c
> > @@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
> >        * overlap on physical address level.
> >        */
> >       list_for_each_entry(entry, &accepting_list, list) {
> > -             if (entry->end < range.start)
> > +             if (entry->end <= range.start)
> >                       continue;
> >               if (entry->start >= range.end)
> >                       continue;
>


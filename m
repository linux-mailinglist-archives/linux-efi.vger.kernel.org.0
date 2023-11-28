Return-Path: <linux-efi+bounces-94-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8957FB9A8
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FAB1F20F77
	for <lists+linux-efi@lfdr.de>; Tue, 28 Nov 2023 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209D4F887;
	Tue, 28 Nov 2023 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjVTNoCn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C584EB50
	for <linux-efi@vger.kernel.org>; Tue, 28 Nov 2023 11:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78109C433CC;
	Tue, 28 Nov 2023 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701172214;
	bh=OCv5jOPu04qFPi6ssiG4av97RLxhHF1iTMxErUPuhxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OjVTNoCngj8vhKQa4NLxoGYZGPzhnXiWZTtymJszXRp9aE5OHmasJdxQxtWYTb1lT
	 x+1ii7lVkfaehoU9AwY17drmJlHGDUVjY7gb2ulMt29SnG31aIAXjY37IRjiHqrjRT
	 3IyWZ8kl4uz0D3//4gXLGxipDqQnpzx9x+U9UdxJYrg2UWwtb4/ihKunSdFRHYuX+H
	 D+x+WM+Y3GycueXKYJcj+GJCE306wYDXHxsJla04bHbSsmI8/Hi3Dnwyv/uDMfvytG
	 1/2/evih98QpUNbii8Xkms+PQRMMYyODIGLBkHgdLmBJvtbqfJl+XYsK2hGEgkS/Gz
	 iCU0/MZpgLXFA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c9b8363683so3623011fa.3;
        Tue, 28 Nov 2023 03:50:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yx5jqUbtgYW/G3SpJbJnB6Qtq2V+fGwottcRm1Yo2vFFcLjcjRQ
	2LEuHEgv7AKMUL6xWVigi1VERosYiMaVBvRxIrM=
X-Google-Smtp-Source: AGHT+IEcQ8JC8Crlu73uQLM9HlwZR3LZT0et+kEASrOblD8H6K4gVCHuT491KE4vEf9NtjRDaSpeS0lEVW4n7CQRei0=
X-Received: by 2002:a2e:7a0e:0:b0:2c9:b8e0:6e4c with SMTP id
 v14-20020a2e7a0e000000b002c9b8e06e4cmr434921ljc.49.1701172212628; Tue, 28 Nov
 2023 03:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103151354.110636-1-michael.roth@amd.com> <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
 <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com> <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
In-Reply-To: <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 28 Nov 2023 12:50:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE65htEpXSL+h1X-zQ2RH4Oc193rac7=PBYMYJvEUBXNA@mail.gmail.com>
Message-ID: <CAMj1kXE65htEpXSL+h1X-zQ2RH4Oc193rac7=PBYMYJvEUBXNA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	stable@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Nov 2023 at 12:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/8/23 12:21, Ard Biesheuvel wrote:
> > On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 11/3/23 16:13, Michael Roth wrote:
> >> > When a task needs to accept memory it will scan the accepting_list
> >> > to see if any ranges already being processed by other tasks overlap
> >> > with its range. Due to an off-by-one in the range comparisons, a task
> >> > might falsely determine that an overlapping range is being accepted,
> >> > leading to an unnecessary delay before it begins processing the range.
> >> >
> >> > Fix the off-by-one in the range comparison to prevent this and slightly
> >> > improve performance.
> >> >
> >> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> >> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
> >> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >>
> >> More justification for introducing a common ranges_overlap() helper somewhere :)
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >
> > Thanks, I'll take this as a fix.
>
> Ping, can't see it in mainline nor -next?
>

Apologies - queued up now.


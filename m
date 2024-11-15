Return-Path: <linux-efi+bounces-2158-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A19CDD30
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 12:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DC6282908
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6A1B6CE3;
	Fri, 15 Nov 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9a6Idmf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E731B6CE1
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668512; cv=none; b=r6/ipaCTIRErO/hLQct5MTkwm0zWyCZqTtjtHGxNk1C0hFVzwg2765ZwJcImRDlmW/emGJ3NaVKbUKV1ui3Ryjy9aMmfHZyvzZhGply9gHdRxAVvzJZLeDTFuOrEhgIMdRONWibnvfE1KtZ6D/N+W5vrOMzU85SGvAp+XRIoe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668512; c=relaxed/simple;
	bh=aTlQYDvLXJ+Lh5VENzQZL18AMJnTpnBPkXzdk/jRpIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUQiDFG/ve+MR4ttF/mwfTyf8UOf5syY2+ZpTmq3XECwKGdqH+7jXUqcUm1lupgMZN9UDL86EHsAnmPDW8m73MC+K1RaQoMQc83z1nmmmo9RhtRmNYVHj7GOOVg/nL43WJtivX19MpJUi9NqeCl8nIpR6Eufibyclvo0ZL9kt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9a6Idmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A142C4CED4
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731668511;
	bh=aTlQYDvLXJ+Lh5VENzQZL18AMJnTpnBPkXzdk/jRpIE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G9a6IdmfLuZEGSxc25ZjnxN1roycGKt3DaQ3iR5j5NNCnt7Q9PH8Qr9ci4QB3Q6b5
	 sOhWvRNa5tJ9ewddAxkc1109aO1hYqWjNaObpK5oe7gNr4FPaZXLVhVevVvJEkuJ19
	 QBRow+XKXQhshzSqtekC8pqv1PGo1amAv3Qhjh8zoPhlb3xsd1Z8PHIcrmS/rBa3rV
	 bTy9Ixps5zYE0Vgbkwtfp4wA3wanXU7C7YFR/7EFJ5aFrBg2tI5HTSfL/NntDFXKc3
	 k8urNf56q1vnz4swygqsXZvgNmYpQvu4Fh5S7vjESH6lQRdVSVChdl38MHYUrn95f0
	 AwsGnnKRrlDgQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso16647651fa.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 03:01:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhFiC/+Hu2i0qbPArJP2DxMJa5ficYnwqcORNwjHve2ldQISbsYLo1XOd76WwME1Pzp2fYAalulZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUU77Trsp0penQA+N1cIK6vNVpJLSfW+DOMzyVgukSMTes557
	dyWjIIIkdD7DO01i6LbmNFltcziDJF944erck6j7v/OfFaYLttKglBZjyG0v51DPqgjBHJ+pCJa
	5J3tPd8RhjMmKiBqLHmQ2QDPBDAI=
X-Google-Smtp-Source: AGHT+IGD/dX3Vof6yYosgCG64MVsbh6CZVtr7430l+jM1hUnCcJFOal8cGpociuS4iYuvelS043NQj7aA3e7Z+dx1rE=
X-Received: by 2002:a05:651c:515:b0:2fb:3960:9657 with SMTP id
 38308e7fff4ca-2ff566a60e5mr19544401fa.12.1731668509860; Fri, 15 Nov 2024
 03:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031175822.2952471-2-ardb+git@google.com> <20241115-honored-macho-deer-dc6def@leitao>
 <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com> <0ee375db-c720-4af3-a74b-d95777212f6e@kernel.org>
In-Reply-To: <0ee375db-c720-4af3-a74b-d95777212f6e@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 12:01:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFN48MynLN7gDqYOrA61R5k62pr4NHwvUAKwMGs6xMvdA@mail.gmail.com>
Message-ID: <CAMj1kXFN48MynLN7gDqYOrA61R5k62pr4NHwvUAKwMGs6xMvdA@mail.gmail.com>
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 11:51, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 15. 11. 24, 11:21, Ard Biesheuvel wrote:
> > On Fri, 15 Nov 2024 at 11:10, Breno Leitao <leitao@debian.org> wrote:
> >>
> >> Hello Ard,
> >>
> >> On Thu, Oct 31, 2024 at 06:58:23PM +0100, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> There are reports [0] of cases where a corrupt EFI Memory Attributes
> >>> Table leads to out of memory issues at boot because the descriptor size
> >>> and entry count in the table header are still used to reserve the entire
> >>> table in memory, even though the resulting region is gigabytes in size.
> >>>
> >>> Given that the EFI Memory Attributes Table is supposed to carry up to 3
> >>> entries for each EfiRuntimeServicesCode region in the EFI memory map,
> >>> and given that there is no reason for the descriptor size used in the
> >>> table to exceed the one used in the EFI memory map, 3x the size of the
> >>> entire EFI memory map is a reasonable upper bound for the size of this
> >>> table. This means that sizes exceeding that are highly likely to be
> >>> based on corrupted data, and the table should just be ignored instead.
> >>
> >> I haven't seen this patch landing in net-next tree yet.
> >> Do you have plan to have this merged into 6.13?
> >>
> >
> > Nobody replied to it, so I wasn't going to.
> >
> > Would you like this patch to be taken for v6.13? Does it fix the
> > issues you have been observing?
>
> For the reporter at:
>    https://bugzilla.suse.com/show_bug.cgi?id=1231465#c50
> definitely!
>
> I was expected this to land in the tree too... (Without any further
> notifications to you.)
>

Excellent. I'll take this as an ack from both of you.


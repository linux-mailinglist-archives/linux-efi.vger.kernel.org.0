Return-Path: <linux-efi+bounces-2160-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CA9CDDAF
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B842280A1E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058F149C53;
	Fri, 15 Nov 2024 11:47:10 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9852F9E
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671230; cv=none; b=DfunwwEK57IXmD9IE8UEGo3h56roPaCPNoO3LMBgNYSKIlGAQLbQipXwA7bnma7fHJwG7uPp+CWyI83tQ1x476DBuuD+y1/qng1zPu9jrG3tpKe7kWV+fiCMjyWJ3gN5pVPUNGGu04AgYXr7kpf9oNcG8FMx028lbo0wlFMlIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671230; c=relaxed/simple;
	bh=F03nWzAVRYHWEg+ISJ4bjRjR3SFFpo6fvfLGx9FGTdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7Y2mBmht0umXohpSaZCvxNQNTW0Bul8IcypwjGDEA0A0npS192Q2ks9hKUE0Tfht501GfBr1BsdD2748sZGCCzajRTGnGvLzOGXDVK9xxhXLCFLtABlUnCyw+TYrDEiyDET1fs4Y0N+yctTU4fJ1o6Q9FDyTMsdgtfCBmaCKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf764e50a3so3307085a12.1
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 03:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671227; x=1732276027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ydOhXtQ8y/lJFhQ7HxBZ7nq8FExAnfI5B1/sjoeY/s=;
        b=tEdbhGZABrR7EJ+akxf5jxy3TPeWEaifW8sxGAW7qtA6O7oZPuheSg3zR4ekU8kXBl
         1ZDOU0S7Zxk6+94IcDGkacz6Vdbi1ocDDAcCWG9ATdDB3JDnlJ/UOG9ihwIEQx4FgooQ
         KiMfgR61Xdj/rhzy/TaolDIJ2GwJRcKEchlqL5b1D3tkL3GQwS/+3mr80nIxzQ0uYCZX
         QRY2Y+rZRgyL93DCFvXVDZLjrFY2CHfkW7AhCzPJoxHiXnlgM9JGLneA6kTC7/uKmpTe
         eZ/gHMipzGRzTNZk5jL5uxwSx6vdVVo+w0BRFoXCqBD4YZ3+rZEO9q6hfLjUcN3prxbB
         zeyg==
X-Forwarded-Encrypted: i=1; AJvYcCUy9iQkR+0WkX4ksmB/ofX4PshqeSucsvjW5Pjidf84djDuaXzPuwRRBOW7P7iprdatYgLKnf+obNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZGE3EeLwOwDxPDDW8P6lPeGyQ5TH1axbywb0Xt/QpU0saP6L
	1snh5G1FEnRR0pvryJ7FBDm7e/ujf1G+KNS36G1oPAdCTcCJ886tLc9lNQ==
X-Google-Smtp-Source: AGHT+IG4nKYrapwja/ZIsFL2NQwlINWlMTsyxbxfXV5LKcs+Vk0ytNfAUxxxIlxJBr2hiEZJoyjnNQ==
X-Received: by 2002:a05:6402:42c2:b0:5cf:1214:8146 with SMTP id 4fb4d7f45d1cf-5cf754baadcmr6824664a12.4.1731671226772;
        Fri, 15 Nov 2024 03:47:06 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9fabdsm1568119a12.30.2024.11.15.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:47:05 -0800 (PST)
Date: Fri, 15 Nov 2024 03:47:02 -0800
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v2] efi/memattr: Ignore table if the size is clearly bogus
Message-ID: <20241115-tamarin-of-regular-pleasure-59d243@leitao>
References: <20241031175822.2952471-2-ardb+git@google.com>
 <20241115-honored-macho-deer-dc6def@leitao>
 <CAMj1kXFjjMcHkbFAsSWJuqtzi2raJgLikx37ipxAB9f0ymXNQA@mail.gmail.com>
 <0ee375db-c720-4af3-a74b-d95777212f6e@kernel.org>
 <CAMj1kXFN48MynLN7gDqYOrA61R5k62pr4NHwvUAKwMGs6xMvdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFN48MynLN7gDqYOrA61R5k62pr4NHwvUAKwMGs6xMvdA@mail.gmail.com>

On Fri, Nov 15, 2024 at 12:01:38PM +0100, Ard Biesheuvel wrote:
> On Fri, 15 Nov 2024 at 11:51, Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 15. 11. 24, 11:21, Ard Biesheuvel wrote:
> > > On Fri, 15 Nov 2024 at 11:10, Breno Leitao <leitao@debian.org> wrote:
> > >>
> > >> Hello Ard,
> > >>
> > >> On Thu, Oct 31, 2024 at 06:58:23PM +0100, Ard Biesheuvel wrote:
> > >>> From: Ard Biesheuvel <ardb@kernel.org>
> > >>>
> > >>> There are reports [0] of cases where a corrupt EFI Memory Attributes
> > >>> Table leads to out of memory issues at boot because the descriptor size
> > >>> and entry count in the table header are still used to reserve the entire
> > >>> table in memory, even though the resulting region is gigabytes in size.
> > >>>
> > >>> Given that the EFI Memory Attributes Table is supposed to carry up to 3
> > >>> entries for each EfiRuntimeServicesCode region in the EFI memory map,
> > >>> and given that there is no reason for the descriptor size used in the
> > >>> table to exceed the one used in the EFI memory map, 3x the size of the
> > >>> entire EFI memory map is a reasonable upper bound for the size of this
> > >>> table. This means that sizes exceeding that are highly likely to be
> > >>> based on corrupted data, and the table should just be ignored instead.
> > >>
> > >> I haven't seen this patch landing in net-next tree yet.
> > >> Do you have plan to have this merged into 6.13?
> > >>
> > >
> > > Nobody replied to it, so I wasn't going to.
> > >
> > > Would you like this patch to be taken for v6.13? Does it fix the
> > > issues you have been observing?
> >
> > For the reporter at:
> >    https://bugzilla.suse.com/show_bug.cgi?id=1231465#c50
> > definitely!
> >
> > I was expected this to land in the tree too... (Without any further
> > notifications to you.)
> >
> 
> Excellent. I'll take this as an ack from both of you.

Thanks! I've just send a "formal" ack to keep it registered.

Thanks again for solving it.
--breno


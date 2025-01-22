Return-Path: <linux-efi+bounces-2706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D1A18B5F
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 06:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD763A2658
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0B158553;
	Wed, 22 Jan 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdeIsokf"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5175653
	for <linux-efi@vger.kernel.org>; Wed, 22 Jan 2025 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524200; cv=none; b=eZ0ZxxJUsryy7CbH1kqvVfoB7N2zMXnzhVkEcqaXIULJLwXHurZat8NfXvdubFqWJbWy3QNgR5N9s7BZCdXBmUMqFliJArguzGkAHamVS9l5UgfWW/tJNgvwciZhwAgJhYD7c5GOSfaQ3vj1Q+UT8lV2/TQEH9TEEhbZRsMWIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524200; c=relaxed/simple;
	bh=UC6SPXbVWG7D+1nWgT0HOFqwaAUx7rwTE5Uw+N1YZe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRq9Sk+sZS1aiDIzaMPBcH/kFKtGBiVw1NyLUUvuW2EEZLQ9BrAUXPejbiKyNxSwT7u7YTxO81ZPbjjs3AeHX+rnvgE1BkegXTEwfX0dilrTNhibtqoKXnoW+JKTcSjiomYZUYPjib/dSqC439SILB9BJDk5f869Iu7kJcWJuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdeIsokf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737524197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9l60eMiBatjulNqPwNpZ4yuZ+rTXdgZOa9/Ftk6xxo4=;
	b=JdeIsokf7h2uM/w0eZmdijt9LjikUpyh7gxMcITt4E/zdzjLihQrGrVQVFJq5HMTlwtlFK
	eG+4aMsoZ0WZ0W+ePi4PNqilCtvKKhePV5lmBYLhIlGND9kEPCLW4vEkF0dQiBc06eRUuE
	WzMB28wBEoHDd6fIt62l5mSRz8zPx48=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-YPvCBT8CMPiNhGd_biDdrA-1; Wed, 22 Jan 2025 00:36:34 -0500
X-MC-Unique: YPvCBT8CMPiNhGd_biDdrA-1
X-Mimecast-MFC-AGG-ID: YPvCBT8CMPiNhGd_biDdrA
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfb3c4fc77so2088065ab.1
        for <linux-efi@vger.kernel.org>; Tue, 21 Jan 2025 21:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524194; x=1738128994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l60eMiBatjulNqPwNpZ4yuZ+rTXdgZOa9/Ftk6xxo4=;
        b=XapQ9eXEYYdtyRcBiixiyvfaiHXTLYEhZdOr3xIJNaOWYwFBhzsVTYPPt3YDx3PeMJ
         cqK55SFd9xbCxp8zx6y4l/YdRMy4nePYqVFt8Y/kgzEQ2dlvcZGCsRbKlsW2gqrHn/c0
         xnm7SeVTPUpnhw0W5yBCDyPbWSSjcvcIT2pss4ar1iSK+VjggQdhg4qgb/D/LfVK6I8T
         v0+ry8zzobE6SPTH7Wk+j0b3kCZ/toi3xBgvxanNvj03BjAdpjyNklSKO6+gkO/z2TCV
         1c2zcMJFnpA1TrzQC+QxlS7PiR8pYcU69iuxQNKPJkFDnGTjbp1agq7BR5kBmdUwxi+6
         pZUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWiCXZBvyhMqwX53wNEDjxqL4WPhE+ikkYcFwyTVQziCesl+cOXUAs7TIGM685CtL93JY4XRv10u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqPqcYbwbVQp43Y4Lrzbprud8o7EE/0vkkY9Gb1ZC0nqjVKkl
	6b9GE/4/1QZUi2E0H8up2LTneUjfW6rcWGHzRm4li+0QWGvI9OgUMhDPUNbEBLtQ+L2nGWOqemU
	dA/42IiPDt3O0km28RIiaV2OLDHKykYNrfpBOGEuTibdNT/PVGkdr54TI7rW/erUE5qsmGBvaZr
	JcBk6RoIzu+OL3PedChrGbZJJxa6RUuA/s
X-Gm-Gg: ASbGncsRyJ3bf8fJRIAlIWQdfhbMGYaxH8+qJ5UfNPNaBhmBf7GBm8F8N/VJ54BQjIX
	UlnrT4eDf6s99Jx4yKRSi/+eFc0cdGXhc+BROliPTIiAwntnujuex
X-Received: by 2002:a05:6e02:b28:b0:3cd:e9a0:3c3d with SMTP id e9e14a558f8ab-3cf7479d52amr170082755ab.2.1737524193749;
        Tue, 21 Jan 2025 21:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1NteIeOEFSZQJMQta9H79qVzAVNQuPvHhvy/+a48GnvWI55kw2kVLGryRVDAv7Jiw553w+jC1f5oh5mpxImA=
X-Received: by 2002:a05:6e02:b28:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3cf7479d52amr170082645ab.2.1737524193462; Tue, 21 Jan 2025
 21:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com> <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com> <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com> <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com> <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com> <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com> <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
 <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
In-Reply-To: <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 22 Jan 2025 13:36:40 +0800
X-Gm-Features: AbW1kvasSuob105uOOtVQhAqqYFk9t9t0n8BzZ024DbzitZW85su35TvVCpG4fY
Message-ID: <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Hi,
On Mon, 20 Jan 2025 at 19:48, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 20/01/2025 11:29, Ard Biesheuvel wrote:
> > On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> >>
> >> On 20/01/2025 10:32, Ard Biesheuvel wrote:
> >>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>>
> >>> ...
> >>>> Hi Ard,
> >>>>
> >>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
> >>>> and corruption during kexec as done in this series or not initialize memory attributes
> >>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
> >>>>
> >>>
> >>> I would prefer kexec boot on x86 to disregard the memory attributes
> >>> table entirely.
> >>
> >> Would you like Dave to send something like
> >> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
> >> on the mailing list (wrapped in ifdef CONFIG_X86_64)
> >>
> >
> > I prefer this approach. and no need for the ifdef, this is x86
> > specific code, and the memory attributes table is already ignored
> > entirely on 32-bit x86 iirc
>
> ah yes, I ignored the file name when reviewing it and just focused on the function :)
>
> Will wait for Dave to send it.

Ok,  I will add reported-by from you and suggested-by from Ard.  But I
can not test the efi mem attr, I'd prefer to have your test results
first.  Could you confirm that?

Thanks
Dave



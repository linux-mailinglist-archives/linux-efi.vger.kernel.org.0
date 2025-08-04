Return-Path: <linux-efi+bounces-4507-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687AB19B16
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 07:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427417A70E3
	for <lists+linux-efi@lfdr.de>; Mon,  4 Aug 2025 05:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6C21B9D6;
	Mon,  4 Aug 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p0SE+C0k"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BC15E8B
	for <linux-efi@vger.kernel.org>; Mon,  4 Aug 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285474; cv=none; b=WUs9RNF7MXe1NzJya+PHMb/2KqtNuXJ9YETktCPws7K8OGwP6TolkNp5tzpsi7ecCAKkbLlqH2p30405+6XcABxPPJ3Ht+1JlrLxnYRyk26pyqgtEzExiQWV20WeODiPr7SCo1zyfLsp/agYzHyE7PaC9aaOzi8C0zcyzSsBKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285474; c=relaxed/simple;
	bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msFZt0zmJo7USxdISDS+gDoUc5X4hNZM+pbIkjHNQPPTzxhCxDIhloWHtLeU/HgkFpX4SjaX5MRSQZFnEH7a0xkI7uYATxLE7TsUPee5J15XtRzjK+ezUqfVuEuqpnjS3shdyeDNG9cQVlxj+HGG5QmAiPf1z/owvZnzmlciMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p0SE+C0k; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0784e3153so1173631cf.2
        for <linux-efi@vger.kernel.org>; Sun, 03 Aug 2025 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754285471; x=1754890271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
        b=p0SE+C0kEkFFWpIQia4HP8I309Mbc6y2gIideSIetE5RSpT59znz4LC101mFSApKsX
         UaVV38qrKgWCzA/IqM7Ll7Va/AumHXMvpYHCo8x+nc8PAL0SYERd4g81JkRyVezrJtRH
         BuKQzqDQ33pEkvbWumfyc7pdUd/cUgxYzLJuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285471; x=1754890271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXRLZKVFPqCMYkS125QRJvkk+n0WPGuGtQ1Co+8MwXs=;
        b=dlnTTJRdXhhStb+EN8Ox9vtPmg2u5HSpzzKqi5U7A5ej/5TshQK5yOa1BiSmlZiGLT
         8m2Rlp7l7S31+M/onrc1oTQY75tkmk8gG7Flx7Qi2UpDqPr7xIHiD7zR9mYW6kkuHwfu
         ++u/RZA9dJd4FcGw8CwJrK+scRWTMSxtkMoh6G+KdsT5lP7sv3xZQ5KeLiRTyokbWFRh
         JHnz8ZRGufLhOyW3s25+FG3rZZEVSwKejaAiTQvsOWgJcsD+W3qC7CwUYkP3OGf4dih+
         Fst2bbxeWqdUarHm40A3ej+xN70DQVLQwwqLZkVnfc+o11Raoy/g3Tt6RbagxwzUoHOp
         atXg==
X-Forwarded-Encrypted: i=1; AJvYcCVHNDDEIcdotLsuXVb86+B4jGr73HU3pZOGYsInsCZQKmpUB6AQnRQpyH+PSgXTDwuev1xwwW/0EC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4stgQJulaEexAh/c8oeBqKNEJ7p1HtO+DhhZRQyVHjfK3ept
	rz2mPUgplYma5U0S2PbcoPxBHJ5JXF3Ay9ThZGO64OU2/Ud68YtS90pg+Qt9kBCNKFFS44v/ZVJ
	g4VT363K0ISotMRwrMNxoCc+fp8LsMFNQSfatN0mw5A==
X-Gm-Gg: ASbGncuVx1JBpQk5Mfuz3WPadKwVYne4RhwDHomkzYwlW5PGkbwGAARaHJ9D41YwCBq
	whb/ltg+hhKiB0u/gfpUwKl/eu/cgX/QrxkNCCshU8FKe9b7agySLt3F7d6li1L26IWrwP/wViE
	yviSPBL7ivQUovj2ELdICFmfrRQZdi6Qur88DhMQhhf7QEmKYewyWKmccOxqpc6WXIi8OCrNDKI
	BHwd+4=
X-Google-Smtp-Source: AGHT+IH0IH0rNC75c+GhfDQJZCuvklC5kQM1oh/HgDVzt03m+1uz14T020E0UkujMdxGJ1sbdkvEK0AIQGjN8f1XEJA=
X-Received: by 2002:a05:622a:1f89:b0:4ab:7fe9:1aa with SMTP id
 d75a77b69052e-4af10a89bbamr143160171cf.29.1754285471393; Sun, 03 Aug 2025
 22:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com> <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
In-Reply-To: <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 07:31:00 +0200
X-Gm-Features: Ac12FXyzcxe_u-skQ24oK2yIIfSZae1qfInamXqtbJ0CQvMMKceqDyTihjyeSp4
Message-ID: <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with suspend/resume
To: Jan Kara <jack@suse.cz>
Cc: Askar Safin <safinaskar@zohomail.com>, brauner@kernel.org, 
	James.Bottomley@hansenpartnership.com, ardb@kernel.org, boqun.feng@gmail.com, 
	david@fromorbit.com, djwong@kernel.org, hch@infradead.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com, 
	pavel@kernel.org, peterz@infradead.org, rafael@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 14:09, Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Sun 20-07-25 22:23:36, Askar Safin wrote:

> > - Suspend doesn't work if we try to read from fuse-sshfs filesystem while
> > network is down
>
> On the surface the problem is the same as the above two but the details
> here are subtly different. Here I expect (although I'm not 100% sure) the
> blocked process is inside the FUSE filesystem waiting for the FUSE daemon
> to reply (a /proc/<pid>/stack of the blocked process would be useful here).
> In theory, FUSE filesystem should be able to make the wait for reply in
> TASK_FREEZABLE state which would fix your issue. In any case this is very
> likely work for FUSE developers.

This is a known problem with an unknown solution.

We can fix some of the cases, but changing all filesystem locks to be
freezable is likely not workable.

Thanks,
Miklos


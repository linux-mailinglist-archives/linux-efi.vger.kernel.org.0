Return-Path: <linux-efi+bounces-836-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FA885BA0
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34609282C98
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467C8624D;
	Thu, 21 Mar 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMBSryKv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A41E879;
	Thu, 21 Mar 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034951; cv=none; b=Jqe7RBhiW+iz2p5I9ij2Ga6pVKWcZ6gF7OfYmuoQIqo07xPAKMQCQIpxApiejjlAl241puHcz99NSjsBvPjbi3IyVk+D5KgC+H6hrN24NEk8hlxVS3JbH051QpHtKQIZGOjJQntta+7evN+MfvQcFo47X5yWeB6W/7sm7W8AiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034951; c=relaxed/simple;
	bh=CXSD8py/dRXi8FZ8YuRHgGgHgHqdMPuZ3RsnkuJhXj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFDXTdARIWs7/Cgk7qaWipJMSvjyW9YOJWxoAoOZz9/EH1k10sN4XXLTSW8jKQ+zCxep7+hVSG45e9iUX/flukwPl4ISs6QloPpIdtfsPRhDdr2Amf4nq3MDtF2GNyrGORVQNBI63ccvdLF9ixBVxDVQxVdkkqMpczn7gSBOMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMBSryKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74760C433F1;
	Thu, 21 Mar 2024 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711034949;
	bh=CXSD8py/dRXi8FZ8YuRHgGgHgHqdMPuZ3RsnkuJhXj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JMBSryKvssHgctd3ZquGd9cqAWYlgCeUaz88xk71YTQ3Rh7CoUELltqVUiAw2Flz3
	 EqDjHfhyijnRAMUzASrASeflqHdbuc7yw4gZrnLB9+QFRu7DS4q58P7YxC+Zt2PuLt
	 5bNYQRWrP+nZrYfd4pgge9Xt/rcqzOj8F7WxJww2fMIV77vtCYq1EAQo/jPuEaE59w
	 +tZR7XHTTwnd3TPozgM5E5dQQCPOguBNZjuSVh6LoEKAxiohzTIV2ENHi2SaORMmNe
	 a1Ze7xO3Fb08Eu/4XNQqsIw11C0wHpCPgGNTc7ff+0dTLFBlHaIUF9sjhif63l8PqK
	 qBMufi0VGWhnQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so12166851fa.1;
        Thu, 21 Mar 2024 08:29:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY79OBUZTne0RgS1hD/Roh5ZpVUH6Kh0tNqT9xkPo5IkA/Gc7MXX81qrEH6zU2ijg1krc1ucNO+39whiXI0rFeYMY7yEWs5hq+0mdpgM6fMdP3zG0nxMQuJgYD0Zt6lU3h
X-Gm-Message-State: AOJu0YzmikDSmb7haZPIWTEUG1qWyKnNWwYmubONTbtNL9ty3Sf042pP
	CLVrB1lCzgYf/JlgFoy1fk5RYgp1qzA0HPbpkVATvcATn7ygHgx/IqsCLVSPdGa73H8HprCIpJA
	jFlHafmM8ev1/1MYT/mxHwHjWkhU=
X-Google-Smtp-Source: AGHT+IG346hC9qpfxXiA3KLkcYQ/xGwy5fETRQ0nYxMw8EQZLmQ1yLQFnwRf+5DtdUPUFUfKD5zhuZMPC8ykWpD+H4A=
X-Received: by 2002:a2e:b04d:0:b0:2d4:8fd0:b5f2 with SMTP id
 d13-20020a2eb04d000000b002d48fd0b5f2mr3913546ljl.7.1711034947840; Thu, 21 Mar
 2024 08:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
 <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com> <2024032132-fax-unsmooth-f92b@gregkh>
In-Reply-To: <2024032132-fax-unsmooth-f92b@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 21 Mar 2024 16:28:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEKfAKJM0o-X5vY9cMpkurvpZ418GpyS5fWqiZO-0H9wg@mail.gmail.com>
Message-ID: <CAMj1kXEKfAKJM0o-X5vY9cMpkurvpZ418GpyS5fWqiZO-0H9wg@mail.gmail.com>
Subject: Re: efivarfs fixes without the commit being fixed in 6.1 and 6.6
 (resending without html)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ted Brandston <tbrandston@google.com>, linux-efi@vger.kernel.org, 
	stable@vger.kernel.org, Jiao Zhou <jiaozhou@google.com>, 
	Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 15:59, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 21, 2024 at 10:43:05AM -0400, Ted Brandston wrote:
> > Hi, this is my first time posting to a kernel list (third try, finally
> > figured out the html-free -- sorry for the noise).
> >
> > I noticed that in the 6.6 kernel there's a fix commit from Ard [1] but
> > not the commit it's fixing ("efivarfs: Add uid/gid mount options").
> > Same thing in 6.1 [2]. The commit being fixed doesn't appear until 6.7
> > [3].
> >
> > I'm not familiar with this code so it's unclear to me if this might
> > cause problems, but I figured I should point it out.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/efivarfs/super.c?h=linux-6.6.y&id=48be1364dd387e375e1274b76af986cb8747be2c
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.1.y
> > [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.7.y
>
> Good catch.

Indeed. Thanks for reporting this.

>  Ard, should this be reverted?
>

With this fix applied, we'll end up kfree()'ing a pointer that is
guaranteed to be NULL, on a code path that typically executes once per
boot, if at all.

So in practical terms, there is really no difference, and this is the
only thing I personally care about.

So I wouldn't mind if we just left them, unless there are other
concerns wrt to maintenance, tidiness etc.


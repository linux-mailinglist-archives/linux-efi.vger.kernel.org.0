Return-Path: <linux-efi+bounces-2306-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE49E6C68
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC1B161337
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611841DF99A;
	Fri,  6 Dec 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcAtvx3v"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65F1AD9F9
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481624; cv=none; b=N5/nWYwYaP12nkDccZJ6onZWXhRjpxZVkKfJagWUTqm08SLWDtHpV4lY7Cfwz1r6S6IBOsP9cYqypvwu1XMFW8U/J/uORir81p4DoT6IIuW8/Kpfwf2kFCBHxHaVh0+YaEOGzjXXHJp4i1t9ipbATQCNbwcoYD4CL4aos0GRjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481624; c=relaxed/simple;
	bh=+/PwHQJ+x8MxAf/gzvSTJHofO6uV0mJQ6uC4Aa1+zd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/8U6zuA9uDvgP2VOH359BVQd3upc5RBvUqb8vGr5K0/sxSnbjg9wDESj930QhfbxZWAy0fAb3isca02guBSnRi4FNu7Q0HWhZis5+XItg4B7CXi4+7ru+e6H/TAAWHty1EzqM7NZ+o12rWa0Rf8r9siX//TVLO48CwlgEiFRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcAtvx3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68C8C4AF0B
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481623;
	bh=+/PwHQJ+x8MxAf/gzvSTJHofO6uV0mJQ6uC4Aa1+zd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GcAtvx3vcZBeXWpuBisBZmFOIT5CbxOn0ALmcXUg1SFs0BR5H3tUCCIzJRqJIzGFW
	 bdpl7u4wdAwV6IU/r1YlxSw+YUyNgptNgx+xdsuSpbETSIh5Pif97d5x1RCuo/H/z6
	 oAGG5yYAi091Iam9VGy3EO0aKp7hqFPzgb61PuMJQdd+l6QQtQ/2bXCgaL3fXWY4B8
	 m8GcqPnQmHt1CGkA7T0MdgTxOjjYF5yarmyCoqIJOY3RSBcqomERhDHkPe3fb0hPST
	 ft5oRHvhEyC+tEutJx3SnQYWodVYd7hWmizduHewcCOG3xpmc2dQk2K20Fkzyd8/Nt
	 qHTPXQTQgBhJw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so19458481fa.1
        for <linux-efi@vger.kernel.org>; Fri, 06 Dec 2024 02:40:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM2iFbUje46ZxwZqGBXwtk/4KmC/OXCEgOA9FhOxvGBt4+yAKHNXhv+rX7uCfaxrQKE3yfsDxDHcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFSLQjpiIvcrNPTFBHj3Gf3Y6yDykOv82VqA4gPRs6llN+Rau
	jTyGDes/TL5vqpaSvZ84teAmO9wNtLBHLsbNy8WBASKTXwGnZEkbkSSSbW9YIu2sYQdE/YQd1hr
	M+7kvlANwTzzTfQ81vyW/GfShCAA=
X-Google-Smtp-Source: AGHT+IGI49Z52bwAqY3nFozg2W9LE0hetYV/flyqbVV5er+1Gs2b/376o7NHbfBn0VHuSyPfIK+al+/rf3IPWTARO2A=
X-Received: by 2002:a2e:bd02:0:b0:2ff:c4a3:8832 with SMTP id
 38308e7fff4ca-3002fc96aa3mr5541651fa.38.1733481622091; Fri, 06 Dec 2024
 02:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206021000.8953-1-piliu@redhat.com> <20241206021000.8953-2-piliu@redhat.com>
 <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com> <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
In-Reply-To: <cc6cpx74vzfzivvob4d3smutdjisvgjz6wjob5tay47ubb5lje@exjqpfyxdg3w>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Dec 2024 11:40:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHOtdQE5KP1K35RQw+i6_2cAgckjZgJ6T99NexYPSroyg@mail.gmail.com>
Message-ID: <CAMj1kXHOtdQE5KP1K35RQw+i6_2cAgckjZgJ6T99NexYPSroyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, Peter Jones <pjones@redhat.com>, linux-efi@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Dec 06, 2024 at 09:03:30AM +0100, Ard Biesheuvel wrote:
> > (cc Peter, Gerd)
> >
...
> > Perhaps we should just make EFI zboot gzip-only, rather than
> > supporting 7 different compression methods because that is what the
> > legacy decompressors on ARM and x86 support - I struggle to see the
> > point of that tbh (even though I implemented that myself)
>
> We have 7 meanwhile?  Wow.  That looks somewhat insane indeed.
>
> > That way, the kernel can authenticate the outer PE zboot image as
> > usual, and perform the decompression itself, without having to carry
> > code for all compression formats it might encounter.
>
> gzip was the only one for a looooong time, so we want probably keep
> that.  It also is somewhat dated and doesn't offer the best compression
> rations, so I do the point in supporting some better alternative.  But
> can we settle on *one* gzip alternative, reducing the total number from
> seven to two?  Reasonable choice for the alternative would IMHO be:
>
>   (1) xz - that seems to have established as *the* gzip alternative,
>       release tarballs are either .gz or .xz these days, everything
>       else is rather exotic.
>
>   (2) zstd - typical distro kernels need that *anyway* because there
>       are more in-kernel users, btrfs uses zstd compression for example.
>
> distro data points:  fedora/x64 used gzip in the past and uses zstd
> compression today.  fedora/aa64 uses gzip for zboot.
>

GZIP + ZSTD seems like a reasonable compromise to me - AIUI, xz offers
a marginal improvement in compression ratio but it is substantially
slower at decompression time.


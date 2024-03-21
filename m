Return-Path: <linux-efi+bounces-835-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E1885B3D
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 15:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8018928176A
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2785C48;
	Thu, 21 Mar 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFbHKP/P"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849B8595B;
	Thu, 21 Mar 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033140; cv=none; b=Y19WldCy3lQrh0j6DKYfKM0ie6ShYL/6yCuUZdIukAfrn6ZHsGpf5caHZSpkMN1yUoevD8rspV3i/GgsJBOfN9e/YPJWSyor36GJULrLYl2BjwLrc+8pskdET7seMjLecLtUwAX8BscBnOz6xoVwpo+9LkQEqydTqTwrsD0MbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033140; c=relaxed/simple;
	bh=PFYFm3h5GsZXpKUvG7t3KLqA9OPxL1t7l8M+4xbvDX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLh7DLj0YG3KwfHQxFOeLW9DVPemd4MwO9UNk40DDv+p4IjDtD7M5QvyrBLU0y0e47oQTLSWyzgsZAWqxKv7NNLo9lLkGcYKSo/CUSTsdJ3wnX11u98hC2WVOYiqTJpPyRBP/prYE8k7g+VKRraNuIr+s3MzfNVgFP0XpK6zYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFbHKP/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6710C433C7;
	Thu, 21 Mar 2024 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711033140;
	bh=PFYFm3h5GsZXpKUvG7t3KLqA9OPxL1t7l8M+4xbvDX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFbHKP/PVKjL/WcxGmWwNukBSvNtEEMzIJDtNk4oEaUMByXLEnZjBdY7ME8ZtvUF6
	 st02csXkL60pCUI4+pDTY9e7jm1w6m0cfwXwOJ8gKL2o8stO0dR/QlD0mD5+lqfUPE
	 +SfeM70MIkeotVWusHXpFonDfy8TUYgTPshyi5jQ=
Date: Thu, 21 Mar 2024 15:58:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ted Brandston <tbrandston@google.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, stable@vger.kernel.org,
	Jiao Zhou <jiaozhou@google.com>,
	Nicholas Bishop <nicholasbishop@google.com>
Subject: Re: efivarfs fixes without the commit being fixed in 6.1 and 6.6
 (resending without html)
Message-ID: <2024032132-fax-unsmooth-f92b@gregkh>
References: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
 <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com>

On Thu, Mar 21, 2024 at 10:43:05AM -0400, Ted Brandston wrote:
> Hi, this is my first time posting to a kernel list (third try, finally
> figured out the html-free -- sorry for the noise).
> 
> I noticed that in the 6.6 kernel there's a fix commit from Ard [1] but
> not the commit it's fixing ("efivarfs: Add uid/gid mount options").
> Same thing in 6.1 [2]. The commit being fixed doesn't appear until 6.7
> [3].
> 
> I'm not familiar with this code so it's unclear to me if this might
> cause problems, but I figured I should point it out.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/efivarfs/super.c?h=linux-6.6.y&id=48be1364dd387e375e1274b76af986cb8747be2c
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.1.y
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.7.y

Good catch.  Ard, should this be reverted?

thanks,

greg k-h


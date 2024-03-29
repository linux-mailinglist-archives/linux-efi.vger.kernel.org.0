Return-Path: <linux-efi+bounces-900-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DB891F48
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 16:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8A31C21C36
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431C13CF85;
	Fri, 29 Mar 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qN7/YxB1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B9657B5;
	Fri, 29 Mar 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718013; cv=none; b=iHgLs77MhmslDEWdbKMVSlkWFq2/w11GMCVVt9Luw5ln8RaClP5EshuQs39bma53UZ64FhhyzDE9R6Hg+54GOmi4Hro5RSEhU+ZzMlOdyG4o8z0z8noYUCnCeEWUWFLavp+kfD6++AwzxptAooG1/i8xtNa5T9UCU+JsLITzIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718013; c=relaxed/simple;
	bh=wvQ5mwBkCgiKnf6K6NYjSedf2tsI0v0ruLxmsaaV0SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN7VlW0bJ1QYM980xgunN3a+A/CtHmqqKwIHf0JjNzX49MvMtzjfLfck5m9c/Y8gw7NrHcHP/MrWtyOl8sOz6CF1bi7uB3JNMwvVxQmh1n/jWnFCkrmrpX66KFuQsMXcCI+MSnUDblYqwgbzi4v9aqjFKpgEoDw9X5X1fDkGqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qN7/YxB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1663C433F1;
	Fri, 29 Mar 2024 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718012;
	bh=wvQ5mwBkCgiKnf6K6NYjSedf2tsI0v0ruLxmsaaV0SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN7/YxB1lUTVN1x+k+4e5a4d3gWSWHQH0dCMO29UsUlKwc1QgiChJU+nmBFZ9WzYA
	 SVrIUTc5WmCBOhUyo6uGter3PDS1x2SzfvFwouEsiulHyMZHx1zq5LgO23LOGErESf
	 JvyWhGdGwgPQl2FlL7jSmhaZovkuX3ZRjjJxUSGU=
Date: Fri, 29 Mar 2024 14:13:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Schumacher <timschumi@gmx.de>
Cc: stable@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH 5.15-] efivars: Request at most 512 bytes for variable
 names
Message-ID: <2024032918-amperage-cornstalk-a77d@gregkh>
References: <20240317023326.285140-1-timschumi@gmx.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317023326.285140-1-timschumi@gmx.de>

On Sun, Mar 17, 2024 at 03:33:21AM +0100, Tim Schumacher wrote:
> commit f45812cc23fb74bef62d4eb8a69fe7218f4b9f2a upstream.
> 
> Work around a quirk in a few old (2011-ish) UEFI implementations, where
> a call to `GetNextVariableName` with a buffer size larger than 512 bytes
> will always return EFI_INVALID_PARAMETER.
> 
> There is some lore around EFI variable names being up to 1024 bytes in
> size, but this has no basis in the UEFI specification, and the upper
> bounds are typically platform specific, and apply to the entire variable
> (name plus payload).
> 
> Given that Linux does not permit creating files with names longer than
> NAME_MAX (255) bytes, 512 bytes (== 256 UTF-16 characters) is a
> reasonable limit.
> 
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [timschumi@gmx.de: adjusted diff for changed context and code move]
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> Please apply this patch to stable kernel 5.15, 5.10, 5.4, and 4.19
> respectively. Kernel 6.1 and upwards were already handled via CC,
> 5.15 and below required a separate patch due to a slight refactor of
> surrounding code in bbc6d2c6ef22 ("efi: vars: Switch to new wrapper
> layer") and a subsequent code move in 2d82e6227ea1 ("efi: vars: Move
> efivar caching layer into efivarfs").
> 
> Please note that the upper Signed-off-by tags are remnants from the
> original patch, I documented my modifications below them and added
> another sign-off. As far as I was able to gather, this is the expected
> format for diverged stable patches.
> 
> I'm not sure on the specifics of manual stable backports, so let me
> know in case anything doesn't follow the process. The linux-efi team
> and list are on CC both for documentation/review purposes and in case
> a new sign-off/ack of theirs is required.

Now queued up, thanks.

greg k-h


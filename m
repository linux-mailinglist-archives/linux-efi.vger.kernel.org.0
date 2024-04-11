Return-Path: <linux-efi+bounces-940-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CF8A1546
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458811C20B80
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11C14A4E5;
	Thu, 11 Apr 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0iizJYj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F15A0F4;
	Thu, 11 Apr 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840870; cv=none; b=GCa4AMWjScvhTnYwu+cC3GOGDFYFsnnhAyIUkIyX7PbIwXT7IM8oFU/34jcTc3nPyroA0MWX0P02c1FBo4R4ZrGudk7qStEj9S1YP1ngm+gb4In7Oz1IMY+A+bcNoKQjUz9VJFddDqJbcjYhcrDBXZue9NAX6Y5svulKoFzH9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840870; c=relaxed/simple;
	bh=pTPEJwwsJFjYG713GzWA/+ri2JEjt8G3lmiEPr5+Q7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzIy3iRSV04BI4VzSMtiMIA61Tl8G8JXSBajH6uMRuFy4N54ibeHOtDre1yihspfUvjdqctBSY28OvvYaO4Lhi1/XjEzmVM2fYs9zzG4eCJhlDErWxLmazSDc7/ulqwXnW6UGtvseyk3eWhXZWT1D19L5exePsjRLCCnw0jtQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0iizJYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E59C433C7;
	Thu, 11 Apr 2024 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712840869;
	bh=pTPEJwwsJFjYG713GzWA/+ri2JEjt8G3lmiEPr5+Q7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0iizJYjhDA9viVVBrewQz0x7ceASK0mzGS6oEsloKRpkcsx0urG/1EddVpslYkG2
	 ZcuAUfOTiffyentqlm1/+PjzykDbUViTFaJCl1BBw6vGvcIm9Sy0l+11wci9GMAemP
	 2BrR5/70rrKjL+iKFVTAZ13fvRwkPdHIvhpsukYQ=
Date: Thu, 11 Apr 2024 15:07:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	intel-gvt-dev@lists.freedesktop.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 0/2] Deduplicate bin_attribute simple read() callbacks
Message-ID: <2024041128-huddling-humped-4304@gregkh>
References: <cover.1712410202.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712410202.git.lukas@wunner.de>

On Sat, Apr 06, 2024 at 03:52:00PM +0200, Lukas Wunner wrote:
> For my upcoming PCI device authentication v2 patches, I have the need
> to expose a simple buffer in virtual memory as a bin_attribute.
> 
> It turns out we've duplicated the ->read() callback for such simple
> buffers a fair number of times across the tree.
> 
> So instead of reinventing the wheel, I decided to introduce a common
> helper and eliminate all duplications I could find.
> 
> I'm open to a bikeshedding discussion on the sysfs_bin_attr_simple_read()
> name. ;)

Seems like no one objects, should I just take this through my
driver-core tree for 6.10?

thanks,

greg k-h


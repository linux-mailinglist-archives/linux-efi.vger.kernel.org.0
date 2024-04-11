Return-Path: <linux-efi+bounces-939-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F478A1542
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437561C211F1
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C45149E10;
	Thu, 11 Apr 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEAigv/e"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4E624;
	Thu, 11 Apr 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840832; cv=none; b=jTRROlBLjTqtI+XIGAUHjzKT/B6pTXhaoUXc4XtfxN031ETZoBR5WYkl5f8SbDD0oE/mkN2sIw/OQ6LGe3PmdFvMBR60d4W9H3YZi+MXnP+Hef9azCgHHSSSHSzUCHPqLaOUCGaCW88qWoLCjtTNoMB/DTNBdaj0zjpwmnF9QNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840832; c=relaxed/simple;
	bh=jBDcfNa+ZA0GhG6LAA8y9wdXr1NILjkk4RiSds6k6CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkm2fj45aTYSGpaxqfuJr6ELhATaGnQpD3MVIg6zV9j9NLHeyDRpatXTgSHQ6wMvL7+SbBgIN3ea/BniRwDF9FGjXtS6R0HThBLmdkM0Y3DgX1xcXqhBN8/sY8+5/CaXUGtTmf7i9gKFUxDdfcOjSpa5JIn21O/Zg/QDtEpCEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEAigv/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171F6C433F1;
	Thu, 11 Apr 2024 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712840831;
	bh=jBDcfNa+ZA0GhG6LAA8y9wdXr1NILjkk4RiSds6k6CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEAigv/eqYtD+nsLaUlG13p5KlC4W5zHhp72SVBIi+SAijs3tSDYQHkjOz8atq0vF
	 YHn+MDCqfVqEJm7JLB4lMHJtirV0VLuYgEmqShGnDjWGqMR5VUT0324OZlMJaDNg8P
	 efibU29MYTA1wtA6bod9kF/GFyaPmhRldp5GKdYI=
Date: Thu, 11 Apr 2024 15:07:08 +0200
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
Subject: Re: [PATCH 1/2] sysfs: Add sysfs_bin_attr_simple_read() helper
Message-ID: <2024041101-haggler-devouring-9dcf@gregkh>
References: <cover.1712410202.git.lukas@wunner.de>
 <5ed62b197a442ec6db53d8746d9d806dd0576e2d.1712410202.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed62b197a442ec6db53d8746d9d806dd0576e2d.1712410202.git.lukas@wunner.de>

On Sat, Apr 06, 2024 at 03:52:01PM +0200, Lukas Wunner wrote:
> When drivers expose a bin_attribute in sysfs which is backed by a buffer
> in memory, a common pattern is to set the @private and @size members in
> struct bin_attribute to the buffer's location and size.
> 
> The ->read() callback then merely consists of a single memcpy() call.
> It's not even necessary to perform bounds checks as these are already
> handled by sysfs_kf_bin_read().
> 
> However each driver is so far providing its own ->read() implementation.
> The pattern is sufficiently frequent to merit a public helper, so add
> sysfs_bin_attr_simple_read() as well as BIN_ATTR_SIMPLE_RO() and
> BIN_ATTR_SIMPLE_ADMIN_RO() macros to ease declaration of such
> bin_attributes and reduce LoC and .text section size.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  fs/sysfs/file.c       | 27 +++++++++++++++++++++++++++
>  include/linux/sysfs.h | 15 +++++++++++++++
>  2 files changed, 42 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


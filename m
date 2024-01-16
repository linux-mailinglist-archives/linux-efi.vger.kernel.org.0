Return-Path: <linux-efi+bounces-411-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5482EB0E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 09:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B558D1C22DD5
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559311CBD;
	Tue, 16 Jan 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVDvBYy2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E4848A;
	Tue, 16 Jan 2024 08:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0151C433F1;
	Tue, 16 Jan 2024 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705394803;
	bh=wVn468P8mPSjSjRjd9jRruk/GCDVWz/BVfaxrAjVDZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVDvBYy2mAYwvSJOB22KxeaClRNRYro32K8yuC9MEehnyUVnTOhkeOdYglmbuzmVL
	 isHRmD2iGRJmfwMH2almLVqkWLtNKkcXV4TaG2+k//vnszCzEAwWjx/IGwgKP9L6bv
	 MbObmIahgjnw0zn8zrdrlSerDYAvhC9bDTqXV4AI=
Date: Tue, 16 Jan 2024 09:46:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-efi@vger.kernel.org, ardb@kernel.org, keescook@chromium.org,
	tony.luck@intel.com, linux-hardening@vger.kernel.org,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH] efi: pstore: Allow dynamic initialization based on
 module parameter
Message-ID: <2024011654-setup-pointer-59d4@gregkh>
References: <20240103184053.226203-1-gpiccoli@igalia.com>
 <706a5008-331b-34ea-c177-bb0070375099@igalia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <706a5008-331b-34ea-c177-bb0070375099@igalia.com>

On Mon, Jan 15, 2024 at 06:20:45PM -0300, Guilherme G. Piccoli wrote:
> On 03/01/2024 15:40, Guilherme G. Piccoli wrote:
> > The efi-pstore module parameter "pstore_disable" warrants that users
> > are able to deactivate such backend. There is also a Kconfig option
> > for the default value of this parameter. It was originally added due
> > to some bad UEFI FW implementations that could break with many variables
> > written.
> > 
> > Some distros (such as Arch Linux) set this in their config file still
> > nowadays. And once it is set, even being a writable module parameter,
> > there is effectively no way to make use of efi-pstore anymore.
> > If "pstore_disable" is set to true, the init function of the module exits
> > early and is never called again after the initcall processing.
> > 
> > Let's switch this module parameter to have a callback and perform the
> > pstore backend registration again each time it's set from Y->N (and
> > vice-versa). With this, the writable nature of the parameter starts to
> > make sense, given that users now can switch back to using efi-pstore
> > or not during runtime by writing into it.
> 
> Hi folks, a friendly ping - any comments on this one, suggestions?

It's the middle of the merge window, not much anyone can do until after
that is over to pick up new stuff.

thanks,

greg k-h


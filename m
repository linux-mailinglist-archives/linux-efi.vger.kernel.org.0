Return-Path: <linux-efi+bounces-941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6258A161E
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11A61C2097C
	for <lists+linux-efi@lfdr.de>; Thu, 11 Apr 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8027150987;
	Thu, 11 Apr 2024 13:40:01 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB314F9F2;
	Thu, 11 Apr 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842801; cv=none; b=hlIng1xdjTAbk7v+6q7dtIkec4OT2WIIbS30ef82lxw6/lktsJx625RxC9Kelv/rcL8plaDWw1W+/koBImqYDa25DepbY73qpEJylTeNZ0vWbtTxoArf252yfmXbUJRxlsAKWFPseNIsVZYPO482EZFAgsa0Pwnxf9HFI9zgGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842801; c=relaxed/simple;
	bh=UuA5dm6koMgua9DkhFOmmz7faxSDfh7lrYIohOK6E+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA5wpeGwMe43VQCzrI9HwhMHeuMhF0QTrI89NMScnypuwjGoYITSGMPESOcetmftlReZ5C2G0SB3FSLfZhuufTjuryjIxqX7U4w7nlbSUWD3A7k1wATtEcgUfXeNunNSoet5pIvKafby5Mny+/j7JeOxWXG/dSV5aD1XvDTc2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5FE7E28013A52;
	Thu, 11 Apr 2024 15:39:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4AE723FFCDE; Thu, 11 Apr 2024 15:39:50 +0200 (CEST)
Date: Thu, 11 Apr 2024 15:39:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <ZhfoJkIxJvRal8aF@wunner.de>
References: <cover.1712410202.git.lukas@wunner.de>
 <2024041128-huddling-humped-4304@gregkh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041128-huddling-humped-4304@gregkh>

On Thu, Apr 11, 2024 at 03:07:46PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 06, 2024 at 03:52:00PM +0200, Lukas Wunner wrote:
> > For my upcoming PCI device authentication v2 patches, I have the need
> > to expose a simple buffer in virtual memory as a bin_attribute.
> > 
> > It turns out we've duplicated the ->read() callback for such simple
> > buffers a fair number of times across the tree.
> > 
> > So instead of reinventing the wheel, I decided to introduce a common
> > helper and eliminate all duplications I could find.
> > 
> > I'm open to a bikeshedding discussion on the sysfs_bin_attr_simple_read()
> > name. ;)
> 
> Seems like no one objects, should I just take this through my
> driver-core tree for 6.10?

That would be awesome, thank you!

Lukas


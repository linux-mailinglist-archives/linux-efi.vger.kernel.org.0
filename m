Return-Path: <linux-efi+bounces-3235-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C8BA80EC1
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F24717B6DF
	for <lists+linux-efi@lfdr.de>; Tue,  8 Apr 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C41DF728;
	Tue,  8 Apr 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eU9Evarw"
X-Original-To: linux-efi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A1152532;
	Tue,  8 Apr 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123536; cv=none; b=hw/s/MHAhHuJzlw4ObcxzIUP1RrCd9getMXDIVJd0GsVWMrMMHMXomxCJqdHYmCXaM6SrPfGBtkzzDcEi8UxNxONMaUwUocln7celNDEBignsY6j6rJX3YzsQIBfx+2NXtshw3wmcAp9CYvcVzpQbBl3ybymoNnTsQLAxifFoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123536; c=relaxed/simple;
	bh=irNlBo1IryRAe63MAHnAMbf6FqWMhnjsTarLwK/Bi/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNynEtlOtHNz9hh5ZT4NlaJy6O4rmLWG1SMw7ZajXuHtMVamKpDsqUTaUSaVQ1hwyDpCZ/Rt5denQG+lk156B1Dx5OoqA6NqZ7l14CRjXq5XCwW+SU7xJUm9hlPGKLmSwKtqHlgdMg+lGMeVJ2oSv+KGj54m+75411QegPOO1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eU9Evarw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 109EC44341;
	Tue,  8 Apr 2025 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744123532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7VTXtzY8zJJywqc76L9MeA0ZKx5Ng26dSN8EWcxsZU=;
	b=eU9EvarwQjr3999mkmhDsMhEeE2HwnCjWKg3d5E/JQdFwM+TznkG6xUDJCesMr0S+XwN0s
	GkkXlVzZjzE+yqVTTv3pEJz1msyLzBUrtgxbzQd8D8B2f/N3k8XlWy3RdHewjIkU6Tov4V
	Ly9JIHoWXgdV6xWjx5tcHdXEdolSMGw/sCqkAGgXT/0tYLlNzj8UClyzaxhvYqCGPVnlzk
	A9lXzsO8hZWONu+lGZVFA+n91Mfacs0WoHcvKbY0cuxfjlbjMICiIpETeoukzP2qnP8BMG
	JRZko8li35U2T8TKPHjXwVel5MYRXjapL7bfLeXXWHf/u1aoEWdMYQiKCD8ytQ==
Date: Tue, 8 Apr 2025 16:45:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: (subset) [PATCH v2 4/8] rtc: efi: Transition to the faux device
 interface
Message-ID: <174412352089.3870554.10940173443800637826.b4-ty@bootlin.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-4-e6cc73f78478@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-plat2faux_dev-v2-4-e6cc73f78478@arm.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmegrugdtfeemgehflegtmeeffeejfhemfheffegunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmegrugdtfeemgehflegtmeeffeejfhemfheffegupdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrr
 hhmrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 18 Mar 2025 17:01:42 +0000, Sudeep Holla wrote:
> The EFI RTC driver does not require the creation of a platform device.
> Originally, this approach was chosen for simplicity when the driver was
> first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
> 
> [...]

Applied, thanks!

[4/8] rtc: efi: Transition to the faux device interface
      https://git.kernel.org/abelloni/c/89a378d01e7e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


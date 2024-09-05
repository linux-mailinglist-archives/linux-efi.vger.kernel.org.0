Return-Path: <linux-efi+bounces-1660-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B208696D306
	for <lists+linux-efi@lfdr.de>; Thu,  5 Sep 2024 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DE11F24629
	for <lists+linux-efi@lfdr.de>; Thu,  5 Sep 2024 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8C194ACB;
	Thu,  5 Sep 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="rHhfDccz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB1957E2
	for <linux-efi@vger.kernel.org>; Thu,  5 Sep 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528172; cv=none; b=U7nKxJSEdMr6XsBjXE/dHeBDZfP366c/B1e44bWRXPUnEXDfLR+P9UTyVsi1jN8mq4xLRVN6DvDog3/mw+2Fzhi7JNHOTSmzb8yzRRvbm/9f68pt6/IgJsSF4/Dd7dTFcIHwj9dFQynIi7SzXmWjKhgYuiH+Pp/b7GoQFMk8VGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528172; c=relaxed/simple;
	bh=AMlNOwI52mhjHVj5adH0Wqme/ZqZb+jTV56E4hLvqY8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FRV35CniTOGg7tfuM5e856e1k09udBDb7sLo6g+AGD4cMZZXCwyRXNPzVHCokJxRomEqqSQzqg5JvOaGTWqtH55gFlj2V7cRlQxTzyT0SnCRVEJOxfmOUQKMK1T3Hc0yiYcYO5c9Cv0XRYYQ2a1dtUW/WaMu9mWY2HO0rGB3zEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=rHhfDccz; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail; t=1725528166; x=1725787366;
	bh=AMlNOwI52mhjHVj5adH0Wqme/ZqZb+jTV56E4hLvqY8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rHhfDcczBYMaxZRe8wnx3R8GFSyRq816py46IkYkf/PFf194dqf6dRu0/4dyu1ZRK
	 nkgzMO97c7a2xFoRwYGUcRWRvXCSZsbUoOw2dXUGBH9UiBoXjJDxTFna7rmT0UjNIM
	 RDZMzOLIfiPfWYBFfa78pKB72ukhrbUSYsOSrV2W+JmlTkIcRmSWJ0SuclnxGfJlGZ
	 Wq73/27se3EfhszkOlq0Kt0YFr/8wXnLu+OKN+03uMAqrLif1MRSyLngslp6c1Fm6n
	 dWlsVY4fC5BgU76stcnTJYEm1Nk6TfWJcHqx3YwpciGC8JVtyvkkzn4ahNNx+dR69d
	 wuuUBYvUeaRFg==
Date: Thu, 05 Sep 2024 09:22:41 +0000
To: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
From: Richard Hughes <richard@hughsie.com>
Cc: "jk@ozlabs.org" <jk@ozlabs.org>, "ardb@kernel.org" <ardb@kernel.org>
Subject: No more /sys/bus/platform/drivers/efi-framebuffer since simpledrm?
Message-ID: <b6Fl9paVpZ66bxYu2jwpQPAIcEZ6UzY2iGUGKd7GSdr9dBRhvK1aLYUG-FWbVdT7YoV-x53b4kleO-krBFTrzKVDdLiCHlVsvVxGgG_cW64=@hughsie.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 3fe99576c0d0fa8665ab264e695b7540e5186f0b
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The fwupd daemon used to read /sys/bus/platform/drivers/efi-framebuffer to =
get the EFI framebuffer size so we can choose the UX capsule bitmap for the=
 correct size (and set the correct position) -- and make the UEFI firmware =
update for users a little nicer.

We've found out that that API has disappeared without warning in Fedora 40.=
 Seemingly the only way to get the info now is to scrape the kernel event l=
og -- but that can't be the right way to do it? I also don't think we can u=
se the DRI interface as we don't know what card/crt the firmware used for b=
ooting.

We pondered if this was a regression from the conversion from efifb to simp=
ledrm. I'm using a standard Fedora 40 distro kernel, with the config of htt=
ps://people.freedesktop.org/~hughsient/temp/config-6.10.6-200.fc40.x86_64 i=
f that helps. Any advice most welcome.

Thanks,

Richard.



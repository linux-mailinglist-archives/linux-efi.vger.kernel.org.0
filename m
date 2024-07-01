Return-Path: <linux-efi+bounces-1335-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0C91D7AC
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233FE1C2224D
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134654765;
	Mon,  1 Jul 2024 05:50:55 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B751C3E;
	Mon,  1 Jul 2024 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813055; cv=none; b=HLdi/vI94M9ekyRXg1/XW/FF11bLgbYMg1gyMFL4iICOOAWwucaGGKVU9cp5AloGDJJz70E2QGVqen3/fEC8pd/3ynUC3akKwpWYKvHGXvVpQqVmEMHZmHeID2Q49MYMIUeG6e8eCGay5f416vy/Efhrd22YhASWXuZojpD7UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813055; c=relaxed/simple;
	bh=cc8p4KEmH5M/kDq7iNE+Hi1sC5UB3/mtKUMib5Tr1CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt5letLYlAjKi3hXZv0xIjuAJPmCqpfYCAfoVKVOs8nRqsUps3+Joca3YQIA1ugtBFtqfTg/BG3uSDI0kc9vKmVn1KrGOCh5tyKIa6JPfJPvOgI19XRK8KYoz/2g+k0ihdx8E8B9bzOx7OA1/piQIbm+PtiW0glkX9qCHZ3zYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 44F832800B747;
	Mon,  1 Jul 2024 07:50:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 210C338834C; Mon,  1 Jul 2024 07:50:50 +0200 (CEST)
Date: Mon, 1 Jul 2024 07:50:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Aditya Garg <gargaditya08@live.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <ZoJDuunseVIDua-m@wunner.de>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>

On Mon, Jul 01, 2024 at 07:38:38AM +0200, Ard Biesheuvel wrote:
> Any thoughts on whether this should depend on CONFIG_APPLE_GMUX or not?

I tend towards *not* making it depend on CONFIG_APPLE_GMUX:

* The gpu-switch utility Orlando linked to doesn't use the apple-gmux
  driver.  (It changes EFI variables that influence to which GPU the
  EFI driver will switch on next reboot.)

* apple_set_os() has side effects beyond exposing the iGPU (such as
  switching the keyboard+trackpad access method to SPI instead of USB).
  If there are issues, they will be harder to debug if their occurrence
  depends on a Kconfig option.


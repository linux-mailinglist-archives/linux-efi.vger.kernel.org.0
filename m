Return-Path: <linux-efi+bounces-2426-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734EC9F93F4
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9419B16888F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE22163B0;
	Fri, 20 Dec 2024 14:07:27 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66A215703;
	Fri, 20 Dec 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703647; cv=none; b=GWPO12LmYtHz5DAo+EBz9NaxC8xEu6g3PPoyG2h9uRN68/cAVRjOZUyK43emTeA8eizCbUbP/K7S9RXXg/wie+inJYmKQ52g4Eg6cnZOwRsfY5ksWUOfnoYb84St7jhmOibJsxEwF2fyfT+iPsiqZQldk256WiXUZOhCBnbob7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703647; c=relaxed/simple;
	bh=cQ7/MSu72Qbhs+pAQTXMPZN0PPx+wJsNJlgaCaXZiW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NARwRIXLdm5O1ImyzcfQa9T8FuWVCB28B6Q/xj0SpuxXf9j+WiUNFBzw55UhtS/U9Kfk9IDNpC5s4SqACtaAF0XfYWPRflAE2eFRT0p2/OulHE/+hShXE6f4/QrB/RyFf3cY+SVn8Cokoatu0GzEiahYj9o21bP2aXvoRvLQtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C581A2800F998;
	Fri, 20 Dec 2024 15:07:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ADAEB366B0C; Fri, 20 Dec 2024 15:07:20 +0100 (CET)
Date: Fri, 20 Dec 2024 15:07:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/7] efi/libstub: Simplify GOP handling code
Message-ID: <Z2V6GKrnDHdvAEqq@wunner.de>
References: <20241220112214.2598872-9-ardb+git@google.com>
 <20241220112214.2598872-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220112214.2598872-12-ardb+git@google.com>

On Fri, Dec 20, 2024 at 12:22:18PM +0100, Ard Biesheuvel wrote:
> Use the LocateHandleBuffer() API and a __free() function to simplify the
> logic that allocates a handle buffer to iterate over all GOP protocols
> in the EFI database.

You previously rejected use of LocateHandleBuffer because you saw
a risk of regressing older EFI versions, so that's a surprising move:

https://lore.kernel.org/r/CAKv+Gu_kfnHfiBH__Wnvh39KMPj_-s39YyY=pT3roNv7iPPzrA@mail.gmail.com/

Thanks,

Lukas


Return-Path: <linux-efi+bounces-3003-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC50A6503E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 14:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D8A169F96
	for <lists+linux-efi@lfdr.de>; Mon, 17 Mar 2025 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA823A982;
	Mon, 17 Mar 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o9mDd8FL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D88F5E;
	Mon, 17 Mar 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216908; cv=none; b=pM5i+Jk5yacN43J5Id2ziIMUE4/1USXZHVochTo+jwiqlHRIdhJpuclp5l7+aOKzZzp8/pCY9hVsfK5ZYvBS3CcU4soPqqrJktGYEkbCQSrkEdJyCuH72BpwAvjYWUPuZ82ABqIb1q0TWrJCJhipxNowM8QO2FqcDexqyQKMv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216908; c=relaxed/simple;
	bh=Lhdjte4zF9XUufgjtadfjSfaeOkVRFMnM8DlfLEHCr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogATMFgAv6Rafyq5KorUtalscEmyLOBNWpDkGoLj1PKn5/P2wuQuiRQi3HQuYL2RUHwLtc79qy197+YgKyCPzCLCCEDwVYkaXUq/KjzYgflcBrKR/dSGguoKkzgtlN3/EDIoPiKYxLVUbT+J7YDWTIFpFOLVW75Tq8QBfC6nJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o9mDd8FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD7C4CEE3;
	Mon, 17 Mar 2025 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742216907;
	bh=Lhdjte4zF9XUufgjtadfjSfaeOkVRFMnM8DlfLEHCr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9mDd8FL1Z9W1oVdQG9lGycsKg8WxzK8C/0UIuD8qbwgqQ7TYK3p4qC7m5b5btke4
	 t4ZfbeUeveJ17zJjxHgq8A4dlF61P9znE8p6B0gtbzGZYUWtwrNkMoGyv/8EqDYWus
	 GrIsqpcqTD0Ml0ouKPPFaOb6IGNQIxveZSkykSns=
Date: Mon, 17 Mar 2025 14:06:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH 5/9] virt: efi_secret: Transition to the faux device
 interface
Message-ID: <2025031716-idiocy-harpist-3882@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-5-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-5-5fe67c085ad5@arm.com>

On Mon, Mar 17, 2025 at 10:13:17AM +0000, Sudeep Holla wrote:
>  MODULE_DESCRIPTION("Confidential computing EFI secret area access");
>  MODULE_AUTHOR("IBM");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:efi_secret");
> +MODULE_ALIAS("faux:efi_secret");

Again, no need for a module alias anymore.



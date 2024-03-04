Return-Path: <linux-efi+bounces-711-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A2870094
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906DA1C212DA
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB063A1C6;
	Mon,  4 Mar 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vVbqPv7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8R7g7uA"
X-Original-To: linux-efi@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B73838B;
	Mon,  4 Mar 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552608; cv=none; b=f61FirhPLunGnM22BkeFm8rUuhGb6pdfiELpIPmqeXLsuC7VzG1jhrjeNkhBM3KQobEYxV2X3mFBvdw8aL+XRN0Sif0wCktbJHAC1bRLQy0El1GY5ABYN1ZSaPy1/ASzl+L/gDmIhsRiQP3H8YMEfa+p36xYBl36CWXer82jCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552608; c=relaxed/simple;
	bh=3udXBRehqBkcrC0yUomfJrS2xBhn8210xOULcGJWHM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApHIu0NYC7s0tNEiiimGYPYm4wSGF6Iy1Mk2/fZfIm9+reyUjzovtS4bGRm73p8rYlvoRm8MkBDtzn7vvq8unieXJO9mXcy+8BzVW6vWQ37lHUfs70GPkb2A/vIQM61+HQTzqz3a3rgVUb24tAYWXRN41uKN9D16ZGzaLSxQuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=vVbqPv7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8R7g7uA; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id C638A1C000A6;
	Mon,  4 Mar 2024 06:43:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 06:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709552605; x=1709639005; bh=vOSWpqy3V6
	RbtrkvImNACTXOXX4i5AAPC1ZApf+eTPU=; b=vVbqPv7cjdYdqyV9W+QOnvwlHf
	JHwlVKeF8SeD+xO6tQlIA18kxvPrpplfO+j/b+c5BQZMQBboPIQjRbQagPgtQk2s
	1e0hY2jdk1dx10UrugnUKLFgghRwtaJkZp4l4ZQ3COfEWJK/LVBlm1f6cf8Vfheu
	l4YUBRmXKAzLOFSMtiAmqfGcjKNjsEJTM3fvSop3V1rUf8cgXxU6k5ufAv3HtiEj
	BRZaPdUXO9/eOrFdkrt7fcIq8aO7lCvGFMWkJAj0r5WU0w7y7+AxigQtYbQmIJ63
	YFtY7NP4aXcyn82R6akqbOgBfZI2QSwen/x0nQFtqhJXlU0WKSr0ChNVpEGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709552605; x=1709639005; bh=vOSWpqy3V6RbtrkvImNACTXOXX4i
	5AAPC1ZApf+eTPU=; b=R8R7g7uA41jDUEHRA7drSNj6DMRwHbPLARaSu+95JkNB
	1Fukgsh/Stexc1znPE4718EzCirAn2JC1O5g0x4rwaeYNEtrmajgDGV+ekTn+siF
	Dl7Pj+NnhCOaFbdRfMO1rpsISTjwKKMObYyvSY0vpZ7Xa4RE9yx6Adr/z2lfmPUi
	1MV/84U+/Sleu/SULGI76yll/4VJu9HLHB4cTQFkWvq55HFAHAdoNGvZxoh+RJTu
	ppTdow593xhDv83YiP5iSrZx1KiAR/sqsbJpJ0Ol56oAXDbpdpOwT7mOu2iwTdkF
	AJQg+J3n5khck4cBndCa1UVCxADfVKpbntbaq/4wKA==
X-ME-Sender: <xms:3LPlZTKQVkhyp-8kPNQiAPkEoiAOPhypdMilTRTgKM6SjSOIwFiA7Q>
    <xme:3LPlZXJtdiRj6dxvvZ-ENaKuBNkrC9AhDgSEcN28WNdTbS6TS1yvyMd9ywQZxK29L
    vwy-VQGbYsOlg>
X-ME-Received: <xmr:3LPlZbtdOaXK_Lt_bmckPauD05cLo7ruJdqUGgotpsywqq47nZ8qxBjY6tt0lrYD3zK7zayXyqO0jWfF24PynErniOs0KVIpKDJ9gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:3LPlZcZW6rp0QXySujjsvDQ6XRS8bi-eYmS8yXxoJ6TilwCgs_Jq2g>
    <xmx:3LPlZaaaiA4mG_prTAKCASmvvWexZQbAenLtWk-hahxOVKyOjbKQ9w>
    <xmx:3LPlZQCZCfEGtA41qECQcAgcJXp-wVZ0B_edSUtbIGYeQ3NINBvZpg>
    <xmx:3bPlZQMrtzbsOwoNLwETnPZv1oxzYzxapDz_7yF4nxeUsz1s4ATi2XlDEWc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 06:43:24 -0500 (EST)
Date: Mon, 4 Mar 2024 12:42:42 +0100
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH stable-v6.1 00/18] efistub/x86 changes for secure boot
Message-ID: <2024030431-giblet-derail-8c7e@gregkh>
References: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>

On Mon, Mar 04, 2024 at 12:19:38PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> These are the remaining patches that bring v6.1 in sync with v6.6 in
> terms of support for 4k section alignment and strict separation of
> executable and writable mappings. More details in [0].
> 
> [0] https://lkml.kernel.org/r/CAMj1kXE5y%2B6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ%40mail.gmail.com

All now queued up, thanks!

greg k-h


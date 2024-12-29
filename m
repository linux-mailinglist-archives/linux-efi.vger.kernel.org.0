Return-Path: <linux-efi+bounces-2487-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A69FDE5E
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 11:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048DC1882648
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4541D6F073;
	Sun, 29 Dec 2024 10:00:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83786C148;
	Sun, 29 Dec 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735466400; cv=none; b=ejbj9lMsAUAAKLXWVj2ji9MUGuj15BV8HMp0GBNGoo4rJScBbjZg8TZ7NlcEU9EZq6rcSDpipe6c9FtQiNAfeTSdWJ7JJNAJpMedOZK9BwIEqJ7DtbBfPHx+FbpEwJFeOQI5HEo1GCJ6kxqfVoiW7wyXqgos6tvnpSg8DSdqqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735466400; c=relaxed/simple;
	bh=iaeXZKZr5l62L7O1oC1TbZtZRowcJiaBdtqSOqyr4go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZgmao3aFjVTaBf6EQ2Z63X9SbCQU07BvJ7OxDFjucAR3bjQ0qso8UWT5J2qB47AkTtZEQJUKcGSsU96YvlQ/Ah+ZQmWgD/PwEC0wub2yK8/EdJWGzvFt/G/GHHk6d/lIMoQi/DNjpnsYDLnTLam8JFolGWPY5LxcXr8/QkB/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9CB68100D9414;
	Sun, 29 Dec 2024 10:59:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5D74630F866; Sun, 29 Dec 2024 10:59:46 +0100 (CET)
Date: Sun, 29 Dec 2024 10:59:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Lleyton Gray <lleyton@fyralabs.com>
Cc: gargaditya08@live.com, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Message-ID: <Z3EdkuCBzTGzTHK3@wunner.de>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228202212.89069-1-lleyton@fyralabs.com>

On Sat, Dec 28, 2024 at 12:21:58PM -0800, Lleyton Gray wrote:
> commit 71e49eccdca6 ("x86/efistub: Call Apple set_os protocol on dual GPU
> Intel Macs") calls the Apple set_os protocol, but only on T2 Macbook Pro
> models. This causes issues on other T2 models when an egpu is used.

How so?  The commit specifically constrains the quirk only to
affected dual GPU MacBook Pros.  So I don't quite see how this
would affect other T2 models?

And what kind of issues are you seeing?  Could you provide
specifics please?

> Add two options which allow force enabling or disabling usage of the
> protocol to fix.

We generally try to avoid command line options.  The kernel
should automatically determine whether to apply the quirk
or not.  So I think the proper solution is to amend the
quirk such that it's applied to additional models or not
applied under certain circumstances.

Thanks,

Lukas


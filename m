Return-Path: <linux-efi+bounces-1351-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03C91E05A
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26AFB242A7
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1F37142;
	Mon,  1 Jul 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbOO7HMH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1F1DFD9;
	Mon,  1 Jul 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839720; cv=none; b=F2AFM0CRaFBam9XK6p/eX9XCUBMWjsYqfXR+NGt6S76wJdd/jZrYByxzUi9i/GMM4+vUcgxKI+WvX4Bd+tQKVFoNQoJ4Pepu7w1cRK5Yq43dQ1D8JLFNQgjEBBtLsFsxsFbOHsPuwptdEBCh+2jOmWBaaX6+2kajjur1uQV854o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839720; c=relaxed/simple;
	bh=544hdO4m+Yo09Ix1f8HVM+SryQd+PGyhysli3+nWtYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=DmcSDwjRDZf2Wmk7pLJj2JK+1Wgh4LKWvK1vKURXrV3v8UR9RvzLJp7f0adGIB7QAQ2PQGrVM76mA/v1cShBX6Uv26P5TJcIVbF/TVppG42rzcC5OqS+zvp+dfnl5Zb0C9VVFQompSi3KBUBTS2oQL/MasUwXMd0QltfR3RtQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbOO7HMH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso16040285ad.1;
        Mon, 01 Jul 2024 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719839718; x=1720444518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=544hdO4m+Yo09Ix1f8HVM+SryQd+PGyhysli3+nWtYU=;
        b=UbOO7HMHQjs6xghw/8mhvNUvbyb64LCC4lS06nWWJavrlZWBdoJXpy0wFJp5VDrt0E
         FDp5oIsRm1yM2uNmkUJ2knrfIB1wKZ952Zqsx1++w0v27AHQErBs0qcu/6xxgBx5FUqY
         QQgPOMhTjCfrTU/y2V3PRZvvrYqGOL1j7oUVUFnnJLaVi76brlBb55Jwsq0mOWj6/MCN
         TylQFwZG3fXJBRVz9yeRykulKBcqRQIpE2fQBk8bvEOQ/rJnGUazKX9wns9TeurBoJjJ
         Pt2DE6Yr3klpJ4tYG8Wxq1C3blK6NXlkViC/xEAmwpLHcVl+vAe3OVBjdlW8G8KKnm1H
         OKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839718; x=1720444518;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=544hdO4m+Yo09Ix1f8HVM+SryQd+PGyhysli3+nWtYU=;
        b=NdXfTOfwujKgBM49Diyr8bXb+hYqJsATidNJiJLDh9CDA0DrpUEjiKOA8wyoqOihq+
         i0gelQBlPetrJK8qOARu8g0NPaMaF0g5wNOn04KE5mWZ4A0hvI1IyJqxxZbzH5MXMnSK
         WTYfK6eQ671VLSEGL4LUzNTVR0c3ordnWO/6ObEIEIbXG3iGiB+COmY9R1FHvQBuc2nY
         EjNQTxYxVTXZIlT73pjwNLJ9AaNgsm+Awet2YVI64kSe63G6Op/dBwr9xEBlOz79yIHa
         f4RIeNLIXsWKSDkeM33xXKE1CI2HZvVDwUD7yRI442GM8JezsDaUoIo3dN+K1U8j8lzw
         7GRw==
X-Forwarded-Encrypted: i=1; AJvYcCXexQWXIrVto7O0uP5vDvUuG21QsoeUsWCYZGYUmz0Qzp4Y5Gst36wpCqjKabIS1vc6PAHZGdPZSA9QvWyF0HydvMiB7HAVIHQdQJkbcqh7LWoDj8L9FU2xxLOBCurVzca4wGwhPJUg
X-Gm-Message-State: AOJu0YyWUFf+CkB48Rd/u6ctojLBcgVVq/YyXZQTt7KqzWFVbTEefXZF
	AjX1zI9JWMKGMQZVe4N386EmvAky768DVNixK85b6gfEqeTgFaEdTIPwIg==
X-Google-Smtp-Source: AGHT+IFFN8wg4fbelccTURAYeNBoHJ1Drq8wevD15r5D0xHsU3RhfIznlMAFHdR7wGtBqZXliZxqKA==
X-Received: by 2002:a17:902:a511:b0:1f9:b9ed:e84e with SMTP id d9443c01a7336-1fadbd08e34mr23626995ad.58.1719839718336;
        Mon, 01 Jul 2024 06:15:18 -0700 (PDT)
Received: from redecorated-mbp (121-45-106-167.tpgi.com.au. [121.45.106.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d15a9sm64544555ad.37.2024.07.01.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:15:18 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:14:52 +1000
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: lukas@wunner.de
Cc: ardb@kernel.org, gargaditya08@live.com, hdegoede@redhat.com,
 kekrby@gmail.com, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Message-ID: <20240701231452.3d547e7f@redecorated-mbp>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <ZoJcVf98MElXhMjT@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> FWIW, there would be only 6 models to match if this needs to be
> constrained to ones with dual GPUs:
>
> MacBookPro11,3
> MacBookPro11,5
> MacBookPro13,3
> MacBookPro14,3
> MacBookPro15,1
> MacBookPro16,1

I know that at least these two also need it:
MacBookPro16,4
MacBookPro15,3

I think there could be more older ones too. Apple has a list of
MacBookPros [0], but I don't know how many of the older models that
list 2 gpus on their "Tech Specs" pages need apple-set-os.

The original apple-set-os code was posted to the GRUB mailing list in
December 2013 [1] so maybe it was in 2013 that new dual GPU Macbooks
started needing apple-set-os?

[0] https://support.apple.com/en-us/108052
[1] https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html




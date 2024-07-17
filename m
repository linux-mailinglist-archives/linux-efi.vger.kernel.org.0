Return-Path: <linux-efi+bounces-1443-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3B933E49
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82034B20E8C
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68E1802DC;
	Wed, 17 Jul 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2SgSA0n"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336311CA1;
	Wed, 17 Jul 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226140; cv=none; b=fLlcPiZjj75Wl/9J5C7s1YJIAVVj2+iDroBKWZMudfYK9ZokiF2/BVbEiFrHK2JK945EUgFBbRq6vv12uxOkaiXVO+96C4cKESyjM4W5efKdfyX1L1WClyki548bbkaEsWkxZOXqVdisuxnMk9nInQHFC4GXLvbHfYU5OZu9dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226140; c=relaxed/simple;
	bh=+cAhLTu6m+4hMSqKQ3PiRLQiyKajwDK62DYflGv+rgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQIwhK1+wjE2klTxUE7yTyf7HsvCOaLFH6NEHuxEmltO0QTHL53h+MsSDSXjGcnbF1pnAhhk1zGZSslkvxOq8Nm2iTRFWoeGfoipdoQFsUsdUoFTbL1Bp0HehwTR6Avunu41pqbQldl2YOhQwlOIsXkmt+VMt8vir8/nPnfc0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2SgSA0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9D8C32782;
	Wed, 17 Jul 2024 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721226140;
	bh=+cAhLTu6m+4hMSqKQ3PiRLQiyKajwDK62DYflGv+rgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a2SgSA0nVGcOxRKZR8FlVlZn5uHFI7/JI5h4gQMPA59403HfBQd9gQviOTqqCm8dj
	 tQwx4KOM8YaWMTbpV/TsZ36QGt7h9bJsq9bu4rcgnMGEsDFVRu1ySgAMRR7hJ2nylm
	 WtM9d5I7w+G2675SmGkha4K4hub/eVlHYxV2hsX0P0Enx7v89khNi3NBPG5vw3Vhdh
	 6lZfFzx1K99u6ZH1JG15ktV+V0H6OhiuAMgIsm1p2zZhdk1OJn4snX5RNRq9z2FnmQ
	 Hgm1stRy4K5OVaebD6CRODVI0RPc2oaiHTYpDitZRkTQxA2EWwTJ6cwZ42UwjIe/sv
	 3mIDSKeTt9LRQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so96721221fa.2;
        Wed, 17 Jul 2024 07:22:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrHv1vEe9zY4/iruDfXV3newMKww9+umDeDSiV5IKUCC+91w2F1F4mDbZHxN6UbFvsRSyOYz5hKwGXF+oWuibNx+r4HSKOEK5zkssh
X-Gm-Message-State: AOJu0Yxs1ll3/GRJb2ipqpE4BR/UmZbT1P24w4BziLnXKy2kmpR2Wi9z
	JEsx1yO+ujCngIXaptpzMsflGv+E3CoaoJ4A0lSUPzyzyzqnlTdcYB9TISuMRiMJZgIFaASGIfN
	llbnnzmPP/CFcChM/RRu7qbQz8tU=
X-Google-Smtp-Source: AGHT+IG2ZkohryGGQUHSurlvpj5b9YglSFu/jVnkAme7zsyldAJgSvwzlF+VG4j5aX7c4ED4TVdv6PkCOMnJ+aFhe0I=
X-Received: by 2002:a2e:a9ab:0:b0:2ec:637a:c212 with SMTP id
 38308e7fff4ca-2eefd1bf382mr14909121fa.39.1721226138457; Wed, 17 Jul 2024
 07:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 07:22:05 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEUF+++qOCwhJ4OHFxjqJRJUM4ar7x8ENm+=aHyn-V6gw@mail.gmail.com>
Message-ID: <CAMj1kXEUF+++qOCwhJ4OHFxjqJRJUM4ar7x8ENm+=aHyn-V6gw@mail.gmail.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
To: "Shao, Marshall" <Marshall.Shao@dell.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Mishra, Ashish" <Ashish.Mishra4@dell.com>, "Dion, Christopher" <Christopher.Dion@dell.com>, 
	"Caisse, Joe" <Joe.Caisse@dell.com>, "Chia, Jia Yuan" <JiaYuan.Chia@dell.com>, 
	"Mukundan, Govind" <Govind.Mukundan@dell.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 00:33, Shao, Marshall <Marshall.Shao@dell.com> wrote:
>
> Internal Use - Confidential

Please drop this footer and resend

